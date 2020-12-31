Best abuse of the C preprocessor:

    Immanuel Herrmann
    University of Freiburg, Germany
    Rehlingstr. 17
    79100 Freiburg
    Germany

    http://pcpool.mathematik.uni-freiburg.de/~immi/


Judges' Comments:

    To build:

        Running and building are combined for this entry.

    Try:
         ./herrmann1.sh 'prg=herrmann1.times2'
      -or-
         ./herrmann1.sh 'prg=herrmann1.gcd'

     There are some clear hints in the source code as to the
     purpose of this program.  Perhaps the only way to figure out what is
     going on is to look at the differences between the runs of the C
     preprocessor!  Computer Science students should recognize what is going
     on.


Selected Author's Comments:

    Many cool things have been done with the preprocessor,
    e. g. calculation of prime numbers or the tower of Hanoi. However,
    up to now, no one proved that the preprocessor is Turing complete,
    and I wondered why. Well, the answer is simply that the
    preprocessor is _not_ Turing complete, at least not if the program
    is preprocessed only once. This is true even if the program is
    allowed to include itself. (The reason being that for a given
    program, the preprocessor has only a finite number of states, plus
    a stack consisting of the places which the file has been included
    from. This is only a push-down automaton.)

    Well, this entry _is_ a Turing machine implemented in the
    preprocessor; so of course, it has to be preprocessed several
    times. Here are the main features:

    - Easy to program: Write your own Turing programs in a nice
      syntax.

    - Easy to debug: (some) errors in the Turing machine program will
      be reported nicely. (That's something which is not often seen in
      IOCCC programs.)

    - Ultra-fast: The resulting C program will print the output in
      time O(n), where n is the length of the output. This means for
      example that you can solve NP hard problems in polynomial time!
      ;-)

    - And best of all: During the preprocessing, watch the animated
      Turing machine running over the tape and doing its work in your
      terminal!



    How to use it
    =============

    For the impatient
    -----------------

    The info files "herrmann1.turing" and "herrmann1.gcd" are sample
    programs for the Turing machine. For example, type

      ./herrmann1.sh 'prg=herrmann1.times2'

    and watch the animated Turing machine multiply 8 by two (in
    unary representation). Here's a screen shot during compilation:

    /*
    *
    * State: st2.
    *
    * _ _ _ _ _ * _ _ _ _ _ _ _ _ _ _ _ _ _
    * ... O O I I I I I O I I I I I O O ...
    * ~ ~ ~ ~ ~ * ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    *
    *
    */

    (As on real videos, you'll see a bit of "white noise" at the
    beginning and at the end.;-) After compilation has terminated,
    type ./prog to see the final result. The output will be

      Final tape:

                          *
      ..OOIIIIIIIIIIIIIIIIOOOO..
                          *

    (Note that the last frame of the animation is _not_ the final
    result.)


    In the previous example, the Turing machine started on the default
    tape of the program "times2.turing". To provide your own tape, type
    (for example)

      ./build prg=times2.turing tape="O O O I I I O O O"

    (The O's and I's are letters, not digits.) You might prefer to
    provide only a finite portion of the tape, like I did above. In
    this case, the remainder of the tape is filled with O's. ;-)

    If you just type
      ./build
    and run the program, you'll get a usage message (and the return
    code will be 2).

    Note: To get a really nice animation, you'll need a terminal which
    is able to scroll fast enough. (xterm is not very good. The
    kde terminal "konsole" or the text console under linux are much
    better. Simply try some out.)



    Writing your own programs
    -------------------------

    Now, let's assume you want to write a program which adds 1 to a
    number in unary representation. (That is, a row of I's is
    expected, and one more I is appended to the row.) Let's call it
    "plus1.turing". Here's what it could look like:

      /* Search beginning of number. */
      #define start_O O, right, start
      /* Number found. Move one step to the left. */
      #define start_I I, left, st2
      /* Write a I and stop */
      #define st2_O   I, left, stop

    Some explanations:
    - The tape alphabet is always O and I.
    - The states can be anything starting with "st". "start" and
      "stop" are the start and stop states, respectively.
    - to define a state, use two lines: one for each letter on the
      tape. You may omit one of the lines if the Turing machine will
      never enter the state reading that letter. (In the example, the
      line defining st2_I has been left out.)
    - The order of the lines is irrelevant.
    - You may use c-style comments. (Would you have guessed it?)

    Now, the program can be used with

      ./herrmann1.sh 'prg=plus1.turing' 'tape="I I I"'

    But what happens if no tape is provided? Up to now, the Turing
    machine would start on an empty tape (that is, a tape filled with
    O's). For many programs, this doesn't make much sense (as is
    the case for "plus1.turing"). So you might want to provide a
    default tape by adding a line like

      #define tape O O O O O I I I I

    to your program.



    Debugging
    ---------

    When writing long programs, the most common errors are to forget
    to define a state or to misspell one. Let's assume you forgot the
    line

      #define start_I I, left, st2

    Remove it and type

      ./herrmann1 'prg=plus1.turing'

    The output will be

      Undefined state start.

      Tape:

                *
      ..OOOOOOOOIIIIOO..
                *

    and the return code will be 1. As you can see, the Turing machine
    moved over the O's, but when it arrived at the I (still in state
    start), the error occurred.

    Note that other kinds of errors can cause compilation to fail.
    If this happens, the build script will write the error message of
    gcc into a file called "error" and then exit.




    What the build script does
    ==========================

    In principle, the build script simply runs the preprocessor over
    and over again, until nothing changes anymore; then, the program
    is compiled. After each preprocessing step, the script outputs the
    beginning of the program; this is where the animation takes place
    (except in the first and last few steps).

    However, there's a technical problem to overcome: Some compilers
    (including gcc) insert a lot of white space during the
    preprocessing. This is bad for two reasons. First, the animated
    picture won't look right. And second, after some time, the file
    will grow too big for your hard disk. (The amount of white space
    grows exponentially.) So after each preprocessing, the first thing
    the build script does is remove all the unnecessary white space
    using sed.

    (gcc would even insert #line directives if I didn't suppress
    them with the -P option.)


    Some more details
    -----------------

    - The arguments passed to the build script are passed on to gcc
      with a "-D" before. I had a slight technical problem doing this
      (especially with the spaces that can appear within the tape
      argument). That made the build script a bit longer.

    - It would be enough to pass the defines in the first
      preprocessing. The program then "remembers" them. However, it
      doesn't matter if they are passed in all preprocessings. (This
      doesn't sound very impressive, but it has required some extra
      lines of code.)

    - During the preprocessing, intermediate files "herrmann1-1.c" and
      "herrmann1-2.c" are generated.

    - Also, a file "error" is generated. This file is removed after
      the compilation, except if gcc produced an error; then it contains
      the error message. (I can't let gcc output all its messages
      directly, because the warnings would clobber the animation. I
      could have made the compile script output the error file in case
      of an error, but I didn't want to make it yet longer.)




    Some technical details / obfuscations
    ====================================

    - The program is compressed. In the first three preprocessing
      passes, it uncompresses itself and initializes the
      "variables". So if you want to understand how it works, the best
      thing is to preprocess it three times and then look at it
      again. (However, I wouldn't have wasted three passes if they
      weren't needed anyway to initialize the tape in certain
      cases. Find out why.)

    - The first problem I had to solve when writing this program was
      to write a preprocessor program which outputs itself. Of course,
      each program which doesn't contain any preprocessor directives
      is such a program, but that's not what I needed. In fact, to do
      this, the program has to include itself, but even then, it's not
      easy.

    - The next problem to solve was how to pass results of a
      calculation of one preprocessing to the next one. This is done
      by outputting #defines with the result. But there's a problem
      with this: it is impossible to output a "#define result xxx",
      where xxx depends on the previous value of result. Try it if you
      don't believe it. And find out what I did instead.

    - What's a useful way to store information, especially the content
      of the tape? Of course, a "#define tape OOIOOIOIIIIO" contains
      the information, but then, how do you access the information?
      (For example, you won't be able to write preprocessor code which
      replaces the first O by I.) My answer looks very much like the
      way a stack would have been implemented in lambda calculus. (The
      tape is implemented as two stacks, to be exact.) And still,
      there were some technical problems to solve. Look at the program
      for more details.

    - There are many other interesting things to look at, e.g. the way
      to access the information in the user-provided program, the way
      a non-defined state is detected, the way the picture is
      produced, etc.  If you want a real challenge, try to understand
      what the line "w j k(P ## x)" does.

    - Due to the fact that our alphabet has only 53 ;-) letters, I had
      to use many variables more than once.

    - I couldn't refrain from doing a little bit of nasty stuff like

        #define a 0&0
        #if !a

      Of course, it is a bit more subtle, and even useful.

    - The layout of the source code..., well, let's call it the
      "modern art of programming" - a mixture of program-like
      indenting and modern art. There are even some comments...




    Compatibility
    =============

    - It works with many versions of gcc. I tested it with versions
      2.7.2.1, 2.8.1, 2.95.2, and ecgs-2.91.66. However, an old version
      of gcc produced "internal compiler errors" (obviously not my
      fault).

    - The only warnings I get tell me that I'm undefining __FILE__ and
      that preprocessing directives are not recognized within macro
      args. My answer to this is "yes, I know this and it's all
      right". With "-Wall", I also get some warnings about "/*"
      inside comments (Well, _I_ like some well-placed "/*/*/".) as
      well as some suggestions where to place some more parentheses
      (as if I didn't know the operator precedence).

    - Different versions of cc all produced only rubbish. Apparently,
      the preprocessors didn't really work. (I don't feel guilty
      there, either. Even with very simple programs, they produced
      mysterious output.)

    - For Mac-Users: It works with the C compiler of Codewarrior (an
      old version). This compiler even leaves out all that unnecessary
      white space, so that no clean-up is needed. (It would be useful
      to write a kind of script which does the equivalent to the build
      script, so that one does not have to choose "preprocess" from
      the menu over and over again. I leave this as an exercise to the
      experienced Mac programmer.)

    - In the build script, I passed the -P option to gcc to suppress
      the insertion of #line directives. If your compiler doesn't
      support this option (and does insert #line directives), you
      should change the call to sed to remove them, too: Add

        -e "/^#line/ d"

      to the sed parameters. Or, if your #line directives look like

        # 15 "filename"

      add

        -e "/^# [0-9]/ d"

      instead.

    - First, I had "-ansi -pedantic" turned on, but on some systems,
      the stdio.h is not compatible to that, so I turned it back off.

    - The build script probably needs a bash to run in. So perhaps you
      have to add "#!/bin/bash" or something like this at the
      beginning.

    - On SunOS, I had to remove the "-q" option from diff in the build
      script.
