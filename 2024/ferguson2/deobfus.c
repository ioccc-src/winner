/*
 * although not strictly deobfuscated it is commented to try and explain it more
 *
 * Please note that I have tried to keep this consistent with the 'final
 * product' but I had to make fixes and so some of this might be out of date.
 * Still I am trying to redo it all; but some comments might not be strictly
 * correct. In which case I hope you can then fully appreciate just how twisted
 * this code is (and you probably will anyway)!
 *
 * Also it is true that some of the variables in the code (which are in the
 * submission itself, I believe but perhaps not) are not used. This was a
 * mistake but it's not worth the effort to try and find them all, especially as
 * it can also cause confusion to people. Trying to parse the code once let
 * alone several times (which I did) was not something I wanted to repeat again.
 *
 * And on that note: there indeed might be things wrongly stated. I tried but
 * failed to completely understand what I wrote years back. I have no idea how I
 * managed some of this and I don't know what I did in every case so any
 * incorrect statements are simply a sign of the obfuscation - a good thing!
 */
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#ifndef DICT
#define DICT "dict"
#endif

/*
 * English -> Navajo.
 *
 * I am sorry but I can't even begin to fathom TRYING to do this again for the
 * alt code (X=1), especially as a lot of it is the same but with some subtle
 * differences.
 */
#define X 0
/*
 * the struct a is the holder of state but the state is, as will be seen soon,
 * mostly anonymous. Even the function pointers array has a different order per
 * function call! The only time (I think) that there is some form of consistency
 * is the *k and *c of the struct a which is the linked list of words for either
 * deciphering (alt version with -DX=1) or enciphering (with -DX=0)
 */
struct a {
    /*
     * some of these are consistent if they're only used in a single function. I
     * believe this applies in particular to:
     *
     *  a - for Z(), which parses main() args and acts on them - it is that
     *      part of main()'s body instead of in main(), this so I could make it
     *      harder to follow with anonymous and inconsistent ordering and
     *      variables.
     * N - first field in dictionary file.
     * S - second field in dictionary file.
     * A - temporary buffer when reading in dictionary file (which S and N use).
     *
     * Like I said the order of v changes depending on the function.
     *
     * However as for S and N it's not so simple because these char *'s are not
     * directly strdup()d! Instead the function that does this, called by F()
     * but not by those names (I will explain this later) set the 's' (below) in
     * an anonymous structure to either S or N in the call. The function being
     * called in all cases (even though it does not look like it) is the same in
     * every case even though it doesn't look like it; that function is w().
     */
    char *w, *c, *s, *x, *t, *u, **h, *S, *N, *A,*(*v[9])(struct a *), *y;
    struct a *e, *a, *z, *k, *j;
    int l;
} *f, *c;
/* ^ the linked list pointers - f is the list and c each node as the list is
 * created. The ->e is the next node which is why this is consistent, at least
 * in f.
 */

/*
 * this is the alphabet of the language and it's translated for exact matches in
 * the alt version especially (it might be used in the encipher - regular -
 * version but I'm no longer sure of this).
 *
 * As can be seen the first element, element 0, is the letter, and the second
 * element, element 1, is the translation. The word for C for instance is MOASI
 * and it translates to 'cat'. When prog.alt encounters this it will report
 * 'cat'. If however prog encounters it it will translate the letters as it's
 * not in the dictionary. As well if prog.alt encounters something not in the
 * dictionary, say IOCCC, it will spell out the letters.
 *
 * If one does something like:
 *
 *      ./prog.alt $(./prog ioccc)
 *
 * then it should print out 'ioccc' (w/o quotes of course).
 */

