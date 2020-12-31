Most Functional Output:

    Jonathan Hoyle
    162 Burwyck Park
    Saline, MI  48176
    USA

    http://www.jonhoyle.com


Judges' Comments:

    To build:

	make hoyle

    Try:

    	./hoyle 10 0.5
    	./hoyle 1 1 1 1
	./hoyle 2 0 1 0 -0.001

    This obfuscation functions at several levels.  Note the clever
    use of use of #defines.  The do(if,else) #define, for example,
    is delightful.  The code itself contains a bunch of curves
    designed to throw you off axis.  :-)

    The original source may be built by:

	make hoyle.orig

    A missing newline was added and tab stops were converted to standard
    8 character width in the new code.


Selected Author's Comments:

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

     Example:
       To graph y = x^2

       		./hoyle 0 0 1

     Note that:

     		./hoyle 0 0 2

     will produce the same graph, since the y-axis is auto scaling.
