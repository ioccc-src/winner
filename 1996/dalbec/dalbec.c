#include<stdlib.h>
#include<stdio.h>
main(I,O,O0,OO,l)
int I,O0,OO,l;
char **O;
{
	return !!I>=I?!I>=I?!!~I>=~I?!~I>=~I?!OO?!I:OO%2?
		OO=main(I,O,O0,OO>>!!OO,l),
		OO=main(I-!I-!!I,O,OO,OO,l),
		OO=main(I-!I-!!I,O,O0,OO,l),
		!(OO-!I||I)?l-1:OO
	:(OO=main(I,O,O0,OO>>!!OO,l),
		!(OO-l+!I||I)?l-1:main(I-!I-!!I,O,OO,OO,l))
	:(O0+OO)%l
	:main(I-I/I-I/I,O,O0,OO+OO/OO,
		main(0,O,O0,OO,I-I-I)+I+1?1:printf("%d ",I-I-I)+fflush(stdout))
	:main(I-I-I-I-I,O,I+I-I+I,I,0)
	:main(~!!I-!!I,O,atoi(1[O]),1,atoi(0[O]));
}
