# Most underscored argument

Ferenc Deak  
<fritzone@gmail.com>  


## Judges' comments:
### To build:

    make deak

### To run:

    ./prog

### Try:

    Changing bounding box coordinates in the source to explore
    various regions of the fractal.

### Selected Judges Remarks:

We consider this entry a tribute to all "Abuse of the C preprocessor"
and Mandelbrot fractal drawing entries we've seen over the years.

We liked the use of unary notation facilitated by variadic macros.

## Author's comments:
### Portability

The application was written on a standard Ubuntu 14.04 and tested with
gcc 4.9.1 and clang 3.5 on 64 bit system (though this should not matter).
The application makes no assumption regarding any system specific settings,
and it only needs a console to run. The provided Makefile is just to have
an easy compilation. I don't see any problems porting it to different
compiler/system as long as it supports the C99 standard.

### The application

The purpose of the application is mainly to illustrate the weird possibilities
of the C preprocessor, than to be a full featured console mode Mandelbrot
drawer. There are tools much better suited for drawing fractals.

The usage of recognizable elements from the C programming language in the
application source code is intentionally kept to a bare minimum. If this phrase
would not be true, the application would be the following:

            double                                 _[]={-2
            ,1,-1.3                ,1.3,  0,         0,0,0
            ,0               ,0,50, 80,     0,0,0     ,255
            ,               8,0};    int      main       (
                           int j) {if (j==  1 ){ if(
                   _[12]      >_[10]  )_[17]=1 ;}  if
               (_[13] >_[11     ] ||_[17]==1)  return
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

The application expects no parameters, the only way you can change the behaviour
is to modify the source code at the indicated location: the line
`/* <-- Configure here: X1, X2, Y1, Y2 */` is intentionally not obfuscated so
that the adventurous programmer can manually modify the coordinates of the
fractal to be drawn on the screen.

### Compiler warnings

Yes, unfortunately there are compiler warnings of the kind "initialization makes
integer from pointer without a cast" the provided Makefile automatically
disables them.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
