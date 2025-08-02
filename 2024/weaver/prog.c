#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

char *A="~\\^__a^\\Z~\\\\^_ZZffa~\\^__a^\\Z~\\\\^_\\Zaaaca~_~ac_aaacaZ~\\^_\\aca~ZZZ\\ccaZZ\\Zaa_ZZ\\Z_a^\\ZZa_ZZ\\Zcca~ZZ\\Zf^_^\\ZZ\\Z_a^\\ZZa_~__\\_a~^\\Z~\\\\^_\\Zffaca_\\\\^_\\_a^\\Z~\\\\^_\\Z~acca_~ac_aaacaZ~\\^_\\aca~ZZZ\\ccaZZ\\Zaa_ZZ\\Z_a^\\ZZa_ZZ\\ZccaZZ\\Zf^_^\\ZZ\\Z_a^\\ZZa_~ZZ\\ZccaZZ\\Zaa_ZZ\\Z_a^\\ZZa_ZZ\\",
*B="?<<<<<=;?E<<<<><><>D<<<<<=;?E<<<<<><<<<?=C;<<<<<<<>>B<<<><<?;;;;;==@;;;;==@;;;;><=;><>B;;;;==?;;;;;><;;>;;;;><=;><>@B<<<<?=<<@@<<<<<@<<><<><<<<<<><<@@<<<<<?;<<>@C;<<<<<<<>>B<<<><<?;;;;;==@;;;;==@;;;;><=;><>B;;;;==@;;;;><;;>;;;;><=;><>@<;;;;==@;;;;==@;;;;><=;><>B;;;",
*C="~L~N~K~L~L~N~K~L~L~N~K~L~L~N~K~D~D~B~B~D~D~B~B~L~N~K~L~L~N~K~L~L~N~K~L~L~N~K~L~L~N~K~L~L~N~K~L~L~N~K~L~L~N~K~L~D~D~B~B~D~D~B~B~L~N~K~L~L~N~K~L~L~N~K~L~L~N~K~L~L~N~K~L~L~N~K~L",
*D=";?;???;>@?;???;>@?;???;???;>@D@?;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;???;?",
E[]="ZxZxZxZxZxZxZl`<^<ZxZ>_>^>ZxZ<Nb@NZxZ<NTRd<NZxZ<QNQb>ZxZ>Q[<b<ZxZ>QVQRZxZBh<RZxZBh<RWh<ZxZ<h<QWhBZtOJVg<hDZnh<OJg<hHZjh@Jg<hHZjh@Jg<hHZjh@Jg<hHZjh@Jg<hJZhh@Jg<Qh@Yh>Zhh@Jg<a<h>Yh>Zhh@Jg<Xa<h<Yh@ZH~",
G[]="ZxZxZxZ>]<^<ZxZ@^<_<NZxZ>Na<RNZxZ>MQRSNZxZ<RPLRLQZxZ<a<VQRQZxZ>QVQRZxZ@a<RZxZBa<RZxZBa>Wh<Zv_<Wh<WhDZlXOXOWh<WhFZjh@Wh<WhFZjXYh>Jg<hFZjhBJg<hFZjhBJWhJZhhBJWh<Qb<Xi<h<Zfi>h<JWh<Qb<XYh@Zbh<i<h<JWh>a<YhBZbh@QXJWh>i>hDZbh<a>JWXiBhBZdi<Ra<JXiFZP~",
H[]="ZxZxZxZxZL`BZxZ>N_<^<ZxZ>TQRSTZxZ<TQKb<TZxZ<La<RTZxZ>a>KRQZxZ>Va<RZxZ@f<RZxZBa<RWZxZ>WQh<Wh<ZtOXOWJh<Wh@Znh@g<h<WhBZjhBg<JWhFZhhDWJWhFZhhDWJWhFZhXYh@WJhHZhXYh@WJhHZhXi<h>WJh>a<Rh<ZhXi<h>WJh>b<Qh<ZhXi<h>WJh>a>h<ZhXi>h<WJh>YQh>ZP~",
*I="/usr/bin/aplay",*J="r.raw",*h[]={E,G,G,H,H,G,G,E},*b,*n,*l,*W;

int f[64],o=0,w,i=0,s=0,S=0,j,d,x,c,r,Z=704e3,g[]={
9474192,11302972,13664348,14718064,6572056,4466688,9985064,13660272,14715016,15507616,8677424,11549756,12605528,13158600,4210752,2895872};

void a(char*N,char*L){for(n=N,l=L;*n;n++,l++){
d=(*l-58)*1e3;w=*n>'z'?0:8e3/f[*n-58];
for(j=0;j<d;j++,o++)if(w&&(j%w<w/2))b[o]+=(j>d/2)?32:63;}}

int main(int argc, char**argv) {
FILE *P;for(;i<64;i++)f[i]=440*pow(2,(i-45)/12.0);
if (!(b=calloc(Z,1))) return 1;
a(A,B);o=0;a(C,D);

if(!fork()){if((P=fopen(I,"r"))){fclose(P);P=popen(I,"w");s=1;}
else{P=fopen(J,"w");}if(P){fwrite(b,Z,1,P);}if (!s)fclose(P);else pclose(P);
for(;;);}
for(;;){W=h[S++&7];x=0;printf("\x1b[1;1H");
while(*W<'~'){c=*W-58;r=c<16?1:c<32?2:*(++W)-56;c&=15;
printf("\x1b[48;2;%d;%d;%dm",(g[c]>>16)&255,(g[c]>>8)&255,g[c]&255);
for(i=0;i<r;i++,x++)printf(x%80?" ":"\n ");
W++;}usleep(Z/3);}return 0;}
