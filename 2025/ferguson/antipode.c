/*
 * antipode.c - return antipodes of a given coordinate in order to test prog.c.
 *
 * write the antipode of a given coordinate to stdout. This is used in test.sh
 * due to several bugs and no longer trusting things, though you might notice
 * that the algorithm is similar. The difference (in that way) is the code is
 * more normal (whether it would pass 'isnormal()' or not is another matter
 * since it's not a real floating point which means it would be undefined! :-) ).
 *
 * I did keep variable names the same and the relevant macros the same as well
 * to simplify the integration of the testing.
 *
 * I was able to determine the modulus is right and other values are right but
 * this program combined with the loop in test.sh, which takes A LONG time,
 * allowed me to test out of range and in range on a large scale. Necessary due
 * to bugs.
 *
 * The isnormal() calls are to make sure they're safe to compare. This is so
 * I don't have to do isless() and so on which is probably more costly and on
 * top of that I want to, if nan or inf, set them to a sane value rather
 * than just exit with an error or assume it's some value. In fact I must do so
 * because if I leave it at nan or inf it will not draw on the image!
 */
#define T 360
#define R 180
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <inttypes.h>

FILE *prog;
char buf[2048];
char out[2048];
uintmax_t count;
uintmax_t mismatches;
uintmax_t sscanf_errors;
int antipode(double U, double tr, double *L, double *lo)
{
    if (!L || !lo)
        return -1;
    if (isnormal(tr))
        tr=fmod(tr+R,T);
    else tr = R;

    if (tr < 0) tr+=T;
    tr-=R;

    if (isnormal(U)) U=fmod(U,R);
    else U=0;

    while (U>90)U=R-U;
    while (U<-90)U=-R-U;
    *L = -U;
    *lo = tr<0?R+tr:-(R-tr);

    return 1;
}
int main(int argc, char **argv)
{
    double U, tr, L, lo, anti_lat, anti_lon;

    for (U = -3333; U < 3334; ++U)
        for (tr = -3333; tr < 3334; ++tr)
        {
            if (antipode(U, tr, &L, &lo));
            else L = lo = NAN;
            sprintf(buf, "./prog %f %f", U, tr);
            prog = popen(buf, "r");
            if (prog)
            {
                if (!(count++ % 500))
                {
                    printf("about to run: %s\n", buf);
                    fflush(stdout);
                }

                *out = '\0';
                if (fgets(out, sizeof out, prog))
                {
                    if (sscanf(out, "%lf %lf\n", &anti_lat, &anti_lon) != 2)
                    {
                        fprintf(stderr, "ERROR: %s failed to return anti_lat anti_lon!\n", buf);
                        fflush(stderr);
                        ++sscanf_errors;
                    }
                    else if (isless(L, anti_lat) || isgreater(L, anti_lat) || isless(lo, anti_lon) || isgreater(lo, anti_lon))
                    {
                        fprintf(stderr, "ERROR: %s mismatch: expected %f %f, got %f %f!\n", buf, L, lo, anti_lat, anti_lon);
                        fflush(stderr);
                        ++mismatches;
                    }
                }
                else
                {
                    fprintf(stderr, "failed to read output from: %s\n", buf);
                    fflush(stderr);
                    exit(1);
                }
                if (!(count % 500))
                {
                    printf("tested a total of %ju coordinates (mismatches: %ju, sscanf errors: %ju)\n", count, mismatches,
                            sscanf_errors);
                    fflush(stdout);
                }
                fclose(prog);
                prog = NULL;
            }
            else
            {
                fprintf(stderr, "ERROR: could not create process, exiting!\n");
                fflush(stderr);
                exit(1);
            }
        }

    if (!mismatches && !sscanf_errors)
        printf("PASS: tested a total of %ju coordinates with no errors\n", count);
    else
        printf("FAIL: tested a total of %ju coordinates with %ju mismatch%s and %ju sscanf error%s\n", count, mismatches,
                mismatches == 1 ? "":"s", sscanf_errors, sscanf_errors == 1 ? "":"s");

    fflush(stdout);
    return 0;
}
