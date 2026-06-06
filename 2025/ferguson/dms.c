/*
 * dms.c: convert lat lon coordinates from DMS (degree minute second) to decimal
 *
 *      usage: ./dms deg min sec [S|N] deg min sec [W|E]
 *
 * where the first set is the latitude and the second set is the longitude. For
 * instance to get to the decimal coordinates of 24° 29′ 10″ S, 46° 40′ 30″ W
 * you would put in:
 *
 *      ./dms 24 29 10 S 46 40 30 W
 *
 * which should print: -24.48611 -46.67500.
 *
 * If you only have lat or lon then you can just do one set. In that case it'll
 * check for both 'S' or 'W': where 'N' or 'E' will not flip the sign.
 *
 * I BELIEVE I have it correct for out of range values but like with this entire
 * program I make ABSOLUTELY NO guarantee it is completely correct. I am less
 * sure of the wraparound in this than I am with prog.c but the in range test
 * above does match.
 */

#define T 360
#define R 180
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h> /* toupper() */
#include <math.h> /* for copysign() */

double dec(double deg, double min, double sec, int sign)
{
    double rslt = deg + copysign(1.0, deg) * (min / 60.0 + sec / 3600.0);
    return sign ? -rslt:rslt;
}
double wrap_lon(double lon)
{
    lon = isnormal(lon)?fmod(lon+R,T):R;
    if (lon<0)lon+=T; lon -=R;
    while(lon < -180.0) lon += 360.0;
    while(lon >= 180.0) lon -= 360.0;
    return lon;
}
double wrap_lat(double lat)
{
    lat = isnormal(lat)?fmod(lat,R):0;
    while(lat > 90.0) lat = R - lat;
    while(lat < -90.0) lat = -R - lat;
    return lat;
}
int main(int argc, char **argv)
{
    double lat, lon, alt;
    int a, b, c;

    if (argc != 9 && argc != 5)
    {
        fprintf(stderr, "usage: %s deg min sec [S|N] deg min sec [W|E]\n", argv[0]);
        fprintf(stderr, "usage: %s deg min sec [S|N|W|E]\n", argv[0]);
        exit(1);
    }

    if (argc == 9)
    {
        /*
         * No. I don't make it an error if it's not ASCII. I could but since
         * it's binary (either the value or not) I don't bother.
         */
        a = toupper(argv[4][0]=='S');
        b = toupper(argv[8][0]=='W');

        lat = dec(strtod(argv[1], 0), strtod(argv[2], 0), strtod(argv[3], 0), a);
        lon = dec(strtod(argv[5], 0), strtod(argv[6], 0), strtod(argv[7], 0), b);

        lat = wrap_lat(lat);
        lon = wrap_lon(lon);

        printf("%.5f %.5f\n", lat, lon);
    }
    else
    {
        /*
         * No. I don't make it an error if it's not ASCII. I could but since
         * it's binary (either the value or not) I don't bother.
         */
        c = toupper(argv[4][0]);
        alt = dec(strtod(argv[1], 0), strtod(argv[2], 0), strtod(argv[3], 0), c=='S'||c=='W');

        if(c == 'S' || c == 'N')
            alt = wrap_lat(alt);
        else
            alt = wrap_lon(alt);

        printf("%5f\n", alt);
    }
}
