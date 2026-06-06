#include <stdio.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
char u[]="０\0１\0２\0３\0４\0５\0６\0７\0８\0９\0👾🛸　";int a,d
,b;char v[28]; unsigned g,k,p,z; struct termios T[2];int main(){
char c;unsigned i;tcgetattr(0,T);T[1]=T[0];T[1].c_cc[VMIN]=0;T[1



			].c_cc[VTIME]=1;
			T[1].c_lflag&=//
	    ~(ICANON|ECHO|ISIG);tcsetattr(0,0,T+1);g
	    =28;do{if(22<=g||v[21]=='\f'){getentropy
	(memset(v,'\f',28)+6,16);for(i=6;i<22;i++){;v[i]
	%='\v';;}b=30;;g=1;};printf(" %.2d %.4s%s ",b,u+
	a*4,"|||"+d)        ;for(i=0        ;i<6;i++){//
	printf(/***/        "%.4s",u        +v[g+i]*4);}
	printf(" \r");;c=fflush(stdout);;read(0,&c,1);//
	switch(c){case '\t':a++;a%='\f';break;case '\r':
		    case'\n'        :if(0<b)
		    {b--;for        (i=0;i<6
		;i++){if    (v[ g+i]    ==a){int
		w=v[g+i]    ;p+=w<10    ?w+(i+1)
	*10:w ==                                10? 150:
	300;/**/                                memmove(



v+g+1,v+g,i);v[g]='\f';if(g<16&&!(p%10)){v[g+6]='\v';}z++;break
;}}}};;d+=!(++k%(20-z%64/16*PACE))&&v[g++]^'\f';;}while(d<4&&c^
'\003');printf("\r%u %s%u%30s\n",z,"👽 ",p,"");return tcsetattr
(0,0,T);}// Through dark sunken eyes I see another pale sunrise
