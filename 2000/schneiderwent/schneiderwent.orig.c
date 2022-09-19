
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <setjmp.h>
#include <time.h>

#define I ??(i??)??(j??)
#define K ??(i-1??)??(j??)
#define S strtok(NULL,",\n\0")
#define P printf(
#define NB_MSGS 42
#define C( f, m ) mNb = m;\
    s = setjmp( sT??( sI++ ??) );\
    if (!s) goto f;
#define bck longjmp( sT??( --sI ??), 0 );

jmp_buf sT??( 256 ??);
int m5??(84??),sI=0,c1='J'%2,mNb=0,s=0,mI=0,r=1;
unsigned long m1??(32??),q=0,z;
unsigned char m??( NB_MSGS ??)??( 11 ??);

int main( int argc, char *argv??(??) )
{
    time_t tmT = time( NULL );
    struct tm *tmS = localtime( &tmT );
    char tms??( 7 ??);
    int hr,n,i=1,j=0;
    FILE *info = NULL;
    char iS??( 2048 ??);

    if ( argc > 1 ) info = fopen( argv??(1??), "r" );
    strftime( tms, 7, "%H:%M\0", tmS );
    if ( info != NULL ) {
        fgets( iS, 2048, info );
        m5??( 0 ??) = atoi( strtok( iS, ",\0" ) );
        for ( hr = 1; hr < 85; hr++ ) m5??(hr??) = atoi(S);
        for ( hr = 0; hr < 32; hr++ ) 
            m1??( hr ??) = strtoul( S, NULL, 10 );
        for ( hr = 0; hr < NB_MSGS; hr++ ) 
            for ( n = 0; n < 11; n++ ) 
                m??(hr??)??(n??) = (unsigned char)atoi( S );
        fclose( info );
        hr = atoi( strtok( tms, ":\0" ) );
        n = atoi( strtok( NULL, ":\0" ) );
        C( mA, 0 )
        C( out, 40 )
        s = setjmp( sT??( sI++ ??) );
        if ( s ) {
            s = setjmp( sT??( sI++ ??) );
            if ( s ); else goto doHr;
        } else goto doMin;
    } else {
        P "%s", tms );
        goto eoj;
        doMin:
            z = 22;
            C( doIt, 0 )
            bck
        doHr:
            hr = ( n >= 36 ) ? hr+1 : hr;
            if ( hr == 24 ) hr=0;
            if (hr&&hr!=12)(hr<12)?(P "%d ",hr)):(P "%d ",hr-12));
            n = hr + 61;
            q = 0;
            r = 1;
            z = 16;
            C( doIt, 0 )
            P "\n" );
            bck
        doIt:
            if ( r & m1??( m5??(n??) ??) ) {
                if (z == 22) q = q << 1;
                C( out, q )
                if (z == 22) q = q >> 1;
            }
            r = r << 1;
            q++;
            if ( q < z ) goto doIt;
            bck
        out:
            mI = 0;
            mNb += c1;
            while ( m??( mNb ??)??( mI ??) ) 
                P "%c", m??( mNb ??)??( mI++ ??) );
            bck
        mA:
            129<=m I ? 137>=m I ? m K=m I-32
            : 145<=m I ? 153>=m I ? m K=m I-39
            : 162<=m I ? 169>=m I ? m K=m I -47
            : j : j : j : 125==m I ? m K=39
            : 64==m I ? m K=32 : j;
            j++;
            if (m I) goto mA;
            i+=2;
            j = 0;
            if ( i < NB_MSGS ) goto mA;
            bck
    }

    eoj: exit( 0 );

}
