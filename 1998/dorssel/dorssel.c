#include<stdio.h>
#include<string.h>

main()
{
	char*O,l[999]="'`acgo\177~|xp .-\0R^8)NJ6%K4O+A2M(*0ID57$3G1FBL";
	while(O=fgets(l+45,954,stdin)){
		*l=O[strlen(O)[O-1]=0,strspn(O,l+11)];
		while(*O)switch((*l&&isalnum(*O))-!*l){
		case-1:{char*I=(O+=strspn(O,l+12)+1)-2,O=34;
			while(*I&3&&(O=(O-16<<1)+*I---'-')<80);
			putchar(O&93?*I&8||!(I=memchr(l,O,44))?'?':I-l+47:32);
			break;
		case 1:	;}*l=(*O&31)[l-15+(*O>61)*32];
			while(putchar(45+*l%2),(*l=*l+32>>1)>35);
		case 0:	putchar((++O,32));}
	putchar(10);}
}
