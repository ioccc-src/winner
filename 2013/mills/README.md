# Most timely rendered

Christopher Mills  
<mrxo@sonic.net>  


## Judges' comments:
### To build:

    make mills

### To run:

    ./mills

### Try:

    ./mills &

While that is running, point your favorite browser at: [http://localhost:8224](http://localhost:8224)

### Selected Judges Remarks:

Who will be the first to post an image rendered during a leap-second?

## Author's comments:

The Program
===========

This program is a handy graphical clock.  Simply run the program, click *OK* to
any annoying security dialogs that pop up (aren't those annoying?), then fire
up your web browser and type in the following URL:

>  <http://localhost:8224>

You will soon be presented with a lovely dynamically rendered 3D scene that
also convienently tells you the current time!

Usage Notes
-----------

The program will continue to give you the time of day as it changes by
reloading the page as often as it can render.  If you grow tired of watching
your life slip by, hit `Control-C` in the original window.  Note that if you
want to restart the program again, you should wait a minute or two before
doing so.  For details as to why this is necessary, feel free to Google
`TIME_WAIT`.  And while you are there, click on an ad.  They could use the
money.

It would be possible to fix this by adding

    n=1,setsockopt(s,SOL_SOCKET,SO_REUSEADDR,&n,sizeof n),

at an appropriate spot in the code (an exercise left to the reader).  However,
as this limitation is documented, it is not techinally a bug.

Details of Operation
--------------------

The program wears many hats (not literally).  It is

 - a web server
 - a PNG encoder
 - a ray tracer
 - a clock

It replies to web requests with a PNG image that uses the
[Adam7](http://en.wikipedia.org/wiki/Adam7_algorithm)
encoding to return data progressively.  Since the data is returned in Adam7
format, the scene is displayed initally at a lower resolution and allowed to
be progressively refined as time goes on.  The ray tracer is integrally tied
to the PNG encoder, casting rays in the Adam7 order.  The web server uses
PNG primarily because of PNG's ability to return data progressively, and not
as you might think because the PNG standard is so obfuscated as to require
both little- and big-endian encodings at different spec layers.

Since ray-tracing was an obvious choice to return to a web server, I needed
something to ray-trace.  A static scene would be uninteresting.  I took
inspiration (as I often do) from the IOCCC remarks file which says

>  At least one judge prefers to maintain the use of the leap-second
>  as part of the world's time standard.

Then it was obvious; The code should display the time.  It is believed (but
not confirmed) that the code will, in fact, display leap seconds correctly.

To display the time, of course we would need a font.  This font is encoded
as a string, using only the C whitespace characters.  Clearly, the judges
intended this use of whitespace for data compression, since their tool
doesn't count whitepsace in strings differently than whitespace outside of
them.

User-modifyable Features
------------------------

The code can be user-modified simply by changing the build command line.
The following symbols are defined in the build file:

  * `-DLT=x1,y1,z1,x2,y2,z2,...`

    Defines the coordinates of the lights in the scene.  It should be a
    comma-separated list of coordinates (x, y, z), three per light.

  * `-DNL=n`

    Defines the number of lights.  Should be equal to the length of the list
    above (three times the number of lights).

  * `-DEY=x,y,z`

    Defines the position of the viewer (the eyepoint) for the scene.  The eye
    is looking at the origin (0, 0, 0).

Other Build Flags
-----------------

The original program bound the server to `INADDR_ANY` to allow everyone to
experience the server's output.  The Judges suggested that I instead restrict
the bind to `INADDR_LOOPBACK` to reduce security alarms.  As a compliant veteran
of innumerable post-ship late feature additions, I have modified the `Makefile`
to inject the new code without destroying the beautiful spherical symmetry of
the source code.  In addition, I have altered the word `sin_port` to the more
family-friendly version `win_port` to protect against curious impressionable
youth trying to learn about sockets on Internet.


--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
