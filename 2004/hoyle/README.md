## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./hoyle point ...
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

The obfuscation functions at several levels.  Note the clever
use of use of `#define`s.  The `#define do(if,else)`, for example,
is delightful.  The code itself contains a bunch of curves
designed to throw you off axis.  :-)


## Author's remarks:

This application graphs polynomials on a standard Cartesian coordinate system.
Polynomials of the form `ax^0 + bx^1 + cx^2 + ...` are graphed by passing the
coefficients `a`, `b`, `c`, etc. as double precision arguments.  It allows up to
8 parameters (thus up to `x^7`).


### Points of interest:

- the [x axis](https://mathworld.wolfram.com/x-Axis.html) goes from `-32` to
`+31`.
- the [y axis](https://mathworld.wolfram.com/y-Axis.html) auto scales!
- up to 8 [coefficients](https://en.wikipedia.org/wiki/Coefficient) may be
passed in.
- the graph will determine direction and use slashes and
  dashes rather than a simple block of `X`s.

For example, to graph `y = x^2`:

``` <!---sh-->
    ./hoyle 0 0 1
```

Note that:

``` <!---sh-->
    ./hoyle 0 0 2
```

will produce the same graph, since the `y-axis` is auto scaling.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
