/**??/
/
#include<netdb.h>
#include<stdio.h>
#include<sys/time.h>
#define NCC 1701
#define STARDATE 500000
#define k 16309

                      int C,p,t,J,a,m,e,s,T,K,i,r[k],_[k][2],c[k][2],f=NCC;
                    fd_set O,d,o;char g[8][k],*h,j[]="0\1&me\1&t&e\1TFTTJPO>"
                 "\1&t\\_<\16\v^\1&+\\_;^&o;&e\1TFU.DPPLJF;\1iuuq;00&92:2\\_0^&"
               "o\1&tDppljf;!tfttjpo>&t\16\v\16\v\1HFU!&t!IUUQ02/1\16\vIptu;!"""
            "&t\16\v\1IUUQ02/1!311!PL\16\vDpoufou.uzqf;!ufyu0iunm\16\vFyqjsft;!1"""
          "\16\vTfu.Dppljf;!tfttjpo>&t\16\vDpoufou.Mfohui;!&me\16\v\16\v&t\1=iunm?=c"                                 "pez!chdpmps>#cmbdl"
       "#?=ejw!tuzmf>(qptjujpo;bctpmvuf<upq;61&&<mfgu;61&&<usbotgpsn;usbotmbufY).61&&*u"                        "sbotmbufZ).61&&*<(?=gpou!dpm"
     "ps>#xijuf#?=qsf?&t=0qsf?=0gpou?=0ejw?=0cpez?=0iunm?\1T`K!`.`[!G!G`\v]C`)K>0`>`0!E`/"                  "D.(D.aD./E`D!C`p`K!F`0F`}\vM!]`!]E!"
   "]E./J`/E.0C!G>I`0L.0\vO!]!]D!0C!0E!a.`.(K!)E`0I!]G`E!}\vK!C`-C.a/a.(//(.`[!N!]C!+!]\vJ!0E`K!}}[!K!C`0E`0C`\vO!aC./E`-.([!K!|K`|";struct sockad\
dr_in l;struct timeval n,q;struct hostent*u;long w;void x(int y){close(y);FD_CLR(y,&O);if(y>=m)while(--m)if(FD_ISSET(m,&O))break;}vo\
id z(char*A,char*B){char*D,*E=A,*F=A;for(0[0[g]]=0;*E;E++)if(*E==10){if(E-F==(*(E-1)-13?1:2))break;*E=0;if(!strncmp(F,B,strlen(B))&&(D=strstr(F,j+\
11))){sscanf(D+8,j+20,0[g]);break;}F=E+1;}else*E=toupper(*E);}int main(int G,char**H){h=j;while(*h)(*h)--,h++;h=j+414;do{t=*h++;e=1;if(t>=65&&t<=90)e
=t-64,t=*h++;while(e--)6[g][i++]=t;}while(t);sprintf(7[g],j+229,6[g]);l.sin_family=2;if(G>1){sscanf(1[H],j+53,4[g],&K);sprintf(2[g],j+97,*(1[H]+K)?1[
H]+K:j,4[g]);sscanf(4[g],j+29,&i,&f);i[4[g]]=0;u=gethostbyname(4[g]);memcpy(&l.sin_addr.s_addr,0[u->h_addr_list],u->h_length);l.sin_port=htons(f);\
for(;;close(G))if(!connect(G=socket(2,1,0),&l,sizeof l))for(;;){strcpy(1[g],0[g]);s=sprintf(5[g],j+72,2[g],0[g]);if(write(G,5[g],s)<0)break;gett\
imeofday(&n,0);0[3[g]]=0;e=read(G,3[g],k);if(e<0)break;else if(e&&*3[g]==72){gettimeofday(&q,0);3[g][k-1]=0;z(3[g],j+41);if(0[1[g]])if(!strnc\
mp(1[g],0[g],strlen(1[g]))){t=0;if((q.tv_sec-n.tv_sec)*1000000+q.tv_usec-n.
tv_usec<STARDATE-1000){t=p<15?1:16;p+=t;C+=t;}else p=p<15?15:255;if(p==2\
55){putchar(C);fflush(stdout);C=p=0;}}else{T=1;goto l;}}}}else{for(f=0;
f<k;f++){if((i=fgetc(stdin))<0)break;f[r]=i;}for(i=0;i<k;i++){0[i[_]]
=1[i[_]]=-1;0[i[c]]=1[i[c]]=0;}gettimeofday(&n,0);p=sprintf(5[g],j+2
,n.tv_sec);n.tv_sec=0;n.tv_usec=STARDATE;FD_ZERO(&d);FD_ZERO(&O);F\
D_ZERO(&o);l.sin_addr.s_addr=0;l.sin_port=htons(NCC);bind(G=sock\
et(2,1,0),&l,sizeof l);listen(G,10);FD_SET(m=G,&O);for(i=1,t=0;;
){d=O;C=select(m+1,&d,0,0,0);if(C<=0){if(!i&&t)x(t);goto l;}fo\
r(J=t;C&&J<=m;J++)if(FD_ISSET(J,&d)){C--;if(J==G){t=accept(G,
0,0);FD_SET(t,&O);FD_CLR(t,&d);FD_SET(t,&o);if(t>m)m=t;t=0;
}else if(!i||FD_ISSET(J,&o)){e=read(J,2[g],k);K=0;if(e>0){
2[g][k-1]=0;if(*2[g]==71){a=0;strcpy(1[g],0[g]);z(2[g],j+
45);if(!strncmp(0[g],5[g],strlen(5[g]))&&!strncmp(1[g],
0[g],strlen(1[g]))){K=atoi(0[g]+p);}if(K){if(0[K[_]]<f
){if(a=(1[K[_]]<15?1[K[_]]:1[K[_]]>>4)>=(1[K[_]]<15?
0[K[_]][r]&15:0[K[_]][r]>>4))1[K[_]]=1[K[_]]<15?1\
5:255;else 1[K[_]]+=1[K[_]]<16?1:16;if(_[K][1]==\
255){0[K[_]]++;1[K[_]]=0;}}else{write(1[K[c]],_[
K],sizeof(_[K]));close(1[K[c]]);K=0;}}else fo\
r(s=1;s<k;s++)if(0[s[_]]==-1){0[s[_]]=1[s[_]]
=0;K=s;break;}if(K)sprintf(0[g],j+6,5[g],K)
;else 0[0[g]]=0;w=sprintf(3[g],j+125,0[g],
strlen(7[g]),7[g]);if(i){pipe(c[K]);if(!
(i=fork())){close(0[K[c]]);FD_ZERO(&O);
FD_SET(t=m=J,&O);}}if(i<0){T=1;goto l;
}if(i){close(1[K[c]]);FD_SET(0[K[c]]
,&O);if(0[K[c]]>m)m=0[K[c]];x(J);\
break;}else{if(a){n.tv_sec=0;n.t\
v_usec=STARDATE;select(0,0,0,0,&
n);}write(J,3[g],w);if(!K){close(J);return 0;}}}}else if(i){
close(J);FD_CLR(J,&o);x(J);}else{write(1[K[c]],K[_],sizeof(K[_
]));close(1[K[c]]);close(J);return 0;}}else{for(K=0;K<=m;K++)if(
0[K[c]]==J){read(J,K[_],sizeof(K[_]));x(J);if(_[K][0]>=f){0[K[_]
]=1[K[_]]=-1;0[K[c]]=1[K[c]]=0;}break;}}}}}l:close(G);return T;}