#define S(r, c) f[r][c] = 1;

char f[96][160]; main(argc, argv) char **argv; { double x, y, atof(); int
r									,
c									,
bi									,
bj									,
i			       ; for (i=10; i<=80			;
i			    ++) { S(i, 18); S(i, 152)			;
}		for (i=18; i<=152; i++) { S(10, i); S(80, i)		;
}	    for (x=-20;				   x<=10; x += .05)	{
y							=atof(argv[1])  *
x						   * x * x + atof(argv	[
2						])*x*x+atof(argv[3])	*
x					 + atof(argv[4])		;
r				 = (500 - y)*.07+10			;
c					 =(x+20)*4.33333		+
20						; if(r>=10 && r<=80 &&	c
>=							  20 && c<=150)	S
(							   r, c); } for (
r							=0; r < 24; r  ++
)	    for (c=0; c				     <80; c++) { bi	=
4		*r;bj=2*c;			 i=(((f[bi][bj]<<	3
)		     +(f[bi+1][bj]<<2)+(f[bi+2][bj]<<1)+(f[bi		+
3			][bj]<<0))*16+ (f[bi][bj+1]<<3)+(		f
[			    bi+1][bj+1]<<2)+(f[bi+2][bj			+
1				]<<1)+(f[bi+3][bj+			1
]				  <<0)+1)*(c<79				)
;					putchar				(

"\n ..,.;:j'::;';!|._:,;;;j/;;;jjjj.,-,r<jq/;I;/|I|,,rx///d///d///d.:\\;\
-=vq':<|':++;;>;==gg':SS///+:\\\\\\r<wq/<64//d+lL+by[pg/</6///+`::;`\\\\\
\\\"::;`\\YT;;;;`2>\\:=;;??]]:;;;>2>\\F;O;7?]7;;;;?2>b;;;;??]#'\\\\\\`\\\
\\\\''<5\"\"Vq;\\\\\\`=\\\\''55\"?ggILLLD\\bfF[[[P?#M|||||#+#T[FFP?PM'"
[i]); } }
