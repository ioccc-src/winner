#define D define
#D Y return
#D R for
#D e while
#D I printf
#D l int
#D W if
#D C y=v+111;H(x,v)*y++= *x
#D H(a,b)R(a=b+11;a<b+89;a++)
#D s(a)t=scanf("%d",&a)
#D U Z I
#D Z I("123\
45678\n");H(x,V){putchar(".XO"[*x]);W((x-V)%10==8){x+=2;I("%d\n",(x-V)/10-1);}}
l V[1600],u,r[]={-1,-11,-10,-9,1,11,10,9},h[]={11,18,81,88},ih[]={22,27,72,77},
bz,lv=60,*x,*y,m,t;S(d,v,f,_,a,b)l*v;{l c=0,*n=v+100,j=d<u-1?a:-9000,w,z,i,g,q=
3-f;W(d>u){R(w=i=0;i<4;i++)w+=(m=v[h[i]])==f?300:m==q?-300:(t=v[ih[i]])==f?-50:
t==q?50:0;Y w;}H(z,0){W(E(v,z,f,100)){c++;w= -S(d+1,n,q,0,-b,-j);W(w>j){g=bz=z;
j=w;W(w>=b||w>=8003)Y w;}}}W(!c){g=0;W(_){H(x,v)c+= *x==f?1:*x==3-f?-1:0;Y c>0?
8000+c:c-8000;}C;j= -S(d+1,n,q,1,-b,-j);}bz=g;Y d>=u-1?j+(c<<3):j;}main(){R(;t<
1600;t+=100)R(m=0;m<100;m++)V[t+m]=m<11||m>88||(m+1)%10<2?3:0;I("Level:");V[44]
=V[55]=1;V[45]=V[54]=2;s(u);e(lv>0){Z do{I("You:");s(m);}e(!E(V,m,2,0)&&m!=99);
W(m!=99)lv--;W(lv<15&&u<10)u+=2;U("Wait\n");I("Value:%d\n",S(0,V,1,0,-9000,9000
));I("move: %d\n",(lv-=E(V,bz,1,0),bz));}}E(v,z,f,o)l*v;{l*j,q=3-f,g=0,i,w,*k=v
+z;W(*k==0)R(i=7;i>=0;i--){j=k+(w=r[i]);e(*j==q)j+=w;W(*j==f&&j-w!=k){W(!g){g=1
;C;}e(j!=k)*((j-=w)+o)=f;}}Y g;}
