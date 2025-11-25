#!/usr/bin/env bash
#
# try.alt.sh - demonstrate alternate YYYY/XXX    <<=== The IOCCC Judges will replace this line

# XXX - NOTE: please remove all "XXX - ... - XXX" lines, including this one - XXX
# XXX -                                                                     - XXX
# XXX - try.alt.sh example version: 29.0.0 2025-11-24                       - XXX

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
# XXX - if you need CC to be something else, say clang, then change cc      - XXX
# XXX - to whatever you need.                                               - XXX
# XXX - If you need other variables you can also set them in whatever way   - XXX
# XXX - you need; this is a good method, however, in cases where it's OK    - XXX
# XXX - to let the user redefine it.                                        - XXX
# XXX -                                                                     - XXX
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
# XXX - make sure to compile the program, using make all!                   - XXX
# XXX - if you need to build the alt code for the try.sh script,            - XXX
# XXX - then change the 'all' to 'all alt' in the below command.            - XXX
# XXX - Later, if the submission wins, it can be changed to 'everything'.   - XXX
# XXX -                                                                     - XXX
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" alt >/dev/null || exit 1

# clear the screen
#
clear

# XXX - NOTE: You can include more than one command line, including pipes.  - XXX
# XXX -                                                                     - XXX
# XXX - It is good to use the shell built-in read(1) to let the user know   - XXX
# XXX - what is about to be executed.  We suggest a double echo after the   - XXX
# XXX - use of the shell built-in read(1) to help separate the prompt from  - XXX
# XXX - any output your code may produce.  We also suggest an echo after    - XXX
# XXX - any execution to help separate any output from the next prompt or   - XXX
# XXX - from the end of the script.                                         - XXX
# XXX -                                                                     - XXX
# XXX - We recommend sending echo's (both empty lines and messages) to      - XXX
# XXX - stderr as this makes it easier to separate script output (stderr)   - XXX
# XXX - from any stdout of your program.  However, do NOT send the shell    - XXX
# XXX - built-in read(1) to stderr.                                         - XXX
# XXX -                                                                     - XXX
# XXX - You may modify the command based on your program and you may have   - XXX
# XXX - more than one invocation.                                           - XXX
# XXX -                                                                     - XXX
# XXX - Examples follow.                                                    - XXX
# XXX -                                                                     - XXX
# XXX - For more examples, see the try.sh scripts under the 2024 directory. - XXX
# XXX -                                                                     - XXX
# XXX - Remove/expand sections as needed: these are just examples.          - XXX

# try the program
#
read -r -n 1 -p "Press any key to run: ./prog.alt: "
echo 1>&2
echo 1>&2
./prog.alt
echo 1>&2

# try the program with args
#
# XXX - Notice that the echo below is also sent to stderr, and there is an  - XXX
# XXX - empty echo written to stderr before the shell built-in read(1) call - XXX
# XXX -                                                                     - XXX
echo 'Let us try another example.  Observe the line count of output and the last line of data!' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: date | ./prog.alt some command line | LANG=C sort > data: "
echo 1>&2
echo 1>&2
rm -f data
date | ./prog.alt some command line | LANG=C sort > data
wc -l < data
tail -n 1 data
echo 1>&2
