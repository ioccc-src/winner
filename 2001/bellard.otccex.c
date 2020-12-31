/* #!/usr/local/bin/otcc */
/*
 * Sample OTCC C example. You can uncomment the first line and install
 * otcc in /usr/local/bin to make otcc scripts !  
 */

/* Any preprocessor directive except #define are ignored. We put this
   include so that a standard C compiler can compile this code too. */
#include <stdio.h>

/* defines are handled, but macro arguments cannot be given. No
   recursive defines are tolerated */
#define DEFAULT_BASE 10

/*
 * Only old style K&R prototypes are parsed. Only int arguments are
 * allowed (implicit types).
 * 
 * By benchmarking the execution time of this function (for example
 * for fib(35)), you'll notice that OTCC is quite fast because it
 * generates native i386 machine code.  
 */
fib(n)
{
    if (n <= 2)
        return 1;
    else
        return fib(n-1) + fib(n-2);
}

/* Identifiers are parsed the same way as C: begins with letter or
   '_', and then letters, '_' or digits */
fact(n)
{
    /* local variables can be declared. Only 'int' type is supported */
    int i, r;
    r = 1;
    /* 'while' and 'for' loops are supported */
    for(i=2;i<=n;i++)
        r = r * i;
    return r;
}

/* Well, we could use printf, but it would be too easy */
print_num(n, b)
{
    int tab, p, c;
    /* Numbers can be entered in decimal, hexadecimal ('0x' prefix) and
       octal ('0' prefix) */
    /* more complex programs use malloc */
    tab = malloc(0x100); 
    p = tab;
    while (1) {
        c = n % b;
        /* Character constants can be used */
        if (c >= 10)
            c = c + 'a' - 10;
        else
            c = c + '0';
        *(char *)p = c;
        p++;
        n = n / b;
        /* 'break' is supported */
        if (n == 0)
            break;
    }
    while (p != tab) {
        p--;
        printf("%c", *(char *)p);
    }
    free(tab);
}

/* 'main' takes standard 'argc' and 'argv' parameters */
main(argc, argv)
{
    /* no local name space is supported, but local variables ARE
       supported. As long as you do not use a globally defined
       variable name as local variable (which is a bad habbit), you
       won't have any problem */
    int s, n, f, base;
    
    /* && and || operator have the same semantics as C (left to right
       evaluation and early exit) */
    if (argc != 2 && argc != 3) {
        /* '*' operator is supported with explicit casting to 'int *',
           'char *' or 'int (*)()' (function pointer). Of course, 'int'
           are supposed to be used as pointers too. */
        s = *(int *)argv;
        help(s);
        return 1;
    }
    /* Any libc function can be used because OTCC uses dynamic linking */
    n = atoi(*(int *)(argv + 4));
    base = DEFAULT_BASE;
    if (argc >= 3) {
        base = atoi(*(int *)(argv + 8));
        if (base < 2 || base > 36) {
            /* external variables can be used too (here: 'stderr') */
            fprintf(stderr, "Invalid base\n");
            return 1;
        }
    }
    printf("fib(%d) = ", n);
    print_num(fib(n), base);
    printf("\n");

    printf("fact(%d) = ", n);
    if (n > 12) {
        printf("Overflow");
    } else {
        /* why not using a function pointer ? */
        f = &fact;
        print_num((*(int (*)())f)(n), base);
    }
    printf("\n");
    return 0;
}

/* functions can be used before being defined */
help(name)
{
    printf("usage: %s n [base]\n", name);
    printf("Compute fib(n) and fact(n) and output the result in base 'base'\n");
}

