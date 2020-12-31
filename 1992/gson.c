#include <stdio.h> 

long a
[4],b[
4],c[4]
,d[0400],e=1;
typedef struct f{long g
,h,i[4]	   ,j;struct f*k;}f;f g,*
l[4096		     ]; char h[256],*m,k=3;
		     long n	(o, p,q)long*o,*p,*q;{
		     long r		  =4,s,i=0;for(;r--;s=i^
		     *o^*p,			    i=i&*p|(i|*p)&~*o++,*q
		     ++=s,p			    ++);return i;}t(i,p)long*p
		     ;{*c=d		  [i],n(a,c,b),n(p,b,p);}u(j)f*j;{j->h
		     =(j->g	=j->i[0]|j->i[1]|j->i[2]|j->i[3])&4095;}v(
j,s)f*		     j; {int i; for(j->k->k&&v(j->k, ' '),fseek(
stdin,	   j->j, 0);i=getchar(),putchar(i-'\n'?i:s),i-
'\n';);}w(o,r,j,x,p)f*o,*j;long p;{f q;int 
s,i=o->h;q.k=o;r>i?j=l[r=i]:r<i&&
(s=r&~i)?(s|=s>>1, s|=s
>>2,s|=s>>4,s
|=s>>8
,j=l[r
=((r&i
			 |s)&~(s>>1))-1&i]):0;--x;for
		 (;x&&!(p&i);p>>=1);for(;!x&&j;n(o->i,j->i,q.
	    i),u(&q),q.g||(q.j=j->j,v(&q,'\n')),j=j->k);for(;x;j=x
	 ?j->k:0){for(;!j&&((r=(r&i)-1&i)-i&&(r&p)?2:(x=0));j=l[r]);!
      x||(j->g&~o->g)||n			      (o->i,j->i,q.i)||(
    u(&q), q.j=j					      ->j,q.g?w(&q
   ,r,j->k,x							  ,p):v(&q,
  '\n'));							     }}y(){f
 j;char								       *z,*p;
for(;m									? j.j=
ftell(									stdin)
,7,(m=			     gets(m					))||w(
&g,315			     *13,l[					4095]
 ,k,64*			     64)&0:				       0;n(g
  .i,j.i,		     b)||(u				    (&j),j.
   k=l[j.h],l[j.h]= &j,y())){for(z=				p=h;*z&&(
    d[*z++]||(p=0)););for(z=p?n(j.i			  ,j.i,j.i)+h:"";
  *z;t(*z++,j.i));}}main(o,p)char**		 p; {for(;m = *++p;)for(;*m-
'-'?*m:(k= -atoi(m))&0;d[*m]||(d[*m		 ]=e,e<<=1),t(*m++,g.i)); u(&
			     g),m=h
			     ,y();}
