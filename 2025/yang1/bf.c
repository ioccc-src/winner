/* Brainfuck interpretor.

   Usage:
      ./bf [program.bf] [input.txt]
      ./bf - [input.txt] < {program.bf}
      ./bf < {program.bf}

   If first argument is specified and it's not "-", input program will be
   read from that file instead of stdin.

   If second argument is specified, "," operator will read from that file
   instead of stdin.
*/

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

/* Tape cell data type. */
typedef int Cell;

/* Return this value to "," operator when end-of-file is reached. */
static const Cell kEndOfFile = -1;

typedef enum
{
   kAdd,    /* Adjust data.  Argument is delta to apply. */
   kShift,  /* Adjust pointer.  Argument is amount of shift to apply. */
   kBegin,  /* Start of loop.  Argument is index at one past end of loop. */
   kEnd,    /* End of loop.  Argument is index at start of loop. */
   kInput,  /* Read input. */
   kOutput  /* Write output. */
} Opcode;

typedef struct
{
   Opcode op;
   int arg;
} Instruction;

typedef struct
{
   Instruction *code;
   int size;      /* Number of instructions loaded. */
   int capacity;  /* code buffer size in instruction units. */
} Program;

typedef struct
{
   Cell *data;
   int size;      /* Highest address written. */
   int capacity;  /* data buffer size in number of ints. */
} Tape;

/* Unload program from memory. */
static void UnloadProgram(Program *program)
{
   if( program != NULL )
   {
      free(program->code);
      free(program);
   }
}

/* Syntactic sugar. */
static Program *UnloadAndReturnNull(Program *program, int *addr_stack)
{
   free(addr_stack);
   UnloadProgram(program);
   return NULL;
}

/* Optionally extend program code array, returning zero on success. */
static int ExtendCode(Program *program)
{
   Instruction *i;

   if( program->size < program->capacity )
      return 0;

   program->capacity += 1024;
   i = (Instruction*)realloc(
      program->code, program->capacity * sizeof(Instruction));
   if( i == NULL )
   {
      fputs("Out of memory\n", stderr);
      return 1;
   }
   program->code = i;
   return 0;
}

/* Extend program code with arithmetic or shift operation,
   returning zero on success.                              */
static int ExtendWithOpcode(Program *program, Opcode op, int delta)
{
   if( ExtendCode(program) != 0 )
      return 1;
   if( program->size == 0 || program->code[program->size - 1].op != op )
   {
      program->code[program->size].op = op;
      program->code[program->size].arg = delta;
      program->size++;
   }
   else
   {
      program->code[program->size - 1].arg += delta;
   }
   if( program->code[program->size - 1].arg == 0 )
      program->size--;

   return 0;
}

/* Load program from opened file, returning NULL on error. */
static Program *LoadProgram(FILE *input)
{
   Program *program;
   int *addr_stack = NULL, *a;
   int stack_size = 0, stack_capacity = 0;
   int c;

   if( (program = (Program*)calloc(1, sizeof(Program))) == NULL )
   {
      fputs("Out of memory\n", stderr);
      return NULL;
   }

   while( (c = fgetc(input)) != EOF )
   {
      switch( c )
      {
         case '+':
            if( ExtendWithOpcode(program, kAdd, 1) != 0 )
               return UnloadAndReturnNull(program, addr_stack);
            break;

         case '-':
            if( ExtendWithOpcode(program, kAdd, -1) != 0 )
               return UnloadAndReturnNull(program, addr_stack);
            break;

         case '>':
            if( ExtendWithOpcode(program, kShift, 1) != 0 )
               return UnloadAndReturnNull(program, addr_stack);
            break;

         case '<':
            if( ExtendWithOpcode(program, kShift, -1) != 0 )
               return UnloadAndReturnNull(program, addr_stack);
            break;

         case ',':
            if( ExtendCode(program) != 0 )
               return UnloadAndReturnNull(program, addr_stack);
            program->code[program->size].op = kInput;
            program->code[program->size].arg = 0;
            program->size++;
            break;

         case '.':
            if( ExtendCode(program) != 0 )
               return UnloadAndReturnNull(program, addr_stack);
            program->code[program->size].op = kOutput;
            program->code[program->size].arg = 0;
            program->size++;
            break;

         case '[':
            if( ExtendCode(program) != 0 )
               return UnloadAndReturnNull(program, addr_stack);
            if( stack_size == stack_capacity )
            {
               stack_capacity += 256;
               a = (int*)realloc(addr_stack, stack_capacity * sizeof(int));
               if( a == NULL )
               {
                  fputs("Out of memory\n", stderr);
                  return UnloadAndReturnNull(program, addr_stack);
               }
               addr_stack = a;
            }
            addr_stack[stack_size++] = program->size;

            program->code[program->size].op = kBegin;
            program->size++;
            break;

         case ']':
            if( ExtendCode(program) != 0 )
               return UnloadAndReturnNull(program, addr_stack);
            if( stack_size == 0 )
            {
               fputs("Unmatched ]\n", stderr);
               return UnloadAndReturnNull(program, addr_stack);
            }
            stack_size--;

            program->code[program->size].op = kEnd;
            program->code[program->size].arg = addr_stack[stack_size];
            program->size++;

            program->code[addr_stack[stack_size]].arg = program->size;
            break;

         default:
            continue;
      }
   }

   if( stack_size > 0 )
   {
      fputs("Unmatched [\n", stderr);
      return UnloadAndReturnNull(program, addr_stack);
   }

   free(addr_stack);
   return program;
}

