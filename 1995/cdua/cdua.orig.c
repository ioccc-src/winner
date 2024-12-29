#define r return 

char*u0="<RET> to begin... ",*u1="Already been here!",*u2="Found a wall! \
    ",*u3="Walking...        ",*u4="Finished.         ",*u5="Going back..\
.     ",*o="\033[23;1HDone!!\n",*x="\033[2J",*y="\033[1;1H",*z="\033[%d;%\
dH%c",*w="\033[1;1H%s",*v="\033[%d;%dH%c\033[%d;%dH%c\033[%d;%dH%c",b[1841
];int c,d,e,f,g;typedef int(*h)();h i,j,k,l,m,n;int printf(),srand(),rand(
),time(),getchar();int main(int a){i=printf,j=srand,k=rand,l=time,m=getchar,
n=main;if(!c)for(j(l(0)),g=a=1000,--d;++d<1840;b[c=d]=" #\n"[d%80==79?2:d/80
&&d%80&&d/80-22&&d%80-78]);if(!(c-1839))++c,i("%s%s%s",x,y,b);k:if(!(c-1840)
&&(b[a+2]+b[a-2]+b[a+160]+b[a-160]-4*' ')){while(b[a+(f=(e=k()%4)?e-1?e-2?-1
:1:-80:80)*2]!='#');b[a]=b[a+f]=b[f+a+f]=' ';i(v,a/80+1,1+a%80,' ',(a+f)/80+
1,1+(a+f)%80,' ',(f+a+f)/80+1,1+(f+a+f)%80,' ');n(f+a+f);goto k;}else if(!(g
-a))c=1,a=162,i(w,u0),m();if(c-1){}else r b[a]!=' '?(i(w,b[a]=='.'?u1:u2),0)
:(b[a]='.',i(w,u3),i(z,a/80+1,1+a%80,'.'),a==1676?(i(w,u4),i(o),1):n(a+1)||n
(a+80)||n(a-80)||n(a-1)?1:(b[a]=' ',i(w,u5),i(z,a/80+1,1+a%80,' '),0));r 0;}
