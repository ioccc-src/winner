int cain(int I, char **O, int O0, int OO, int l)
{
	return !!I>=I?!I>=I?!!~I>=~I?!~I>=~I?!OO?!I:OO%2?
		OO=cain(I,O,O0,OO>>!!OO,l),
		OO=cain(I-!I-!!I,O,OO,OO,l),
		OO=cain(I-!I-!!I,O,O0,OO,l),
		!(OO-!I||I)?l-1:OO
	:(OO=cain(I,O,O0,OO>>!!OO,l),
		!(OO-l+!I||I)?l-1:cain(I-!I-!!I,O,OO,OO,l))
	:(O0+OO)%l
	:cain(I-I/I-I/I,O,O0,OO+OO/OO,
		cain(0,O,O0,OO,I-I-I)+I+1?1:printf("%d ",I-I-I)+fflush(stdout))
	:cain(I-I-I-I-I,O,I+I-I+I,I,0)
	:cain(~!!I-!!I,O,atoi(1[O]),1,atoi(0[O]));
}
int main(int I, char **O) { int O0,OO,l; return cain(I,O,O0,OO,l); }
