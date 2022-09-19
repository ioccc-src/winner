/** J.K.Bonfield **
^	<						 	 							
^	>						 	 							
<			#				>						v		
<			 				 			<					
<			>				>			<		v		
X			 				 			X				j
x			 				 			X				j
X	 						x	^						k
^	 						 	^							
^	#						 									
X			 				X			X				X

^	v						 	 							
v						 	 						v		
v						#	 									
v						X	 						 		
v						x	 						 		
>				#			<						v		
>				 			 				>				
X				 			 				X			l
x				 			 				X			l

41 20
########################################
#                                      #
#  <   <   <   <   <>  <   <   <       #
#       >   >   >  <>   >   >   >   >  #
#  <   <   <   <   <>  <   <   <       #
#       >   >   >  <>   >   >   >   >  #
#  <   <   <   <   <>  <   <   <       #
#       >   >   >  <>   >   >   >   >  #
#                                      #
#                                      #
#                                      #
#                                      #
#                                      #
#                                      #
#                                      #
#                                      #
#                                      #
#                                      #
#           X                          #
########################################*/
#include <stdio.h>
#include <curses.h>
#include <stdlib.h>
#include <setjmp.h>
#include <sys/time.h>
int _tty_ch;
bool _echoit;
bool _rawmode;
SGTTY _tty;
#define U char
#define G for(
#define I )malloc(sizeof(

typedef struct z {U x[20]; struct z*y; } j; j*J[2][256];
struct timeval v= {0,1<<17} ;
U**X,c,*P="noopoqqnr",d;

j*a(int Q, int i) {
    G
    clear(),noecho(),cbreak(); ;
)

{
    int x=0,y=0,W=Q,Q=i-1,k;
    G;
    y<=Q;
    (mvaddch(y,x,X[y][x]),++x^W-1)||(x=0,y++));
    k=y=- --x;
    G
    refresh(),c=select(k,&y,0,0,&v)?getch():0;
    k?++x-W||(x=1,++y-Q||(--k,x=W-1,y=Q-1)):--x||(y--,x=W-1),k|y;
)

{
    j *t;
    G
    t=J[1-k][X[y][x]]; t; t=t->y) {
	U*f=t->x;
	if (d==f[17]|f[17]==c) {
	    int i=k&2,u=9,k=1,w=x,_=y,T;
	    G;
	    --u||(d-f[8]&&(X[y][x]=f[8]),w---_--,i=0,u=8,k--);) {
	        _+=P[T=i>u?u:i]-'o';
	        w+=P[4+T]-'p';
	        if(k) {
		    if (d-f[i]&&f[i]-X[_][w]) break;
		        i++;
	        } else
		    f[++i+8]-d && (X[_][w]=f[i+8]);
}   }   }   }   }   }

jmp_buf E;

int main(int open, U**exit) {
    FILE*C=fopen (
	open-2?__FILE__:*++exit,P+8);
	j*t;
	volatile int Q,Y=0;
	int i,q; d=open-2?'\t':'*'; L:

	Q=0; G; setjmp(E)<256; Q--
    )
    longjmp(E,(J[Y][Q]=0,Q++));
    G; ; ) {
	if(!C)return 1;
	if('\n'==(c=getc(C)))
	    if(!Y++)goto L; else
	    {	fscanf(C,"%d %d\n",&i,&q);
		X=(U**I P++)*q*(i+1));
	    Q=0; G; Q<q; Q++)
        X[Q]=(U*)&X[q]+Q*i;
    
	fread(*X,(initscr(),q*i),1,C);
	a(i,Q);
    }
    t=(j*I*a(Q--,--Q)));
    t->y=J[Y][c]; J[Y][c]=t;
    fgets(t->x,20,C); }
}
