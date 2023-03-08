# Best game:

	John Tromp
	Centre for Mathematics and Computer Science (CWI)
	Oetgensstraat 7
	1701CK Heerhugowaard
	Netherlands

## To build:

        make all

NOTE: we used a patch from Yusuke Endoh to get this to compile under gcc. Thank
you Yusuke for your assistance! Cody Boone Ferguson got this to work with clang
by further changing the variable `a` to be not the third argument to `main()` to
a variable declared in `main()`. We thank you for your assistance Cody (he
cynically notes that he did it because tetris just has to work)!


### To run

	./tromp [drops_per_sec  [cmd_string]]

NOTE: after this game is finished you will likely get an error along the lines
of:

    Segmentation fault: 11
    stty: stdin isn't a terminal


and a file `HI` will be in the directory.

## Judges' comments

This is a character terminal version of the TETRIS program.
It runs on a VT100 compatible terminal or emulator.  It is
best used at 4800 baud or more.

By default, "drops_per_sec", the number of times an object
will drop in a second, is 2.  The default "cmd_string" is
"jkl pq".  The first 6 characters of "cmd_string" relate
to the following 6 game commands:

		    j - left
		    k - rotate
		    l - right
	      <space> - drop
		    p - pause
		    q - quit

Specifying "cmd_string" allows one to re-define the commands.
The pause command pauses the game, clears the screen and
prints the current score.  To un-pause, type the pause
character again, which by default is "p".

As was stated last year, we are likely to be more strict about
portability in the future.  [ We mean it this time :-) ]

### Bug fix thank you

[Yusuke Endoh](/winners.html#Yusuke_Endoh) provided a patch to get
this entry to compile with modern compilers.

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson)
fixed this so it will compile and work under clang.

## Author's comments

This program plays the familiar game of `TETRIS' with the
following features:

* outputs vt100-like escape-sequences for cursor
  positioning and normal/reverse video in curses
  like fashion (minimal output for screen updates)

* continuously increasing speed (except in pause)

* start speed selectable by giving n as first argument,
  where n is the number of drops per second (default=2).

* controls also selectable by giving as the second argument
  a string of 6 characters.  By default they are "jkl pq".

* screen is blanked during the pause and the score is shown

* maintains a high-score table

Giving a full path name for the table will result in a
system-wide hiscore allowing a competition between users.

The author provided us with the following notes and new version of
the program:

Here is a somewhat improved version of my tetris entry.  All the
changes are in the popen() at the end.  Formerly a move was done
to the HI score file which is not permitted for other users. Now
other users can change the HI score file.  The extra option -m is
passed to sort, so that it knows that its input files are already
sorted.  The -o output option of sort is used instead of a
temporary file.

You may also want to consider giving just the raw option to stty
at the start and -raw at the end. This further reduces the size of
the program, but has the possible disadvantage that the program
can only by stopped by 'q' or by the `kill -9' command.

long h[4];t(){h[3]-=h[3]/3000;setitimer(0,h,0);}c,d,l,v[]={(int)t,0,2},w,s,I,K
=0,i=276,j,k,q[276],Q[276],*n=q,*m,x=17,f[]={7,-13,-12,1,8,-11,-12,-1,9,-1,1,
12,3,-13,-12,-1,12,-1,11,1,15,-1,13,1,18,-1,1,2,0,-12,-1,11,1,-12,1,13,10,-12,
1,12,11,-12,-1,1,2,-12,-1,12,13,-12,12,13,14,-11,-1,1,4,-13,-12,12,16,-11,-12,
12,17,-13,1,-1,5,-12,12,11,6,-12,12,24};u(){for(i=11;++i<264;)if((k=q[i])-Q[i]
){Q[i]=k;if(i-++I||i%12<1)printf("\033[%d;%dH",(I=i)/12,i%12*2+28);printf(
"\033[%dm  "+(K-k?0:5),k);K=k;}Q[263]=c=getchar();}G(b){for(i=4;i--;)if(q[i?b+
n[i]:b])return 0;return 1;}g(b){for(i=4;i--;q[i?x+n[i]:x]=b);}main(C,V,a)char*
*V,*a;{h[3]=1000000/(l=C>1?atoi(V[1]):2);for(a=C>2?V[2]:"jkl pq";i;i--)*n++=i<
25||i%12<2?7:0;srand(getpid());system("stty cbreak -echo stop u");sigvec(14,v,
0);t();puts("\033[H\033[J");for(n=f+rand()%7*4;;g(7),u(),g(0)){if(c<0){if(G(x+
12))x+=12;else{g(7);++w;for(j=0;j<252;j=12*(j/12+1))for(;q[++j];)if(j%12==10){
for(;j%12;q[j--]=0);u();for(;--j;q[j+12]=q[j]);u();}n=f+rand()%7*4;G(x=17)||(c
=a[5]);}}if(c==*a)G(--x)||++x;if(c==a[1])n=f+4**(m=n),G(x)||(n=m);if(c==a[2])G
(++x)||--x;if(c==a[3])for(;G(x+12);++w)x+=12;if(c==a[4]||c==a[5]){s=sigblock(
8192);printf("\033[H\033[J\033[0m%d\n",w);if(c==a[5])break;for(j=264;j--;Q[j]=
0);while(getchar()-a[4]);puts("\033[H\033[J\033[7m");sigsetmask(s);}}d=popen(
"stty -cbreak echo stop \023;sort -mnr -o HI - HI;cat HI","w");fprintf(d,
"%4d from level %1d by %s\n",w,l,getlogin());pclose(d);}

Copyright (c) 1989, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