char *B[][2] = {
 { "A", "WOL-LA-CHEE" } , { "B", "SHUSH" } , { "C", "MOASI" } , { "D", "CHINDI" } ,
 { "E", "DZEH" } , { "F", "CHUO" } , { "G", "JEHA" } , { "H", "TSE-GAH" } ,
 { "I", "YEH-HES" } , { "J", "AH-YA-TSINNE" } , { "K", "BA-AH-NE-DI-TININ" } , { "L", "NASH-DOIE-TSO" } ,
 { "M", "BE-TAS-TNI" } , { "N", "TSAH" } , { "O", "A-KHA" } , { "P", "CLA-GI-AIH" } ,
 { "Q", "CA-YEILTH" } , { "R", "DAH-NES-TSA" } , { "S", "KLESH" } , { "T", "D-AH" } ,
 { "U", "NO-DA-IH" } , { "V", "A-KEH-DI-GLINI" } , { "W", "GLOE-IH" } ,
 { "X", "AL-NA-AS-DZOH" } , { "Y", "TSAH-AS-ZIH" } , { "Z", "BESH-DO-TLIZ" } ,
 } , *Y(struct a *) ;
int z, J, C, k, H, D, s, L; size_t n, o; FILE *g;
/*
 * these variables would not fit in the structs as they are needed in multiple
 * functions. Besides the next node of the linked list we can use the other
 * members of the struct anonymously and differently depending on the function
 * (to make it extremely hard to keep track of what is what).
 *
 * Now it would be possible to have these in as different variables but that
 * would go well beyond the size limit of rule 2!
 *
 * I will tell what these are as we encounter them.
 */