/* Extend tape to cover the address referenced by data pointer.
   Returns 0 on success.                                        */
static int ExtendTape(Tape *tape, int dp)
{
   Cell *d;
   int old_capacity;

   if( dp < 0 )
   {
      fputs("Attempting to reference negative address\n", stderr);
      return 1;
   }

   if( tape->capacity > dp )
      return 0;

   /* Extend tape buffer size so that we have enough to cover the
      referenced address, and align this size to block size so that
      we don't re-allocate on every size adjustment.                */
   old_capacity = tape->capacity;
   tape->capacity = dp - (dp % 1024) + 1024;
   d = (Cell*)realloc(tape->data, tape->capacity * sizeof(Cell));
   if( d == NULL )
   {
      fputs("Out of memory\n", stderr);
      return 1;
   }
   tape->data = d;

   memset(tape->data + old_capacity * sizeof(Cell),
          0,
          (tape->capacity - old_capacity) * sizeof(Cell));
   return 0;
}

/* Run program with opened input, returns 0 on success. */
static int Run(const Program *program, Tape *tape, FILE *input)
{
   int ip = 0, dp = 0, c;
   while( ip < program->size )
   {
      switch( program->code[ip].op )
      {
         case kAdd:
            if( ExtendTape(tape, dp) != 0 )
               return 1;

            /* Mark current address as initialized. */
            tape->size = tape->size > dp + 1 ? tape->size : dp + 1;

            /* Update data cell. */
            tape->data[dp] += program->code[ip].arg;
            ip++;
            break;

         case kShift:
            dp += program->code[ip].arg;
            ip++;
            break;

         case kBegin:
            if( ExtendTape(tape, dp) != 0 )
               return 1;
            if( tape->data[dp] == 0 )
            {
               ip = program->code[ip].arg;
            }
            else
            {
               ip++;
            }
            break;

         case kEnd:
            ip = program->code[ip].arg;
            break;

         case kInput:
            if( ExtendTape(tape, dp) != 0 )
               return 1;
            c = fgetc(input);
            tape->data[dp] = c != EOF ? (Cell)c : kEndOfFile;
            tape->size = tape->size > dp + 1 ? tape->size : dp + 1;
            ip++;
            break;

         case kOutput:
            if( dp < 0 )
            {
               fputs("Reading from negative address\n", stderr);
               return 1;
            }
            if( dp >= tape->size )
            {
               fputs("Outputting uninitialized data\n", stderr);
               return 1;
            }
            putchar(tape->data[dp]);
            ip++;
            break;
      }
   }
   return 0;
}

int main(int argc, char **argv)
{
   FILE *input;
   Program *program;
   Tape tape;
   int status;

   memset(&tape, 0, sizeof(Tape));

   /* Load program. */
   if( argc > 1 && strcmp(argv[1], "-") != 0 )
   {
      if( (input = fopen(argv[1], "rb")) == NULL )
      {
         fprintf(stderr, "Error loading program from %s\n", argv[1]);
         return 1;
      }
      program = LoadProgram(input);
      fclose(input);
   }
   else
   {
      program = LoadProgram(stdin);
   }
   if( program == NULL )
      return 1;

   /* Open input and run. */
   if( argc > 2 )
   {
      if( (input = fopen(argv[2], "rb")) == NULL )
      {
         fprintf(stderr, "Error opening %s for reading\n", argv[2]);
         status = 1;
      }
      else
      {
         status = Run(program, &tape, input);
         fclose(input);
      }
   }
   else
   {
      status = Run(program, &tape, stdin);
   }

   free(tape.data);
   UnloadProgram(program);
   return status;
}
