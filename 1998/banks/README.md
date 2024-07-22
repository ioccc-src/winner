## To build:

``` <!---sh-->
    make all
```

NOTE: this entry requires the `X11/Xlib.h` header file and the X11 library to
compile.  For more information see the
FAQ on "[X11](../../faq.html#X11)".

If you do not have a page up or page down key you might wish to see the
[Alternate code](#alternate-code) section below. You may redefine all the keys
and the time step with predefined macros, however, so one lacking page up / page
down does not strictly need the alternate code; it jut gives those controls a
default value. The author provided the following table:


```
    Control         Description         Default Key
    -------  -------------------------  -----------
     IT         Increase throttle      XK_Page_Up
     DT         Decrease throttle      XK_Page_Down
     FD         Move stick forward     XK_Up
     BK         Move stick back        XK_Down
     LT         Move stick left        XK_Left
     RT         Move stick right       XK_Right
     CS         Center stick           XK_Enter
```

There is another macro, `dt`, which is the time step. See some important points
on this in the author's comments in the [Alternate Build
Instructions](#alternate-build-instructions) section.

If however you wish to change the above controls, see the header file
[keysym.h](%%REPO_URL%%/1998/banks/keysym.h) for the definitions of other characters that you might wish
to use. The name of the macro in the header file is what you need to set the
macros to, depending on what controls you wish to redefine. For instance, to set
the throttle up and down to `u` and `d`:


``` <!---sh-->
    make clobber IT=XK_u DT=XK_d all
```

because in the header file you can see that `XK_u` corresponds to `u` and `XK_d`
corresponds to `d`:

``` <!---c-->
    #define XK_d                             0x0064  /* U+0064 LATIN SMALL LETTER D */
    #define XK_u                             0x0075  /* U+0075 LATIN SMALL LETTER U */
```

Note that the [keysym.h](%%REPO_URL%%/1998/banks/keysym.h) file is not complete from X11; it's just the
more likely candidates (and some that are probably unlikely :-) ).

The upper case letters would be `XK_U` and `XK_D` and you can search the header
file for 'LATIN CAPITAL D', for example.

