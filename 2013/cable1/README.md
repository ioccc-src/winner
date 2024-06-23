## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./cable1 name group1 group2
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Partisan may be defined as a strong supporter of a cause, party or person.
We need not limit ourselves to the two major political parties in the US today.

Let us consider:

``` <!---sh-->
    ./cable1 Cooper Mac PC
```

Simon works for Apple, so you would expect Mac.  :-)
Landon is a long time Mac user:

``` <!---sh-->
    ./cable1 Noll Mac PC
```

That works too!  Now Leo brings PCs to the IOCCC judging for cross-platform
testing:

``` <!---sh-->
    ./cable1 Broukhis Mac PC
```

We can test other people.  The late Steve Jobs:

``` <!---sh-->
    ./cable1 Jobs Mac PC
```

That works!  How about Bill?

``` <!---sh-->
    ./cable1 Gates Mac PC
```

A PC guy as expected.  What about that other Steve?

``` <!---sh-->
    ./cable1 Ballmer Mac PC
```

Humm .. maybe there is a hidden reason he is leaving the late Micro$oft? :-)
Why late? Because:

<img src="dead-ms-tweet.jpg"
 alt="image of snarky tweet from 2013 Nov 15 by Landon Noll about Microsoft"
 width=491 height=312>

```
    An important 2023 update about twitter:

    The IOCCC no longer uses twitter.  Today the IOCCC uses Mastodon.
    For more information and to see our IOCCC Mastodon posts, see:

	https://fosstodon.org/@ioccc

    End of important 2023 update to this historic note.
```

So how does a one line C source know so much?  Hint: it doesn't.


## Author's remarks:

### Presidents of the United States of America!

Politics is full of memorable
[one-liners](https://rationalwiki.org/wiki/Politics#Famous_quotes). Without wishing to
[misunderestimate](https://www.youtube.com/watch?v=JhmdEq3JhoY)
the taste of the judges, nor prejudge the past, the author hopes you enjoy this
contribution to the genre.

This one-line C program accepts as a first command-line argument the last name
of any of the last 31 US Presidents (from Franklin Pierce onwards), in lower
case, and prints out their political affiliation.

Use `republican` as the 2nd command-line argument, and `democrat` as the 3rd (or
equivalent strings of your choice).


### Why is this entry obfuscated/interesting?

The program looks up the name supplied on the command line against a list of
Presidents' names, and matches names to political affiliations using a look-up
table. But where in the source is the list of names, and where is the look-up
table?

### Notes

- For Theodore Roosevelt, use: `./cable1 roosevelt republican democrat`.

- But, for Franklin D Roosevelt, use: `./cable1 fdr republican democrat`.

- This program needs a little endian CPU to work properly.


### Compiler warnings

`clang` warns about a missing type specifier for `main()`, and that implicit
function declarations are invalid in C99 (but still accepts them).


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
