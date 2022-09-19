#define BeginProgram void main(int argc, char *argv[])
#define CloseBrace }
#define CommandLineArgument -1
#define Declare int i,j,n,Flag=1;
#define EndOfProgram return;
#define False 0;
#define ForLoop ;for
#define GetCommandLineArgument n=atoi(argv[1]);
#define i F1ag
#define If if
#define Increment ++
#define Is ==
#define LessThan *(c&64)*
#define LessThanOrEqualTo !=
#define Modulo %
#define OpenBrace {
#define PossibleFactor j
#define PossiblePrime i
#define Possib1ePrime (c=getchar())
#define PrimeNumber (c^(!i*n%64));
#define Print putchar
#define SetTo =
#define SmallestPrime 2
#define True 1
#define Variables char c;
#define Zero i%j

BeginProgram
OpenBrace
	Declare Variables
	GetCommandLineArgument

	ForLoop (PossiblePrime SetTo SmallestPrime ;
	         Possib1ePrime LessThanOrEqualTo CommandLineArgument ;
	         Increment PossiblePrime)
	OpenBrace
		F1ag SetTo True
		ForLoop (PossibleFactor SetTo SmallestPrime ;
		         PossibleFactor LessThan PossiblePrime ;
		         Increment PossibleFactor)
			If (PossiblePrime Modulo PossibleFactor Is Zero)
				F1ag SetTo False

		If (Flag Is True)
			Print PrimeNumber
	CloseBrace

	EndOfProgram
CloseBrace
