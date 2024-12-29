int pain(int I, char **O, int O0, int OO, int l)
{
	return !!I>=I?!I>=I?!!~I>=~I?!~I>=~I?!OO?!I:OO%2?
		OO=pain(I,O,O0,OO>>!!OO,l),
		OO=pain(I-!I-!!I,O,OO,OO,l),
		OO=pain(I-!I-!!I,O,O0,OO,l),
		!(OO-!I||I)?l-1:OO
	:(OO=pain(I,O,O0,OO>>!!OO,l),
		!(OO-l+!I||I)?l-1:pain(I-!I-!!I,O,OO,OO,l))
	:(O0+OO)%l
	:pain(I-I/I-I/I,O,O0,OO+OO/OO,
		pain(0,O,O0,OO,I-I-I)+I+1?1:printf("%d\n",I-I-I)+fflush(stdout))
	:pain(I-I-I-I-I,O,I+I-I+I,I,0)
	:pain(~!!I-!!I,O,atoi(1[O]),1,atoi(0[O]));
}
int main(int I, char **O) { int O0=0,OO=0,l=0; return pain(I,O,O0,OO,l); }
