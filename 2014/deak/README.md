## To build:

``` <!---sh-->
    make
```

There is an alternate version that the author provided but fixed in 2023 to
compile with modern systems and to allow one to reconfigure the constants `X1`,
`X2`, `Y1` and `Y2` (which were magic numbers). See [Alternate
code](#alternate-code) below.


## To use:

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    ./prog
```

Try changing bounding box coordinates in the source to explore
various regions of the fractal.


## Alternate code:

The alternate code is included as [prog.alt.c](%%REPO_URL%%/2014/deak/prog.alt.c) so you can more
easily see the difference in what it might look like if the C was more
recognisable and also to let you reconfigure the coordinates.


### Alternate build:

``` <!---sh-->
    make alt
```

If you wish to redefine the coordinates you can do so by defining `X1`, `X2`,
`Y1` and/or `Y2`, which default to: `-2`, `1`, `-1.3` and `1.3` respectively.
For instance:


``` <!---sh-->
    make clobber X1=-3 X2=2 Y1=-2.3 Y2=2.3 alt
```

You may pick and choose which ones to redefine.


### Alternate use:

Use `prog.alt` as you would `prog`.


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

We consider this entry a tribute to all "Abuse of the C preprocessor"
and Mandelbrot fractal drawing entries we've seen over the years.

We liked the use of unary notation facilitated by variadic macros.


## Author's remarks:

### Portability

The application was written on a standard Ubuntu 14.04 and tested with
gcc 4.9.1 and clang 3.5 on a 64 bit system (though this should not matter).
The application makes no assumption regarding any system specific settings,
and it only needs a console to run. The provided Makefile is just to have
an easy compilation. I don't see any problems porting it to different
compiler/system as long as it supports the C99 standard.


### The application

The purpose of the application is mainly to illustrate the weird possibilities
of the C preprocessor, rather than to be a full featured console mode Mandelbrot
drawer. There are tools much better suited for drawing fractals.

The usage of recognizable elements from the C programming language in the
application source code is intentionally kept to a bare minimum. If this phrase
would not be true, the application would be the following:

``` <!---c-->
    double                                 _[]={-2
    ,1,-1.3                ,1.3,  0,         0,0,0
    ,0               ,0,50, 80,     0,0,0     ,255
    ,               8,0};    int      main       (
                   int j) {if (j==  1 ){ if(
           _[12]      >_[10]  )_[17]=1 ;}  if
       (_[13] >_[11     ] ||_[17]==1)  return 1
     ;_[6]   =  _ [13] / _[11]*(_[1]-_[   0])
    +_[  0];  _ [7]=_[12]/_[10]*(_[3]-_[2] )+_
    [2];_[8]=_[9]=_[14]=0;l2:_[4]=_[8] * _ [8]
    ;_[  5]=  _ [9]*_[9];_[9]=2*_[8]*_[9]+ _[7
     ];_[8   ]  = _ [ 4 ]-_[5]+_[6];_[14   ]++
       ;if((_ [14]<     _ [15])&&(_[4]+ _[ 5]
           <_[16      ])) goto l2;  putchar(
                   " #@*+   "[( int)  _[14]%
    5             ]);_ [13   ] ++ ;   main       (
    0)               ;_[12]++;      _[13]       =0
    ;if(_                [17]    !=1)      putchar
    (0xa);                               main(1);}
```

The application expects no parameters, the only way you can change the behaviour
is to modify the source code at the indicated location: the line
`/* <-- Configure here: X1, X2, Y1, Y2 */` is intentionally not obfuscated so
that the adventurous programmer can manually modify the coordinates of the
fractal to be drawn on the screen.


### Compiler warnings

Yes, unfortunately there are compiler warnings of the kind "initialization makes
integer from pointer without a cast" but the provided Makefile automatically
disables them.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
