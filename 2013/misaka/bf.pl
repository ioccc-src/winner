#!/usr/bin/perl -w
#
# Usage:
#  ./bf.pl [-e <file.txt>] [-d] <program>
#
#  -e  Read expected output from <file.txt>, exit with nonzero status
#      if output does not match.  Output is not written to stdout when
#      this option is used.
#
#  -d  Dump tape contents to stdout on exit.
#
# Yet another brainfuck interpreter.  This is not a general brainfuck
# interpreter in that it intentionally does not support input
# operations.  Instead, this interpreter is specialized for debugging
# small embedded brainfuck code that generate deterministic output.
# Where there is a choice between speed and ease of debugging, the
# latter is preferred.
#
# 2013-09-27

use strict;
use Getopt::Long;
use constant MAX_LOOP_LIMIT => 0x200000;
use constant MAX_OUTPUT_LIMIT => 4096;
use constant MAX_TAPE_SIZE => 1024;


# {{{ Run time data and functions

# Data tape and pointer
my @d = ();
my $p = 0;

# Error message from executing the compiled code
my $eval_error = '';

# Evaluation counters, used to break infinite loops
my $loop_count = 0;
my $output_count = 0;

# Command line settings
my $expected = undef;
my $cursor = 0;
my $dump_tape = 0;

# Handle input operator
sub R($$)
{
   my ($line, $column) = @_;
   $eval_error = "$line:$column: input operations are not allowed\n";
   die;
}

# Handle output operator
sub W($$)
{
   my ($line, $column) = @_;

   if( $p < 0 )
   {
      $eval_error = "$line:$column: reading from negative tape [$p]\n";
      die;
   }
   unless( defined $d[$p] )
   {
      $eval_error = "$line:$column: uninitialized read [$p]\n";
      die;
   }
   if( ++$output_count > MAX_OUTPUT_LIMIT )
   {
      $eval_error = "$line:$column: max output limit exceeded: $output_count\n";
      die;
   }
   print chr($d[$p]);
}

# Handle output operator, for use with matching expected output
sub E($$)
{
   my ($line, $column) = @_;

   if( $p < 0 )
   {
      $eval_error = "$line:$column: reading from negative tape [$p]\n";
      die;
   }
   unless( defined $d[$p] )
   {
      $eval_error = "$line:$column: uninitialized read [$p]\n";
      die;
   }
   if( ++$output_count > length($expected) )
   {
      $eval_error = "$line:$column: max output limit exceeded: $output_count\n";
      die;
   }
   if( chr($d[$p]) ne substr($expected, $cursor, 1) )
   {
      $eval_error = "$line:$column: output mismatched on byte $cursor: " .
                    $d[$p] . " != " . ord(substr($expected, $cursor)) . "\n";
      die;
   }
   $cursor++;
}

# Check number of times loop condition has been evaluated.
# This breaks infinite loops.
sub L($$)
{
   my ($line, $column) = @_;
   if( ++$loop_count > MAX_LOOP_LIMIT )
   {
      $eval_error = "$line:$column: max loop limit exceeded: $loop_count\n";
      die;
   }
}

# Check cell updates for array bounds
sub A($$)
{
   my ($line, $column) = @_;
   if( $p < 0 )
   {
      $eval_error = "$line:$column: writing to negative tape [$p]\n";
      die;
   }
   if( $p >= MAX_TAPE_SIZE )
   {
      $eval_error = "$line:$column: tape overflow [$p]\n";
      die;
   }
}

# }}}

# {{{ Compile time functions

# Flush pending add instructions
sub FlushAdd($)
{
   my ($add) = @_;
   my $code = '';

   if( defined($$add) )
   {
      if( $$add > 0 )
      {
         $code = '$d[$p]+=' . $$add . ';';
      }
      elsif( $$add < 0 )
      {
         $code = '$d[$p]-=' . (-$$add) . ';';
      }
      $$add = undef;
   }
   return $code;
}

# Flush pending move instructions
sub FlushMove($)
{
   my ($move) = @_;
   my $code = '';

   if( $$move > 0 )
   {
      $code = '$p+=' . $$move . ';';
   }
   elsif( $$move < 0 )
   {
      $code = '$p-=' . (-$$move) . ';';
   }
   $$move = 0;
   return $code;
}

# Flush pending add or move instructions
sub Flush($$)
{
   my ($add, $move) = @_;
   return FlushAdd($add) . FlushMove($move);
}

# Optimize generated perl code
sub Optimize($)
{
   my ($code) = @_;

   $code =~ s/while\(\$d\[\$p\]\)\{
              L\(\d+,\d+\);
              A\(\d+,\d+\);
              \$d\[\$p\]-=1;
              \}/\$d[\$p]=0;/gx;
   return $code;
}

# Load input from stdin and convert it to perl code.  Dies on error.
sub CompileInput()
{
   # Perl code compiled from brainfuck code
   my $code = '';

   # Loop stack
   my @stack = ();

   # Pending operation
   my $move = 0;
   my $add = undef;

   while( my $line = <> )
   {
      my @bytes = map {chr $_} (unpack 'C*', $line);
      for(my $column = 1; $column <= $#bytes + 1; $column++)
      {
         my $opcode = $bytes[$column - 1];
         if( $opcode eq '+' || $opcode eq '-' )
         {
            $code .= FlushMove(\$move);
            unless( defined($add) )
            {
               $code .= "A($.,$column);";
               $add = 0;
            }
            $add += $opcode eq '+' ? 1 : -1;
         }
         elsif( $opcode eq '>' )
         {
            $code .= FlushAdd(\$add);
            $move++;
         }
         elsif( $opcode eq '<' )
         {
            $code .= FlushAdd(\$add);
            $move--;
         }
         elsif( $opcode eq '[' )
         {
            push @stack, "$.:$column";
            $code .= Flush(\$add, \$move) . "while(\$d[\$p]){L($.,$column);";
         }
         elsif( $opcode eq ']' )
         {
            unless( scalar @stack )
            {
               die "$.:$column: unmatched ]\n";
            }
            pop @stack;
            $code .= Flush(\$add, \$move) . '}';
         }
         elsif( $opcode eq ',' )
         {
            $code .= Flush(\$add, \$move) . "R($.,$column);";
         }
         elsif( $opcode eq '.' )
         {
            $code .= Flush(\$add, \$move);
            if( defined($expected) )
            {
               $code .= "E($.,$column);";
            }
            else
            {
               $code .= "W($.,$column);";
            }
         }
      }
   }
   if( scalar @stack )
   {
      die (join '', (map {"$_: unclosed [\n"} @stack));
   }
   $code .= Flush(\$add, \$move);
   return Optimize($code);
}

# Load expected output to $expected global variable
sub LoadExpectedOutput()
{
   my $opt = '';
   GetOptions('expected=s' => \$opt, 'debug' => \$dump_tape);
   if( $opt ne '' )
   {
      open my $file, "<$opt" or die "Can not open $opt: $!\n";
      $expected = join '', <$file>;
      close $file;
   }
}

# }}}


# Run program
LoadExpectedOutput();
eval CompileInput();

# Dump tape contents
if( $dump_tape )
{
   for(my $i = 0; $i <= $#d; $i++)
   {
      if( defined($d[$i]) )
      {
         print "[$i] = $d[$i]\n";
      }
   }
   print "p = $p\n";
}

# Check for abnormal termination
if( $eval_error ne '' )
{
   die "\n$eval_error";
}
if( defined($expected) && $cursor < length($expected) )
{
   die "Truncated output, cursor=$cursor, expected=" . length($expected) . "\n";
}
exit 0;
