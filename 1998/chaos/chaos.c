#include<curses.h>
#include<stdlib.h>
#include<string.h>

#define A int
#define F float
#define O sizeof
#define V ((A *)(X+N))
#define U(a,b) for(a = 0; a < b; a++)
#define L(a) (X[K] * H[a*4]+ X[K+1] * H[a*4+1]+ X[K+2] * H[a*4+2])
#define _(e,f,a,b,c) if(M==e) { T[a*4+c] = T[b*4+c] = T[c*4+a] = T[c*4+b] = !(T[c*5] = 1); T[a*4+b] = -(T[b*4+a] = f .1045284632); T[b*5] = T[a*5] = .9945418726; U(M,3) U(E,4) U(K,3) R[M*4+E] += H[K*4+E] * T[M*4+K]; memcpy(H,R,12*O(F)); }

char Q[3792];
A K, M=0, E, B;
long Z;
F H[] = { 1,0,0,0,0,1,0,0,0,0,1,0 } , T[12], R[12], C, D, I, J, S, * X, G=4;
FILE * W;

A main(A N,char ** Y) { 
	char P[] = "AlWuzEre 72 -1 1 1 1 1 1 1 1 1 1 1 -1 1 1 1 1 -1 1 1 1 -1 1 -1 -1 -1 1 -1 -1 1 1 1 1 -1 -1 1 -1 1 -1 1 -1 -1 1 1 -1 -1 -1 -1 -1 1 -1 1 1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 -1 -1 -1 -1 -1 1 -1 -1 -1 ";
	strcpy(Q,P);
	if(!(W = fopen(Y[N<2?0:1],"r"))) {
	printf("Can't read\n"); exit(-1); }
	fseek(W,0,SEEK_END);
	Z = ftell(W);
	fseek(W,0,SEEK_SET);
	strcpy(Q+9, "%d");
	while(fscanf(W,Q,&N) != 1) {
	fseek(W,1,SEEK_CUR);
	if(ftell(W) >= Z) {
	printf("Bad input\n"); exit(-1); } }

	X = (F *)malloc(N * (O(A)>O(F)?O(A):O(F)) * 2);
	if(!X) { printf("No memory\n"); exit(-1); }
	U(K,N) fscanf(W,"%f",X+K);
	fclose(W);

	initscr(); 
	halfdelay(30);
	noecho(); 

	CH:
	memset(R,0,12*O(F));
	_('h', ,1,2,0)
	_('j', ,2,0,1)
	_('k', ,1,0,2)
	_('y',-,1,2,0)
	_('u',-,2,0,1)
	_('i',-,1,0,2)
	G += M=='a'?-.1:M=='z'?.1:0;
	if(M=='q') { printf("%.9s\n",P); exit(0); }
		
	memset(Q,0,3792); 
	erase(); 

	U(K,N) { 
    C = 40 / (L(2)+G);
	V[K] = (A)(L(0) * C) + 40; 
	V[K+1] = (A)(L(1) * C) + 24; 
	K+=2; } 

	U(B,N) {
	C = V[B++];
	D = V[B++];
	E = V[++B] - C;
	M = V[++B] - D;
	B++;
	S = (F)abs((abs(E)>abs(M))?E:M);
	I=E/S;
	J=M/S++;
	U(K,S)
	{
		E = (A)(C+0.5);
		M = (A)(D+0.5);
		if(E>=0 && M>=0 && E<79 && M<48)
		{
			Q[E + M * 79] = 1;
			mvaddch((M&1?M-1:M)/2,E,Q[E+(M+(M&1?-1:1))*79]?':':(M&1?'.':'`'));
		}
		C+=I;
		D+=J;
	}
	}

	move(0,0);
	refresh(); 

	M = getch();
	halfdelay(M==ERR?1:30);
	M = M==ERR?'u':M;

	goto CH;
} 
