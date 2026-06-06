#include <stdio.h>
#include <stdlib.h>
#include <math.h>

static const double bands[] = {
    0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.6, 0.9, 1.2, 1.5, 1.8, 2.1
};
#define NBANDS (sizeof(bands)/sizeof(bands[0]))

int main(int argc, char **argv) {
    if (argc > 1) {
        fprintf(stderr, "\nUsage: %s < flux.data > contour.pgm\n\n", argv[0]);
        fprintf(stderr, "Reads flux data from stdin and draws iso-flux contour\n");
        fprintf(stderr, "lines at fixed brightness levels, writing a PGM image to stdout.\n");
        fprintf(stderr, "Image dimensions are inferred assuming a 2:1 aspect ratio.\n");
        fprintf(stderr, "The result should match Fig 10 in Luminet's 1979 paper.\n");
        return 1;
    }

    int cap = 1024, n = 0;
    double *v = malloc(cap * sizeof(double));
    double val;
    while (fscanf(stdin, "%lf", &val) == 1) {
        if (n >= cap) { cap *= 2; v = realloc(v, cap * sizeof(double)); }
        v[n++] = val;
    }
    /* infer 2:1 dimensions: w=2h, w*h=n => h=sqrt(n/2) */
    int h = (int)(sqrt(n / 2.0) + 0.5);
    int w = n / h;
    if (w * h != n) {
        fprintf(stderr, "cannot factor %d values into 2:1 image (tried %dx%d)\n", n, w, h);
        return 1;
    }

    unsigned char *img = malloc(w * h);

    for (int y = 0; y < h; y++) {
        for (int x = 0; x < w; x++) {
            int i = y * w + x;
            double c = v[i];
            int black = 0;

            /* black where value is zero */
            if (c == 0.0) { black = 1; goto done; }

            /* black where value crosses a band (check right and down neighbors) */
            for (int b = 0; b < (int)NBANDS; b++) {
                double level = bands[b];
                if (x + 1 < w) {
                    double r = v[i + 1];
                    if ((c - level) * (r - level) < 0) { black = 1; goto done; }
                }
                if (y + 1 < h) {
                    double d = v[i + w];
                    if ((c - level) * (d - level) < 0) { black = 1; goto done; }
                }
            }

done:
            img[i] = black ? 0 : 255;
        }
    }

    fprintf(stdout, "P5\n%d %d\n255\n", w, h);
    fwrite(img, 1, w * h, stdout);

    free(v);
    free(img);
    return 0;
}
