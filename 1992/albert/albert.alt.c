#include <stdio.h>
#include <malloc.h>
#include <setjmp.h>
#include <ctype.h>
#define new(PP) (PP *) malloc(sizeof(PP)) 
typedef struct q {
    jmp_buf ppp;
    long qq;
    struct q *P;
    struct q *p;
} 
PP;

PP *P;
int aaaaaa=2;
int aaaaaaa=1;

long qqq;


aaAaaa(aa,aaa)
char *aa;
char *aaa;
{
    char aaaa = 0;
    if ((((( aaa )))))
    {
        aaaa = *aa;
        *aa=0;
        aa+=strlen(aa+1);
        P =new(PP);
        P->P=P;
        P->p=P;
    }

    if ((((( !setjmp(P->ppp) ))))) 
        {
        if ((((( !isdigit(*aa) )))))
            longjmp(P->ppp,aaaaaaa);
        else {
            P->p->P = new(PP);
            P->p->P->P = P;
            P->p->P->p = P->p;
            P->p = P->p->P;

            P->qq = *aa--;
            P = P->p;
            aaAaaa(aa,0);
        }
    } else {
        if ( !aaaa&&!*aa ) 
           longjmp(P->p->ppp,aaaaaaa);

        if ((((( (P->qq=aaaa)<10     &&!
                 (isdigit(aaaa))     ||!
                 (isdigit(*aa)       ||!
                 *aa                        )))))) 
        {
            fprintf(stderr,"Usage %c%s <number>\n",
            (aaa[0]?7:aaaa),aaa+!aaa[0]);
            exit(1);
        }
    }
}


ppPppp(pp,ppp)
PP **pp, *ppp;
{
    int aa;
    if ((((( !(aa=setjmp(ppp->ppp))||aa==aaaaaa )))))
    {
        if ((((( *pp==ppp )))))
        {
            ppp = (*pp)->p;

            if ( qqq<47 ) return;
            if ( ppp->qq!=48 ) return;

            while ( ppp->qq==48 ) 
            {
                printf("%ld\n",qqq-45);
                *pp = ppp;
                ppp = ppp->p;
            }
            qqq -= 1;
            longjmp(ppp->ppp,aaaaaaa);
        } else {
            PP *p;

            ppPppp(pp,ppp->p);
            for (p=ppp;p!=*pp;p=p->p)
            {
                int qq=4;
                if ((((( qqq<47                            &&
                         (qq=0,p->qq+=p->p->qq-96)>=48-qqq ||
                         qqq>46                            &&
                         (p->qq-=p->p->qq)<0                   ))))) 
                {
                    p->qq += qqq+qq;
                    if ( p->p==P && qqq<=46 )
                    {
                        P->p->P = new(PP);
                        P->p->P->P = P;
                        P->p->P->p = P->p;
                        *pp = P = P->p = P->p->P;
                        P->qq = 48;
                    }

                    p->p->qq+=qq==0;
                    p->p->qq-=qq!=0;
                }
                else
                {
                    p->qq += 48;
                }
            }
            if ( ppp->P==P ) longjmp(ppp->ppp,aaaaaaa);
        }
    }
    else
    {
        qqq += 1; 

        while (48==P->qq )
        {
            P->P->p = P->p;
            P = P->p->P = P->P;

        }

        if (ppp!=ppp->p->p )
            longjmp(ppp->ppp,aaaaaa);
        else
        {
            printf("At most one remains\n");
            exit(0);
        }
    }
}


main(aaa,aaaa)
int aaa;
char **aaaa;
{
    aaAaaa(aaa==aaaaaaa?aaaa[0]:aaaa[1],aaaa[0]);
    qqq = 39;
    ppPppp(&P,P->p);
}