char *I(struct a *a)
{
    /*
     * okay this is truly dreadful.
     *
     * What z is set to is actually 0. That's it.
     *
     * Remember that a->z is actually a->j which is f. Well okay you can't know
     * that yet but you will.
     */
    for (a->a = a->z, z = 0**"1"; a->a; a->a = a->a->e)
    {
        /*
         * the function called (a->v[2] (and remember a is anonymous in this
         * function, created by the calling function at time of calling it) is
         * Y(). Y() also takes a struct a * but we create it as we call the
         * function itself, just like what happened when we were called. We set
         * .w to a->a->w (a->a is the current node in the linked list) and .c to
         * a->x.  But what are these?
         *
         * Well a->w is assigned (will talk about this later) the first field OR
         * second field of the dictionary depending on if we are deciphering or
         * enciphering. Of course this file is enciphering but that only adds to
         * confusion! As I see it right now, if deciphering (X==1) (which again
         * does not happen here) then it is the second field (S in that struct);
         * else it is the first field (N in that struct).
         *
         * And what was 'x'? I am sorry but I can't figure that out but I can
         * say that Y() checks if two strings are equal but ignoring !isalpha().
         * What this implies is it is either the first or second string as Y()
         * acts on exact matches of letters as noted earlier.
         *
         * Okay doing an fprintf() suggests that it is the input. For instance
         * if I were to do ./prog.alt shush the a->x is shush itself.
         */
	if (a->v[2](&(struct a){ .w=a->a->w, .c=a->x} ))
	{
            /*
             * just to make sure we print out the stuff before in case there is
             * a non-alpha character (or characters)
             */
            while (!isalpha(*a->x) && *(a->x)) { L=putchar(*a->x); ++a->x; }
            /*
             * okay this is also really nasty. Remember that z starts out at 0
             * and a->c is (I think!) the first field if X==1 (which is false)
             * and the second field if X==0 (enciphering mode, true). Well okay
             * so this part is not the nasty part; it's the body of the loop.
             */
	    while ((z++)[a->a->c])
                /*
                 * this is truly awful. First of all remember that z starts out
                 * at 0 here and we want to set 's' to something terrible. But
                 * what in the world is '-*"1"-*"1"- -97? It is -1. But why do I
                 * want s to be -1? Well I don't. Remember that I'm adding it to
                 * s which starts out at 0. Thus the first pass this will be
                 * indeed -1, second pass 0 etc. But why start out at -1 when it
                 * seems like we're indexing into a->c (a char *)? This is
                 * extremely nasty too.
                 *
                 * Let us break this down a bit more. If s is -1 the !s (will
                 * end up being?) false. That means the !isupper(a->x[0**"z"])
                 * will not be called the first time (or perhaps it will, I
                 * don't know now). Okay but we have to back up a bit.  What is
                 * 0**"z"? That is 0, as you'd expect. So what is a->x[1]? This
                 * is also very ugly. I believe (but I am no longer sure!) that
                 * the calling code is:
                 *
                 *  (((*a->h[--a->l]=='e'-':')&&(*a->v)(&(struct a){ .v[0]=I,
                 *  .s=((a->l)[a->h])+1} ) &&++a->l)||(a->v[1](&(struct a){
                 *  .v[2]=Y,.x=((a->l)[a->h])} ),++a->l)); if (g) puts(""); }
                 *
                 * Okay actually I'm sorry. I have absolutely no idea what this
                 * is. But the numbers at least can be explained. Also we can
                 * break the code down more though, just not determine all the
                 * values. If !s and isupper(a->x[1]) we will index a->a->c[s].
                 * But when it's not we will call tolower(a->a->c[s]). Now you
                 * might ask how in the world a->a->c[s] is legal on the first
                 * pass. I'm sorry but once again I have no clue I just know it
                 * does not evaluate to invalid indexing. Even more baffling is
                 * if the index starts out at 0 (i.e. - -98 instead of - - 97),
                 * the code does not work! Of course it might not be baffling at
                 * all but seems that way after trying to parse this nasty nasty
                 * code.
                 */
		s=z+-*"1"-*"1"- -97,L=putchar(!s&&isupper(a->x[0**"z"])?a->a->c[s]:tolower(a->a->c[s]));
	    goto n;
	}
    }
    /*
     * if we get here it means that the word is not in the dictionary. And of
     * course this is also extremely nasty, the expressions.  The 2/ *"z"
     * evaluates to 0 and the 1+0**"1" evaluates to 1.
     *
     * Okay and the number[pointer] indexing is used. As noted above I believe
     * K->x is the actual input. I'll try and parse the loop but no guarantees I
     * get everything! Much of this was written years ago.
     */
    for (z = 2/ *"z", s=1+0**"1"; z[a->x]; ++z)
    {
        /*
         * okay the first part is simple enough. For each !isalpha() char in
         * a->x we simply print the char via putchar(). Again I'm unclear what
         * a->x is however.
         */
	if (!isalpha(z[a->x]))
	    L=putchar(z[a->x]);
	else
	{
            /*
             * so C is if the current char of the current input is lower case. I
             * am not sure if we actually need to save this or not but it's
             * quite possible we do. It might just be to save bytes (or it might
             * not save bytes).
             */
	    C = islower(z[a->x]);
            /*
             * This is even nastier than before I guess.
             *
             * The first one is easy: J is set to 0 and while J < 26 and ...
             * hold on, what are we checking against now?
             *
             * Well remember that B is the letter <-> Navajo word for that
             * letter array. So B[J][0] would be the letter itself and B[J][1]
             * will be the word itself. But now we have the other horrible
             * expressions! Remember that if X (it's always 0 in this file) is
             * non-zero it's deciphering and if it's 0 (always 0 here) it's
             * enciphering. But what is:
             *
             *      1/ *"1"+s/
             *           *"1"+1/ *"1"+s/ *"1"+1+(s-s)**"1"+(s*(s-s))**"1"
             *
             * ? Well first of all let's clarify that this is actually:
             *
             *      1/ *"1"+s/ *"1"+1/ *"1"+s/ *"1"+1+(s-s)**"1"+(s*(s-s))**"1"
             *
             * Observe too how a space removed in several places will turn it
             * into a comment!
             *
             * I can try and parse some of this but I'm not really sure of all
             * of it. For instance, how is (s*(s-s)) parsed? It would appear that
             * it's s * 0 and it might very well be. Assuming that s is 0 (for
             * example) it is 1; assuming it is 1 it is ... 1? So it seems. And
             * assuming it is 2 is .... 1 again? So it seems! So how in the
             * world does this work? Well remember what we're trying to get:
             * either the first element or the second, and in this place we
             * always need 1. Let's evaluate the other part (I'm sure you can
             * figure it out though after this first one): 0! Okay but there's
             * something really sneaky here (and above): ask yourself if 's' is
             * actually incremented. Got your answer? Okay good! In fact if you
             * were to update it you will get bad answers! For instance what
             * happens if it's 2? I got 5764801. And then what if it's 0?
             * -5764801.
             */
	    for (J = *"1"-*"1"; J < 26 && B[J][X?1/ *"1"+s/
                    *"1"+1/ *"1"+s/ *"1"+1+(s-s)**"1"+(s*(s-s))**"1":((((s-1)**"1")**"1")**"1")**"1"]; ++J)
	    {
                /*
                 * oh dear did I do it again? Yup. I did. But in this case you
                 * can probably figure it out. Even so I'll evaluate these for
                 * you. Yes: 0+*"1"-*"1" is 0.
                 */
		if (*B[J][0+*"1"-*"1"] == toupper(z[a->x]))
		{
                    /*
                     * Not again! Okay to help out let's remember s is 1. So s *
                     * 2 is 2. It's the other stuff that's a nightmare.
                     *
                     *      (s*2)**"9"-171+*"9" == 0
                     *
                     * And you probably want to kill me but what is:
                     *
                     *      *"1"-49 ?
                     *
                     * It is 0. And since you killed me you probably now want to
                     * chop me up into tiny bits but before you do that I guess
                     * you want to know what s/ *"1"+s/ *"1"+1/ *"1"+(s*s*s) is?
                     * That evaluates to 1.
                     */
		    for (k = (s*2)**"9"-171+*"9"; H=B[J][X?*"1"-49:s/ *"1"+s/ *"1"+1/ *"1"+(s*s*s)][k]; ++k)
			putchar(C?tolower(H):toupper(H));
                    /*
                     * this is putchar(' ')
                     */
                    L=putchar(('\0'+'!'-1));
                    break;
		}
	    }
	}

    }
    /*
     * we jumped here if a word was in the dictionary and translated, as
     * explained earlier but we also get here if we don't (obviously)
     */
    n:
    /*
     * if the last char we pushed on the stream is a space, don't add a space
     */
    if (!isspace(L))
    putchar(' ');
    return a->s;
}

