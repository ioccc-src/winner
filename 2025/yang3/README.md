Award: INABIAF award

## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog "message-for-gcc" "message-for-clang" > output.c
    gcc output.c -o decode 2>/dev/null && gcc output.c -o /dev/null 2>&1 | ./decode
    clang output.c -o decode 2>/dev/null && clang output.c -o /dev/null 2>&1 | ./decode
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

These compiler warnings are not a bug 🐞, they are a feature 🤓.

As an added bonus, there are some real Perls and Ruby gems in the code.

And while you are at it, open [making.html](making.html) in your favorite browser to
watch how the author created this excellent winning entry.  To watch obfuscation in action,
we recommend that you:

* turn **ON** [x] Follow cursor
* make the window tall
* play at 60x


### A fun challenge

Explain the purpose of the constant **114** in [prog.c](%%REPO_URL%%/2025/yang3/prog.c).
Are there any alternative values that could replace **114** without affecting the program’s functionality?

**UPDATE**: We are in the process of changing how we present fun challenges,
and present potential solutions to those challenges.  Please stay tuned for an update.


## Author's remarks:


### Synopsis

``` <!---sh-->
    ./prog "some message\n" "another message\n" > output.c
    gcc output.c -o decode

    gcc output.c -o /dev/null 2>&1 | ./decode
    clang output.c -o /dev/null 2>&1 | ./decode

    ruby output.c | ./decode
    perl output.c | ./decode
```


### Details

This program is a message encoder.  Run without arguments for a help message:

``` <!---sh-->
    ./prog
```

This program accepts one or two arguments, where each argument contains
a text message to encode.  For convenience, most C escape sequences are
accepted and interpreted just as they would in C: `\n`, `\r`, `\t`,
`\a`, `\b`, `\v`, and also `\x` with one or two hexadecimal digits.
Note that while it's possible to insert any byte value with `\x`, an
embedded NUL (`\x00`) will terminate the input string, just like C strings.

Pass in one argument to generate C code to stdout:

``` <!---sh-->
    ./prog "Hello world\n" > output.c
```

The output might seem suspicious in that both GCC and Clang will output many warnings even at the default warning level:

``` <!---sh-->
    gcc output.c -o output

    output.c: In function 'main':
    output.c:4:4: warning: division by zero [-Wdiv-by-zero]
        4 |   O/0-O/0-
          |    ^
    output.c:4:8: warning: division by zero [-Wdiv-by-zero]
        4 |   O/0-O/0-
          |        ^
    ...
```

The reason why we got so many warnings is because we are using those
warning messages to encode data.  To recover the input message, pipe
the warnings to the output program:

``` <!---sh-->
    gcc output.c -c -o /dev/null 2>&1 | ./output
```

(Remember to redirect stderr since that's usually where compiler
warnings go.  Also, we want to send the binary output to `/dev/null`
since we just want the warnings.  We certainly don't want to overwrite
the decoder while it's running.)

Encoding data using compiler warnings might seem like a fragile thing
to do, but we like it because the warning messages for GCC and Clang
are subtly different, such that it's possible to encode two different
messages in one file:

``` <!---sh-->
    ./prog "Message for GCC\n" "Message for Clang\n" > output2.c

    gcc output2.c -o decode

    gcc output2.c -c -o /dev/null 2>&1 | ./decode
    clang output2.c -c -o /dev/null 2>&1 | ./decode
```

* First message will be encoded in warning messages for GCC (11.1 or later, tested up to 15.2).
* Second message will be encoded in warning messages for Clang (tested up to 21.1.0).  GCC 10.5 and earlier shares the same behavior as Clang.

For users who are missing GCC or Clang, and also to future-proof against
changes in GCC/Clang warning messages, output code also includes extra
decoders to simulate GCC/Clang behavior.  By running output code with Ruby
or Perl, we get diagnostics that are sufficiently similar to GCC/Clang
warnings such that the decoder can recover the input messages:

``` <!---sh-->
    ruby output2.c | ./decode
    perl output2.c | ./decode
```


### Miscellaneous features

Encoder and generated output have been verified to work under these environments:

* gcc 13.4.0 on Cygwin.
* gcc 11.4.0 on Linux.
* clang 20.1.8 on Cygwin.
* clang 11.0.1 on Linux.
* clang 10.0.0 on JSLinux.

The encoder and generated output have also been tested under these
environments below.  They compile and run just fine, but the compiler
warning messages aren't sufficient to fully exercise the program

* gcc 10.2.1 on Linux.
* gcc 9.3.0 on JSLinux.
* tcc 0.9.27 on JSLinux.

CRC32 of the source code is embedded in the code itself (44495630),
which spells out `DIV0`.

Code layout is based on Kurumi, also known as Walnut, the elite hacker
from "Lycoris Recoil".  The code is a bit larger than it needs to be
due to the 50% dither pattern used for the hair.


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
