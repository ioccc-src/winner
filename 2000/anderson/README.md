## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    echo something | ./anderson
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

This small program might be a nice addition to a digital personal
organizer; just in case you are stranded on a desert island and need to
signal your distress to passing ships.

The obfuscation in this program is truly masterful.  The program is
very cleverly obscured without the use of a single `#define`!
Reformatting this program by hand :-) is the easiest way to understand
what is going on.

### Note about `#define`s not being used:

In 2023 due to annoying warnings triggered at different times, sometimes
interspersed with the output of the program (this happens in macOS), many
entries were changed to use `fgets(3)` instead. However to make the entries more
like the original we redefined `gets` to use `fgets`. Unfortunately it's not
possible to do it through `-Dfoo` compiler options so there is a `#define` in
the code now.


## Author's remarks:

This program is a simple filter that translates ASCII text into
semaphore code.  It reads from standard input and converts all
alphanumeric characters to their corresponding semaphore codes.
Consecutive whitespace is translated as a single 'break' code.  Newlines
also cause the next code to be output on a new line.  All other
characters are ignored.  The codes themselves are written to standard
output as a depiction of a person holding two flags, using only ASCII
characters (semaphore smileys, if you will).  For example, given the
input "Hello, world!", the output will be:

```
                  <>       <>       <>    <>                  <>     <>
      _()       ()/      ()/      ()/     _\)       ()       (/_     _\)
    [] /^      |^^      /^^      /^^    [] ^^      |^^|      ^^ [] [] ^^
      <>[      [][     <>][     <>][       ][      [][]      ][       ][


                  <>    []
      _()_      ()/     |()       ()
    [] ^^ []   /^^       ^^|     |^^|
       ][     <>][       ][]     [][]
```

The program is obfuscated without the use of the preprocessor or any
special compilation parameters.  In fact, the program doesn't even
bother using any keywords, save the single `char` at the beginning.
This program was crafted using only operator precedence rules,
short-circuit evaluation and recursion.  Each function contains a
single, non-empty statement.  (I did have to add a couple of empty
statements to format the code properly.)  There is a single string
constant which encodes the flag positions and other data needed for
drawing the semaphore codes.

The preprocessor will provide no help in de-obfuscating this code, and a
C beautifier won't get you very far either.  You just have to crunch
through it.

An ANSI C compiler will generate several warnings when it compiles this
program, as none of the functions declare their return type, nor do they
return anything.  This was necessary to keep the program free of
keywords.  It's valid in K&R C, and compiles in ANSI C.  There are also
warnings about conversion from `int` to `char` and the resulting loss of
data.  Again, if it's OK with K&R, it's OK with me.

This program is a great teaching tool for learning the semaphore code;
and if you don't have any flags handy you can just use two copies of the
source file.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
