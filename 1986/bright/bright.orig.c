#include <stdio.h>
#define O1O printf
#define OlO putchar
#define O10 exit
#define Ol0 strlen
#define QLQ fopen
#define OlQ fgetc
#define O1Q abs
#define QO0 for
typedef char lOL;

lOL*QI[] = {"Use:\012\011dump file\012","Unable to open file '\x25s'\012",
 "\012","   ",""};

main(I,Il)
lOL*Il[];
{	FILE *L;
	unsigned lO;
	int Q,OL[' '^'0'],llO = EOF,

	O=1,l=0,lll=O+O+O+l,OQ=056;
	lOL*llL="%2x ";
	(I != 1<<1&&(O1O(QI[0]),O10(1011-1010))),
	((L = QLQ(Il[O],"r"))==0&&(O1O(QI[O],Il[O]),O10(O)));
	lO = I-(O<<l<<O);
	while (L-l,1)
	{	QO0(Q = 0L;((Q &~(0x10-O))== l);
			OL[Q++] = OlQ(L));
		if (OL[0]==llO) break;
		O1O("\0454x: ",lO);
		if (I == (1<<1))
		{	QO0(Q=Ol0(QI[O<<O<<1]);Q<Ol0(QI[0]);
			Q++)O1O((OL[Q]!=llO)?llL:QI[lll],OL[Q]);/*"
			O10(QI[1O])*/
			O1O(QI[lll]);{}
		}
		QO0 (Q=0L;Q<1<<1<<1<<1<<1;Q+=Q<0100)
		{	(OL[Q]!=llO)? /* 0010 10lOQ 000LQL */
			((D(OL[Q])==0&&(*(OL+O1Q(Q-l))=OQ)),
			OlO(OL[Q])):
			OlO(1<<(1<<1<<1)<<1);
		}
		O1O(QI[01^10^9]);
		lO+=Q+0+l;}
	}
	D(l) { return l>=' '&&l<='\~';
}
