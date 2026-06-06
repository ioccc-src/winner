#!/usr/bin/env bash
#
# try_examples.sh - run example Fortran punchcard decks through the interpreter

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program and convert tool have been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" all convert >/dev/null || exit 1

# clear the screen
#
clear

echo "This script runs example Fortran punchcard decks through the interpreter." 1>&2
echo "Each deck was punched from a short Fortran program. The convert tool" 1>&2
echo "decodes the punchcard deck back to Fortran source for viewing." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to start: "
echo 1>&2
echo 1>&2

# primes - find primes up to 100 by trial division
#
echo "Example: primes.deck - find primes up to 100 by trial division" 1>&2
echo 1>&2
./convert -d < examples/primes.deck
echo 1>&2
echo "View the Fortran source (decoded from punchcards) above." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog < examples/primes.deck: "
echo 1>&2
echo 1>&2
./prog < examples/primes.deck
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

# logical - logical operators .AND. and .OR.
#
echo "Example: test-logical.deck - logical .AND. and .OR. operators" 1>&2
echo 1>&2
./convert -d < examples/test-logical.deck
echo 1>&2
echo "View the Fortran source (decoded from punchcards) above." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog < examples/test-logical.deck: "
echo 1>&2
echo 1>&2
./prog < examples/test-logical.deck
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

# test-precedence - operator precedence
#
echo "Example: test-precedence.deck - operator precedence (including Fortran's unary minus)" 1>&2
echo 1>&2
./convert -d < examples/test-precedence.deck
echo 1>&2
echo "View the Fortran source (decoded from punchcards) above." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog < examples/test-precedence.deck: "
echo 1>&2
echo 1>&2
./prog < examples/test-precedence.deck
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

# test-stdlib-all - all standard library functions
#
echo "Example: test-stdlib-all.deck - standard library (SIN, COS, ABS, AMOD, ALOG, INT, CMPLX, REAL, AIMAG, CABS)" 1>&2
echo 1>&2
./convert -d < examples/test-stdlib-all.deck
echo 1>&2
echo "View the Fortran source (decoded from punchcards) above." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog < examples/test-stdlib-all.deck: "
echo 1>&2
echo 1>&2
./prog < examples/test-stdlib-all.deck
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

# test-format-all - all FORMAT specifiers
#
echo "Example: test-format-all.deck - FORMAT specifiers (In, Fn.m, nX, Hollerith)" 1>&2
echo 1>&2
./convert -d < examples/test-format-all.deck
echo 1>&2
echo "View the Fortran source (decoded from punchcards) above." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog < examples/test-format-all.deck: "
echo 1>&2
echo 1>&2
./prog < examples/test-format-all.deck
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

# test-control-all - comprehensive control flow
#
echo "Example: test-control-all.deck - control flow (GOTO, IF, DO, ASSIGN TO, extended range)" 1>&2
echo 1>&2
./convert -d < examples/test-control-all.deck
echo 1>&2
echo "View the Fortran source (decoded from punchcards) above." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog < examples/test-control-all.deck: "
echo 1>&2
echo 1>&2
./prog < examples/test-control-all.deck
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

# test-quirks - Fortran quirks
#
echo "Example: test-quirks.deck - Fortran quirks (whitespace independence, 3-char var names, col 72, etc.)" 1>&2
echo 1>&2
./convert -d < examples/test-quirks.deck
echo 1>&2
echo "View the Fortran source (decoded from punchcards) above." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog < examples/test-quirks.deck: "
echo 1>&2
echo 1>&2
./prog < examples/test-quirks.deck
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2


# lunar - Earth-to-Moon orbital dynamics simulation
#
echo "Example: lunar.deck - Earth-to-Moon transfer orbit + lunar orbit insertion" 1>&2
echo 1>&2
./convert -d < examples/lunar.deck
echo 1>&2
echo "View the Fortran source (decoded from punchcards) above." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog < examples/lunar.deck: "
echo 1>&2
echo 1>&2
./prog < examples/lunar.deck
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

# mandelbrot - render Mandelbrot set to PPM image
#
echo "Example: mandelbrot.deck - render Mandelbrot set to PPM image (640x384)" 1>&2
echo 1>&2
./convert -d < examples/mandelbrot.deck
echo 1>&2
echo "View the Fortran source (decoded from punchcards) above." 1>&2
echo 1>&2
echo "This might take 5 - 10 seconds to complete: " 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: time ./prog < examples/mandelbrot.deck > mandelbrot.ppm: "
echo 1>&2
rm -f mandelbrot.ppm
time ./prog < examples/mandelbrot.deck > mandelbrot.ppm
echo 1>&2
echo "You may wish to view: mandelbrot.ppm" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

# march - SDF ray marcher rendering IOCCC in 3D
#
echo "Example: march.deck - SDF ray marcher rendering IOCCC in 3D letters (720x360)" 1>&2
echo 1>&2
./convert -d < examples/march.deck
echo 1>&2
echo "Fortran source (decoded from punchcards) above." 1>&2
echo 1>&2
echo "This might take 1 - 2 minutes to complete: " 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: time ./prog < examples/march.deck > march.ppm: "
echo 1>&2
rm -f march.ppm
time ./prog < examples/march.deck > march.ppm
echo 1>&2
echo "You may wish to view: march.ppm" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

# tracer - black hole ray tracer (unobfuscated version)
#
echo "Example: tracer.deck - black hole ray tracer (readable Fortran version)" 1>&2
echo 1>&2
./convert -d < examples/tracer.deck
echo 1>&2
echo "View the Fortran source (decoded from punchcards) above."
echo 1>&2
echo "This might take 8 - 16 minutes to complete: " 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: time ./prog < examples/tracer.deck > tracer.pgm: "
echo 1>&2
rm -f tracer.pgm
time ./prog < examples/tracer.deck > tracer.pgm
echo 1>&2
echo "You may wish to view: tracer.pgm" 1>&2
echo 1>&2