/*
 * Z() used to be the parsing of args in main() and it's also truly dreadful, I
 * know. Unfortunately I am not sure if I can explain it all but I will try.
 */
char *Z(struct a *a)
{
    /*
     * it would appear that a->l was argc of main() (c) and a->h is the argv
     * (a) so the condition of the loop is going through all the args. However
     * before we can continue we need to see how this function was called:
     *
     *      Z(&(struct a){ .v = { t, I } ,.k=0, .l=c, .h=a, .j=f} );
     *
     * This means that a->v[0] == t() and a->v[1] == I and a (our struct)'s l is
     * c (argc in main()) and our a->l is argv in main(). Additionally a->j is
     * the linked list of words.
     */
    while (a->h[a->l++])
        /*
         * I() :-) no longer can parse this completely (as in I don't know all
         * of what it does) but I'll still try breaking it down a bit. I make no
         * promises however. I will break the line up to help out, though it
         * might not do that much good.
         */

        /*
         * first notice how where the loop condition (postfix) increments argc
         * (a->l) the body of the loop immediately decrements (prefix decrement)
         * and compares the first char of the current arg to - what? The
         * expression 'e'-':' evaluates to '+'. This is checking for file as
         * input.
         */
    (((*a->h[--a->l]=='e'-':')&&
      /*
       * Okay remember what I said above about x->v[0] being t() ? That means
       * that this is calling t().
       */
      (*a->v)
      /*
       * ...and here we create the anonymous struct * for t(). As you can see
       * the first function pointer in the v[] array is I(). Observe how in
       * _this_ function v[0] is a different function! In this function v->[0]
       * is t() but in this next function (t() itself!) it will be I()! But how
       * do we construct it? Well...
       *
       * The &(struct a) is important because we can't do:
       *
       *    (struct a *)
       *
       * because it is an error:
       *
       *    prog.c:67:41: error: initialization of non-aggregate type 'struct a *'
       *    with a designated initializer list.
       *
       * (Okay the line numbers are different but you get the idea.)
       * But since we need a pointer we can use & to get the address of the
       * anonymous struct.
       */
      (&(struct a)
       /*
        * Now the fun part! The object we create is in the {}s (of course). Each
        * field, even pointers use '.' (which as shown above is required as we
        * can't do { ->s=... } as it's also illegal and this is why we make it a
        * struct that's not a pointer and take its address to get past that
        * problem).
        *
        * Here we are saying that in the anonymous struct we're passing to t()
        * the v[0] is I() and the s (a char *) is - what? Well this is awful. Do
        * you remember that a->l is argc and a->h is argv from main()? So
        *
        *       ((a->l)[a->h])
        *
        * is argv[argc]. Now the usual C programmer would point out that that is
        * NULL. But something *extremely* nasty was done before we called this
        * function. I will explain it (or rather try to) in main() but it looks
        * like this:
        *
        *   F((c=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u),c&=9u,&(struct a){ .l=1, .s=a[c],.v= { &w, &w } } ));
        *
        * Remember that c in main() (or our a->l) is argc. So this horrible call
        * resets c to some value, in particular 1 though that line does a lot
        * more.
        *
        * So what this part does is, again, set OUR v[0] to I() which we are now
        * calling, remember, and set OUR s (a char *) that is a->s to beyond
        * (argv[argc])+1 (starting out with argc == 1). This also sets .j to
        * a->k which is actually - what? This is sneaky. In main() when calling
        * Z() a->j is set to f (the linked list) but here we're setting a->j (in
        * the function call) to a->k. But in main() in calling Z() a->k is set
        * to NULL! Further down though we will do .z=a->j so this might (or
        * might not) be called a red herring.
        *
        * But of course we're not done!
        */
       { .v[0]=I, .j=a->k, .s=((a->l)[a->h])+1} )
        /*
         * I'm sure that some people are screaming by now, if they even got this
         * far, but here we are doing something sneaky (imagine that) too.
         *
         * Remember how the loop condition incremented argc but the loop body
         * immediately decremented it (since we needed to check the first char
         * of the first arg, not the next)? Well the problem is now that we have
         * checked that we nee to get x-> (argc) incremented again, but prefix.
         */
      &&++a->l)||
      /*
       * But of course if these (what are these? Please go back up and check, I
       * too am getting tired of trying to parse all this and I have a lot more
       * to do!) did not succeed we still have more nastiness.
       *
       *    a->v[1] is I() so now main() is (or rather we, Z(), are on behalf of
       *    main()) calling t with - yup, ANOTHER anonymous struct a *!
       */
          (a->v[1](&(struct a)
      /*
       * The good news at least is you know how the struct is constructed but
       * what are we doing here and why?
       *
       * Well here we are saying that in the call to I() that v[2] is Y() (not
       * again) and x (a char *, not like x here which is a struct a *) is set
       * to the current argv[argc].
       *
       */
        { .v[2]=Y,.x=((a->l)[a->h]),.z=a->j}
        /*
         * this is the end of the function call but we're not actually done just
         * yet.
         *
         * Observe how we are prefix incrementing a->l again (argc in main())!
         */
        ),++a->l));
          /*
           * Okay but you might ask yourself: how come we're using the comma
           * operator here? Well because at this point although we do need to
           * call I() we also need to increment argc (a->l) yet again!
           *
           * But...why? After all the body of the loop does this! Not quite. It
           * does do this but that was on the left hand side (lhs) of the body
           * of the loop and the beginning of the body of the loop decremented
           * it! So in order to get argc back to the next one we have to
           * increment it as a side effect!
           */

          /*
           * we only do this because we need to return a char *; a simple return
           * 0 would also work and so would a return NULL.
           */
    return "";
}
/*
 * this function is simpler though there still are some potentially confusing
 * things going on here. Yes this looks kind of like a rot13 implementation but
 * the dictionary file actually has Z -> A, Y -> B, X -> C etc. But what was r
 * formed of? Actually this is extremely sneaky.
 */
