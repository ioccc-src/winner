#define C " "
#define O( _ ) # _
#define R( n , d ) e ( n , d )
#define e(p,o)o##p
#define D O ( % ) O ( l ) O ( d )
#define U R ( e ( g , n ) , e ( o , l ) )
#define M H ( R ( e ( c , i ) , t ) , R ( e ( a , t ) , s ) )
#define P H ( R ( e ( f , t ) , n ) , R ( e ( i , r ) , p ) ) (
#define H(O,r)R(O,r)
#include<stdio.h>
	H ( R ( 	e ( f , 	e ) , e 	( d , e
)	) , R	(	e ( p	,	y ) ,	t	) ) H
( R	( e	( t	, c	) ,	u )	, R	( e
( r ,	t	) , s	)	) { U	n	, t ;	}
F ; H ( 	R ( e ( 	f , e ) 	, e ( d
, e )	)	, R (	e	( p ,	y	) , t	)
) H	( R	( e	( d	, e	) ,	e (	n ,
g	) ) ,	R	( e (	i	, s )	,	e ( n
	, u ) ) 	) U B ; 	M F I [ 	4 * 5 ]
,	w [ 4	*	5 ] ,	p	[ 4 ]	=	{ { 9
, 1	} ,	{ 1	, 1	} ,	{ 1	, 1	} ,
{ 6 *	7	, 1 }	}	; M R	(	e ( t	,
n ) , i 	) J ; M 	R ( e ( 	d , i )
, e (	o	, v )	)	o ( F	f	) { e	(
f ,	i )	( f	. t	- 1	) {	J =	P D
O	( / )	D	, f .	n	, f .	t	) ; }
	R ( e ( 	e , s ) 	, e ( l 	, e ) )
{	J = P	D	, f .	n	) ; }	}	M R (
e (	d ,	i )	, e	( o	, v	) )	n (
F * f	)	{ U a	=	( * f	)	. n ,	b
= ( * f 	) . t ; 	e ( f , 	i ) ( b
) { H	(	R ( e	(	e , l	)	, i )	,
e (	h ,	w )	) (	a )	{ U	i =	b %
a	; b =	a	; a =	i	; } b	=	b < 0
	? - b : 	b ; ( * 	f ) . n 	e ( = ,
/	) b ;	(	* f )	.	t e (	=	, / )
b ;	} }	R (	e (	t ,	n )	, i	) R
( e (	n	, i )	,	e ( a	,	m ) )	(
R ( e ( 	t , n ) 	, i ) a 	, R ( e
( r ,	a	) , e	(	h , c	)	) * v	[
] )	{ B	m ,	W ;	R (	e (	t ,	n )
,	i ) i	,	c ; R	(	e ( r	,	o ) ,
	f ) ( i 	= 1 ; i 	< 5 ; i 	= i + 1
)	{ e (	f	, i )	(	a > i	)	{ J =
H (	R (	e (	f ,	n )	, a	) ,	R (
e ( c	,	s ) ,	s	) ) (	v	[ i ]	,
D O ( / 	) D , & 	p [ i - 	1 ] . n
, & p	[	i - 1	]	. t )	;	} n (	p
+ i	- 1	) ;	} I	[ 0	] =	p [	1 ]
;	R ( e	(	r , o	)	, f )	(	i = 0
	; i < p 	[ 0 ] . 	n ; i = 	i + 1 )
{	I [ i	+	1 ] .	n	= I [	i	] . n
* p	[ 2	] .	t +	p [	2 ]	. n	* I
[ i ]	.	t ; I	[	i + 1	]	. t =	I
[ i ] . 	t * p [ 	2 ] . t 	; n ( I
+ i +	1	) ; }	R	( e (	r	, o )	,
f )	( W	= ~	( ~	0 e	( <	, <	) p
[	0 ] .	n	* 2 )	;	~ ( B	)	0 - W
	; W = W 	- 1 ) { 	w [ c = 	0 ] = I
[	0 ] ;	R	( e (	r	, o )	,	f ) (
m =	W ,	i =	1 ;	! (	i >	p [	0 ]
. n )	;	i = i	+	1 , m	=	m / 4	)
{ e ( f 	, i ) ( 	( m & 3 	) < 2 )
{ e (	f	, i )	(	m & 1	)	{ w [	c
] .	n e	( =	, *	) I	[ i	] .	t ;
e	( f ,	i	) ( (	w	[ c ]	.	t e (
	= , * ) 	I [ i ] 	. n ) < 	0 ) { w
[	c ] .	n	e ( =	,	* ) -	1	; w [
c ]	. t	e (	= ,	* )	- 1	; }	} R
( e (	e	, s )	,	e ( l	,	e ) )	{
w [ c ] 	. n e ( 	= , * ) 	I [ i ]
. n ;	w	[ c ]	.	t e (	=	, * )	I
[ i	] .	t ;	} }	R (	e (	e ,	s )
,	e ( l	,	e ) )	{	w [ c	=	c + 1
	] = I [ 	i ] ; } 	} R ( e 	( r , o
)	, f )	(	m = W	,	i = c	=	0 ; i
< p	[ 0	] .	n ;	i =	i +	1 ,	m =
m / 4	)	{ e (	f	, i )	(	( m &	3
) > 1 ) 	{ w [ 0 	] . n = 	w [ 0 ]
. n *	w	[ c +	1	] . t	+	( ( m	&
1 )	? -	1 :	+ 1	) *	w [	c +	1 ]
.	n * w	[	0 ] .	t	; w [	0	] . t
	= w [ 0 	] . t * 	w [ c = 	c + 1 ]
.	t ; }	}	n ( w	)	; e (	f	, i )
( !	p [	3 ]	. t	e (	| ,	| )	( !
( p [	3	] . n	-	w [ 0	]	. n )	e
( & , & 	) ! ( p 	[ 3 ] . 	t - w [
0 ] .	t	) ) )	{	R ( e	(	r , o	)
, f	) (	m =	W ,	i =	0 ;	i <	p [
0	] . n	;	i = i	+	1 , m	=	m / 4
	) { o ( 	I [ i ] 	) ; J = 	P C O (
%	) O (	c	) C ,	O	( * )	O	( / )
O (	+ )	O (	- )	[ m	& 3	] )	; }
o ( I	[	i ] )	;	J = P	C	O ( =	)
C ) ; o 	( w [ 0 	] ) ; J 	= P O (
% ) O	(	c ) ,	e	( 0 ,	1	) ) ;	}
} H	( R	( e	( n	, r	) ,	u )	, R
(	e ( t	,	e ) ,	r	) ) J	-	1 ; }
