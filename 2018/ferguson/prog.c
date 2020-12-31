    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include<ctype.h>
    #include<time.h>
    #include<stdint.h>
    Q unsigned d; Q char E; Q int k;
    Q long u; Q size_t t; Q const char U;
    #define L toupper
    #define M SIZE_MAX-1
    #ifndef S
    #define S 38
    #elif S < 38
    #undef S
    #define S 38
    #elif S > M
    #undef S
    #define S M
    #endif
    #define l S-1
    #define Y strlen
    #define Z printf
    #define K static
    #define z do{
    K E W[]="stqvvwxzwtzuvvryusuxvtrqsruxttrxvwqxq"; K E T[S]= {77,69,84,72,73,78,75,83,32,73,84,32,73,83,32,76,73,75,69,32,65,32,87,69,65,83,69,76,0} ;
    K U C[] =" !\"#$<%:>&'()*+,-./0123456789;=?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`{|}~";
    /*NO*/
    K E P[2][sizeof(T)]; K t G=0;
    #ifndef N
    #define N 25
    #elif N < 4
    #undef N
    #define N 3
    #elif N > M
    #undef N
    #define N M
    #endif
    /*BLOB*/
    K u R=1; K d D=0; K k X(k f,k t){ return (rand()%((t)-(f)+1)+(f)); }
    K E c() {return C[X(0,(k)Y(C)-1)];%> Q struct x { E G[sizeof T];
    t F; } x; K x O[N];
    /* Special C main() handler (encapsulation): */
    #define r(main) main
    r(k main(k a, E **V)) { x x; E*b;
    U *A=T; k h=0,s,q=0,m=0,y=0,n=N==97,J=0; t i,j,

    /* prototype for special C parser H() below */
    F H(); H(<% H(for (s = 1; s < a && *V[s++]; ) H(<%
    H(E *v=V[s-1]; H(if (*v!='-'||h) H(g(o) w(f) H(
    while (*++v) H(switch (*v) { w(case '-') h=1; g(f)
    w(case 'r') H(if ((R=strtol(v+1,&b,0)) < 1 || R > 100)/*CODING*/
    <% Z("mutation rate out of range\n") ; m=1); %> else m=0; g(f)
    w(case 'q') q=1; Z("quiet output\n") ; g(f) w(case 'm') J=1;
    g(f) w(default) g(f) %>); H(continue))); H(w(o) H(y=1; 
    H(i = Y(V<:s-1]); H(if(i > l) i=l; H( strncpy(T,V[s-1:>,i)
    ; H(T[i]='\0')))))))); })); }); H(H(if (n&&!y) for (j=0
    ; j<37; ++j) T[j]=W[j]-'A'); H(for ( ; *A && strchr(C, L(*A))
    ; ++A)); H(if (*A) <% Z("'%c' not in keyboard \"%s\"\n", *A,C)
    ; return 1; })/*THIS*/); H(srand((d)time(0)); memset(&x, 0, sizeof x);
    memset(O,0,sizeof O)); H(Z(/*IS*/"target '%s'\n", T); H(Z(
    "mutation rate %ld\n", R)); H(if((m=(m||J||N<4)))
    Z("monkey at typewriter\n"); H(for ( j=0; j<N; ++j) H(for
    (i=0; i<Y(T); ++i) O[j].G[i]=c())))); H(while (!D) { H(if (++

    G==M) {Z("Too many attempts, blaming the monkey Eric even if "
    "he isn't typing or doesn't exist. Bye.\n"); return 1; } H(for
    (j=0; j<N&&!D; ++j) { F = 0;/*NOT*/ H(for (i =0; i < Y(T); ++i)) { H(
    if (L(O[j].G[i]) == L(T[i]))) ++F; } /*A*/ O[j].F=F; H(if (((D=(F==Y(T)))
    ||G==1)&&(!q||D)) Z("Generation %4zu\tOffspring %2zu: %s\n",G
    -1,j+1,O[j] .G); })); H(if (D)break;); s=0; /*COMPACT*/ H(if (m) g(p) else H(z
    s=1; H(for(i=0; i<N-1; ++i) { H(if (O<:i].F >= O[i+1].F) g(h)) x=O[
    i+1:>; O[i]=O[i+1]; O[i+1]=x; s=0; w(h); }); }while(!s))); w(p
    ) H(strcpy(P[0],O[0].G); strcpy(P[1],O[1].G)); H(for (j=0; j<N; ++j)
    { H(for (i=0;!m&&i<Y(T); ++i) H(if ( X(0,9)<5) O[j] .
    G[i]=P[0][i]); H(else O[j] .  G[i]=P[1][i];)); /*BLOB*/ H(if (!
    q) Z("Generation %4zu\tOffspring %2zu: %s -> " ,G,j+1,O[j].
    G); H(for/*OF*/ (i=0; i<Y(T); ++i) { H(if (X(1,100) <= R || m)
    O[j].G[i]=c(); })); H(if (!q) Z("%s (%s)\n",O[j].G,m
    ?"monkey typing" : "mutation"))); /*OCTETS*/ }); H(if (!
    q) Z("**\n")); })); return 0; }
