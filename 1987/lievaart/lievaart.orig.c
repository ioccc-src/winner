#define D define
#D Y return
#D R for
#D e while
#D I printf
#D l int
#D C y=v+111;H(x,v)*y++= *x
#D H(a,b)R(a=b+11;a<b+89;a++)
#D s(a)t=scanf("%d",&a)
l V[1100],u,r[]={-1,-11,-10,-9,1,11,10,9},h[]={11,18,81,88},ih[]={22,27,72,77},
bz,lv=60,*x,*y,m,t;S(d,v,f,a,b)l*v;{l c=0,*n=v+100,bw=d<u-1?a:-9000,w,z,i,zb,q=
3-f;if(d>u){R(w=i=0;i<4;i++)w+=(m=v[h[i]])==f?300:m==q?-300:(t=v[ih[i]])==f?-50
:t==q?50:0;return w;}H(z,0){if(GZ(v,z,f,100)){c++;w= -S(d+1,n,q,-b,-bw);if(w>bw
){zb=z;bw=w;if(w>=b||w>=8003)Y w;}}}if(!c){bz=0;C;Y-S(d+1,n,q,-b,-bw);}bz=zb;Y
d>=u-1?bw+(c<<3):bw;}main(){R(;t<1100;t+=100)R(m=0;m<100;m++)V[t+m]=m<11||m>88
||(m+1)%10<2?3:0;V[44]=V[55]=1;V[45]=V[54]=2;I("Level:");s(u);e(lv>0){do{I("Yo\
u:");s(m);}e(!GZ(V,m,2,0)&&m!=99);if(m!=99)lv--;if(lv<15&&u<10)u+=2;I("Wait\n")
;I("Value:%d\n",S(0,V,1,-9000,9000));I("move: %d\n",(lv-=GZ(V,bz,1,0),bz));}}GZ
(v,z,f,o)l*v;{l*j,q=3-f,g=0,i,h,*k=v+z;if(*k==0)R(i=7;i>=0;i--){j=k+(h=r[i]);e(
*j==q)j+=h;if(*j==f&&j-h!=k){if(!g){g=1;C;}e(j!=k)*((j-=h)+o)=f;}}Y g;}
