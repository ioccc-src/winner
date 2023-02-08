# Most GIFted expressions

Philip Blakely  
Cambridge, UK  
<pmblakely@gmail.com>  


## Judges' comments:
### To build:

    make blakely

### To run:

    ./blakely "RPN formula" resolution > output.gif

### Try:

    ./blakely "xx*yy*+" 64 > paraboloid.gif

    ./blakely 9 32 > empty.gif

    time ./blakely 0 250 > flat.gif

### Selected Judges Remarks:

Several IOCCC themes (RPN calculator, animated GIF generator, ray tracing) in one package! Very impressive!

The checkerboard pattern in the output can be broken. Could you figure out how?

Larger GIF files confuse some image viewers.


## Author's comments:
Remarks
-------

This program renders a generic RPN expression in ray-traced animated GIF form.
The expression in spatial variables x and y is specified on the command-line with the required resolution,
and an animated GIF showing a fly-around of the resulting surface is output to stdout.

Usage
-----

The program should be run as:

    ./blakely xy* 32 > pic.gif
where the first parameter is a RPN expression, and the second is the width of the required GIF, up to a maximum of 250.

The expressions are written in Reverse Polish Notation with the following characters recognised:

* +,-,\*,/ - usual arithmetic operations
* ^ - Exponentiation - valid for constant exponent only
* s - sin
* c - cos
* 0-9 - single digit integers
* d - duplicate number on stack
* t - transpose top two elements on stack
* x - x coordinate value
* y - y coordinate value

NB all arithmetic is done in double precision, so 23/ is two-thirds, rather than 0

The surface plotted corresponds to -1 <= x,y <= 1 and for best results, the generated z value should lie between -1 and 1.

If there is a division by zero, square-root of a negative number, or similar operation, then the results are undefined.

Examples
--------

For test-runs, use a resolution of 32. For simple expressions, the GIF generation should take only
a few seconds with a modern processor and full optimization. Run-time scales as O(N^3) with resolution N,
and more complex expressions take longer to compute. For example, increasing the resolution of ripple.gif
to 250 took ~35 minutes to render on an i7 processor.

    ./blakely xy* 32 > saddle.gif

    ./blakely xx*yy*1++d5*ct/ 64 > ripple.gif

Algorithm
---------

A generic root-finding algorithm to find the point of intersection between a ray
and the surface is done using a simple forward search from the eye.
In order to make the rendering realistic, both the value of the expression, and its derivative with respect to x and y must be tracked.
This is done using an obvious stack-based approach.

Obfuscations
------------

Much of the obfuscation is achieved through the use of single-letter variables and #defines.
The characters output for the GIF format are generated in myriad and wonderful ways, making use
of XOR, return values from putchar, and odd expressions.
The layout is in the form of X Y Z.

Limitations
-----------
ASCII is assumed since many bytes for the GIF output are generated from characters given in the source code.
On compilation a few warnings about parentheses come up when using gcc 4.6.3, and one about no return value from main() (who uses exit codes anyway?),
but clang 3.1 emits no warnings.

Questions
---------

* Apart from their appearance when computing the RPN expression, sin and cos are not used.
  How do we then get the correct angles for rotation?
* Exactly how many times will the animation repeat?
* Why is there an upper limit of 250x250 for the resolution?
* What is the point of b[0]?
* Where are the words NETSCAPE and GIF hidden in the source?

(Note that the author may or may not be able to answer all of the above questions.)

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
