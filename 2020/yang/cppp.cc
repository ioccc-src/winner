// CPPP stands for "C Pre-PreProcessor", so named because the output
// is meant to be fed into a real C preprocessors before they are
// useful.  Not to be confused with CPP (a real C preprocessor) or
// CCCP (something else entirely).
//
// This tool is written to do primarily one thing, which is to
// evaluate files that are heavy on ifdef/ifndef and self-includes,
// and unroll those to something that is more palatable to typical
// preprocessors.  To that end, it is able to handle these directives:
//
//  if elif else ifdef ifndef endif define undef warning error include
//
// With lots of caveats, such as:
//
//  - #if and #elif only works if the expressions are shaped like these:
//    #if A % B > C
//    #if A > B
//    #if A
//
//  - #include only works if right hand side evaluates to __FILE__,
//    otherwise the directive is copied to output.
//
//  - __LINE__ is not preserved.  Or rather, they are copied as is.
//    So if a __LINE__ moved to a different line after preprocessor
//    directives are evaluated, it will take on a different value as
//    opposed to whatever they would have been in the original source
//    location.
//
//  - #define with right-hand side or macro parameters are copied to
//    output, otherwise they are evaluated and dropped.  The intent is
//    to allow the next preprocessor to parse these and do macro
//    expansion there, since this tool doesn't do any macro expansion
//    on its own.
//
// That's right, no macro expansions.  The one thing that is the main job
// for most other preprocessors, we don't do that here.  Don't mistake
// this utility for a real preprocessor, it's just a pre-preprocessor.
// But for the one task it is implemented to do, it does so significantly
// faster than GCC or Clang's preprocessors.
//
// Requires compilers that supports C++17 or later.

#include<ctype.h>
#include<inttypes.h>
#include<stdio.h>
#include<stdlib.h>

#include<array>
#include<string_view>
#include<string>
#include<unordered_map>
#include<unordered_set>
#include<vector>

namespace {

// Maximum depth to avoid runaway includes.
//
// GCC supports 200 and said standard requires at least 15:
// https://gcc.gnu.org/onlinedocs/cpp/Implementation-limits.html
//
// We cap our max inclusion depth at 15 so that this tool can be used
// to flag inputs that might be troublesome for other preprocessors.
static constexpr int kMaxIncludeDepth = 15;

// List of characters that passes isspace().
static constexpr char kSpace[] = " \t\r\n\f\v";

// List of characters to match start of macro parameter or value.
static constexpr char kSpaceOrLeftParen[] = " \t(";

// Table of (macro name, macro definition).
//
// Note that there is no place to store macro arguments here.  This is
// intentional, since we don't do any macro expansions.
using MacroTable = std::unordered_map<std::string_view, std::string_view>;

// Preprocessor directives.
enum class Directive
{
   kIf,           // arg = expression
   kElif,         // arg = expression
   kElse,
   kIfDef,        // arg = macro to test
   kIfNDef,       // arg = macro to test
   kEndIf,
   kDefine,       // arg = macro to insert
   kUndef,        // arg = macro to remove
   kInclude,      // arg = filename or macro
   kWarning,      // arg = output text
   kError,        // arg = output text
   kRawDefine,    // arg = input line
   kText          // arg = input line
};

// A single preprocessor instruction step.
struct Operation
{
   // Operation parameters.
   Directive directive;
   std::string_view arg;

   // Index of next instruction after evaluating conditional expression.
   size_t true_branch, false_branch;
};

// Debugging stats.
struct Stats
{
   // Number of #include counts.
   //
   // Number of includes overflowing signed 32bits?  It's more likely
   // than you think.  Although if you did observe this number going
   // even above just a few hundred, you are likely going to have a
   // terrible experience feeding the same file to a real preprocessor.
   int64_t include_count = -1;

   // Number of Operation steps executed, which is roughly the number
   // of lines that we didn't skip.
   int64_t operation_steps = 0;

