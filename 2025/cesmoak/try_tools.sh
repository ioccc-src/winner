#!/usr/bin/env bash
#
# try_tools.sh - demonstrate the convert, interpret, and contour tools

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program and tools have been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" all tools >/dev/null || exit 1

# clear the screen
#
clear

echo "This script demonstrates the convert, interpret, and contour tools." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

# convert: deck to Fortran source
#
echo "=== convert: decode a punch card deck to Fortran source ===" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./convert -d < examples/primes.deck: "
echo 1>&2
echo 1>&2
./convert -d < examples/primes.deck
echo 1>&2
echo "View the Fortran source (decoded from punchcards) above." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

# round-trip: verify deck -> f -> deck produces equivalent results
#
echo "=== round-trip: verify deck -> Fortran -> deck ===" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./convert -d < examples/primes.deck > examples/primes_rt.f: "
echo 1>&2
echo 1>&2
rm -f examples/primes_rt.f
./convert -d < examples/primes.deck > examples/primes_rt.f
read -r -n 1 -p "Press any key to run: ./convert -f < examples/primes_rt.f > examples/primes_rt.deck: "
echo 1>&2
echo 1>&2
rm -f examples/primes_rt.deck
./convert -f < examples/primes_rt.f > examples/primes_rt.deck
read -r -n 1 -p "Press any key to run: diff examples/primes.deck examples/primes_rt.deck: "
echo 1>&2
echo 1>&2
if diff examples/primes.deck examples/primes_rt.deck > /dev/null 2>&1; then
    echo "No differences found -- round-trip works as expected." 1>&2
else
    echo "ERROR: Differences found." 1>&2
fi
echo 1>&2

# convert: Fortran source to deck with text annotation
#
echo "=== convert: encode with text annotation (-t) ===" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./convert -d < examples/tracer.deck > examples/tracer_rt.f: "
echo 1>&2
echo 1>&2
rm -f examples/tracer_rt.f
./convert -d < examples/tracer.deck > examples/tracer_rt.f
read -r -n 1 -p "Press any key to run: ./convert -f -t < examples/tracer_rt.f | head -34: "
echo 1>&2
echo 1>&2
./convert -f -t < examples/tracer_rt.f | head -34
echo 1>&2
echo "View the Fortran source punchcards above." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

# interpret: annotate a deck with source text
#
echo "=== interpret: annotate punch cards with decoded source text ===" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./interpret < examples/primes.deck | head -34: "
echo 1>&2
echo 1>&2
./interpret < examples/primes.deck | head -34
echo 1>&2
echo "View the Fortran source punchcards above." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

# contour: render contour image from flux data
#
echo "=== contour: render a contour image from flux data ===" 1>&2
echo 1>&2
echo "First, generate flux data at a small resolution: This might take 8 - 16 minutes to complete: " 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: time ./prog 160 < prog.c | ./prog > examples/flux_160.data: "
echo 1>&2
rm -f examples/flux_160.data
time ./prog 160 < prog.c | ./prog > examples/flux_160.data
echo 1>&2
read -r -n 1 -p "Press any key to run: ./contour < examples/flux_160.data > examples/contour_160x80.pgm: "
echo 1>&2
rm -f examples/contour_160x80.pgm
./contour < examples/flux_160.data > examples/contour_160x80.pgm
echo 1>&2
echo "Written to examples/contour_160x80.pgm -- compare with Fig 10 of Luminet's 1979 paper."
echo 1>&2
echo "You may wish to view: examples/contour_160x80.pgm" 1>&2
echo 1>&2
