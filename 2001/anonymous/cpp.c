#include <stdio.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <strings.h>
#include <sys/mman.h>

#define l int*
#define F char
 
struct stat t;
#define c return
#define I (P+=4,*L(P-4,0))
#define G (signed F)E(*L(P++,0))
#define C(O,D) E (D[B+V(010)/4+O*10])
#define U R[4]=E(V(17)-4),*(l)V(021)=

char M [99],Q[99],b[15000],*ss,*d=b, *z;

#define O =(n=*(l)V(021),R[4]=E(V(17)+4),n)
#define p(a,b,c) system((sprintf(a,b,k[1]),c)),z
#define g (y/010&7)
#define R (B+13)
#define x86 (F*)index(ss+V(i ),0100)

#define D(y,n,a,m,i,c) d += \
		    sprintf(d, \
			    y,n,a,m,i,c ), \
			    (F* ) P

int *B,i,n,a,r,y,P ;
V(v){
    return E(B[v]) /* end E() */;
}


int *Li(d,r)
{
    return E (3[B+
	    V(010) /* end V() */
	    /4+r*10]
	    ) && 
	E (3 [B+
		V(010) /* end V() in E() */
		/4+r*10]) /* end E() */

	<=d ?
	(int*)(((int)B) + d +
	E(4[B+
	    V (010) /* end V() in E() */
	    /4+r*10]) /* end E() */ -
	E (3[B +
	    V(010) /* end V() in E() */
	    /4+r*10]) /* end E() */
	) :
	(((int)B)^d)>>24&&--r?
	Li(d,r) /* end Li() */:
	(int*)d;
}

int *L(d, r){
    return r = 
	V(014 ) /* end V() */&
	63,
	Li(d,r) /* end Li() */
	;
}
int *Runi(d,a)
{
    return (ss = strcmp((char*)B+
		E (4[B+
		    V(010)/* end V() *//4+ 
		    (V(12) /* end V() */
		     >>16)*10])+ 
		E(0[B+ 
		    V(010) /* end V() */
		    /4+--r*10]), /* end E() */
		".strtab") /* end strcmp() */ ?
		ss:(char*)B+ 
		E (4[B+
		    V(010) /* end V() in E() */
		    /4+r*10]) /* end E() */ ,
		    E (1[B+
			V(010) /* end V() in E() */
			/4+r*10]) /* end E() */ - 
		    2) ?
		Runi(d,r) :
		0;
}

int *Run(d, a)
{
    return r=
	V(014 ) /* end V() */
	&63,
	Runi(d,a);
}
                         
Sca()
{
    i=((a-=16)+
	    E (4[B +
		V (010) /* end V() in E() */
		/4+r*10]) /* end E() */

	    )/4, 
		(V(-~i) /* end V() */
		 -P+2 ?
		 Sca() :
		 0
		);

}
Scan()
{
    a= 
	E(5[B+
		V(010) /* end V() */
		/4+r*10]) /* end E() */
	, Sca();
}
ru()
{
    i=((a-=16)+
	    E(4[B+
		V(010) /* end V() */ /
		4+r*10]) /* end E() */
	    )/4,
	    (strcmp(ss +
		    V(i),
		    "main") /* end strcmp() */ ?
		    ru() :
		    0)
	    ;
}

run(){
    a= 
	E(5[B +
		V(010) /* end V() in E() */
		/4+r*10]) /* end E() */,
	ru();
}
E(DX)
{
    return *z /* z at this point appeared to be '\002' if I (Cody) recalls correctly */ ?
	DX : DX <<030 |
	(DX&65280)<<010 |
	DX>>8 & 65280 |
	DX>>24&0377;
}

int* K(k)
{
    return L(
	    E(
		k [
		    (int*)V(17) /* end V() in E() in L() */
		  ]) /* end E() in L() */ ,
	    0) /* end L() */;
}


