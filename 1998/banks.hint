Best of Show:

    Carl Banks
    Penn State Department of Aerospace Engineering
    232 Hammond Building
    University Park, PA 16802
    USA

    http://www.personal.psu.edu/users/c/w/cwb129/


Judge's Comments:

    To build:

	make banks

    To use:

	cat horizon.sc pittsburgh.sc | ./banks

    What can we say?  It's a flight sim done in 1536 bytes of real code.
    This one is a real marvel.  When people say the size limits are too
    tight, well, we can just point them at this one.  This program really
    pushes the envelope!

    The provided Makefile should work; you will need an X-ish system, and
    a select() system call.  More on building in the author comments.

    NOTE: On some systems the original entry did not correctly display
    the altitude and airspeed.  These problems have been fixed.  One can
    still build the original program by:

	make banks.orig


Selected Author's Comments:

    You have just stepped out of the real world and into the
    virtual.  You are now sitting in the cockpit of a Piper Cherokee
    airplane, heading north, flying 1000 feet above ground level.

    Use the keyboard to fly the airplane.  The arrow keys represent
    the control stick.  Press the Up Arrow key to push the stick
    forward.  Press the left arrow key to move the stick left, and
    so on.  Press Enter to re-center the stick.  Use Page Up and Page
    Down increase and decrease the throttle, respectively.  (The
    rudder is automatically coordinated with the turn rate, so
    rudder pedals are not represented.)

    On your display, you will see on the bottom left corner three
    instruments.  The first is the airspeed indicator; it tells you
    how fast you're going in knots.  The second is the heading
    indicator, or compass.  0 is north, 90 is east, 180 is south,
    270 is west.  The third instrument is the altimeter, which
    measures your height above ground level in feet.

    --------
    Features
    --------

    * Simulator models a Piper Cherokee, which is a light,
      single-engine propeller driven airplane.

    * The airplane is modeled as a six degree-of-freedom rigid
      body, accurately reflecting its dynamics (for normal flight
      conditions, at least).

    * Fly through a virtual 3-D world, while sitting at your X
      console.

    * Loadable scenery files.

    * Head-up display contains three instruments: a true airspeed
      indicator, a heading indicator (compass), and an altimeter.

    * Flight controls may be mapped to any keys at compile time
      by redefining the macros in the build file.  Nice if your
      keyboard doesn't have arrow keys.  (Or if you still use
      vi. :-)

    * Time step size can be set at compile time.  This is useful to
      reduce flicker on network X connections.  (But be careful:
      step sizes longer than about 0.03 seconds tend to have
      numerical stability problems.)

    * Airplane never stalls!

    * Airplane never runs out of fuel!

    * Fly underground!

    * Fly through buildings!


    -------
    Scenery
    -------

    Each of the *.sc files is a scenery file.  The simulator
    program reads in the scenery from standard input on startup.
    You may input more than one scenery file, as long as there are
    less than 1000 total lines of input.

    Here is a brief description of the scenery files:

      horizon.sc    -- A horizon, nothing more.  You will probably
		       always want to input this piece of scenery.

      mountains.sc  -- An alternate horizon; a little more
		       mountainous.

      pittsburgh.sc -- Scenery of downtown Pittsburgh.  The downtown
		       area is initially located to your right.

      bb.sc         -- Simple obstacle course.  Try to fly over the
		       buildings and under the bridges.

      pyramids.sc   -- Fly over the tombs of the ancient Pharaohs,
		       in this (fictitious) Egyptian landscape.

      river.sc      -- Follow a flowing river from the sky.

    A few examples of how to input scenery:

      cat horizon.sc pittsburgh.sc | ./banks
      cat mountains.sc bb.sc | ./banks
      cat mountains.sc river.sc pyramids.sc | ./banks

    You can simulate flying through a cloud bank as well:

      ./banks < /dev/null

    You will usually want at least a horizon, though.

    The format of scenery files is simple, by the way.  They're just
    a list of 3-D coordinates, and the simulator simply draws line
    segments from point to point as listed in the scenery file.  0 0
    0 is used to end a series of consecutive line segments.  Note
    that in the coordinate system used, the third coordinate
    represents altitude in a negative sense: negative numbers are
    positive altitudes.

    I'm sure you'll be making your own scenery files very soon!!!

    ----------------------------
    Alternate Build Instructions
    ----------------------------

    Several options must be passed to the compiler to make the build
    work.  The provided build file has the appropriate options set
    to default values.  Use this section if you want to compile with
    different options.

    To map a key to a control, you must pass an option to the
    compiler in the format ``-Dcontrol=key''.  The possible controls
    you can map are described in the table below:


	   Control         Description         Default Key
	   -------  -------------------------  -----------
	     IT         Increase throttle      XK_Page_Up
	     DT         Decrease throttle      XK_Page_Down
	     FD         Move stick forward     XK_Up
	     BK         Move stick back        XK_Down
	     LT         Move stick left        XK_Left
	     RT         Move stick right       XK_Right
	     CS         Center stick           XK_Enter


    Values for the possible keys can be found in the X Windows
    header file <X11/keysym.h>.  This file is most likely a
    cross-reference to another header, <X11/keysymdef.h>.

    You must map all seven controls to keys at compile time, or the
    compilation will fail.

    For example, to map Center Stick to the space-bar, the compile
    option would be ``-DCS=XK_space''.


    To set the time step size, you must pass the following option to
    the compiler: ``-Ddt=duration'', where dt is literal, and where
    duration is the time in seconds you want the time step to be.

    Two things to keep in mind when selecting a time step.  Time
    steps that are too large (more than about 0.03) will cause
    numerical stability problems and should be avoided.  Setting the
    time step to be smaller than your clock resolution will slow
    down the simulator, because the system pauses for more time than
    the simulator expects.

    The best advice is to set time step size to your system timer
    resolution.  Try a longer period if you're getting too much
    flicker.
