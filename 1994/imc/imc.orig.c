#include<stdio.h>
#include<stdlib.h>
#define f (sizeof(int))

int i,j,k,l,m,*t,*u,*v;
int r(x)int x;{return (rand()/256)%x;}
void p(x,y)int *x,y;{for(i=y;--i;k=x[i],x[i]=x[j],x[j]=k)j=r(i+1);}

void o(n,a,q,d)int n,d,*a,*q;
{
   for(m=r(2)?n:1,t=q,l=n/2,i=n;
       i--&&(i!=l||i--);
       *(t++)=i);
   for(p(q,n-1),q[n-1]=l,u=a,i=j=0;
       i<n*n;
       u[i] =q[j]*m,j++,++i%n||(++j,u+=d),j>=n&&(j-=n));
   for(p(q,n-1),u=a,m=n+1-m,i=0,j=n-1;
       i<n*n;
       u[i]+=q[j]*m,j++,++i%n||(--j,u+=d),j>=n&&(j-=n));
}

void s(n,a,q,d)int n,d,*a,*q;
{
   for(q[1]=3-(*q=r(n)),q[3]=3-(q[2]=1^q[r(2)]),t=a,i=n,m=3*r(2);
       i--;
       t+=d)
   for(j=n;
       j--;
       t++[0]=q[j^(i&m)^(i/2)]);
   for(q[1]=3-(*q=r(n)),q[3]=3-(q[2]=1^q[r(2)]),t=a,i=n,m=3-m;
       i--;
       t+=d)
   for(j=n;
       j--;
       t++[0]+=q[j^(i&m)^(i/2)]*4);
}

void e(n,a,q,d)int n,d,*a,*q;
{
   int h,i,k,l,z,g=n/2;
   void (*m)();
   for((m=g!=4?g%2?o:e:s)(g,a,q,g+d),m(g,a+g,q,g+d),l=(n+d)*g,u=a,i=g;
       i--;
       u+=d)
   for(j=n;
       j--;
       j<g&&(*u+=g*2*g),l[u]=*u+(j<g?-1:3)*g*g,u++);
   for(i=g; i--; q[i]=i<g/2);
   for(h=k=(g+1)/2,v=a; v<a+n; v+=g){
      for(u=v,i=g; i--; u+=g+d){
         if(p(q,g),q[z=g-i-1])
         if(k)k--;
         else
         for(j=g;q[--j]||(q[j]=1,q[z]=0););
         else 
         if(k>i)
         for(j=g;!q[--j]||(k--,q[z]=1,q[j]=0););
         if(q[i])
         if(h)h--;
         else
         for(j=g;q[--j]||j==z||(q[j]=1,q[i]=0););
         else
         if(h>i||(g==3&&h&&(k==2||i==z)))
         for(j=g;!q[--j]||j==z||(h--,i==z&&k--,q[i]=1,q[j]=0););
         for(t=q,j=g;j--;u++)
         if(0[t++])z=*u,*u=u[l],u[l]=z;
      }
      for(h=k=g/2-g%2,i=g;i--;q[i]=i<h);
   }
}

int main(c,v)
int c;
char **v;
{
   int n,*a,*b;
   srand(getpid());
   if(c<2 || sscanf(1[v],"%d",&n)!=1 || n<3) n=5;
   if(!((a=(int*)malloc(n*n*f))&&(b=(int*)malloc(n*f))))
      return perror("malloc"),1;
   (n!=4?n%2?o:e:s)(n,a,b,0);
   for(i=0;i<n*n;i++)
      printf("%4d%c",a[i]+1,(i+1)%n?' ':'\n');
   return 0;
}
