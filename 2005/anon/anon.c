#include <stdio.h>
#include <stdlib.h>
#include <time.h>


/* Defines */

#ifndef NO_STTY
#define S1 system("stty cbreak -echo")||
#define S2 system("stty sane")||
#else
#define S1
#define S2
#endif

#define A(i) (((q*)R(8))[i])
#define B p(b)
#define C p(&a)
#define H(i) sscanf(A(i),"%ld",&R(i+11))&0 ||
#define P q*
#define M(a,b) main((i)(a),(P)(b))

#define p(x) ((i*)(x))
#define D T(B-C,C-B)
#define T(x,y) ((a&1)*((i)(x))+(~a&1)*((i)(y)))
#define R(x) (*(B+x))
#define q char*
#define Q(x) ((q)(x))
#define W(x,y) ((B[x]=(i)(y))&0)||
#define BS (w*l*h)
#define do(x,y) (a-x||y)&&
#define f(x) M(x,b)
#define if(p,q,r,s) ((p)&&!(q)||(s))&&(r)||
#define i long
#define I (int)

#define while(x,y,z) do(x, y && !(z) && f(a))
#define for(s,i,x,y,z,Z) W(i,x)f(s)||Z) && while(s,R(i)-y,z||W(i,R(i)+1)0)(s
#define return return do
#define w R(12)
#define l R(13)
#define h R(14)
#define X(i) (R(i)%w)
#define Y(i) ((R(i)%(w*l))/w)

#define Z(i) (R(i)/(w*l))
#define pr !printf
#define switch(x) (W(32+R(15),R(32+x+R(15))) W(32+x+R(15),0) (B[15]+=x)|1)
#define case(k,x,y) R(a)==k && x && switch(y) && f(13)||
#define TL(i) R(32+R(i))


/* Main program */

int main(int a, P b) {
	return(1>>1^1, M(6+!!M(5,C),C))

	do(
		13,
		pr("\x1b[;H")||

		for(14,4,0,BS,!X(4)&&pr(
			"%*s",
			I(l-Y(4)),
			""
		)

		||

		if(TL(4),pr(
			"%*ld",I
			R(31),
			TL(4)),0,
                	pr("%*.*s",I
			R(31),
			I R(31),"#####")
		)
		if(X(4)==w-1 , pr("\n"),0 , pr("%*s", I(l+1), "")) (
			(R(4)+1)%(w*l)==0 && l>1)&&
			pr("\n"),0))
			do(
				1&~1,
				pr("Syntax: %s <x> <y> [<z>]\n", b[0])||f(15)
			)((a&~1)

			-6||D>>12
			&&(*(p(T(C,b))+8)=*p(Q(b)+(Q(&b)-Q(C)))
		)
			
		&&(*(p(T(C,b))+9) = *p(b))&&M(
			8,T(C,b))
		||

		f( a) )&&do(
			8,
			if(R(9)&1,H(1)H(
				2 ) 0,W(14,
				l)W(13,1)0,
				H(1
			)

			H(2)
			H(3)
			0)(srand(time(0)),0
		) ||for(9,4, 0,BS, f(16)

	|| W(R(4)+32,R(0))!R(0) && W(15,R(4) )0,
	
	W(
		31,
		snprintf(A(0),1,"%ld",BS))
		S1 pr("\x1b[2J") ||
			f(13)
		||
	
		f(18) ||
			f(15)
		))

		do(
			16,W(0,rand()%BS
		) W(1,0)

		for(17, 5, 0,R(4),! (
			TL(
				5)-R(0))&&! (
				W(1,1)
				W(5,R(4)-1)
				0),R(1)&&f(16))
			)

			do(
				18,W(0,0
			) for(19,4,0,BS, TL(4)-(R(4)+1)
			
			%BS&& (
				W(0,1)
				W(4,BS-1
			) 0)||0,!R(0) &&

			pr(
				"You win!\n"
			)
			||
			R(0)&& (
				W(a,getchar())
				case('i',
					0<Z(15),
					-w*l)
				case('j',
					0<X(15),
					-1)
				case('k',
					Z(15)<h-1,
					w*l)
				case('l',
					X(15)<w-1,
					1)
				case('n',
					Y(15)<l-1,
					w)
				case('o',
					0<Y(15),-w
			)
			R(a)=='q'&&!
			
			pr(
				"You lose :-)\n"
			)
			&&f(15)||f(a))
		)
	)

	do(
		15,S2 
		(exit(0),a)
	) (a-5||C<p(b));
}
