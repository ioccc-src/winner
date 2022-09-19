#include <curses.h>
#define R break
#define U M[h][f]
#define W M[g][e]
#define T M[y][x]
#define B(a) "A"#a"A",
#define A "AAAAAAAAAAAAAAAAAAAAAA"
#define z(a) case a:if(U=='B')U=W,x=e,y=g,u--;
#define Z(a,b) else if(U==a&&d==b)U=W='B';R;
#define K(a) a##a##a
#define k(a) #a#a#a#a#a#a"\0"
#define V "      \0"
#define S " \0/----\\\0_/  \\_"
int u=484,X[]={-1,0,0,1},Y[]={0,1,-1,0},x,y,D,i,j,a;char o,m,*t,*O="MNOH"
,*k="hjkl",*s=K(k(#))V V V"  ___ \0 /   \\\0 \\___/\0  ___ \0 /@@@\\\0 "
"\\@@@/\0| | /\\\0----||\0    \\/\0  /--\\\0   \\/ \0 ==|  \0 ==|  \0  "
" /\\ \0  \\--/\0 /O__o\0 \\___/\0 /_\\_ \0"K("  <<  \0")V k(v)V V k(^)V
"  /\\  \0 <  > \0  \\/  \0o__O\\ \0\\___/ \0 _/_\\ \0 O__O"S"\0 ^__^"S,
M[12][22]={A,B(LCABBBBBBBABBCBBCABB)B(CCABAKAAABAFBABABAEB
)B(BBBBABBIBBBBBEEABACL)B(CCBNIBBAAAAGALBBBABC)B(AAAAAAJACBABBCABAABC
)B(LLAACCBACBAAALLCABBB)B(BDLAAABABCAAAALCABBL)B(BCBIBBBBBBBBAAAAACBB
)B(BCCAABBADBBBBDBDBDBC)B(LBBACCCCDBCABBBDBBBB)A};main(){initscr();clear();
noecho();cbreak();x=y=4;D=39,o='M';m=T;while(D&&u){for(i=j=a=0;j<7;!(mvaddstr(
j*3+a,i*6,s+(((M[((y-1)/5)*5+j][((x-1)/10)*10+i]-'A')*3+a++)*7)),a^3)&&(a=0,!
(++i^12))&&(a=i=0,j++));refresh();T='B';if(t=(char*)strchr(k,getch())){int e=
x,g=y,f=x,h=y,d=t-k;o=O[d];f=(e=x+X[d])+d[X];h=(g=y+Y[d])+d[Y];switch(W){case
'B':x=e;y=g,u--;R;z('C')else if(U=='C')U=W='L';R;z('D')R;case'L':x=e;y=g,u--;D
--;R;z('E')Z('I',0)z('F')Z('J',1)z('G')Z('K',2)}}m=T;T=o;}clear();mvaddstr(12
,31,u?"Well done!":"Too many moves");move(23,0);refresh();endwin();return 0;}

