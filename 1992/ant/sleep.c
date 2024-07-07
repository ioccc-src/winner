/*
 * sleep.c
 */

#include <time.h>

void
sleep(secs)
unsigned secs;
{
	clock_t start, now;

	start = clock();
	do
		now = clock();
	while ((now - start) / CLK_TCK < secs);
}

