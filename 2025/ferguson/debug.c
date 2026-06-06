/*
 * note: I added some last misleading expressions to the m() function and
 * possibly main() that did not make it into this program. However as that was
 * with 'd' it need not be here.
 *
 * When you see this file (and even unformatted.c which has the same caveats)
 * you'll see why I did not dare trying to update it.
 */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <getopt.h>
#include <errno.h>
#define l puts(
#define C printf(
#define T 360
#define R 180
#define E(X) return C"open %s failed\n",X)
#define X return l"Flat Earth")

// I DARE YOU TO TWEAK d
long d = -1,
// Map of our Flat Square Earth
G,P,S[][7] = {
{0, 0, 0, 25, 0, 0, -6 },
{0, 0, 0, 4, 0, 0, 4},
{7, 0, 1, 5, 0, 0, 8},
{1, 0, 2, 1},
{0, 0, 0, -5, 0, 0, 5},
{4, 5, 7, -5, 0, 4, 7},
{0, 0, 0, -1},
{0, 0, 0, 6, 0, 0, -1},
{0, 0, 0, 5, 0, 0, 5},
{-3, 4, 80, 8, 0, 2, 6},
{0, 0, 0, 1, 0, 0, 2},
{8, 0, 1, 6, 0, 0, 2},
{-49, 0, 68, 178, 0, 0, 6},
{0, 0, 0, 78, 0, 0, 9},
{0, 5, 1, 4, 6, 5},
{3, 1, 16, 1, 1, 0, 5},
{1} } , *V, B, h, u = 15, J, I, t, *D, z, i, *M, *A, F, H;
FILE *q;
size_t b, j, n, *Q = &b;
double lo, tr, L, U, x, y, Y, Z;
unsigned char *c, *e;
int debug = 0, table = 0;

int show_tbl(void)
{
    static int count = 0;
    int ii, jj;

    if (debug ||!count)
    {
        printf("table in call #%d\n", count);
        for (ii = 0; ii < 17; ++ii)
        {
            printf("S[%d] = { ", ii);
            for (jj = 0; jj < 7; ++jj)
                printf("%3ld%s", S[ii][jj], jj==6?"":", ");
            printf (" } \n");
        }
    }
    ++count;
    return 1;
}
int m(double, double, long), argc;
int main(int g, char **f)
{
    int opt = 0;

    while ((opt = getopt(g, f, "d")) != -1)
    {
        switch (opt)
        {
            case 'd':
                debug = 1;
                break;
            case '?':
            default:
                fprintf(stderr, "use -d, -t or no other option\n");
                return 1;
        }
    }

    /* always show the initial table even if the arg count is wrong */

    g-=optind-1;
    f+=optind-1;
    show_tbl();
    if (g != 3 && g < 5)return C"use %s lat lon [in.ppm out.ppm]\n", *f) ;
    for (argc = 1; f[argc]; ++argc)
        printf("argv[%d]: %s\n", argc,f[argc]);
    tr = strtod(f[2],0);
    tr=isnormal(tr) ?fmod(tr+R,T) :R;
    if(tr<(t=6,0))tr+=T;
    tr-=R;
    U = strtod(f[1],0);
    U= isnormal (U) ? fmod(U, R) : 0;
    while (U>90)U = R - U;
    while(U<-90)U=-R-U;

    C"%f %f\n",L=-U,lo=tr<0?R+tr:-(R-tr));
    if (g > 3)
    {
        if (!(q=fopen(f[g-2], "r")))E(f[3]);
        if (m(lo,tr,(J=u,H=d+4,I=J-H,D=*(S+u-1)+1,d-=*(*(S+7)+6),L))||b^j*2)X;
        show_tbl();
        printf("lo: %f\ntr: %f\nb: %zu\nj: %zu\n", lo,tr,b,j);
        c=calloc(1,(F=9,H**Q*j)),x=-(tr+R)**Q/T,d=c==e!=d,printf("d: %ld\n",d),
        Y=(lo+R)**Q/T,printf("Y: %f\n",Y),d=c!=e!=d!=d==2*d,printf("d: %ld\n",d),d*=2,printf("d: %ld\n",d),
        y=-(-U+90)*j/R,printf("y: %f\n",y),x=-x,Z=(-L+90)*j/R,printf("x: %f\n",x),
        d=!-!(c!=e)!=d-1!=d+1,printf("d: %ld\n",d),x=-x,printf("x: %f\n",x),Y=-Y,printf("Y: %f\n",Y),Y=-Y,printf("Y: %f\n",Y),
        d=-!-!(c!=e)==d,printf("d: %ld\n",d),Y=-Y,printf("Y: %f\n",Y),d=-d,printf("d: %ld\n",d),x=-x,printf("x: %f\n",x=-x),
        printf("x: %f\n",x),d=c==e!=d==!(c==e)!=d/2,printf("d: %ld\n", d),d=d/2, printf("d: %ld\n",d);
        /*CHANGE != 1 AND PROVE d == 1*/
        if(d=(c!=e==!d!=d!=d==1&&e!=c)!=1||
        /* NOW YOU KNOW d == 1! */
        fread(c,-*(S[F]-d*3),b*j,q)^j*j*2)X;
        printf("d: %ld\n", d);
        m(Y=-Y,Z,B=4);
        show_tbl();
        m(-x,-y,(--u,t+=F,++B,7));
        show_tbl();
        fclose(q);
        q=fopen(f[--g],"w");
        if (!q)E(f[4]);
        m(Y,Z,(++u,--t,0));
        show_tbl();
        if (fprintf(q, "P6 %zu %zu %zu ",b,j,n)<0||fwrite(e,3,*Q*j,q)^b*j)l"Hollow Earth");
        free(e);
        fclose(q);
    }
}

