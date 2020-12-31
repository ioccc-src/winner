Most likely to amaze:

    The author wishes to remain anonymous
    Great Britain


Judges' Comments:

    To build:

    	make anonymous

    Try:

	./anonymous anonymous.ten

    Is emulation the sincerest form of flattery?  This small program does
    quite a lot of bit twiddling.


Selected Author's Comments:

    This program is an optimizing dynamic binary translator, allowing you to
    run x86 programs on any machine (x86 or otherwise).

    I have included a simple "10 green bottles" program, already compiled
    for the x86.  The program 'ten', and its source (dull) are given as info
    files.  Warning: note that the translator screws around with the binary
    you run on it, *will* corrupt the binary to some extent, and may leave
    any program you run on it unusable.

    The build script should give an example command to run.

    Features

    Basic Block Cache: Rather than translating each instruction individually
    the dynamic binary translator generates a translation for an entire
    basic block of subject code.  Having translated a block once, the target
    code generated will be stored for the duration that the program is
    running, so as a program runs its performance will improve, as it hits
    cached blocks.  This can be clearly observed in the example program,
    'ten'.

    Target Library Linking:

    The program runs dynamically linked elf binaries, and when the subject
    program attempts to make a call to a standard library, the translator
    attempts to make an appropriate call to the native system libraries on
    the target machine.  This involves mangling between different calling
    conventions, etc.

    Automatic Endian Detection/Reversal:

    There are various problems raised when attempting to run little endian
    x86 code on a big endian chip, such as a PPC.  These problems are dealt
    with in a manner that is entirely transparent to the user.

    Configuration

    Warnings:

    By default the build script should compile the program with a set of
    switches such that while compiling the program it generates one error
    (which I feel is useful advice).  The program should generate no further
    compiler errors while it is running (yes, the program can generate
    compiler errors while it is running).  If you do not wish to see this
    error, or if the program generates any further error when compiled using
    your C compiler please remove the "warning=..." line from the build
    script.

    Optimization:

    The build script contains a "-O1" switch for the compiler.  Increasing
    the optimization level will make the program run *slower*, while
    compiling the program without any optimization will allow it to run
    *faster*.

    Obfuscation

    The most obvious part of the obfuscation is probably the mess of defines
    at the top.  This may seem a somewhat tired old obfuscation - however
    since many of these macros are (sometimes only) used by the program once
    it has dynamically recompiled itself, they are only referenced within
    the source code from within strings - and therefore the macros cannot be
    expanded.  Furthermore, some of these strings of code are not given as
    strings, but instead are wrapped up in macros that use the "#"
    preprocessor operator to turn them into strings. In the hope throwing a
    few C beautifiers the macro to generate the strings is not contained
    within the source code but instead is passed in on the command line.

    Buried under all this, and the fact that the entire program is just a
    call to exit, there are some nice subtle little obfuscations.  For
    example, you may notice that there are a couple of macros that use the
    "##" preprocessor operator to build pairs of functions.  One of these
    macros is used to build to pairs of functions of which only one has
    local variables which shadow global variables; so one modifies the
    global state, and the other doesn't.

    There is also quite a nice trick where I wave a magic wand, and a chunk
    of code which should only be run when the program is run for the first
    time (setting the PC to point at main, etc) gets turned into a
    frog^M^M^M^Mstring.  The C compiler sees a string by itself in the code,
    thinks "yup, thats a valid C expression", and quietly moves on to the
    next line of code.

    Limitations

    Due to space limitations only a handful of instructions are supported,
    those instructions which are supported may supported in somewhat
    non-conventional ways, chunks of the architecture (e.g. flags) are just
    ignored, the elf loader does not really load the elf binary, the target
    library linking can only pass up to 3 parameters to the target library
    function, etc, etc, etc.

    In short, please consider this a full disclaimer for any bug that may
    turn up - yes the program is unsafe, but it's pretty cool anyway.

    Despite all this, the translator is not exclusively limited to running
    the 'ten' program.  Other trivial x86 programs may run on the translator
    - and I have successfully run a wide range of HelloWorld programs,
    including one of last years IOCCC winners, 'tomx'.

    Complete Program

    The fact that the program makes calls to system and execv may imply that
    it is not a complete program in its own right, as it relies on other
    programs.  The call to system is a call to ask gcc to recompile the
    translator with a new set of switches, and the call to execv asks for
    the newly compiled program to be executed.  I would point out that
    almost every other entry to this competition also require a C compiler
    (well, the published winners at any rate, and I recognize that a few
    don't).  There is little real difference between this program and one
    like last years entry 'dhyang'; both are just C programs that generate C
    code as their output.

    Enjoy, thanks!
