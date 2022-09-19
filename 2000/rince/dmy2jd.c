/*
 * Calculates the Julian Day from any day,month,year tuple.
 *
 * This is valid for all dates, including both julian and gregorian calendars.
 *
 * The algorithm is taken from Astronomical Algorithms by Jean Meeus.
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double dmy2jd(double d, int m, int y) {
    int b;

    if (m <= 2) {
	y--;
	m += 12;
    }
    
    /* Handle Julian dates */
    if (y < 1582 || (y == 1582 && (m < 10 || (m == 10 && d <= 4)))) {
	b = 0;
    } else {
	int a;

	a = y/100;
	b = 2 - a + a/4;
    }

    return (int)(365.25 * (y+4716)) + (int)(30.6001 * (m+1)) + d + b - 1524.5;
}

int main(int argc, char **argv) {
    double jd;

    if (argc != 4) {
	fprintf(stderr, "usage: %s day_float month_int year_int\n", argv[0]);
	return 1;
    }

    jd = dmy2jd(atof(argv[1]), atoi(argv[2]), atoi(argv[3]));
    printf("%f\n", jd);

    return 0;
}
