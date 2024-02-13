/*
 * ascii.c - simple program that shows the character value of ASCII values, if
 * isascii() is true, to help demonstrate IOCCC entry 2019/endoh.
 *
 * Will not do anything if no args specified. Use xargs(1) to pass args to
 * program if it's a lot of characters.
 */
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
int main(int argc, char **argv)
{
    int i;
    for (argc = 1; argv[argc]; ++argc)
    {
	i=atoi(argc[argv]);
	if (isascii(i)) printf("%c", i);
    }
}
