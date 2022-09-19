#include <stdio.h>
#include <stdlib.h>

int main(int a,char     **A){FILE*B;typedef     unsigned long C;C b
[8]; if(!(a==7&&(B=     fopen(1[A],"rb"))))     return 1;for(7[b]=0
;7[b]<5;7[b]++)b[7[     b]]=strtoul(A[2+7[b     ]],0,16-!7[b]*6);5[
b]=3[b]                 ; while     ((6[b]=     getc(B)
)!=(C)-                 1){if(2     [b])for     (7[b]=0
;7[b]<4                 ;7[b]++     )if(((6     [b]>>7[
b])^(6[                 b]>>(7-7[b])))&1)6[     b] ^=(1
<<7[b])                 ^(1<<(7-7[b]));5[b]     ^= 6[b]
<<(0[b]                 -8);for(7[b]=0;7[b]     <8;7[b]
++)if((                 5[b]>>(0[b]-            1))&1)5
[b]=(5[                 b]<<1)^ 1[b];           else 5[
b]<<=1;                 }5[b]&=((((C)1          <<(0[b]
-1))-1)                 <<1)|1; if(2[b]         )for(7[
b]=0;7[                 b]<(0[b  ]>>1);7        [b] ++)
if(((5[b]>>7[b])^(5     [b]>>(0   [b]-1-7       [b])))&1)5[b]^=((C)
1<<7[b])^((C)1<<(0[     b]-1-7[    b]));5[      b]^=4[b];fclose(B);
printf("%0*lX\n", (     int)(0[     b]+3)>>     2,5[b]); return 0;}
