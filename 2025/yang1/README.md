Award: Compound prize

## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog number < in > out
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

What's better than winning entry that does something useful?  An entry that does multiple useful things!
Then when you consider that the code is a polyglot, we think you will be even more impressed.

As an added bonus, there are some real Perls and Ruby gems in the code.

And while you are at it, open [making.html](making.html) in your favorite browser to
watch how the author created this excellent winning entry.  To watch obfuscation in action,
we recommend that you:

* turn **ON** [x] Follow cursor
* make the window tall
* play at 60x


### A fun challenge

Please checkout the [fun challenge&lpar;s&rpar;](../challenge.html#yang1) for this winning entry.


## Author's remarks:


### Synopsis

``` <!---sh-->
    ./prog {line_number} < {input.txt} > {output.txt}

    ./prog 1 < prog.c > prog_head.c && gcc prog_head.c -o prog_head
    ./prog -1 < prog.c > prog_tail.c && gcc prog_tail.c -o prog_tail

    ./prog_head {line_count} < {input.txt} > {output.txt}
    ./prog_tail {line_count} < {input.txt} > {output.txt}

    ruby prog.c {line_count} < {input.txt} > {output.txt}

    ./prog_head 40 < prog.c | ./prog_tail 12 > prog_generate.c
    gcc prog_generate.c -o prog_generate && ./prog_generate > prog_classify.c

    ./prog {integer_between_1_and_9999} < prog_classify.c > output.c
    gcc output.c -o output && ./output
    cpp output.c | grep main

    perl prog.c
```


### Details

This entry contains a collection of line-based file cutting tools.


#### Slash

The main program removes a single line from stdin and writes the result to stdout.

``` <!---sh-->
    ./prog {line_number} < {input.txt} > {output.txt}
```

This program accepts a single command line argument, which specifies the line number of the line to remove.

* If line number is positive, it's measured from start of file.  First line is `1`.
* If line number is negative, it's measured from end of file.  Last line is `-1`.
* If line number is zero, input is copied to output unchanged.
* If line number is not specified, a help message is printed to stdout.

The code will still compile when a single line is removed, but the program behavior will change, see the next sections.


#### Head

Removing a single line from lines 1..41 (i.e., the "head" portion of
the code) will produce a tool that behaves similar to `head(1)`:

``` <!---sh-->
    ./prog 1 < prog.c > prog_head.c && gcc prog_head.c -o prog_head

    ./prog_head {line_count} < {input.txt} > {output.txt}
```

This program accepts a single command line argument, which specifies number of lines to keep.

* Positive line count specifies number of lines to keep from start of file.
* Negative line count are interpreted the same way, so `./prog_head 42` and `./prog_head -42` have the same behavior.
* If line count is zero, output will be empty.
* If line count is not specified, a help message is printed to stdout.


#### Tail

Removing a single line from lines 42..62 or -1..-21 (i.e., the "tail"
portion of the code, or the tip of the ponytail hair) will produce a
tool that behaves similar to `tail(1)`:

``` <!---sh-->
    ./prog -1 < prog.c > prog_tail.c && gcc prog_tail.c -o prog_tail

    ./prog_tail {line_count} < {input.txt} > {output.txt}
```

This program accepts a single command line argument, which specifies number of lines to keep.

* Positive line count specifies number of lines to keep from end of file.
* Negative line count are interpreted the same way, so `./prog_tail 42` and `./prog_tail -42` have the same behavior.
* If line count is zero, output will be empty.
* If line count is not specified, a help message is printed to stdout.


#### Chop

Sometimes the complement behavior of head/tail is more convenient,
i.e., specify how much to drop instead of how much to keep.  This can
be achieved by running the code with Ruby:

``` <!---sh-->
    ruby prog.c {line_count} < {input.txt} > {output.txt}
```

This program accepts a single command line argument, which specifies number of lines to drop.

* Positive line count specifies number of lines to remove from start of file.  `ruby prog.c 1` will remove the first line.
* Negative line count specifies number of lines to remove from end of file.  `ruby prog.c -1` will remove the last line.
* If line count is zero, input is copied to output unchanged.
* If line count is not specified, a help message is printed to stdout.


#### Prime classifier

After having built all the tools for cutting files, naturally you might
be looking for something to cut.  You might have noticed that there is
a complete C program embedded within `prog.c`, which can be extracted
in at least three ways:

``` <!---sh-->
    ./prog_head 40 < prog.c | ./prog_tail 12 > prog_generate.c
    ./prog_tail 34 < prog.c | ./prog_head 12 > prog_generate.c
    ruby prog.c 28 < prog.c | ruby prog.c -22 > prog_generate.c
```

This program generates another C program on stdout:

``` <!---sh-->
    gcc prog_generate.c -o prog_generate && ./prog_generate > prog_classify.c
```

This output code is a number classifier with 9999 lines.  It will compile
as is (and outputs `?` to stdout), but it will also compile when a single
line is removed.  The output will tell you whether the line number of
the removed line was prime, composite, or one.

``` <!---sh-->
    ./prog 1 < prog_classify.c > output_one.c
    ./prog 2 < prog_classify.c > output_prime.c
    ./prog 1234 < prog_classify.c > output_composite.c
    ./prog 9973 < prog_classify.c > output_prime.c
    ./prog 9999 < prog_classify.c > output_composite.c
```

You can compile and run the output code to get the classification printed
to stdout.  But since classification is done entirely at compile time,
you can just run the C preprocessor and search for `main`, which is
usually the last line:

``` <!---sh-->
    cpp output_one.c | ./prog_tail -1
    cpp output_prime.c | ./prog_tail -1
    cpp output_composite.c | ./prog_tail -1
```


### Miscellaneous features

Layout of the code is based on Ubel from "Sousou no Frieren" (Frieren:
Beyond Journey's End), for her ability to cut just about everything.

The main feature is being able to compile even with one line removed,
and detect which region contained the removed line.  It costs a lot of
preprocessor lines to write code that can survive and detect cuts, and
those extra lines worked against making the layout work.  This resulted
in a slightly large ASCII art, and I tried to fill in as many features
as possible in the extra space.  Besides the collection of tools listed
above, there are a few bonus features to fill in the remaining bytes:

* Running the program with a Perl interpreter will output a scissor emoji to stdout (assumes that your terminal uses UTF-8 encoding).
* Running the program with a brainf.ck interpreter will output a tiny ASCII-art scissor to stdout.
* CRC32 of the code is embedded in the code: `5562656c`, which spells out `Ubel`.
* Note that the embedded CRC32 is inside the region containing the number-classifier-generator.  Those inner lines also have a CRC32 of `5562656c`.


### Compatibility

Ubel requires compiler supporting C99 and above, or C++98 and above.
The main C program and the generated C code from cutting the main program
have been verified to work under these environments:

* gcc 13.4.0 on Cygwin.
* gcc 11.4.0 on Linux.
* gcc 10.2.1 on Linux.
* gcc 15.2.0 on JSLinux.
* clang 20.1.8 on Cygwin.
* clang 11.0.1-2 on Linux.
* clang 21.1.2 on JSLinux.

It would have been trivial to write a cut-detecting program using C23's
`#embed` feature, but that requires C23.  Instead, this program targeted
the more widely available C99 standard.  C99 is needed to support this
pattern:

``` <!---c-->
    original_line();  /*
    backup_line();    //*/
```

If I had gone with C90, the equivalent pattern would have been `/* /* */`,
but there we would trip over `-Wcomment` warnings when compiling
with `-Wall -Wextra -pedantic`.  By making use of C99's `//`, the main
C code and the embedded/generated C code all compile without warnings.

The extra embedded scripts have been verified to work under these
environments (runs free of warnings with `ruby -w` and `perl -w`):

* ruby 3.4.7 on Cygwin.
* ruby 3.0.2p107 on Linux.
* ruby 2.7.4.p191 on Linux.
* ruby 3.4.8 on JSLinux.
* perl 5.40.3 on Cygwin.
* perl 5.34.0 on Linux.
* perl 5.32.1 on Linux.
* perl 5.42.0 on JSLinux.

Everyone has probably written their own brainf.ck interpreters a few times, but I packaged another one here just in case.


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
