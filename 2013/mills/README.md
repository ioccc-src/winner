## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [2013/mills in bugs.html](../../bugs.html#2013_mills).


## To use:

``` <!---sh-->
    ./mills
```


## Try:

``` <!---sh-->
    ./mills &
```

While that is running, point your favorite browser at:
[http://localhost:8224](http://localhost:8224).


## Judges' remarks:

Who will be the first to post an image rendered during a leap-second?


## Author's remarks:

### The Program

This program is a handy graphical clock.  Simply run the program, click *OK* to
any annoying security dialog that pop up (aren't those annoying?), then fire
up your web browser and type in the following URL: <http://localhost:8224>.

You will soon be presented with a lovely dynamically rendered 3D scene that
also conveniently tells you the current time!

### Usage Notes

The program will continue to give you the time of day as it changes by
reloading the page as often as it can render.  If you grow tired of watching
your life slip by, hit `Control-C` in the original window.  Note that if you
want to restart the program again, you should wait a minute or two before
doing so.  For details as to why this is necessary, feel free to Google
`"TIME_WAIT"`, `"SO_REUSEADDR"` and `"SO_REUSEPORT"` (with the quotes).  And
while you are there, click on an ad.  They could use the money.

It would be possible to fix this by adding

``` <!---c-->
    n=1,setsockopt(s,SOL_SOCKET,SO_REUSEADDR,&n,sizeof n),
```

at an appropriate spot in the code (an exercise left to the reader).  However,
as this limitation is documented, it is not technically a bug.


### Details of Operation

The program wears many hats (not literally).  It is

- a web server
- a PNG encoder
- a ray tracer
- a clock

It replies to web requests with a PNG image that uses the
[Adam7](http://en.wikipedia.org/wiki/Adam7_algorithm) encoding to return data
progressively.  Since the data is returned in Adam7 format, the scene is
displayed initially at a lower resolution and allowed to be progressively
refined as time goes on.  The ray tracer is integrally tied to the PNG encoder,
casting rays in the Adam7 order.  The web server uses PNG primarily because of
PNG's ability to return data progressively, and not as you might think it being
because the PNG standard is so obfuscated as to require both little and
big-endian encodings at different spec layers.

Since ray-tracing was an obvious choice to return to a web server, I needed
something to ray-trace.  A static scene would be uninteresting.  I took
inspiration (as I often do) from the IOCCC remarks file which says

```
    At least one judge prefers to maintain the use of the leap-second
    as part of the world's time standard.
```

Then it was obvious; the code should display the time.  It is believed (but
not confirmed) that the code will, in fact, display leap seconds correctly.

To display the time, of course we would need a font.  This font is encoded
as a string, using only the C whitespace characters.  Clearly, the judges
intended this use of whitespace for data compression, since their tool
doesn't count whitespace in strings differently than whitespace outside of
them.


### User-modifiable Features

The code can be user-modified simply by changing the build command line.
The following symbols are defined in the [Makefile](%%REPO_URL%%/2013/mills/Makefile):

* `-DLT=x1,y1,z1,x2,y2,z2,...` defines the coordinates of the lights in the
scene. It should be a comma-separated list of coordinates `(x, y, z)`, three per
light.

* `-DNL=n` defines the number of lights. It should be equal to the length of the
list above (three times the number of lights).

* `-DEY=x,y,z` defines the position of the viewer (the eye point) for the scene.
The eye is looking at the origin `(0, 0, 0)`.


### Other Build Flags

The original program bound the server to `INADDR_ANY` to allow everyone to
experience the server's output.  The Judges suggested that I instead restrict
the bind to `INADDR_LOOPBACK` to reduce security alarms.  As a compliant veteran
of innumerable post-ship late feature additions, I have modified the
[Makefile](%%REPO_URL%%/2013/mills/Makefile) to inject the new code without destroying the beautiful
spherical symmetry of the source code.  In addition, I have altered the word
`sin_port` to the more family-friendly version `win_port` (via
`-Dwin_port="sin_addr.s_addr=htonl(2130706433),R.sin_port"`) to protect against
curious impressionable youth trying to learn about sockets on the Internet.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
