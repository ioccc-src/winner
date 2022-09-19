Best Non-Use of Curses:

    Mark Schnitzius
    Eclipse Group
    94 Richardson St
    Albert Park, VIC 3206
    Australia


Judges' Comments:

    To build:

	make schnitzi

    Try:

        On some systems (Some sort of UNIX with "vim") try the following

	./schnitzi <schnitzi.inp0 | vi
        ./schnitzi <schnitzi.inp1 | vi

        For others, create an output file and use your system
	pasteboard/selection/cut buffer to "input" the output into vi

        ./schnitzi <schnitzi.inp0 >schnitzi.out0
        ./schnitzi <schnitzi.inp1 >schnitzi.out1

     This exemplifies the meaning of Visual Editor, but we don't think
     that any benchmarking sites are going to use this to tout the
     performance of the latest hardware!


Selected Author's Comments:

    If you've ever pasted a large chunk of text into an editor (such as
    'vi') without first putting it into insert mode, or turning off
    the auto-indent, you know the dismay of watching your screen fill
    up with misaligned junk.

    It's not the editor's fault.  The editor is just acting just as if
    you typed exactly what you're pasting.  (Of course, you could blame
    the editor for being modal in the first place, but that's a
    discussion for another time.)

    It occurred to me that you could get interesting results by pasting
    a carefully designed string into the editor.  In fact, if the pasted
    string contains cursor navigation commands, you can go back and
    overwrite things that were already inserted earlier in string,
    anywhere on the screen.  Can you see where this is going?


    ANIMATION!

    The program takes input from stdin which defines the animated
    elements (sprites) that appear on the screen.  For each sprite,
    you can specify exactly when and how long it will appear, and which
    direction it is moving.  Also, the sprite can oscillate between
    up to four different views, which appear in subsequent frames.
    Forgive me, animators, if I'm mangling the terminology.  Sprites
    which appear later in the input file will be drawn in front of
    sprites which appear earlier.

    The output, to stdout, is a string which, when pasted into vi, will
    perform the animation defined in the input.  [The vi editor is a
    common (and ancient) editor that should be available on most Unix,
    Linux, Solaris, and Mac OS X machines; you can get it on Windows
    by installing Cygwin, which is how I do it.]


    THE INPUT

    It's easiest to place the input in a file, so you can redirect it
    to stdin when running the program.  What follows is a detailed
    description of the input file format.

    The first line is specified thusly:

       [duration] [timefactor]

    The first parameter, duration, defines how long the animation will
    run.  The second, timefactor, is used as sort of a fudge factor
    for machines that run too fast to see the animation.  A timefactor
    of 0 means, "run the animation as fast as you can".  On a pretty
    fast machine, I've had to set it as high as 2000 to get the
    animation to slow down sufficiently.  Note that the higher the
    timefactor, the longer the output string that you'll have to copy-
    and-paste, as extra characters are necessary to "waste time" between
    frames.

    Following the first line parameters, you may have up to nine
    different sprites, each up 50 by 50 in size, and with up to four
    different 'views' of that object, which are cycled through with
    each successive frame.  Each sprite begins with a line of parameters
    of the following form:

       [start] [end] [x] [y] [dx] [dy] [cols] [rows] [viewcount]

    where:

       'start' is the time at which this sprite first appears
       'end' is the time at which it disappears
       'x' is the horizontal position at which it starts
       'y' is the vertical position
       'dx' is the amount that the x position changes per frame
       'dy' is the amount that the y position changes per frame
       'cols' is the number of columns in each view
       'rows' is the number of rows in each view
       'viewcount' is the number of views to cycle through

    Each such parameter line will be followed by 'viewcount'
    view frames, each with 'rows' rows and 'cols' columns.

    Input is terminated by end of file.  Duh.

    Two samples input files are included; one a nice pastoral park
    scene, the other a bit of scrolling text.


    RUNNING THE ANIMATION

    Try one of these methods to get the animation to run:

    1.  Redirect the output directly to vi, like this:

        ./schnitzi < input.dat | vi

    2.  Redirect the output to a file, like this:

        ./schnitzi < input.dat > output.dat

        Then, open the output file, select the text, and copy it
        to your system pasteboard/cut/selection buffer and paste
        it into vi.  The paste is NOT the vi paste command, but
        rather an action you take within your operating system.
        On a Windows machine running vi via Cygwin, "Edit|Paste"
        is a right-click menu option on the top window bar.

    3.  Memorize the output, and type it into vi really really fast.


    A FINAL NOTE

    I would like to remind the Pixar Animation Studios that I retain
    royalties on this technique.