char *w(struct a *a)
{
    /*
     * Okay but you might notice I did something nasty again. Okay I did
     * multiple nasty things! You probably can figure these out at least though.
     * Anyway, 1/ *"s" is 0 and 'k'-'*' evaluates, as you might have guessed, to
     * 'A'.
     *
     * That means start out at 0, go through a->s - well you get the idea. But
     * what is a->s? Well that is the dictionary file of course but that'll be
     * discussed in the respective function.
     */
    for (D = 1/ *"s"; a && a->s && D[a->s] && (a->s[D]) &&
            (a->s[D] = isupper(a->s[D])?("ZYXWVUTSRQPONMLKJIHGFEDCBA"
            )[(a->s[D] - ('k'-'*'))]:D[a->s]); ++D) ;

    /*
     * at one point it was possible for a to be NULL so we checked here. It
     * shouldn't be needed now though.
     */
    return a?a->s:"";
}

/*
 * this is kind of like strcasecmp() except that it ignores !isalpha(). There is
 * only one thing that might not be immediately obvious so I'll only comment on
 * that. Well okay as you'll see a->w is the first string and a->c is the
 * second. But besides that it's pretty easy.
 */
char *Y(struct a *a)
{
    if (*a->w && *a->c && a->w[1] && a->c[1])
    while (*a->w && *a->c)
    {
        while (!isalpha(*a->w) && *a->w++);
        while (!isalpha(*a->c) && *a->c++);
	if (!*a->c || !*a->w || tolower(*a->w) != tolower(*a->c))
	    break;
	++a->w; ++a->c;
    }
    /*
     * remember that we need to return a char * so what this does is it
     * evaluates to either a 'true' value (non NULL string) or a NULL pointer.
     * This can be checked as if an int but matching the requirement that it
     * returns a char * (for the function pointer array).
     */
    return !*a->w&&!*a->c?"":0;
}

