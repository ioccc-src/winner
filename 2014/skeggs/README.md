# Most dynamic

Cel Skeggs  
<ioccc@celskeggs.com>  
<http://www.celskeggs.com>  


## Judges' comments:
### To build:

    make

### To run:

    ./prog

### Try:

    ./prog

HINT: Try pressing the left and right arrow keys as needed.
Also try pressing space/enter to select options.
Pressing Q or Escape may end the fun before you are ready. :-)

### Selected Judges Remarks:

When the code looks like lemons, it is probably because the LEMONPEOPLE,
or at least the LEMONLORD was involved. :-)

Look at some of the C pre-processor macros in the source code.
Ask yourself why C source is being passed as arguments to some
of those macros.

Now you may observe, while it is running, that some C source code
is being written to a file and then compiled.  And yet that compiled
code is somehow executed from main.  But how?  How is main able to
call code that was written and compiled just in time for execution?

## Author's comments:
### TABLE OF CONTENTS

 * Backstory
 * Known compiler warnings
 * Obfuscation
 * Troubleshooting guide (IMPORTANT!)
 * Q&A

### BACKSTORY

It was ten yours ago when THE LEMONPEOPLE invaded, juicing all in their path.

Attempting to free the Earth from their tyranny, you have endured pulpy and
sour battles.

This has now culminated in you reaching the throne room of THE LEMONLORD.

Armed with your right-facing curly brace, you charge into battle.

(Use left and right arrow keys and space/enter to select options. Press Q or
Escape to quit.)

### KNOWN COMPILER WARNINGS

Unfortunately, it became very difficult to get this entry to fit within the
size requirements. It's currently at 2052 according to iocccsize, and 3994
according to wc -c.

The current size is a third to a half of the original size before compression.

Due to this, it does LOTS of things that subtly annoy compilers!

 * (10) data argument not used by format string

   This occurs because some of the fprintf invocations don't use all their
   parameters. The program should still work fine!

 * (1) using the result of an assignment as a condition without parentheses

   Somewhere, I needed to set a variable and then branch on the result. The
   shortest way was to combine them. Some self-proclaimed "EXPERTS" think this
   is a bad programming practice, but what do they know? :P

 * (1) implicit declaration of function 'time' is invalid in C99

   An `#include` statement is expensive, and I'm broke.

 * (1) control may reach end of non-void function

   Turns out that sometimes, a return statement is too much. This will never
   actually occur, but some C compilers think they know more about my program
   than I do! :P

 * (?) Under some systems, `-fPIC` is irrelevant for shared libraries. If so,
   you should remove it from the Makefile.

## OBFUSCATION? WHAT OBFUSCATION? THIS IS A PERFECTLY NORMAL C PROGRAM!

# THE COOL PART

Take a close look at how it works. Notice that it's passing C code to certain
macros...

Guess what? It's a very simple kind of JIT compiler, though not used as deeply
as would be cool.

Essentially, it generates C code at runtime, dumps it to a file, and then runs
a C compiler on that file, telling the C compiler to generate a shared library.
Then it loads the shared library with dlopen, and...

Ignores the result?

That can't be right.

Well, it is. Instead of using dlsym like a normal programmer, I mark one of the
generated functions with `__attribute__((constructor))`. This means that it
gets called immediately on load, so it can make its functions available.

But wait - how can it link into the main program, either? It has no way to
reference anything in the main executable!

But it does: I'm injecting certain addresses into the generated code, which it
then casts to pointers and accesses! It uses this to make certain functions
available to the main program, so the main program's generated code will then
enter itself where it's needed.

# THE NOT-SO-COOL PART

There are also lots of `#defines`.

No, these are not obfuscation. These are compression.

There is a little bit of obfuscation gained from using the stringification
operator. (I can never remember what it's actually called, but it's the #
operator in a preprocessor macro) - this allows me to pass C code in arguments
to the macros, meaning that it gets interpreted as C code instead of a string
by the iocccsize tool, so it gets counted as smaller! :D

# A SLIGHTLY COOL PART

As part of the JIT compiling, the program hides the fact that it needs ncurses:
it just links ncurses with one of the generated shared libraries, and then can
access the contents of the ncurses library!

# WAIT WHAT

Also, note where functions start and end...

I've messed with the syntax so that it's not actually formatted properly. It
almost looks like it is, but it isn't.

This isn't significant obfuscation as long as you run it through a C source
code beautifier.

But wait... if you aren't careful, running it through a C source code
beautifier won't work. Remember how I'm interlacing generated C code with
actual C code? Note that this WRECKS some beautifiers. I hope you have a good
one!

(There's an obvious way around this but I'm not going to spell it out for you.
That'd be too easy!)

### MISCELLANEOUS STUFF

Do note that there are some other miscellaneous obfuscations, but they should
be easy to understand once you figure out the ones above.

### TROUBLESHOOTING GUIDE

This program is a very easy program to cause to fail!

Some things to check

 * On line 16, where it says `%cinclude "prog.c"`, is `prog.c` the name of the
   original source code file?
 * Do you have ncurses installed?
 * Does your system have `ncurses.h` (like a nice system) or
   `ncurses/ncurses.h` (like a rude system) ?

   If it's the latter (or some other path), you'll need to update line 97.

   (I had to do this under Cygwin.)
 * Does your system need `-fPIC` (or other arcane invocations) to compile a
   shared library? If so, make sure that you include it in the -DCC argument in
   the build script.
 * Does your system have a vague dislike for `-fPIC`? (Like Cygwin.) You might
   need to remove it from the build script.
 * Does your system support `__attribute__((constructor))`? It needs to.
 * Check the file `err`. Maybe it will help you figure out why a runtime-
   generated program failed. The failing program should be found in `t.c`.
 * Can't run a beautifier on the source code? I'm not going to help you there.

I've tested it on the following platforms, in case you need to try it on one:

 * 64-bit Windows 7 32-bit Cygwin with gcc 4.8.2 and standards c89, c90, c99,
   and c11. Note that the program ran as 32-bit due to the version of cygwin.
 * 64-bit Arch Linux with gcc 4.9.1 and standards c89, c90, c99, c11.
 * 64-bit Arch Linux with clang 3.5.0 and standards c89 and c11.

I ran out of time to test it on more systems.

### Q&A

 * Who am I?

   Yes.

 * Why doesn't your program require a pet fish license?

   THE LEMONLORD's pet LEMONFISH was not rendered in the game, and so does not
   require a pet fish license.

 * Was this inspired by anything?

   Yes, this was inspired by a minigame from an open-source codebase of Space
   Station 13. I didn't, however, look at the minigame at all during the
   development of this entry.

 * What's the length of this REMARKS file according to the iocccsize tool?

   `$ ./iocccsize -i <REMARKS.MD`

   `5092`

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
