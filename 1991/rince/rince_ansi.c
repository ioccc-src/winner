#include <curses.h>
int u=484,X[]={-1,0,0,1},Y[]={0,1,-1,0},x,y,D,i,j,a;
char o,m,*t,*O="MNOH",*k="hjkl",*s="######\0######\0######\0      \0      \0      \0  ___ \0 /   \\\0 \\___/\0  ___ \0 /@@@\\\0 \\@@@/\0| | /\\\0----||\0    \\/\0  /--\\\0   \\/ \0 ==|  \0 ==|  \0   /\\ \0  \\--/\0 /O__o\0 \\___/\0 /_\\_ \0  <<  \0  <<  \0  <<  \0      \0vvvvvv\0      \0      \0^^^^^^\0      \0  /\\  \0 <  > \0  \\/  \0o__O\\ \0\\___/ \0 _/_\\ \0 O__O \0/----\\\0_/  \\_\0 ^__^ \0/----\\\0_/  \\_" ,
M[12][22]={"AAAAAAAAAAAAAAAAAAAAAA" ,"ALCABBBBBBBABBCBBCABBA", "ACCABAKAAABAFBABABAEBA", "ABBBBABBIBBBBBEEABACLA", "ACCBNIBBAAAAGALBBBABCA", "AAAAAAAJACBABBCABAABCA", "ALLAACCBACBAAALLCABBBA", "ABDLAAABABCAAAALCABBLA", "ABCBIBBBBBBBBAAAAACBBA", "ABCCAABBADBBBBDBDBDBCA", "ALBBACCCCDBCABBBDBBBBA", "AAAAAAAAAAAAAAAAAAAAAA" };main(){initscr();clear();
noecho();cbreak();x=y=4;D=39,o='M';m=M[y][x] ;while(D&&u){for(i=j=a=0;j<7;!(mvaddstr(
j*3+a,i*6,s+(((M[((y-1)/5)*5+j][((x-1)/10)*10+i]-'A')*3+a++)*7)),a^3)&&(a=0,!
(++i^12))&&(a=i=0,j++));refresh();M[y][x] ='B';if(t=(char*)strchr(k,getch())){int e=
x,g=y,f=x,h=y,d=t-k;o=O[d];f=(e=x+X[d])+X[d];h=(g=y+Y[d])+Y[d];switch(M[g][e] ){case
'B':x=e;y=g,u--;break ;case 'C':if(M[h][f] =='B')M[h][f] =M[g][e] ,x=e,y=g,u--; else if(M[h][f] =='C')M[h][f] =M[g][e] ='L';break ;case 'D':if(M[h][f] =='B')M[h][f] =M[g][e] ,x=e,y=g,u--; break ;case'L':x=e;y=g,u--;D
--;break ;case 'E':if(M[h][f] =='B')M[h][f] =M[g][e] ,x=e,y=g,u--; else if(M[h][f] =='I'&&d==0)M[h][f] =M[g][e] ='B';break ; case 'F':if(M[h][f] =='B')M[h][f] =M[g][e] ,x=e,y=g,u--; else if(M[h][f] =='J'&&d==1)M[h][f] =M[g][e] ='B';break ; case 'G':if(M[h][f] =='B')M[h][f] =M[g][e] ,x=e,y=g,u--; else if(M[h][f] =='K'&&d==2)M[h][f] =M[g][e] ='B';break ; }}m=M[y][x] ;M[y][x] =o;}clear();mvaddstr(12
,31,u?"Well done!":"Too many moves");move(23,0);refresh();endwin();return 0;}

