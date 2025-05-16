/* Preprocessor hack to set binary mode for stdin and stdout.

   This replaces main() with an alternative function forces binary
   modes.  This is intended to included via compiler arguments, so we
   would be able to enable binary modes without modifying the original
   program source.  Conceptually, it's similar to LD_PRELOAD, except
   we hack it in via preprocessor.

   It only works for programs where main() occurs just once.
*/

#if defined(_WIN32)
   #include<stdio.h>
   #include<fcntl.h>
   #include<io.h>
   #include<unistd.h>

   #define main \
      /* Forward declaration for the updated main(), now renamed  */         \
      /* binmode_main().  Return type is omitted since this macro */         \
      /* is expanded just after the return type.                  */         \
      binmode_main(int argc, char **argv);                                   \
                                                                             \
      /* Updated main(). */                                                  \
      int main(int argc, char **argv)                                        \
      {                                                                      \
         /* Set binary modes. */                                             \
         setmode(STDIN_FILENO, O_BINARY);                                    \
         setmode(STDOUT_FILENO, O_BINARY);                                   \
                                                                             \
         /* Call the original main(). */                                     \
         return binmode_main(argc, argv);                                    \
      }                                                                      \
                                                                             \
      /* Definition for the original main.  Function arguments are       */  \
      /* omitted since this macro is expanded just before the arguments. */  \
      int binmode_main

#endif