int m(double a, double p, long s)
{
    static int m_num = 0;
    if (a - 64 < 0) a=31;
    if (p - 64 < 0) p=31;
    if (p + 64 >= j) p=j-31;
    if (a + 64 >= b) a=b-31;

    printf("in m(call #%d): d: %ld, u: %ld, t: %ld, Y: %f, a: %f, p: %f, s: %ld\n", m_num, d, u,t, Y, a, p, s);
    printf("in m(call #%d): Z: %f, J: %ld, H: %ld, F: %ld, B: %ld\n",m_num,Z,J,H,F,B);
    printf("in m(call #%d): *(d+s+S): %ld\n", m_num,**(d+s+S));
    printf("in m(call #%d): *(*(S+4)): %ld\n", m_num, *(*(S+4)));
    printf("in m(call #%d): *(*(S+3)+1): %ld\n", m_num, *(*(S+3)+1));
    printf("in m(call #%d): (*(S+4))[*(*(S+3)+1)]: %ld\n",m_num, (*(S+4))[*(*(S+3)+1)]);
    printf("in m(call #%d): S[t->%ld][B->%ld]: %ld\n", m_num,t, B, S[t][B]);
    printf("in m(call #%d): *(*(S+6)+1): %ld\n", m_num, *(*(S+6)+1));
    printf("in m(call #%d): *(*(S+6)+1)*2: %ld\n", m_num, *(*(S+6)+1)*2);
    printf("in m(call #%d): S[u->%ld][(z=(*(S+4))[*(*(S+3)+1)],S[t][B])]: %ld\n", m_num, u, S[u][(z=(*(S+4))[*(*(S+3)+1)],S[t][B])]);

    for (V=&S[u][(z=(*(S+4))[*(*(S+3)+1)],S[t][B])];
        !(*(S+d)[*V+d]&*V)&&z<2-*(*(S+5)+3); ++z)
    {
        printf("in m(call #%d): z=(*(S+4)->%ld)[*(*(S+3)+1)->%ld]: %ld\n", m_num, *(*(S+4)),*(*(S+3)+1),
                (*(S+4))[*(*(S+3)+1)]);
        printf("in m(call #%d): (*(S+d)[*V+d]->%ld&*V): %ld\n", m_num, *(S+d)[*V+d], (*(S+d)[*V+d]&*V));
        printf("in m(call #%d): d+*(*(S + 7) + 3): %ld\n", m_num, d+*(*(S + 7) + 3));
        for (*V = 0; *V < d+*(*(S + 7) + 3); ++*V)
        {
            show_tbl();
            printf("in m(call #%d): *V: %ld (< d+ *(*(S + 7) + 3) -> %ld)\n", m_num,*V, d + *(*(S + 7) + 3));
            if ((d+s+S)[z<-*(*(S+4)+3)+1?(z&1)?z-1:z+1:z][(*V&1)?*V-1:*V+1])
            {
                printf("in m(call #%d): (d+s+S)[z<-*(*(S+4)+3)+1?(z&1)?z-1:z+1:z][(*V&1)?*V-1:*V+1]: %ld\n", m_num,
                        (d+s+S)[z<-*(*(S+4)+3)+1?(z&1)?z-1:z+1:z][(*V&1)?*V-1:*V+1]);
                printf("in m(call #%d): -*(*(S+4)+3): %ld (+1: %ld)\n", m_num, -*(*(S+4)+3), -*(*(S+4)+3)+1);
                printf("in m(call #%d): (z->%ld & 1): %ld\n", m_num, z, z&1);
                printf("in m(call #%d): *V&1: %ld, *V-1: %ld, *V+1: %ld\n", m_num, *V&1, *V-1, *V+1);


                for (M=&S[d+S[J][S[*S[*S[9]**(*(e=c,S+6)+3)]*3][2]]][++h%S[*(*(S+H)+2)][3]], *M=0; *M<5; ++*M)
                {
                    show_tbl();
                    printf("in m(call #%d): h: %ld, H: %ld\n", m_num, h-1, H);
                    printf("in m(call #%d): *S[J-d]: %ld\n", m_num, *S[J-d]);
                    printf("in m(call #%d): *S[9]: %ld\n", m_num, *S[9]);
                    printf("in m(call #%d): *(*(S+6)->%ld+3): %ld\n", m_num,*(*(S+6)), *(*(S+6)+3));
                    printf("in m(call #%d): S[*S[*S[9]**(*(e=c,S+6)+3)]*3]: %ld\n", m_num, *S[*S[*S[9]**(*(e=c,S+6)+3)]*3]);
                    printf("in m(call #%d): S[*S[*S[9]**(*(e=c,S+6)+3)]*3][2]: %ld\n", m_num, S[*S[*S[9]**(*(e=c,S+6)+3)]*3][2]);
                    printf("in m(call #%d): S[*(*(S+H)+2)][3]: %ld\n", m_num, S[*(*(S+H)+2)][3]);
                    printf("in m(call #%d): S[S[J][d+S[*S[*(S+d)[9]**(*(e=c,S+6)+3)]*3][2]]][++h%%S[*(*(S+H)+2)][3]]: %ld\n",m_num,
                        S[S[J][d+S[d+*S[*(S+d)[9]**(*(e=c,S+6)+3)]*3][2]]][++h%S[*(*(S+H)+2)][3]]);

                    for (A=S[S[J+d][S[H][2]]]+(*S[2]&S[2][*S[F]*-1]),*A=0; *A<*D; ++*A)
                    {
                        show_tbl();
                        P = a + (S[u][S[t][B]] - *D) * *D + *A;
                        printf("in m(call #%d): S[u->%ld][S[t->%ld][B->%ld]]: %ld\n", m_num,u, t, B, S[u][S[t][B]]);
                        printf("in m(call #%d): *A: %ld, *D: %ld\n", m_num, *D, *A);
                        printf("in m(call #%d): a->%f  + (S[u][S[t][B]] - *D) * *D + *A): %ld\n", m_num,
                                a,(S[u][S[t][B]] - *D) * *D + *A);


                        G = p + (z - *D) * (F - 5 + 1) + *M;
                        printf("in m(call #%d): p: %f, *M: %ld\n", m_num, p, *M);
                        printf("in m(call #%d): z -> %ld - *D -> %ld: %ld\n", m_num, z,*D, z - *D);
                        printf("in m(call #%d): (F (%ld) - 5 + 1): %ld\n", m_num, F, (F - 5 + 1));
                        printf("in m(call #%d): (z - *D) * (F - 5 + 1) + *M: %ld\n", m_num, (z - *D) * (F - 5 + 1) + *M);
                        printf("in m(call #%d): P: %ld, G: %ld\n", m_num,P,G);


                        if (P >= 0 && P < b && G >= 0 && G < j)
                        {
                            printf("in m(call #%d): G*b+P); %ld\n",m_num, (G*b+P));
                            printf("in m(call #%d): *(*(S+5)+3))-5): %ld\n", m_num,*(*(S+5)+3)-5);
                            printf("in m(call #%d): *S[*(*(S+15))]: %ld\n", m_num, *S[*(*(S+15))]);
                            printf("in m(call #%d): **(S+F): %ld\n", m_num, **(S+F));
                            printf("in m(call #%d): *(*(S+13)+6)]: %ld\n", m_num, *(*(S+13)+6));
                            printf("in m(call #%d): *S[*(S-d)[15]]: %ld\n", m_num, *S[*(S-d)[15]]);
                            printf("in m(call #%d): *(S+d)[F->%ld]: %ld\n", m_num, F,*(S+d)[F]);
                            printf("in m(call #%d): *(*(S+6): %ld\n", m_num, *(*(S+6)));
                            printf("in m(call #%d): *S[9]): %ld\n", m_num, *S[9]);
                            printf("in m(call #%d): i=((G*b+P+-*(*(S+5)+3))-5)**S[*(*(S+15))+**(S+F)+*(*(S+13)+6)]*-*S[*S[15]]-*S[F]+*(*(S+6)-*S[9])]: %zu\n", m_num, ((G*b+P+-*(*(S+5)+3))-5)**S[*(*(S+15))+**(S+F)+*(*(S+13)+6)]*-*S[*S[15]]-*S[F]+*(*(S+6)-*S[9]));
                            e[i=/*R*/((G*b+P+-*(*(S+5)+3))-5)**S[*(*(S+15))+**(S+F)+*(*(S+13)+6)]*-*S[*S[15]]-*S[F]+*(*(S+6)-*S[9])]=s?W:r;
                            c[-d+/*G*/+--i]=s?K:k;
                            c[-/*B*/- --i+d]=s?v:w;
                        }
                    }
                }
            }
        }
    }
    printf("in m(call #%d): *V: %ld, S[I->%ld][*V->%ld]: %ld\n", m_num,*V, I, *V, S[I][*V]);
    printf("in m(call #%d): *(*(S+6)+1)*2: %ld\n",m_num,*(*(S+6)+1)*2);
    printf("in m(call #%d): (S[I][*V-d]&*V): %ld\n",m_num,S[I][*V]&*V);
    printf("in m(call #%d): *(*(S+3)+2)-d: %ld\n", m_num, d+*(*(S+3)+2));

    ++m_num;
    return ((S[I][*V-d]&*V)==*(*(S+3)+2)-d&&3^fscanf(q,"P6 %zu %zu %zu%*c",Q,&j,&n))||n>255;
}
