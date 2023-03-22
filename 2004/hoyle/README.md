# Most Functional Output:

    Jonathan Hoyle
    162 Burwyck Park
    Saline, MI  48176
    USA

    http://www.jonhoyle.com

# To build:

```sh
make
```

### To run:

```sh
./hoyle point ...
```

### Try:

```sh
./hoyle 10 0.5
./hoyle 1 1 1 1
./hoyle 2 0 1 0 -0.001
```

### Alternate code

An alternate version of this entry, `hoyle.alt.c`, is provided.  This alternate code
missing newline and used a non-standard tab stop size.

To compile this alternate version:

```sh
make alt
```

Use `hoyle.alt.c` as you would `hoyle` above.

## Judges' comments

This obfuscation functions at several levels.  Note the clever
use of use of #defines.  The do(if,else) #define, for example,
is delightful.  The code itself contains a bunch of curves
designed to throw you off axis.  :-)

## Author's comments

This application graphs polynomials on a standard Cartesian coordinate
system.  Polynomials of the form ax^0 + bx^1 + cx^2 + ... are graphed by
passing the coefficients a, b, c, etc. as double precision arguments.
It allows up to 8 parameters (thus up to x^7).

Points of note:

- the x axis goes from -32 to +31
- the y axis auto scales!
- up to 8 coefficients may be passed in
- the graph will determine direction and use slashes and
  dashes rather than simple block X's.

For example, ta graph y = x^2:

```sh
./hoyle 0 0 1
```

Note that:

```sh
./hoyle 0 0 2
```

will produce the same graph, since the y-axis is auto scaling.
