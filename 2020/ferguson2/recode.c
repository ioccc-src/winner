%:  include  <string.h>
%:  include   <stdio.h>
%:  include   <ctype.h>
%:  include  <stdlib.h>
%:  include    <time.h>
%:  include  <unistd.h>
%:  define W (char<: :> <: 4 :>){   "  I"," II","III"," IV", "  V"}
%:define E(x) do (*x) = getchar(); while ((*x)!='\n')
#define q Q"Invalid input. ")
#define Z(x) (x)=A<:F(0,25):>
%:define Q    fprintf(stderr,

%:define U   (char<::>){"BC"}
#define L(V) (V)=toupper((V))
%:define n	      isalpha

			   /\
/			    This is				      *not*					what you think:

	    void D(char*x){ for(char*p=x; *p; ++p)*p=islower(*p)		?"nopqrstuvwxyzabcdefghijklm"<:(*p-97+26)%26:>:*p; }
	    char *M,*Y<:3:>,R<:3:>,A<::>="ABCDEFGHIJKLMNOPQRSTU"		"VWXYZ",N<::><:27:> = { "EKMFLGDQVZNTOWYHXUSPAIBRCJ"
	    ,"AJDKSIRUXBLHWTMCQGZNPYFVOE","BDFHJLCPRTXVZNYEIWGA"		"KMUSQO","ESOVPZJAYQUIRHXLNFTGKDCMWB","VZBRGITYUPSD"
	    "NHLXAWMJQOFECK"} ,o<::><:27:>={ "YRUHQSLDPXNGOKMIE"		"BFZCWVJAT","FVPJIAOYEDRZXWGCTKUQSBNMHL"} ,P<::>="A"
	    "BC", T<::>="BBC",C<:2:><:11:>, g<:27:>,X<::><:21:>=		{ "Rbgbef", "Iachg ebgbe", "Iachg frggvat", "Iachg "
	    "cbfvgvba","Rrsyrpgbe", "Iachg ersyrpgbe","Iachg cy"		"htobneq cnve","Rvat","frggvatf","cbfvgvba"} ; int K
	    <::>={ 0,1,2} ,y, H, v, c; size_t l; int F(int i,int		j) { return(rand()%(j-i+1))+i; } void d(void){ int i
	    ,j,k; srand((unsigned)time(0)); strcpy(g,A); K<:0:>=		F(0,4); while((K<:1:>=F(0,4))==K<:0:>) ; while((K<:2
	    :>=F(0,4))==K<:0:>||K<:2:>==K<:1:>) ; y=F(0,1); for(		i=0; i<3; ++i){ Z(P<:i:>); Z(T<:i:>); } k=0; while (
	    k<10){ do i=F(0,25); while (g<:i:> == ' '); do j=F(0		,25); while(j==i||g<:j:>==' '); C<:0:><:k:>=g<: i:>;
	    C<: 1 :> <: k ++:> = g<: j:>; g<:i:>=' '; g<:j:>=' '                ; } H=1; } int p(char x){ return strchr(C<:0:>,x) ||

		    strchr(C<:1:>,x); } char B<:3:>; void G(void){ * B ='\0'; scanf("%2s", B); } void m(void) { int i, j=0,h;
		    char k; Q"%s:\n",*X); for(i=0; i<5; ++i)Q"(%d) %s: ""%s\n", i+1,W<:i:>,N<:i:>); for(i=0; i< 3; ) { x :  Q
		    "%s %d (1 - 5): ", X        <:1:>,i+1); G(); j=strtol(B,0,0); if (j<1||j>5) {          q; E(&j); continue
		    ; } j =(j < 1 ?1:(j>        5?5:j))-1; h=i-1; for(; h>= 0; --h) { if(K<:h:>==          j){ Q"Already use"
		    "d. "); E(&j);  goto        x; } } K<:i++:>=j; E(& j); } for(i=0; i<3; ++i) {          i:Q"%s %d (A - Z)"
		    ": ", 2<:X:>,i+1); G(); if(!n(k=*B)){ q; E(&*B); goto i; } P<:i:> = toupper(k); E(&*B); } for (i = 0; i<3
		    ; ++i){ j:Q"%s %d (A - Z): ",X<:3:>,i+1); G(); if(!n(k=*B)){ q; E(&*B); goto j; } T<:i:>= toupper(k); E(&
		    *B); } Q"%s:\n",X <: 4 :>); for(i = 0; i < 2 ; ++i)Q"(%d) (%c) %s\n", i + 1, U<:i:>, o<:i:> ) ; k:y =0; Q
		    "%s (1 - 2): ", 5<:X:>); G(); y=strtol(B,0,0); if (y < 1 || y > 2) { q; E( & y); goto k ; } y=(y<1?1:(y >
		    1 ?2:y))-1; strcpy(g,A); for (i=0; i<10; ++i) { char a,b; v:a = b = '.'; Q"%s %d: ",6<:X:>,i+1); G(); a=B
		    <:0:>; b=B<:1:>; L(a); L(b); if((n(a)&&!n(b))||(!n(a)&&n(b))||(n(a) && (a== b || (p(a)||p(b)))))<%if((p(a
		    )||(b))&&(n(a)&&n(b))) Q"Already used. "); else q; E(&a); goto v; } a=n(a)?a:'.'; b=n(b)?b:'.'; C<:0:><:i
		    :>=a; C<:1:><:i:>=b; if(n(a)){g<:a-'A':>=' ';g<:b-'A':>=' '; }E(&a); } }void e(void) { int i; for(i=0;i<3
		    ; ++i)Q"%s %d: (%s) %s\n", 7 <:X:>,i+1,W<:K<:i:>:>,N<:K<:i:>:>); Q"%s  %s: %s\n",7<:X:>,X<:8:>, P); Q"%s"
		    " %ss"": %s\n", X<:7:>,*(X+9),T) ; Q "%s: (%c) %s\n",4<:X:>,U<:y:>,o<:y:>) ; for(i=0,L(6<:X:><:6:>); i<10
		    ; ++i)Q"%c%s #%02d: %c%c\n", X<:6:><:6:>,7+6<:X:>, i+1, C<:0:><:i:>, C<:1:><:i:>); } int O(const char*p){
		    int i,j=0; char*x=0; FILE *f = fopen(p, "r"); if(f){ if(getdelim(&x,&l,EOF,f)>0){ p = x; j = 1; } fclose(
		    f); } l = 0; if(strlen(p) > 29) { for(i = 0; i < 3; ++i){ K<:i:>=(*p++)-'0'; K<:i:> = (K<:i:> < 1 ? 1 : (
		    K<:i:>> 5 ? 5 : K<:i        :>))-1; P<:i:> = *p++; T<:i:> = *p++ ; } y = ( * p         ++)-'0'; y=(y<1?1:
		    (y>1?2:y))-1; for(i=        0; i<10; ++i){ C<:0:><:i:>=*p++; C<:1:><:i:>=*p++;         } if (j) free(x) ;
		    return 1 ; }  if (j)        free(x); return 0; } void x(FILE*f,int k) { int i;         for (i=0; i <3; ++
		    i){ fprintf(f,"%d",K<:i:>+1); fprintf(f,"%c",P<:i :>);fprintf(f,"%c", T<:i:>); } fprintf(f, "%d", y + 1);
		    for (i= 0; i<10; ++i)fprintf(f,"%c%c",C<:0:><:i:>,C <:1:><:i:>); if(f==stdout&&k)fprintf(f,"%s",M); } int

	    t(const char*a,const char *b) { int i, j; for (i = 0		; *(a+i) || *(b+ i); ++i) if ((j = tolower(a<:i:>) -
	    tolower(b<:i:>))){ if (j < 0) return -1; return 1; }		return 0; } int main(int V, char **I){ FILE*w=stdin,
	    *z=NULL; const char*p, *J="", *k= ""; int i; ssize_t		s; for(i = 0; i < 10; ++i) D(i<:X:>); for(V = 1; I<:
	    V:>; ++V) { if (*(p = I<: V :>) =='-') { switch (*++		p){ case'h':Q"usage: %s [options]\n-v\t\t\tdisplay "
	    "selected settings\n-r\t\t\tpseudo-randomly select "		"settings\n-f<input file>\t\tread file for Enigma i"
	    "nput\n-R<string|file>\t\tinit settings from settin"		"gs string or file\n-o<output file>\t\twrite settin"
	    "gs to file\n", * I); return 0; case 'v':c=1; break;		case'r':if(!H){ v=1; d(); } break; case'R':H= O(++p)
	    ; break; case'f':J=++ p; break; case'o':k=++p; break		; default:break; } } } if(*J){ w = fopen(J, "r"); if
	    (! w) { Q"couldn't open input file, using stdin\n");		w=stdin; } } if (*J && *k && !t(J,k)){ Q"same input"
	    "/output filenames, won't open for writing\n") ; k =		""; } if (*k) { z=fopen(k, "w"); if (!z) Q"couldn't"
	    " open output file, only using stdout\n");  } if (!v		&& !H && isatty(0)) m(); if (c) e(); s = getdelim(&M
	    ,&l,EOF,w); if(w!=stdin)fclose(w); if (z){ x(z,s>0);		fclose(z); } x(stdout,s>0); free(M); return 0;     }
