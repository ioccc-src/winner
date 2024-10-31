/* file: better_time.c */
/*
 * If you enjoyed the functionality of my 1994 IOCCC entry (you like having
 * a clock on your screen at all times) but you do not want to use up 7 
 * process slots to run the code, then this is the program for you. This
 * program uses ANSI/VTxxx escape sequences and perodic time(3) calls to 
 * print a clock in the upper right corner of you screen.
 * 
 *     -Andrew Shapiro
 *      CSES/CIRES University of Colorado
 *      Campus Box 216
 *      Boulder, CO 80309-0216, USA
 * 
 *      shapiro@alumni.cs.colorado.edu
 *      andrew@gooter.metronet.org
 * 
 * To build:
 *	cc -o shapiro.alt shapiro.alt.c
 * 
 * To run:
 *	shapiro.alt &
 * 
 */
#include <stdio.h>
#include <time.h>

#define ESC '\033'
#define MOVETO "\033[%d;%d;H"
#define SAVE "\0337"
#define RESTORE "%c8",ESC
#define ROW 1
#define COL 50

main()
{
  time_t i;
  char * atime;

  while (1) {
    time(&i);
    atime = asctime(localtime(&i));
    atime[strlen(atime)-1] = '\0';
    printf(SAVE);
    printf(MOVETO,ROW,COL);
    printf(" +--------------------------+ ");
    printf(MOVETO,ROW+1,COL);
    printf(" + %s +",atime);
    printf(MOVETO,ROW+2,COL);
    printf(" +--------------------------+ ");
    printf(MOVETO,ROW+3,COL);
    printf("                              ");
    printf(RESTORE);
    fflush(stdout); /**/
    sleep(1);
  }
}

