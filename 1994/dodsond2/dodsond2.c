#include <ctype.h>
#include <stdio.h>
#define A { E"Your score is %d\n",j);exit(0);}
#define B(x,y) K(x<y){p=x;x=y;y=p;}
#define C do{p=random()%N;}F(c[p]||d[p]);
#define D random()%N
#define E printf(
#define F while
#define G int
#define H return
#define I for
#define J(r,j) a[r][j]
#define K if
#define L else
#define M isdigit
#define N 30
#define P getchar()
G a[N][3],b[N],c[N],d[N],e[N],f[N],g[N],i,j=0,k,l=0;
main(){m();n();A;}m(){G o;srandom(getpid());do{I(o=0;
o<N;e[o++]=3){J(o,0)=J(o,1)=J(o,2)=-1;c[o]=d[o]=g[o]=0;
b[o]=N*2;}r(0);s();}F(s());t();}s(){G o,p;I(o=0;o<N;o++){
B(J(o,2),J(o,1))B(J(o,1),J(o,0))B(J(o,2),J(o,1))K(J(o,0)==-1)H(1);
}H(0);}t(){G o,p;I(o=0;o<N;o+=8){C c[p]=1;C d[p]=1;}w(D,0);I(o=0;
o<3;o++){do{p=D;}F(c[p]||d[p]||f[p]||!b[p]);f[p]=1;}do{k=D;}
F((c[k])||(d[k])||(b[k]==0));}w(o,d)G o,d;{G x;b[o]=d;I(x=0;
x<3;x++)K(b[J(o,x)]>d)w(J(o,x),d+1);}G r(x)G x;{G y,t=0,u;
F(e[x]){u=3;(e[x])--;do{y=D;K(t++>1000)H(0);K(t%100==0)u--;}
F((y==x)||(e[y]<=0)||(y==J(x,2))||(y==J(x,1))||(e[y]<u));(e[y])--;
J(x,e[x])=y;J(y,e[y])=x;K(!r(y)){J(x,e[x])=J(y,e[y])=-1;(e[y])++;
(e[x])++;}L t=0;}H(1);}n(){G r,n;char v;do{r=D;}
F(c[r]||d[r]||(b[r]<3)||d[J(r,0)]||d[J(r,1)]||d[J(r,2)]||
c[J(r,0)]||c[J(r,1)]||c[J(r,2)]);F(1){E"You are in room %d\n",r);
K(f[r]){i++;E"You found an arrow\n");j+=20;f[r]=0;}K(b[r]==0){
E"Wumpus meat\n");j-=100;A;}K(d[r]){E"You fell in a pit\n");j-=50;
A;}K(r==k){K(i){i--;l++;j-=20;E"You are missing an arrow!\n");
}K(l==3){E"You catch the robber and recover all 3 arrows!\n");
i=3;j+=200;k=-1;}L{E"The robber scurries away\n");do{k=D;}
F((c[k])||(d[k])||(b[k]==0)||(k==r));}}K(c[r]){c[r]=0;c[D]=1;r=D;
E"The bats pick you up and drop you in room %d\n",r);j-=10;}L{
K(b[r]<3)E"You smell a wumpus\n");
K(d[J(r,0)]||d[J(r,1)]||d[J(r,2)])E"You feel a breeze\n");
K(c[J(r,0)]||c[J(r,1)]||c[J(r,2)])E"You hear a rustling sound\n");
E"Passageways to room %d, %d, and %d\n",J(r,0),J(r,1),J(r,2));
K(!g[r]){j+=10;g[r]=1;}do{v=P;K(v=='s')q(r);K(v=='l')break;
K(v=='i')E"You have %d arrow%c\n",i,i-1?'s':' ');K(v=='q')A;}
F(!M(v));K(M(v)){n=v-'0';v=P;K(M(v))n=n*10+v-'0';
K((J(r,0)==n)||(J(r,1)==n)||(J(r,2)==n))r=n;}}}}q(r)G r;{G z,n;
char v;K(i==0){E"You have no arrows\n");H;}i--;
E"Shoot into which rooms?  ");I(z=0;z<4;z++){j-=20*z;do{v=P;
K((v=='\n')&&(i>0)){j-=50;E"You have %d arrows\n",i);H;}}F(!M(v));
n=v-'0';v=P;K(M(v))n=10*n+v-'0';K((J(r,0)==n)||(J(r,1)==n)||(J(r,2)
==n)){r=n;K(b[r]==0){E"You have killed the Wumpus!\n");j+=500+i*100;
A;}}L K(random()%3==1){E"The arrow bounces back and kills you\n");
j-=100;A;}L{I(n=0;n<N;n++)b[n]=2*N;w(D,0);j-=100;}K(v=='\n'){j-=50;
E"You have %d arrows\n",i);H;}}}
