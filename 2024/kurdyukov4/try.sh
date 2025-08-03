#!/usr/bin/env bash
#
# try.sh - demonstrate 2024/kurdyukov4

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program and the alt program have been built
#
MAKE=$(which gmake)
${MAKE:=make} CC="$CC" everything >/dev/null || exit 1

# clear the screen
#
clear

# view the program
#
read -r -n 1 -p 'Press any key to view prog.c: '
echo 1>&2
echo 1>&2
echo "cat prog.c" 1>&2
echo 1>&2
cat prog.c
echo 1>&2
ls -l prog.c
echo 1>&2

# compile the program
#
read -r -n 1 -p 'Press any key to compile prog.c: '
echo 1>&2
echo 1>&2
echo "${CC} -O3 prog.c -o prog"
"${CC}" -O3 prog.c -o prog
echo 1>&2

# get ready for try #0
#
read -r -n 1 -p '^^^^^ Press any key after viewing prog.c above ^^^^^: '
clear

# try the program #0
#
read -r -n 1 -p 'Press any key to run: echo "Hello, World!" | ./prog > test0.c: '
echo 1>&2
echo 1>&2
rm -f test0.c
echo "Hello, World! | ./prog > test0.c" 1>&2
echo "Hello, World!" | ./prog > test0.c
echo 1>&2

# view the result #0
#
read -r -n 1 -p 'Press any key to view test0.c: '
echo 1>&2
echo 1>&2
echo "cat test0.c" 1>&2
echo 1>&2
cat test0.c
echo 1>&2
ls -l test0.c
echo 1>&2

# compile and run result #0
#
read -r -n 1 -p 'Press any key to compile and run the result: '
echo 1>&2
echo 1>&2
rm -f test0
echo "${CC} -O3 test0.c -o test0; ./test0" 1>&2
"${CC}" -O3 test0.c -o test0
echo 1>&2
./test0
echo 1>&2

# get ready for try #1
#
read -r -n 1 -p '^^^^^ Press any key after viewing the results above ^^^^^: '
clear

# list files for #1
#
read -r -n 1 -p 'Press any key to run: ls: '
echo 1>&2
echo 1>&2
touch ./test1
# shellcheck disable=2012
ls | cat
echo 1>&2

# try the program #1
#
read -r -n 1 -p 'Press any key to run: ls | ./prog > test1.c: '
echo 1>&2
echo 1>&2
rm -f test1.c
echo "ls | ./prog > test1.c" 1>&2
# shellcheck disable=2012
ls | tee /dev/tty | ./prog > test1.c
echo 1>&2

# view the result #1
#
read -r -n 1 -p 'Press any key to view test1.c: '
echo 1>&2
echo 1>&2
echo "cat test1.c" 1>&2
echo 1>&2
cat test1.c
echo 1>&2
ls -l test1.c
echo 1>&2

# compile and run result #1
#
read -r -n 1 -p 'Press any key to compile and run the result: '
echo 1>&2
echo 1>&2
rm -f test1
echo "${CC} -O3 test1.c -o test1; ./test1" 1>&2
"${CC}" -O3 test1.c -o test1
echo 1>&2
./test1
echo 1>&2

# get ready for try #2
#
read -r -n 1 -p '^^^^^ Press any key after viewing the results above ^^^^^: '
clear

# try the program #2
#
read -r -n 1 -p "Press any key to run: ./prog < prog.c > test2.c: "
echo 1>&2
echo 1>&2
rm -f test2.c
echo "./prog < prog.c > test2.c" 1>&2
./prog < prog.c > test2.c
echo 1>&2

# view the result #2
#
read -r -n 1 -p 'Press any key to view the last 10000 characters of test2.c: '
echo 1>&2
echo 1>&2
echo ... 1>&2
tail -n 1 test2.c | rev | cut -c 1-10000 | rev
echo 1>&2
ls -l test2.c
echo 1>&2

# compile and run result #2
#
read -r -n 1 -p 'Press any key to compile and run the result: ' 1>&2
echo 1>&2
echo 1>&2
rm -f test2
echo "${CC} -O3 test2.c -o test2; ./test2" 1>&2
"${CC}" -O3 test2.c -o test2
echo 1>&2
rm -f test2.out
echo ./test2 '>' test2.out.c 1>&2
./test2 > test2.out.c
echo 1>&2

# verify the result #2
#
read -r -n 1 -p 'Press any key to compare prog.c and test2.out: ' 1>&2
echo 1>&2
echo 1>&2
if cmp prog.c test2.out.c; then
    echo 'prog.c and test2.out.c are the same!' 1>&2
else
    echo 'ERROR: test2.out.c is NOT the same as prog.c!' 1>&2
fi
echo 1>&2

# get ready for try #3
#
read -r -n 1 -p '^^^^^ Press any key after viewing the results above ^^^^^: '
clear

# generate 64K of random data for #3
#
read -r -n 1 -p 'Press any key to generate 64K of random data: ' 1>&2
echo 1>&2
echo 1>&2
rm -f random.bin
echo dd if=/dev/urandom bs=64K count=1 '>' random.bin
dd if=/dev/urandom bs=64K count=1 > random.bin
echo 1>&2

# verify the result #3
#
read -r -n 1 -p 'Press any key to ./prog < random.bin > test3.c: ' 1>&2
echo 1>&2
echo 1>&2
rm -f test3.c
echo ./prog '<' random.bin '>' test3.c
./prog < random.bin > test3.c
echo 1>&2

# view the result #3
#
read -r -n 1 -p 'Press any key to view the last 10000 characters of test3.c: '
echo 1>&2
echo 1>&2
echo ... 1>&2
tail -n 1 test3.c | rev | cut -c 1-10000 | rev
echo 1>&2
ls -l test3.c
echo 1>&2

# compile and run the result #3
#
read -r -n 1 -p 'Press any key to compile and run the result (this will take a bit of time to compile): ' 1>&2
echo 1>&2
echo 1>&2
rm -f test3
echo "time ${CC} -O3 test3.c -o test3; ./test3" 1>&2
time "${CC}" -O3 test3.c -o test3
echo 1>&2
rm -f test3.out
echo ./test3 '>' test3.out 1>&2
./test3 > test3.out
echo 1>&2

# verify the result #3
#
read -r -n 1 -p 'Press any key to compare random.bin and test3.out: ' 1>&2
echo 1>&2
echo 1>&2
if cmp random.bin test3.out; then
    echo 'random.bin and test3.out are the same!' 1>&2
else
    echo 'ERROR: random.bin is NOT the same as test3.out!' 1>&2
fi
echo 1>&2