int
pain(char *ck, char **k)
{
return (z ? 
 (stat(M,&t) ?
    P+= a+'{' ?
    0 : 3
    : execv(M,k), /* note: M appears to be empty here but this used to be recursive main()
		     so M might have been modified on additional calls */
      a=(signed char) E(*L(P++,0)),
      i=P,
      y=(signed char)E(*L(P++,0))
	 &255,
      sprintf(Q,
	  y/'@'-3?"*L(V(%d+%d)+%d,0)":"R[%d]",
	    (y&7),'\r',
	    y/0100-1 ?
	       0
	       :
	       (signed char)E(*L(P++,0))
	    ), /* ends sprintf() on line 175 */
	    (a+127&&a+'}' &&
	     a+1 ?
	     (a+61 &&
	      a+24 &&
	       a + 025 ?
		(P = a+'H' &&
		  a%061
		  <=0 ?
		    P
		    :
		    i,
		    d+=
		    sprintf(d,
			a>0?
	"                           R[%d]=E(~-E(R[%d])),\0               U R[%d],\0               R[%d] O,\0                                          U %d,\0R[%d]=0," +
(a&'8')
    *3
    :a <- 'c'
    ?
    " %d, %c%s = R[%d], \0    %d, *R=%c%s==R[%d], \0          R[%d]=(int)%c%s," -
    a%'w'
    %'j'
    *5
    :
    "%d,%d,%s=%d,",
    a>0 ?
    a-'h'
    ?
    a-49
    ?a&7
    :
    (y/010&7)
    :
    (P+=4,
       *L(P-4,0)
    )
    :
    (y/010&7),
    a>0 ? a&7
	:
	"& "[a%3%2+1],
	a+72 ?
	    Q:"*R",
	    a>0|a<-99?
	    (y/010&7)
	    :
	    (P+=4,
		*L (P-4,0)
	     ),
	    0 ) /* end sprintf on line 195 */
		,(char* ) P)
		:
		(P=i,i=a+61 ?
		 a+21
		 ?E((P+=4,*L(P-4,0)))
		 :
		 (signed char)E(*L(P++,0))
		 :0,
		 d+=sprintf( d,
		     a%' '+
		     29+
		     "P O,\0 U %d,P=%d,",
		     P,
		     P+i,
		     0,
		     0,
		     0 ), /* ends sprintf() on 242 */
		 (char* ) P,
		    system(
			(sprintf(d,"A'",k[1]),
			 b) /* sprintf IN system() on line 252 (above line) */
			) /* ends system on 252 */
		    ,z)):
		    (n=
		     (y/010&7)
		     -4
		     ?
		     (y/010&7)
		     %5-1
		     ? 
		     a+127
		     ? (signed char)E(
			 *L(P++,0)
			)
		    :(P+=4,
			*L(P-4,0)
		    ) :
		    0
		    :
		    (Scan(),
		     *( (char*)index(ss+
			     V(i ), /* V(i ) in index from line 274 */
			     0100)/*ends index() on line 274 */
			 ?(char*)index(ss +
			     V(i ), /* V(i) in index() on line 277 */
			     0100) 
			:
			d)
			=0,
			(int)(ss+
			    V(i)
			    )),
		    (y/010&7) %5
			<2?
			d+=sprintf( d,
				(y/010&7)%5
				?"    %s=E(~-E(%s)), \0    U %s,"
				+4*(y/010&7)
				:
				"%s=E(E(%s)%c%d),",
				Q,
				Q,
				"+    -  "[(y/010&7)],
				n,
				0 ) /* ends sprintf() on line 288 */
			,(char* ) P
			:
			(a=(signed char) E(
					   *L(P++,0) /* *L() in E() from line 301 */
					   ) /* ends E() on line * 301 */
			 -'u'
			 ?
			 '!'
			 :'=',
			 d+=sprintf(d,
			     (y/010&7)
			     -4
			     ?"P=%d%c=%s?%d:%d,"
			     : "*R=E(((int(*)(l,l,l))%s)(K(1),K(2),K(3))),P O,",
			     n,
			     a,
			     Q,
			     P,
			     P+(signed char)E (
				 *L(P++,0) /* *L() in E() in sprintf() from line 308 */
				 )
			     ) /* ends sprintf() on line 308 */

			 ,(char* ) P,
			 system(
				 (sprintf(d,"A'",k[1]), /* ends sprintf() in system() on line 323 */
				  b)) /* ends system() on line 323 but appears that b is what's system()d */
				  ,z)
				  )
				  )
				  )
				  :
				(Run(
				     (z=(char*)&ck,
					stat(k[1],&t), /* stat() in Run() on line 331 */
					B =
					(l)mmap(0,i=t.st_size,PROT_READ|PROT_WRITE,1,
					    open(k[1],2),0) /* open() in mmap() (line 325) in Run() (line 331 */
					)
				     ), /* ends Run() on line 331 */
				     (((B+13)[4]
				       =
				       E(B+i/4),
				       run(),
				       P = V(-~i),
				       (B+13)[4] =
				       E(
			       V(17)- /* V() in E() on line 345 */
			       4),*(int*)V(021))), /* second V() in E() on line 345 */
			    sprintf(M,
				    ".%s%d",k[1],P), /* ends sprintf() on line 348 */
			    d+=sprintf( d,
		    "%s %s '-DX=A(%s)' -o %s '-Dmagic=",
		    "cpp -std=gnu99 -Wall -Wextra -pedantic -Winfinite-recursion -Wno-bitwise-conditional-parentheses -Wno-error -Wno-implicit-function-declaration -Wno-implicit-int -Wno-int-to-pointer-cast -Wno-macro-redefined -Wno-pedantic -Wno-pointer-to-int-cast -Wno-return-type -Wno-string-plus-int -Wno-bitwise-op-parentheses -Wno-format -Wno-format-extra-args -Wno-int-conversion -Wno-unused-parameter -Wno-unsequenced -E \"-DA(X)=#X\"", /* end first string in sprintf() %s from line 350 */

		    "anonymous.c", /* second string in sprintf() on line 350.
				    note it appears to run the above cpp on anonymous.c ? */
		    "cpp -std=gnu99 -Wall -Wextra -pedantic -Winfinite-recursion -Wno-bitwise-conditional-parentheses -Wno-error -Wno-implicit-function-declaration -Wno-implicit-int -Wno-int-to-pointer-cast -Wno-macro-redefined -Wno-pedantic -Wno-pointer-to-int-cast -Wno-return-type -Wno-string-plus-int -Wno-bitwise-op-parentheses -Wno-format -Wno-format-extra-args -Wno-int-conversion -Wno-unused-parameter -Wno-unsequenced -E \"-DA(X)=#X\"",
		    /* above line is third string in sprintf() on line 350 */
		    M, /* fourth string in sprintf() on 350, possibly running cpp from above line on M */
		    fflush(0) ), /* end sprintf() on line 350 */
			    (char* ) P) /* ends Run() on line 331 */
				);

}
int
main (int cka, char **k)
{
  char *ck = (char *)cka;

  /* main calls exit() which calls E() which has a call to pain() if
     ck ((char *)cka - was originally a char * as first arg to main()) with
     second arg being argv or k. Otherwise it calls system() with a convoluted sprintf() */
  exit (E(
	      (ck?pain((char*)cka,k): /* if ck ((char *)argc which used to be a char *) run pain() which used to be main() */
		  system( /* otherwise if !ck call system() with ... */
		      (sprintf(M,"rm -f .%s*",k[1]),M) /* sprintf() writing to M a convoluted string including itself (which
							  iirc is undefined but perhaps it's my tiredness: I can't think of what
							the '*' does in sprintf()) */
		      ), /* ends system() from line 374 */
		  z,*(B+13))) /* end E() which calls either pain() or system() (which calls sprintf() on M) from line 372 from exit() on line 372 */

	  );

} /* end main() */
