#include <stdio.h>

main(argc,argv)
int argc;
char **argv;
{
        long arg[100];
        int i,j;
        int base = 10;
        int start = 0;
        int end= strlen(argv[1]);


        for (i=0;i<end;i++)
                 arg[i] = argv[1][i]-'0';

        while ( end-start > 2 )
        {
                while ( arg[end-1] == 0 ) {
			printf("%d\n",base);
			end--;
		}
                while ( arg[start] == 0 ) start +=1;
                base += 1;

                for (i=start+1;i<end;i++)
                        for (j=i;j>start;j--)
                                if ( (arg[j]-=arg[j-1])<0 )
                                {
                                    arg[j]+=base;
                                    arg[j-1] -= 1;
                                }
        }
}
