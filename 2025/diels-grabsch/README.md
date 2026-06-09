Award: Best one liner

## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog n e e d s a r g u m e n t s < infile > outfile.Z
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Some of our wishes are granted after quite a few years, and some previous IOCCC winners
turn out prescient by a decade.


### A fun challenge

Explain the purpose of the constant **9018655** in [prog.c](%%REPO_URL%%/2025/diels-grabsch/prog.c).

**UPDATE**: We are in the process of changing how we present fun challenges,
and present potential solutions to those challenges.  Please stay tuned for an update.


## Author's remarks:


<div id="description">
### Description
</div>

This one-liner is an implementation of the following Judges' remark
on [2019/diels-grabsch1](https://www.ioccc.org/2019/diels-grabsch1/):

> can you compress it down to a one-liner, still producing files in
> the UNIX compress format, albeit sacrificing the compression ratio?

Challenge accepted! This one-liner does exactly that ... if you ask
nicely.


<div id="usage">
### Usage
</div>

``` <!---sh-->
    cc -ansi -w -o prog prog.c
    ./prog p l e a s e c o m p r e s s < remarks.md > remarks.md.Z
    wc -c remarks.md
    wc -c remarks.md.Z
```

Output:

```
   2638 remarks.md
   1999 remarks.md.Z
```


<div id="note-9-bit">
### Note about 9-bit mode
</div>

This tool produces compressed files with a maximum code word size
of 9&nbsp;bits.  Due to a
[bug in ncompress](https://github.com/vapier/ncompress/issues/5)
that was only fixed after the 5.0 release, you should *not* use that
widespread version of `ncompress`, but instead compile the latest
`main` branch of `ncompress` to verify the compressed data:

``` <!---sh-->
    git clone -b main https://github.com/vapier/ncompress
    cd ncompress
    make
    cd ..
    ./ncompress/compress -dc < remarks.md.Z | diff -s - remarks.md
```

Output:

>   Files - and remarks.md are identical


<div id="ioccc-verification">
### Pure IOCCC verification
</div>

Alternatively, you can use
[2015/mills2](https://www.ioccc.org/2015/mills2/) which provided a
correct 9-bit mode implementation right from the start.  This is
remarkable as the unmodified `2015/mills2` only supports 16-bit mode,
but can be turned into 9-bit mode by changing a single constant from
16&nbsp;to&nbsp;9 in the code:

``` <!---sh-->
    curl -Lso mills2.c https://github.com/ioccc-src/winner/raw/refs/heads/master/2015/mills2/prog.c
    sed s/16/9/ < mills2.c > mills2-9bit.c
    cc -ansi -w mills2-9bit.c -o mills2-9bit
    ./mills2-9bit remarks.md.Z | diff -s - remarks.md
```

Output:

>   Files - and remarks.md are identical


<div id="ratio">
### Compression ratio
</div>

You might be suprised to learn that this one-liner beats `ncompress`
on any random input!

``` <!---sh-->
    head -c 10000 /dev/urandom | ./prog p l e a s e c o m p r e s s | wc -c
    11214

    head -c 10000 /dev/urandom | compress | wc -c
    14498
```

Joking aside, using just 9-bit codes means that this one-liner of
course has a worse compression ratio than `ncompress`:

``` <!---sh-->
    cat remarks.md | ./prog p l e a s e c o m p r e s s | wc -c
    1999

    cat remarks.md | compress | wc -c
    1660
```

But on the other hand, as seen above, using just 9-bit codes also
makes it less worse than `ncompress` on hopelessly incompressible
input.


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