/*
 * This function reads in the dictionary file as the first line might suggest.
 */
char *F(struct a *a)
{
    g = fopen(DICT, "r");
    if (g)
    {
        /*
         * We use getline(3) even though there is the bug I mentioned in the
         * remarks file because we can have it dynamically allocate memory. It
         * stores the newline but so does fgets() and we don't really care about
         * it. In fact we do not want to remove the newline!
         */
	while (getline(&a->A, &n, g) != -1)
            /*
             * So we were called like this:
             *
             *      F((c=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u),c&=9u,&(struct a){ .l=1, .s=a[c],.v= { &w, &w } } ));
             *
             * I am not going to explain the first part until main() but the
             * second part, which can only happen by the comma operator (like in
             * other places) and which we use as we need the other thing to be
             * done first, it sets up our struct a *a's .l to 0, v[0] to &w and
             * v[1] to &w. Why both? To mislead of course!
             */

            /*
             * this part is easy but note how we use a->A and a->S as the first
             * and second column. They are not really needed except to have them
             * also in the struct (and even if they were not NULL we assign them
             * first).
             */
        if ((a->N = strtok(a->A, "\t")) && (a->S = strtok(0, "\t")))
        {
            /*
             * Oh no! Not another bonkers calculation! Well fortunately you can
             * probably put together what it is but if not it evaluates to 1.
             * Basically we're allocating a struct a *.
             */
            c = calloc(1**"0"-47, sizeof *c);
            /*
             * more fun with anonymous structs here as we populate the struct a *
             * we just created. As I might have said elsewhere if X is non-zero
             * (never true here) it means decipher and otherwise it means encipher.
             * means. But observe how c->w can be one or the other just like
             * c->c. That's because the X check is done in other places too.
             *
             * Now about these structs being created. For c->w it is a strdup()d
             * copy of the result of calling w() on either a->S or a->N.
             * Similarly we are doing the same thing (but opposite order) for
             * c->c. But hold on a moment you might think. Why then are we
             * assigning multiple values? Well actually we're not. This is just
             * the copy but both are always assigned to the w()'s struct a *'s s
             * (a char *).
             *
             * As for the function calls:
             *
             *      a->l is 0 and a->e is NULL but even if it wasn't it would
             *      evaluate to 1 and so a->v[a->l], a->v[a->e==0] (as 1 or 0)
             *      and a->v[1] all point to w()!
             */
            c->w = strdup(X?a->v[a->l](&(struct a){ .s=a->S} ):a->v[a->e==0](&(struct a){ .s=a->N} ));
            c->c = strdup(X?a->v[1](&(struct a){ .s=a->N} ):a->v[a->l](&(struct a){ .s=a->S} ));
            c->e = f;
            f = c;
        }

        free(a->A);
	a->A = 0;
	fclose(g);
	g = 0;
    }
    else puts("couldn't open dict");
    return "";
}

