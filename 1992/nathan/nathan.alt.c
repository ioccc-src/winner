#include <stdio.h>
static char *text[] =
{
  "Export of this program from the USA is governed by the US",
  "Munitions List from the ITAR (International Traffic in Arms",
  "Regulations). This list gives the specific categories of",
  "restricted exports and includes cryptographic exports. Traffic",
  "entirely external to, entirely internal to, or into the USA is",
  "not restricted.",
  "To obtain a copy of the program, email to nathan@inmos.co.uk",
  "with a subject \"IOCCC request\". If you know that your 'From'",
  "line is incorrect, add a single line",
  "\"replyto you@your.correct.address\" to the body of the message.",
  "A deamon will autoreply.",
  "WARNING: You must not re-export this out of the USA, or else",
  "the men in black might get you.",
  NULL
};
int main()
{
  char **ptr;

  for(ptr = text; *ptr; ptr++)
    printf("%s\n", *ptr);
  return 0;
}
