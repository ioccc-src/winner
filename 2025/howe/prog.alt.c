#include <stdio.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
char v[22]="      ";struct termios T[2]; unsigned g,k,p,z;int a,
d,b;int main(){char c;int i;tcgetattr(0,T);T[1]=T[0];;T[1].c_cc[
VMIN]=0;T[1].c_lflag&=~(ICANON|ECHO|ISIG); T[1].c_cc[VTIME]=1;//



			tcsetattr(0,0,T+
			1);g=22;do{if(g/
	    22||v[21]==' '){getentropy(v+6,16);for(i
	    =6;i<22;i++){v[i]=v[i]%10+'0';}b=30;g=1;
	}printf(" %.2d %c%s %-6.6s \r",b,a<10?a+'0':'n',
	"|||"+d,v+g);;c=fflush(stdout);;read(0,&c,1);//;
	switch(c){;;        case'\t'        :a++;;a%=11;
	break;/***/;        case'\r'        :case '\n':;
	if(0<b){b--;for(i=0;i<6;i++){int w=v[g+i]-'0';if
	(w==a||(w=='>'&&a==10)){p+=w<10?w+(i+1)*10:300;;
		    memmove(        v+g+1,v+
		    g,i);v[g        ]=' ';if
		(g<16&&!    (p%10)){    ;v[g+6]=
		'n';}z      ++;/**/;    break;}}
	}};d+=!(                                ++k%(20-
	z%64/16*                                PACE))&&



v[g++]^' ';}while(d<4&&c^'\003');printf("\r%u %u%30s\n",z,p,"");
return tcsetattr(0,0,T);}// the Invaders their infernal machines