   // Maximum level of self-includes observed.
   int max_include_depth = 0;
};

// Load input from opened file handle and append to output string.
static void LoadInputFromHandle(FILE *infile, std::string *text)
{
   std::array<char, 1024> buffer;
   for(size_t read_size;;)
   {
      read_size = fread(buffer.data(), 1, buffer.size(), infile);
      text->append(std::string(buffer.data(), read_size));
      if( read_size < buffer.size() )
         break;
   }
}

// Load input to memory.
static bool LoadInput(const char *file_name, std::string *text)
{
   FILE *infile;
   if( (infile = fopen(file_name, "rb")) == nullptr )
   {
      fprintf(stderr, "Error reading from %s\n", file_name);
      return false;
   }
   LoadInputFromHandle(infile, text);
   fclose(infile);
   return true;
}

// Return list of strings, roughly one string per line except multiline
// comments and preprocessor directives will be coalesced as one string.
static std::vector<std::string_view> TokenizeToLines(std::string *text)
{
   // State machine for parsing various regions of text.
   enum class State
   {
      Normal,
      SingleQuotedString,
      DoubleQuotedString,
      RawString,
      SingleLineComment,
      BlockComment
   };
   State state = State::Normal;

   // List of offsets that are the start of each line.
   std::vector<size_t> line_offsets = {0};

   // r = offset we are reading from, w = offset we are writing to.  w <= r.
   //
   // These indices are used to modify the input string in-place, to
   // skip over uninteresting things such as backslash-newline pairs
   // and single line comments.
   size_t w = 0;
   for(size_t r = 0; r < text->size();)
   {
      const char c = (*text)[r];
      switch( state )
      {
         case State::Normal:
            // Normal state, check if we are about to enter enclosed things.
            if( c == '\'' )
            {
               // Single quoted literal.
               state = State::SingleQuotedString;
               (*text)[w++] = (*text)[r++];
            }
            else if( c == '\"' )
            {
               // Double quoted literal.
               state = State::DoubleQuotedString;
               (*text)[w++] = (*text)[r++];
            }
            else if( c == 'R' )
            {
               // Start a C++11 raw string if we saw a R"( trigram not
               // preceded by what might be an identifier.
               //
               // Note that this is the only kind of raw string we
               // support, and not the full R"token( type of raw strings.
               if( r == 0 ||
                   (!isalnum((*text)[r - 1]) && (*text)[r - 1] != '_') )
               {
                  // While C++11 guarantees that we can read +1 past
                  // the end of a string, it doesn't guarantee that we
                  // can read +2, so we must check the bounds here
                  // (unlike other places).
                  if( r + 2 < text->size() &&
                      (*text)[r + 1] == '\"' &&
                      (*text)[r + 2] == '(' )
                  {
                     state = State::RawString;
                  }
               }
               (*text)[w++] = (*text)[r++];
            }
            else if( c == '/' )
            {
               // Start of comments.
               if( (*text)[r + 1] == '/' )
               {
                  // Single line comments are dropped entirely.
                  state = State::SingleLineComment;
                  r += 2;
               }
               else if( (*text)[r + 1] == '*' )
               {
                  // Whitespaces inside block comments are preserved, such
                  // that line numbers and code alignment after the block
                  // comments are preserved.
                  state = State::BlockComment;
                  (*text)[w++] = ' ';
                  (*text)[w++] = ' ';
                  r += 2;
               }
               else
               {
                  (*text)[w++] = (*text)[r++];
               }
            }
            else if( c == '\\' && (*text)[r + 1] == '\n' )
            {
               // Skip over backslash-newline pairs, thus joining backslash
               // escaped line breaks.  Note that this is only done in
               // Normal state.  We specifically want to preserve
               // backslash-newline pairs inside C++11 raw strings.
               r += 2;
            }
            else
            {
               // Copy other characters as is, recording offsets to
               // next character just after a newline.
               (*text)[w++] = (*text)[r++];
               if( c == '\n' )
                  line_offsets.push_back(w);
            }
            break;

         case State::SingleQuotedString:
            // Skip over backslash escapes, and end single quoted
            // literals on single quotes.
            if( c == '\\' )
            {
               (*text)[w++] = (*text)[r++];
            }
            else if( c == '\'' )
            {
               state = State::Normal;
            }
            (*text)[w++] = (*text)[r++];
            break;

         case State::DoubleQuotedString:
            // Skip over backslash escapes, and end double quoted
            // literals on double quotes.
            if( c == '\\' )
            {
               (*text)[w++] = (*text)[r++];
            }
            else if( c == '\"' )
            {
               state = State::Normal;
            }
            (*text)[w++] = (*text)[r++];
            break;

         case State::RawString:
            // End C++11 raw strings on )" bigram.
            if( c == ')' && (*text)[r + 1] == '\"' )
            {
               (*text)[w++] = (*text)[r++];
               state = State::Normal;
            }
            (*text)[w++] = (*text)[r++];
            break;

         case State::SingleLineComment:
            // Drop all single line comment contents until the trailing
            // newline.  Only the final newline is copied to output.
            if( c == '\n' )
            {
               state = State::Normal;
               (*text)[w++] = (*text)[r++];
               line_offsets.push_back(w);
            }
            else
            {
               r++;
            }
            break;

         case State::BlockComment:
            // Replace block comments with spaces, and end comments on
            // */ bigram.
            if( c == '*' && (*text)[r + 1] == '/' )
            {
               state = State::Normal;
               (*text)[w++] = ' ';
               (*text)[w++] = ' ';
               r += 2;
            }
            else
            {
               // If the byte we are replacing is already a space character,
               // then just copy it as is.  Otherwise, replace it with a
               // normal whitespace.  This is meant to preserve layout for
               // when block comments are used within a single line.  If we
               // were to support __LINE__, this may also help in keeping that
               // consistent, but since we don't support macro expansions of
               // any kind, it doesn't matter.
               //
               // We don't have to worry about embedded newlines mess up line
               // splitting, since line splitting is done by remembering the
               // offsets of all newlines outside of all enclosed regions.
               // This means something like this works:
               //    # /*
               //          */ define NEXT_LINE
               if( isspace(c) )
                  (*text)[w++] = c;
               else
                  (*text)[w++] = ' ';
               r++;
            }
            break;
      }
   }
   text->erase(w);

   // Build list of lines from line offsets.
   std::vector<std::string_view> lines;
   if( w > 0 )
   {
      lines.reserve(line_offsets.size());
      if( line_offsets.back() != w )
         line_offsets.push_back(w);
      for(size_t i = 0; i + 1 < line_offsets.size(); i++)
      {
         std::string_view l(*text);
         l.remove_prefix(line_offsets[i]);
         l.remove_suffix(l.size() - (line_offsets[i + 1] - line_offsets[i]));
         lines.push_back(l);
      }
   }
   return lines;
}

// Remove leading and trailing spaces.
static std::string_view Trim(std::string_view s)
{
   const size_t l_space = s.find_first_not_of(kSpace);
   if( l_space > 0 )
      s.remove_prefix(l_space);
   const size_t r_space = s.find_last_not_of(kSpace);
   if( r_space != std::string_view::npos )
      s.remove_suffix(s.size() - r_space - 1);
   return s;
}

// Convert a line into our operation struct.
static Operation ParseSingleLine(std::string_view line)
{
   Operation op;
   op.directive = Directive::kText;
   op.arg = line;

   // Skip past leading space and '#'.
   const size_t i = line.find_first_not_of(kSpace);
   if( i == std::string_view::npos || line[i] != '#' )
      return op;
   const size_t j = line.find_first_not_of(kSpace, i + 1);
   if( j == std::string_view::npos )
      return op;

   // Extract directive and optional argument.
   std::string_view directive(line.substr(j));
   std::string_view arg;
   const size_t k = directive.find_first_of(kSpace);
   if( k != std::string_view::npos )
   {
      arg = Trim(directive.substr(k));
      directive.remove_suffix(directive.size() - k);
   }

   if( directive == "define" )
   {
      // If this is a macro with parameters or substitution value, we
      // will copy the full directive (minus the leading and trailing
      // space) to output on evaluation, so we will need to preserve
      // the full line here.
      if( arg.find_first_of(kSpaceOrLeftParen) != std::string_view::npos )
      {
         op.directive = Directive::kRawDefine;
         op.arg = Trim(line);
      }
      else
      {
         op.directive = Directive::kDefine;
         op.arg = arg;
      }
   }
   #define MATCH_DIRECTIVE(s, o) \
      else if( directive == s ) { op.directive = o; op.arg = arg; }
   MATCH_DIRECTIVE("if",      Directive::kIf)
   MATCH_DIRECTIVE("elif",    Directive::kElif)
   MATCH_DIRECTIVE("else",    Directive::kElse)
   MATCH_DIRECTIVE("ifdef",   Directive::kIfDef)
   MATCH_DIRECTIVE("ifndef",  Directive::kIfNDef)
   MATCH_DIRECTIVE("endif",   Directive::kEndIf)
   MATCH_DIRECTIVE("undef",   Directive::kUndef)
   MATCH_DIRECTIVE("include", Directive::kInclude)
   MATCH_DIRECTIVE("warning", Directive::kWarning)
   MATCH_DIRECTIVE("error",   Directive::kError)
   #undef MATCH_DIRECTIVE
   return op;
}

// Convert lines to operations.
static std::vector<Operation> ParseLines(
   const std::vector<std::string_view> &input_lines)
{
   std::vector<Operation> output;
   output.reserve(input_lines.size());
   for(const auto &line : input_lines)
      output.push_back(ParseSingleLine(line));
   return output;
}

// Check for nonempty stack.
template <typename T>
static void AssertNonEmptyStack(const T &stack, const char *directive)
{
   if( stack.empty() )
   {
      fprintf(stderr, "Unmatched %s\n", directive);
      exit(EXIT_FAILURE);
   }
}

// Find branch locations.  This makes skipping over conditional blocks
// much faster.  This optimization probably doesn't make sense for
// typical code since most people aren't doing "#include __FILE__",
// but for our purposes it makes a big difference.
//
// Empirically, cppp's processing time is roughly linear to the number
// of "#include __FILE__" directives because it is able to jump to the
// relevant #if blocks quickly.  Whereas GNU's cpp exhibits quadratic
// time because it always reads in the entire file for each #include.
static void IndexOps(std::vector<Operation> *code)
{
   // first = list of indices looking for #else destination.
   // second = list of indices looking for #endif destination.
   using StackFrame = std::pair<std::vector<size_t>, std::vector<size_t>>;
   std::vector<StackFrame> stack;
   for(size_t i = 0; i < code->size(); i++)
   {
      Operation *op = &((*code)[i]);
      op->true_branch = op->false_branch = i + 1;
      switch( op->directive )
      {
         case Directive::kIf:
         case Directive::kIfDef:
         case Directive::kIfNDef:
            // Start of conditional block.
            stack.push_back(StackFrame());
            stack.back().first.push_back(i);
            break;

         case Directive::kElif:
            // End of one conditional block and start of the next block.
            // Update previous false_branch destinations to point at the
            // current conditional instruction.
            AssertNonEmptyStack(stack, "#elif");
            for(size_t f : stack.back().first)
               (*code)[f].false_branch = i;
            stack.back().first.clear();
            stack.back().first.push_back(i);
            break;

         case Directive::kElse:
            // End of conditional block.  Update previous false_branch
            // destinations to skip past current instruction directly
            // into the body of the conditional branch.
            AssertNonEmptyStack(stack, "#else");
            for(size_t f : stack.back().first)
               (*code)[f].false_branch = i + 1;
            stack.back().first.clear();
            break;

         case Directive::kEndIf:
            // End of conditional block.  Update previous false_branch
            // destinations to point at current instruction.
            AssertNonEmptyStack(stack, "#endif");
            for(size_t f : stack.back().first)
               (*code)[f].false_branch = i;
            for(size_t f : stack.back().second)
               (*code)[f].true_branch = (*code)[f].false_branch = i;
            stack.pop_back();

            [[fallthrough]];

         case Directive::kDefine:
         case Directive::kUndef:
         case Directive::kInclude:
         case Directive::kWarning:
         case Directive::kRawDefine:
         case Directive::kText:
            // Other non-branching directives, including #endif.  If
            // we are currently inside a conditional block and the
            // next instruction ends the block, we want to update the
            // current instruction later to jump to the matching #endif.
            //    #if ...
            //       #if ...
            //          step 1
            //       #endif  // this will branch to #endif just before step 2
            //    #else
            //       ...
            //    #endif
            //    step 2
            if( !stack.empty() &&
                i + 1 < code->size() &&
                ((*code)[i + 1].directive == Directive::kElif ||
                 (*code)[i + 1].directive == Directive::kElse) )
            {
               stack.back().second.push_back(i);
            }
            break;

         case Directive::kError:
            // Error directives don't have any other place to go.
            op->true_branch = op->false_branch = i;
            break;
      }
   }
}

// Try to evaluate a possible macro reference as integer.
static int LookupInt(const MacroTable &table, std::string_view token)
{
   std::unordered_set<std::string_view> used_macros;
   for(MacroTable::const_iterator f = table.find(token); f != table.end();)
   {
      if( !used_macros.insert(token).second )
      {
         fprintf(stderr, "Recursive macro reference: %s\n",
                 std::string(token).c_str());
         exit(EXIT_FAILURE);
      }
      token = f->second;
      f = table.find(token);
   }
   int value;
   if( sscanf(std::string(token).c_str(), "%d", &value) == 1 )
      return value;
   return 0;
}

// Evaluate a conditional expression.
static bool Evaluate(const MacroTable &table, std::string_view expr)
{
   // Try matching something like "a % b > c".
   const std::string expr_string(expr);
   std::array<char, 64> token[5];
   if( sscanf(expr_string.c_str(), "%s %s %s %s %s",
              token[0].data(),
              token[1].data(),
              token[2].data(),
              token[3].data(),
              token[4].data()) == 5 )
   {
      const int value1 = LookupInt(table, std::string_view(token[0].data()));
      const std::string_view op1(token[1].data());
      const int value2 = LookupInt(table, std::string_view(token[2].data()));
      const std::string_view op2(token[3].data());
      const int value3 = LookupInt(table, std::string_view(token[4].data()));

      #define INNER_EXPR(first_op, second_op)                \
         if( op2 == #second_op )                             \
            return value1 first_op value2 second_op value3
      #define OUTER_EXPR(first_op)                           \
         if( op1 == #first_op )                              \
         {                                                   \
            INNER_EXPR(first_op, ==);                        \
            INNER_EXPR(first_op, !=);                        \
            INNER_EXPR(first_op, <);                         \
            INNER_EXPR(first_op, >);                         \
            INNER_EXPR(first_op, <=);                        \
            INNER_EXPR(first_op, >=);                        \
         }
      OUTER_EXPR(+) else
      OUTER_EXPR(-) else
      OUTER_EXPR(*) else
      OUTER_EXPR(/) else
      OUTER_EXPR(%) else
      OUTER_EXPR(<<) else
      OUTER_EXPR(>>)
      #undef OUTER_EXPR
      #undef INNER_EXPR
   }

   // Try matching something like "a > b";
   if( sscanf(expr_string.c_str(), "%s %s %s",
              token[0].data(),
              token[1].data(),
              token[2].data()) == 3 )
   {
      const int lhs = LookupInt(table, std::string_view(token[0].data()));
      const std::string_view op(token[1].data());
      const int rhs = LookupInt(table, std::string_view(token[2].data()));
      #define EXPR(o)  if( op == #o ) return lhs o rhs
      EXPR(==);
      EXPR(!=);
      EXPR(<);
      EXPR(>);
      EXPR(<=);
      EXPR(>=);
      #undef EXPR
   }

   // Check if there are multiple tokens in this expression.  If so,
   // since it didn't match one of the earlier multi-token branches,
   // it's an expression that we don't support.
   //
   // Also check if there are operators in this expression.  This is
   // a best effort attempt to issue warnings for single-token
   // expressions like "x>0" (as opposed to "x > 0"), instead of
   // silently evaluating them to zero.
   if( expr.find_first_of(kSpace) != std::string_view::npos ||
       expr.find_first_of("+-*/%^~!&|<>()") != std::string_view::npos )
   {
      fprintf(stderr, "Expression not supported by this preprocessor:\n%s\n",
              std::string(expr).c_str());
      exit(EXIT_FAILURE);
   }

   // Assume single value expression.
   return LookupInt(table, expr) != 0;
}

// Execute preprocessor instructions.
static void Run(int depth,
                const std::vector<Operation> &code,
                MacroTable *macros,
                Stats *stats)
{
   stats->include_count++;
   if( stats->max_include_depth < depth )
   {
      if( depth > kMaxIncludeDepth )
      {
         fprintf(stderr, "Include stack too deep: %d\n", depth);
         exit(EXIT_FAILURE);
      }
      stats->max_include_depth = depth;
   }

   for(size_t i = 0; i < code.size();)
   {
      stats->operation_steps++;

      const Operation &op = code[i];
      i = op.true_branch;
      switch( op.directive )
      {
         case Directive::kIf:
         case Directive::kElif:
            if( !Evaluate(*macros, op.arg) )
               i = op.false_branch;
            break;

         case Directive::kIfDef:
            if( macros->find(op.arg) == macros->end() )
               i = op.false_branch;
            break;

         case Directive::kIfNDef:
            if( macros->find(op.arg) != macros->end() )
               i = op.false_branch;
            break;

         case Directive::kElse:
         case Directive::kEndIf:
            break;

         case Directive::kDefine:
            (*macros)[op.arg] = "";
            break;

         case Directive::kRawDefine:
            {
               const size_t j = op.arg.find_first_of(kSpace);
               const size_t k = op.arg.find_first_not_of(kSpace, j + 1);
               const size_t l = op.arg.find_first_of(kSpaceOrLeftParen, k + 1);
               const std::string_view macro_name = op.arg.substr(k, l - k);
               if( op.arg[l] == '(' )
               {
                  // Macro with parameters.  Since we don't do any macro
                  // expansion, there is no way to expand the value
                  // correctly, so we will mark the macro as defined but
                  // don't bother with putting the value in our table.
                  //
                  // That said, we will mark the macro as having *some*
                  // value, so we will copy #undef directives when we
                  // encounter those.
                  (*macros)[macro_name] = op.arg;
               }
               else
               {
                  // Marco without parameters, but with a value.  Here we
                  // have a chance of making some substitutions work, like
                  // these kind of things:
                  //
                  //    #define X __FILE__
                  //    #define Y X
                  //    #include Y
                  //
                  // So we will record the value in our table.
                  const size_t value = op.arg.find_first_not_of(kSpace, l);
                  if( value != std::string_view::npos )
                     (*macros)[macro_name] = Trim(op.arg.substr(value));
                  else
                     (*macros)[macro_name] = "";
               }
            }

            // Copy the whole macro directive to output, so that the next
            // preprocessor might have some chance to make use of it.
            fwrite(op.arg.data(), op.arg.size(), 1, stdout);
            fputc('\n', stdout);
            break;

         case Directive::kUndef:
            if( const MacroTable::iterator f = macros->find(op.arg);
                f != macros->end() )
            {
               // If a macro has value, then we also want to include the
               // #undef statement in the output, otherwise a subsequent
               // #define for the same macro name might not work.
               if( !(f->second.empty()) )
               {
                  fputs("#undef ", stdout);
                  fwrite(op.arg.data(), op.arg.size(), 1, stdout);
                  fputc('\n', stdout);
               }
               macros->erase(f);
            }
            break;

         case Directive::kInclude:
            {
               std::string_view include_file = op.arg;
               std::unordered_set<std::string_view> used_macros;
               for(auto f = macros->find(include_file); f != macros->end();)
               {
                  if( !used_macros.insert(include_file).second )
                  {
                     fprintf(stderr, "Recursive macro reference: %s\n",
                             std::string(include_file).c_str());
                     exit(EXIT_FAILURE);
                  }
                  include_file = f->second;
                  f = macros->find(include_file);
               }
               if( include_file == "__FILE__" )
               {
                  Run(depth + 1, code, macros, stats);
               }
               else
               {
                  fputs("#include ", stdout);
                  fwrite(op.arg.data(), op.arg.size(), 1, stdout);
                  fputc('\n', stdout);
               }
            }
            break;

         case Directive::kWarning:
            fwrite(op.arg.data(), op.arg.size(), 1, stderr);
            fputc('\n', stderr);
            break;

         case Directive::kError:
            fwrite(op.arg.data(), op.arg.size(), 1, stderr);
            fputc('\n', stderr);
            exit(EXIT_FAILURE);
            break;

         case Directive::kText:
            fwrite(op.arg.data(), op.arg.size(), 1, stdout);
            break;
      }
   }
}

}  // namespace

int main(int argc, char **argv)
{
   // Initialize macros and load input.
   MacroTable macros;
   std::string input_text;
   int input_file_count = 0;
   for(int i = 1; i < argc; i++)
   {
      if( argv[i][0] == '-' && argv[i][1] == 'D' )
      {
         const std::string_view d(argv[i] + 2);
         const size_t e = d.find('=');
         if( e != std::string_view::npos )
            macros[d.substr(0, e)] = d.substr(e + 1);
         else
            macros[d] = "";
      }
      else
      {
         if( !LoadInput(argv[i], &input_text) )
            return 1;
         input_file_count++;
      }
   }

   // If no input is specified, try reading from stdin.
   if( input_file_count == 0 )
      LoadInputFromHandle(stdin, &input_text);

   // Parse lines.
   std::vector<Operation> code = ParseLines(TokenizeToLines(&input_text));
   IndexOps(&code);

   // Execute preprocessor.
   Stats stats;
   Run(0, code, &macros, &stats);
   printf("# /* include_count = %" PRId64 " */\n", stats.include_count);
   printf("# /* operation_steps = %" PRId64 " */\n", stats.operation_steps);
   printf("# /* max_include_depth = %d */\n", stats.max_include_depth);
   return 0;
}