/*
 * fortunately t() is a bit easier - although you might remember the call to it
 * is not.
 */
char *t(struct a *a)
{
    /*
     * this assigns o with 0
     */
    o = *"";
    g = fopen(a->s, "r");
    a->A = 0;
    while (g && getline(&a->A, &o, g) != -1)
    {
        /*
         * the usual suspect: we're using a->S as a temporary value for strtok()
         * to extract the first field (space or tab delimited)
         */
            a->S = strtok(a->A, " \t");
            while (a->S)
                /*
                 * strdup() is useful here
                 */
                if ((a->y=strdup(a->S))) {
                    /*
                     * if a token was found then we will call a->v[0] which is I don't
                     * even know; I'm really tired doing this and I have more to parse
                     * for you - sorry! Anyway in that function v[2] will be Y() and w
                     * will be S (the token we extracted).
                     */
                    (*a->v)(&(struct a){ .v[2]=Y, .x=a->y} );
                    /*
                     * get next token for this line
                     */
                    a->S = strtok(0, " \t"); free(a->y); a->y=0;

                    /*
                     * if the last char we pushed on the stream is a space
                     * don't add a space
                     */
                    if (L!='\n')putchar(' ');
                }
    }
    if(g) { clearerr(g); fclose(g); g = 0; free(a->A); a->A= 0; }
    return "";
}

/*
 * Good news: we've reached the last function!
 *
 * Bad news: it's also dreadful, really dreadful!
 */
int main(int c, char **a)
{
    /*
     * Do I have to try and parse this? Okay well I did explain in one function
     * (F() itself) the second half but I did not explain the first half so I'll
     * try here.
     *
     * Remember how I said (I think I said anyway) that argc is set to 1? Well
     * that is because:
     *
     *          ((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u)
     *
     * evaluates to 113 and 113 & 9 is 1. The other parts are just a
     * distraction.
     *
     * Notice the double {} there (that's not the only place this occurs though
     * I think).
     */
    F((c=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u),c&=9u,&(struct a){ .l=1, .s=a[c],.v= { &w, &w } } ));
    /*
     * This was the one that processes the args. It is not a hard call to deal
     * with (the function Z() itself is of course): call Z() with an anonymous
     * struct a * with v[0] == t(), v[1] == I(), l == c (argc), a == a
     * (argv) and k == 0 (NULL) and j == f (linked list of words)
     */
    Z(&(struct a){ .v = { t, I } ,.k=0, .l=c, .h=a, .j=f} );
    puts("");
    /*
     * Now go have some good chocolate or some great pie! You deserve it!
     */
}
