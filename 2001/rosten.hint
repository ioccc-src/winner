Best abuse of the user:

    Edward Rosten
    Oxford University
    34 The Chilterns
    Gloucester Green
    Oxford
    OX1 2DF
    United Kingdom

    http://users.ox.ac.uk/~scat1148


Judges' Comments:

    To build:

    	make rosten

    Try:

	./rosten 1.03
	./rosten 1.00

    For some abuse, try:

        ./rosten 0.99

    Friction can be your friend if it does not rub you (or your mouse
    cursor) in the wrong way.  :-)


Selected Author's Comments:

    NAME

        rosten - make the mouse act as if it has been greased

    SYNOPSIS

        rosten [greasiness]


    DESCRIPTION

        This program is designed primarily to make your X windows interface more
        obfuscated. Try doing something mouse driven (such as using a mouse
        driven editor on this program) whilst it is running. If you're not sure
        what it does, looking at the code should give a fair idea.

        It also has a [cat] man page if you want to install it as a `utility'.


    OPTIONS

        It only takes one optional option: the greasiness factor. This is the
        number that the speed is divided by on each iteration. The default is
        1.03. A setting of 1 (no friction is fun), as is 0.99.

        Being an X program, it recognised the DISPLAY variable.


    PORTABILITY

        The program is very portable, even to non X architectures. All that is
        required is a large desk and some good grease.


    COMMENTS

    	It is really rather surprising that code like this should not only be
    	portable, but compile with almost no warnings on most of the compilers
    	tested. It's a kind of shame that none of the compilers do anything
	like this:

    	$make greasymouse
    	cc greasymouse.c -o greasymouse -lX11
    	greasymouse.c:30: This macro should have more text and spaces in it
    	greasymouse.c:32: This is a really stupid way to perform this operation
    	greasymouse.c:42: This program would look better with a newline here
    	greasymouse.c:48: That's a really silly thing to do
    	greasymouse.c:55: So is that
    	...
    	greasymouse.c:58: This program is rubbish. I'm not going to link it.

	The code is best viewed with tabstops every 8 spaces.


    BUGS

	The mouse gets stuck completely if you give it an option of less
	than 1 and leave it for too long. This is quite annoying if it
	didn't leave the terminal if was run from in focus.

        It gets very jerky if the processor is being used. There are
        better time functions than clock() but I haven't used them.

        It deflects slightly when it gets very slow.

        It annoys other people if you run it on their display too
        often. Maybe I should make future versions print funny jokes to
        keep the humor fresh.

        It's pretty ropey over a 56K modem.

    	It's even ropier over a 56K modem and tunneled through 3 ssh links.


    WARNINGS

	Pages and pages and pages of things, with GCC at any rate.

	It suggests loads of ()'s where they're not needed.

	It reckons I have not used some of the values I have computed. I
	would never do a thing like that: I just haven't used them in
	the way it's used to.

        The MIPS compiler suggests an == instead of an = in expressions
	such as:

            &&(a=b)

        but I its suggestions would break my program.  It also reckons
        that r() has no prototype.

    	Giving the -pedantic option to the MIPS compiler causes it to generate
    	warnings about its own header files, but not any extra ones with this
    	program.

        With all warnings enabled, the DEC compiler, oddly enough finds some
        problems with its own include files, but none with my program.


    ERRORS

        The DEC compiler of this version:

	    DEC C V5.6-079 on Digital UNIX V4.0 (Rev. 878)

        can't compile the code. It thinks that preprocessor lines can not have
        whitespace preceding the #. Moving the preprocessor directives to the
        beginning of the line wrecks the layout but makes it compile.
