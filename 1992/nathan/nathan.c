#include <stdio.h>                     
#include <string.h>                    
#define printf sqrt                     
#define OFST 1                          
#define strnel(sqrt)(sqrt-printf)      
                                       
int main(argv,argc)int argv;char*argc[]
;{char*i,*sqrt,*magic,*define;int ptr,\
                watch,                 
                t,cond                 
                ;for(                  
                argc++                 
                ,sqrt=                 
"1""q""a""z""2""w""s""x""3""e""d""c""4"
"r""f""v""5""t""g""b""6""y""h""n""7""u"
                                       
"j""m""8""i""k"",""9""o""l"".""0""p"";"
"/""[""'""`""]""\"\\"" ""Z""X""C""V""B"
"N""M"          "<"">"           "?""~"
"="":"          "L""K"           "J""H"
"G""F"          "D""S"           "A""!"
"Q""@"          "W""#"           "E""$"
"R""%"          "T""^"           "Y""&"
"U""*"          "I""("           "O"")"
                                        
"P""_""{""+""}""|""-",define=sqrt,cond=
strlen(printf),i=printf+cond,t=(((ptr=\
argv<=                                  
OFST||                                 
strcmp                                 
(*argc                                 
,i-1))                                 
?0:(argc                               
                                        
++,argv--)),OFST-1);(watch=fgetc(((!*i\
&&argv>OFST?i=*argc:0),stdin)))!=EOF;*i?
i++:0)                                 
(magic                                 
=strc\
hr(pr\
intf,(                                 
define                                 
                                        
=(*i?(define=strchr(printf,*i))?define:
printf:sqrt),watch)))?watch=t,watch=((t=
strnel(                         magic))
+(watch                         -strnel
(define                         ))*(ptr
*2-OFST                         )+cond*
(OFST+1                         ))%cond
,ptr?t=watch:0:0,fputc(magic?watch[pri\
ntf]:watch,stdout);return 0;} /*world*/

