#include <stdio.h>
#include <malloc.h>
#include <string.h>

#define A(x) (e^d)&i?e:(e+=i+i/15-d,d<<=4,i<<=4,x)
#define B b+=!((e^d)&i)&&(d|=i),i<<=4,
#define C i=15,B B B B d=d<<4|d>>12,
#define D=(d=g,b=0,C b<<=4, C C C b)
#define E if(**y)goto
#define F=a[rand()%c]
#define G unsigned short
#define H e^=a[z],a[z]^=e,e^=a[z],

void
    main
	(int
	    z,char
		**y)
		    {G*a
			,b,c
			    ,d,e
				,f,g
				    ,h,i
					;*(*
					    y+=
						strlen
						    (*y)
							-1)^=
							    'd';
								srand
								    (time
									(0))
									    ;z==
									2&&
								    sscanf
								(y[1
							    ],"%d"
							,&z)
						    &&z?
						0:(z
					    =6);
					if(!
				    (a=(
				G*)
			    calloc(
			z*z*
		    z*z,
		sizeof
	    (G))
	)){
    printf
("No\
    memory\
	\n");
	    exit
		(1);
		    }for
			(c=1
			    ;i=15
				,d=z
				    ,c<z
					*z*z
					    *z&&
						(e=a
						    [c-1
							]+1,
							    a[c]
								=A(A
								    (A(A
									(0))
									    )),1
									);c++
								    );*(
								**y?
							    &g:&
							e)F;
						    do{
						printf
					    ("(%d): ????\b\b\b\b"
					,c);E
				    q0;else
				goto
			    q1;q0:
			printf
		    ("%04X\n"
		,g+
	    4369
	);E
    q2;q1:
scanf
    ("%hx"
	,**y
	    ?&h:
		&g);
		    E q3
			;g-=
			    4369
				;q2:
				    printf
					("??\b\b"
					    );E q1;
						printf(
						    "%02x\n"
							,h D
							    );q3
								:for
								    (z=f
									=0;(
									   z<c||
									(c=f
								    ,0))
								&&(H
							    b D!=
							h,H b
						    ||(a[
						f++]=
					    a[z])
					,1);z
				    ++);
				}while
			    (h!=
			64&&
		    c>0&&
		((g F
	    ),1)
	);printf
    ("\n"
);}
