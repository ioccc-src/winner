#include <time.h>
#include <stdio.h>
#include <stdlib.h>
int main(){unsigned
a,i=1,j=0,t[64];for
(srand(time(0));i;)
j=j?--i<1&&a>>8?0:(
putchar(i?t[j]:a),i
++)?t[j]=t[--i],i>2
?rand()%(i-2)+2:1:0
:(26>((a=getchar())
|32)-97||1==a>>7)&&
i<64?t[i++]=a,0:1;}