For those who do not have a Page Up or Page Down key, see [alternate
code](#alternate-code) below. The difference from the alt build and the original
entry is that the page up and page down keys are defined to a default but they
are hard coded as doing otherwise would necessarily complicate the build
instructions. Since you can use the original entry to redefine these this is not
a problem and is purely a convenience .. if only for those who are okay with the
preselected alternative keys.


## To use:

``` <!---sh-->
    cat horizon.sc pittsburgh.sc | ./banks
```

See the author's remarks in [scenery](#scenery) for more details on the scenery
files.


## Try:

For a fun time after running the above command, hold down the up arrow and left
arrow for about 10 seconds and see what happens. Or, if you wish to really use
it in a non-silly way, see the author's remarks for the real controls. Perhaps
you can regain control?


## Alternate code:

If you do not have access to a page up or page down key, for instance you're
using a Mac, you can use the alternate code (though it actually uses the same code)
that will redefine the keys to increase throttle and decrease throttle. This
same method can be used with the original code but this sets up predefined keys
in place of Page Up and Page Down.

The keys were somewhat arbitrarily selected but it was decided to make them both
on the left side of a QWERTY keyboard as one might have a harder time using the
arrows at the same time as typing on the right side.


### Alternate build:

As the Makefile allows you to configure the keys to use you may redefine the
keys but with the alt build you cannot, as described earlier, redefine the page
up and page down replacement keys. The other controls you may redefine; this is
just a convenience build. If you want to redefine the page up / page down keys
you should use the original entry as described in the to build section above.

In the alt build it is `f` (for page up) and `d` (for page down) as these are
letters on the left side of the keyboard which is easier to use if one is using
the right side for movement. These are hard coded, as noted.

To use the default settings for the alternate build:

``` <!---sh-->
    make alt
```

You may change the other keys as described in the build instructions, above, but
this alternate code can be seen as an alternative for those who don't have or don't
want to use page up and page down.


### Alternate use:

Use `banks.alt` as you would `banks` but use the different keys as
configured at compilation.


## Judges' remarks:

What can we say?  It's a flight sim done in 1536 bytes of real code.
This one is a real marvel.  When people say the size limits are too
tight, well, we can just point them at this one.  This program really
pushes the envelope!

The provided Makefile should work; you will need an X-ish system, and
a `select(2)` system call.  More on building in the author remarks.

Carl Banks linked to (on his old website) an interesting article about this
entry, a flight simulator in just 1536 bytes, which can be found at
<https://web.archive.org/web/20040201120708/http://www.idg.co.nz/magazine/pcworld/oct99/code.htm>.


## Author's remarks:

You have just stepped out of the real world and into the
virtual.  You are now sitting in the cockpit of a Piper Cherokee
airplane, heading north, flying 1000 feet above ground level.

Use the keyboard to fly the airplane.  The arrow keys represent
the control stick.  Press the Up Arrow key to push the stick
forward.  Press the left arrow key to move the stick left, and
so on.  Press Enter to re-center the stick.  Use Page Up and Page
Down to increase and decrease the throttle, respectively.  (The
rudder is automatically coordinated with the turn rate, so
rudder pedals are not represented.)

On your display, you will see on the bottom left corner three
instruments.  The first is the airspeed indicator; it tells you
how fast you're going in knots.  The second is the heading
indicator, or compass.  0 is north, 90 is east, 180 is south,
270 is west.  The third instrument is the altimeter, which
measures your height above ground level in feet.


### Features

* Simulator models a [Piper
Cherokee](https://en.wikipedia.org/wiki/Piper_PA-28_Cherokee), which is a light,
single-engine propeller driven airplane.

* The airplane is modeled as a six degree-of-freedom rigid body, accurately
reflecting its dynamics (for normal flight conditions, at least).

* Fly through a virtual 3D world, while sitting at your X console.

* Loadable scenery files.

* Head-up display contains three instruments: a true airspeed indicator, a
heading indicator (compass), and an altimeter.

* Flight controls may be mapped to any keys at compile time by redefining the
macros in the Makefile.  Nice if your keyboard doesn't have arrow keys.  (Or
if you still use vi. :-)

* Time step size can be set at compile time.  This is useful to reduce flicker
on network X connections.  (But be careful: step sizes longer than about 0.03
seconds tend to have numerical stability problems.)

* Airplane never stalls!

* Airplane never runs out of fuel!

* Fly underground!

* Fly through buildings!


### Scenery

Each of the `*.sc` files is a scenery file.  The simulator
program reads in the scenery from standard input on startup.
You may input more than one scenery file, as long as there are
less than 1000 total lines of input.

Here is a brief description of the scenery files:

- [horizon.sc](%%REPO_URL%%/1998/banks/horizon.sc)

    A horizon, nothing more.  You will probably always want to input this piece
    of scenery.

- [mountains.sc](%%REPO_URL%%/1998/banks/mountains.sc)

    An alternate horizon; a little more mountainous.

- [pittsburgh.sc](%%REPO_URL%%/1998/banks/pittsburgh.sc)

    Scenery of downtown Pittsburgh.  The downtown area is initially located
    to your right.

- [bb.sc](%%REPO_URL%%/1998/banks/bb.sc)

    Simple obstacle course.  Try to fly over the buildings and under the
    bridges.

- [pyramids.sc](%%REPO_URL%%/1998/banks/pyramids.sc)

    Fly over the tombs of the ancient Pharaohs, in this (fictitious) Egyptian
    landscape.

- [river.sc](%%REPO_URL%%/1998/banks/river.sc)

    Follow a flowing river from the sky.


A few examples of how to input scenery:

``` <!---sh-->
    cat horizon.sc pittsburgh.sc | ./banks
    cat mountains.sc bb.sc | ./banks
    cat mountains.sc river.sc pyramids.sc | ./banks
```

You can simulate flying through a cloud bank as well:


``` <!---sh-->
    ./banks < /dev/null
```


You will usually want at least a horizon, though.

The format of scenery files is simple, by the way.  They're just
a list of 3D coordinates, and the simulator simply draws line
segments from point to point as listed in the scenery file.  `0 0
0` is used to end a series of consecutive line segments.  Note
that in the coordinate system used, _the third coordinate
represents **altitude** in a negative sense: negative numbers are
positive altitudes_.

I'm sure you'll be making your own scenery files very soon!!!


### Alternate Build Instructions

Several options must be passed to the compiler to make the build
work.  The provided [Makefile](%%REPO_URL%%/1998/banks/Makefile) has the appropriate options set
to default values.  Use this section if you want to compile with
different options.

To map a key to a control, you must pass an option to the
compiler in the format `-Dcontrol=key` or if you use the Makefile you can do
`make control=key`.

The possible controls you can map are described in the table below:

```
    Control         Description         Default Key
    -------  -------------------------  -----------
     IT         Increase throttle      XK_Page_Up
     DT         Decrease throttle      XK_Page_Down
     FD         Move stick forward     XK_Up
     BK         Move stick back        XK_Down
     LT         Move stick left        XK_Left
     RT         Move stick right       XK_Right
     CS         Center stick           XK_Enter
```

Values for the possible keys can be found in the X Windows
header file `<X11/keysym.h>`.  This file is most likely a
cross-reference to another header, `<X11/keysymdef.h>`.

For example, to map Center Stick to the space-bar, the compile
option would be `-DCS=XK_space` or `make CS=XK_space`.


To set the time step size, you must pass the following option to
the compiler: `-Ddt=duration`, where `dt` is literal, and where
`duration` is the time in seconds you want the time step to be. Alternatively,
if you use the provided Makefile, you may just do `make dt=time`.

Two things to keep in mind when selecting a time step.  Time
steps that are too large (more than about `0.03`) will cause
numerical stability problems and should be avoided.  Setting the
time step to be smaller than your clock resolution will slow
down the simulator, because the system pauses for more time than
the simulator expects.

The best advice is to set time step size to your system timer
resolution.  Try a longer period if you're getting too much
flicker.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
