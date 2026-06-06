/*
 * IMPORTANT! This does NOT work right for some coordinates because it uses
 * longs instead of floating point! Antipodes require negative 0. Additionally
 * without floating point you have the problem of truncation. I also believe I
 * had (did not really look) this program clamp out of range coordinates but
 * despite my jokes our Earth is not flat (it's actually tetrahedral! Roundish
 * yes but still a tetrahedron) so when one goes to the edge of the world they
 * do not fall off the edge.
 *
 * The point of including this file is so you can see how small the arrows were
 * before and also how simple the program was, how unobfuscated it was and how
 * frankly awful it was, even if it did something beautiful.
 *
 * A program calculating antipodes simply MUST use floating points.
 *
 * Nonetheless you do get to see how the arrows were 'rendered' in that the
 * arrays are simple with ones and zeros and not interleaved.
 */
#include <stdio.h>
#include <stdlib.h>

FILE *f;
unsigned char *pixels;
char magic[3];
long V,h,m,a_lat,a_lon, lat, lon, px, py, y, dy, x, dx, mx, my, i,apx,apy,
down_arrow[][7] =
{
    { 0,0,1,0,0,0,0} ,
    { 0,0,1,0,0,0,0} ,
    { 0,1,1,1,0,0,0} ,
    { 0,1,1,1,0,0,0} ,
    { 1,1,1,1,1,0,0} ,
    { 0,0,1,0,0,0,0} ,
    { 0,0,1,0,0,0,0}
}
,
up_arrow[][7] =
{
    { 0,0,1,0,0,0,0} ,
    { 0,0,1,0,0,0,0} ,
    { 0,0,1,0,0,0,0} ,
    { 1,1,1,1,1,0,0} ,
    { 0,1,1,1,0,0,0} ,
    { 0,1,1,1,0,0,0} ,
    { 0,0,1,0,0,0,0}
} ;
void plot(long X, long Y, long mask[][7], unsigned char R, unsigned char G, unsigned char B)
{
    if (X - 10 < 0) X = 10;
    if (X + 10 >= V) X = V - 1 - 10;
    if (Y - 10 < 0) Y = 10;
    if (Y + 10 >= h) Y = h - 1 - 10;

    for (y = 0; y < 7; y++) {
        for (x = 0; x < 7; x++) {
            if (mask[y][x]) {
                for (dy = 0; dy < 3; dy++) {
                    for (dx = 0; dx < 3; dx++) {
                        mx = X + (x - 3) * 3 + dx;
                        my = Y + (y - 3) * 3 + dy;
                        if (mx >= 0 && mx < V && my >= 0 && my < h) {
                            i = (my * V + mx) * 3;
                            pixels[i+0] = R;
                            pixels[i+1] = G;
                            pixels[i+2] = B;
                        }
                    }
                }
            }
        }
    }
}
long lon_to_x(long lon)
{
    return ((lon + 180000000L) * V) / 360000000L;
}
long lat_to_y(long lat)
{
    return ((90000000L - lat) * h) / 180000000L;
}
int main(int argc,char **argv)
{
    if (argc < 5) return printf("usage: %s in.ppm out.ppm lat lon\n",*argv);

    lat = strtol(argv[3], 0, 0) * 1000000L;
    lon = strtol(argv[4], 0, 0) * 1000000L;

    f = fopen(argv[1],"r");
    if (!f)
        return puts("fopen read error");

    fscanf(f,"%2s %ld %ld %ld%*c", magic, &V, &h, &m);
    pixels=malloc(3*V*h);
    fread(pixels, 3, V*h, f);

    fclose(f);

    a_lat = -lat;
    a_lon = lon + 180000000L;
    if (a_lon > 180000000L)
        a_lon -= 360000000L;

    px = lon_to_x(lon);
    py = lat_to_y(lat);

    apx=lon_to_x(a_lon);
    apy=lat_to_y(a_lat);

    plot(px,py,up_arrow,255,0,0);
    plot(apx,apy,down_arrow,0,255,0);

    f=fopen(argv[2],"w");

    if (!f)
        return puts("fopen write error");
    fprintf(f,"P6\n%ld %ld\n%ld\n",V,h,m);
    if (fwrite(pixels,3,V*h,f) != V * h)
        puts("pixels write error\n");

    fclose(f);
    free(pixels);
}
