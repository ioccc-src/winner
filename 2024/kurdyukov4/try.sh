#!/usr/bin/env bash
#
# try.sh - demonstrate 2024/kurdyukov4

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program and the alt program have been built
#
MAKE=$(command -v gmake)
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
echo "time ${CC} -O3 prog.c -o prog -lm"
time "${CC}" -O3 prog.c -o prog -lm
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
read -r -n 1 -p 'Press any key to compile and run: '
echo 1>&2
echo 1>&2
rm -f test0
echo "time ${CC} -O3 test0.c -o test0" 1>&2
time "${CC}" -O3 test0.c -o test0
status="$?"
if [[ $status -ne 0 || ! -x test0 ]]; then
    echo 1>&2
    echo "ERROR: time ${CC} -O3 test0.c -o test0 error: $status" 1>&2
    exit 2
fi
echo 1>&2
echo './test0' 1>&2
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
read -r -n 1 -p 'Press any key to compile and run: '
echo 1>&2
echo 1>&2
rm -f test1
echo "time ${CC} -O3 test1.c -o test1" 1>&2
time "${CC}" -O3 test1.c -o test1
status="$?"
if [[ $status -ne 0 || ! -x test1 ]]; then
    echo 1>&2
    echo "ERROR: time ${CC} -O3 test1.c -o test1 error: $status" 1>&2
    exit 3
fi
echo 1>&2
echo './test1' 1>&2
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
read -r -n 1 -p 'Press any key to compile and run: ' 1>&2
echo 1>&2
echo 1>&2
rm -f test2
echo "time ${CC} -O3 test2.c -o test2" 1>&2
time "${CC}" -O3 test2.c -o test2
status="$?"
if [[ $status -ne 0 || ! -x test2 ]]; then
    echo 1>&2
    echo "ERROR: time ${CC} -O3 test2.c -o test2 error: $status" 1>&2
    exit 4
fi
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
    echo 'PASS: prog.c and test2.out.c are the same' 1>&2
else
    echo 'ERROR: test2.out.c is NOT the same as prog.c !!!' 1>&2
    exit 5
fi
echo 1>&2

# get ready for try #3
#
read -r -n 1 -p '^^^^^ Press any key after viewing the results above ^^^^^: '
clear

# generate 64K of random data for #3
#
read -r -n 1 -p 'Press any key to generate 64K bytes of random data: ' 1>&2
echo 1>&2
echo 1>&2
rm -f random.64K.bin
echo 'dd if=/dev/urandom bs=64K count=1 of=random.64K.bin' 1>&2
dd if=/dev/urandom bs=64K count=1 of=random.64K.bin
echo 1>&2

# verify the result #3
#
read -r -n 1 -p 'Press any key to ./prog < random.64K.bin > test3.c: ' 1>&2
echo 1>&2
echo 1>&2
rm -f test3.c
echo ./prog '<' random.64K.bin '>' test3.c
./prog < random.64K.bin > test3.c
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

# compile and run #3
#
echo 'NOTICE: Compiling and running the 64K byte random input data test' 1>&2
echo 1>&2
echo 'NOTICE: Because test3.c can take so long to compile, we will compile without optimization.' 1>&2
echo 1>&2
echo 'NOTICE: clang might take about 10 seconds to compile' 1>&2
echo 'NOTICE: gcc   might take about 75 seconds to compile' 1>&2
echo 1>&2
read -r -n 1 -p 'Press any key to compile and run: ' 1>&2
echo 1>&2
echo 1>&2
rm -f test3
echo "time ${CC} -O0 test3.c -o test3" 1>&2
time "${CC}" -O0 test3.c -o test3
status="$?"
if [[ $status -ne 0 || ! -x test3 ]]; then
    echo 1>&2
    echo "ERROR: time ${CC} -O0 test3.c -o test3 error: $status" 1>&2
    exit 6
fi
echo 1>&2
rm -f test3.out
echo ./test3 '>' test3.out 1>&2
./test3 > test3.out
status="$?"
if [[ $status -ne 0 ]]; then
    echo 1>&2
    echo "ERROR: ./test3 > test3.out error: $status" 1>&2
    exit 7
fi
echo 1>&2

# verify the result #3
#
read -r -n 1 -p 'Press any key to compare random.64K.bin and test3.out: ' 1>&2
echo 1>&2
echo 1>&2
if cmp random.64K.bin test3.out; then
    echo 'PASS: random.64K.bin and test3.out are the same' 1>&2
else
    echo 'ERROR: random.64K.bin is NOT the same as test3.out !!!' 1>&2
    exit 8
fi
echo 1>&2

# get ready for try #4
#
read -r -n 1 -p '^^^^^ Press any key after viewing the results above ^^^^^: '
clear

# generate 1M of random data for #4
#
read -r -n 1 -p 'Press any key to generate 1M bytes of random data: ' 1>&2
echo 1>&2
echo 1>&2
rm -f random.1M.bin
echo 'dd if=/dev/urandom bs=64K count=16 of=random.1M.bin' 1>&2
dd if=/dev/urandom bs=64K count=16 of=random.1M.bin
echo 1>&2

# verify the result #4
#
read -r -n 1 -p 'Press any key to ./prog < random.1M.bin > test4.c: ' 1>&2
echo 1>&2
echo 1>&2
rm -f test4.c
echo ./prog '<' random.1M.bin '>' test4.c
./prog < random.1M.bin > test4.c
echo 1>&2

# view the result #4
#
read -r -n 1 -p 'Press any key to view the last 10000 characters of test4.c: '
echo 1>&2
echo 1>&2
echo ... 1>&2
tail -n 1 test4.c | rev | cut -c 1-10000 | rev
echo 1>&2
ls -l test4.c
echo 1>&2

# compile and run #4
#
echo 'NOTICE: Compiling and running the 1M byte random input data test' 1>&2
echo 1>&2
echo 'NOTICE: Because test4.c can take so long to compile, we will compile without optimization.' 1>&2
echo 1>&2
echo 'NOTICE: clang might take about 80 seconds to compile' 1>&2
echo 'NOTICE: gcc   might take about 1 hour 15 minutes to compile !!!' 1>&2
echo 1>&2
read -r -n 1 -p 'Press any key to compile and run: ' 1>&2
echo 1>&2
echo 1>&2
rm -f test4.o
echo "time ${CC} -O0 test4.c -o test4" 1>&2
time "${CC}" -O0 test4.c -o test4
status="$?"
if [[ $status -ne 0 || ! -x test4 ]]; then
    echo 1>&2
    echo 'NOTICE: This is not a code bug, this is a compiler mis-feature !!!' 1>&2
    echo 1>&2
    echo "ERROR: time ${CC} -O0 test4.c -o test4 error: $status" 1>&2
    exit 9
fi
echo 1>&2
rm -f test4.out
echo ./test4 '>' test4.out 1>&2
./test4 > test4.out
status="$?"
if [[ $status -ne 0 ]]; then
    echo 1>&2
    echo 'NOTICE: This is not a code bug, this is a linker and/or architecture limitation !!!' 1>&2
    echo 1>&2
    echo "ERROR: ./test4 > test4.out error: $status" 1>&2
    exit 10
fi
echo 1>&2

# verify the result #4
#
read -r -n 1 -p 'Press any key to compare random.1M.bin and test4.out: ' 1>&2
echo 1>&2
echo 1>&2
if cmp random.1M.bin test4.out; then
    echo 'PASS: random.1M.bin and test4.out are the same' 1>&2
else
    echo 'ERROR: random.1M.bin is NOT the same as test4.out !!!' 1>&2
    exit 11
fi
echo 1>&2

# get ready for try #5
#
read -r -n 1 -p '^^^^^ Press any key after viewing the results above ^^^^^: '
clear

# generate 4M of random data for #5
#
read -r -n 1 -p 'Press any key to generate 4M bytes of random data: ' 1>&2
echo 1>&2
echo 1>&2
rm -f random.4M.bin
echo 'dd if=/dev/urandom bs=64K count=64 of=random.4M.bin' 1>&2
dd if=/dev/urandom bs=64K count=64 of=random.4M.bin
echo 1>&2

# verify the result #5
#
read -r -n 1 -p 'Press any key to ./prog < random.4M.bin > test5.c: ' 1>&2
echo 1>&2
echo 1>&2
rm -f test5.c
echo ./prog '<' random.4M.bin '>' test5.c
./prog < random.4M.bin > test5.c
echo 1>&2

# view the result #5
#
read -r -n 1 -p 'Press any key to view the last 10000 characters of test5.c: '
echo 1>&2
echo 1>&2
echo ... 1>&2
tail -n 1 test5.c | rev | cut -c 1-10000 | rev
echo 1>&2
ls -l test5.c
echo 1>&2

# compile and run #5
#
echo 'NOTICE: Compiling and running the 4M byte random input data test' 1>&2
echo 1>&2
echo 'NOTICE: Because test5.c can take so long to compile, we will compile without optimization.' 1>&2
echo 1>&2
echo 'NOTICE: clang might take about 1 minute 50 seconds to compile' 1>&2
echo 'NOTICE: gcc   might take about 14 hours !!!' 1>&2
echo 1>&2
echo 'WARNING: Some buggy compilers may crash, especially in resource limited environments, while compiling test5.c !!!' 1>&2
echo 1>&2
read -r -n 1 -p 'Press any key to compile and run: ' 1>&2
echo 1>&2
echo 1>&2
rm -f test5
echo "time ${CC} -O0 test5.c -o test5" 1>&2
time "${CC}" -O0 test5.c -o test5
status="$?"
if [[ $status -ne 0 || ! -x test5 ]]; then
    echo 1>&2
    echo 'NOTICE: This is not a code bug, this is a compiler mis-feature !!!' 1>&2
    echo 1>&2
    echo "ERROR: time ${CC} -O0 test5.c -o test5 error: $status" 1>&2
    exit 12
fi
echo 1>&2
rm -f test5.out
echo ./test5 '>' test5.out 1>&2
./test5 > test5.out
status="$?"
if [[ $status -ne 0 ]]; then
    echo 1>&2
    echo 'NOTICE: This is not a code bug, this is a linker and/or architecture limitation !!!' 1>&2
    echo 1>&2
    echo "ERROR: ./test5 > test5.out error: $status" 1>&2
    exit 13
fi
echo 1>&2

# verify the result #5
#
read -r -n 1 -p 'Press any key to compare random.4M.bin and test5.out: ' 1>&2
echo 1>&2
echo 1>&2
if cmp random.4M.bin test5.out; then
    echo 'PASS: random.4M.bin and test5.out are the same' 1>&2
else
    echo 'ERROR: random.4M.bin is NOT the same as test5.out !!!' 1>&2
    exit 14
fi
echo 1>&2

# get ready for try #6
#
read -r -n 1 -p '^^^^^ Press any key after viewing the results above ^^^^^: '
clear

# generate 16M of random data for #6
#
read -r -n 1 -p 'Press any key to generate 16M bytes of random data: ' 1>&2
echo 1>&2
echo 1>&2
rm -f random.16M.bin
echo 'dd if=/dev/urandom bs=64K count=256 of=random.16M.bin' 1>&2
dd if=/dev/urandom bs=64K count=256 of=random.16M.bin
echo 1>&2

# verify the result #6
#
read -r -n 1 -p 'Press any key to ./prog < random.16M.bin > test6.c: ' 1>&2
echo 1>&2
echo 1>&2
rm -f test6.c
echo ./prog '<' random.16M.bin '>' test6.c
./prog < random.16M.bin > test6.c
echo 1>&2

# view the result #6
#
read -r -n 1 -p 'Press any key to view the last 10000 characters of test6.c: '
echo 1>&2
echo 1>&2
echo ... 1>&2
tail -n 1 test6.c | rev | cut -c 1-10000 | rev
echo 1>&2
ls -l test6.c
echo 1>&2

# compile and run #6
#
echo 'NOTICE: Compiling and running the 16M byte random input data test' 1>&2
echo 1>&2
echo 'NOTICE: Because test6.c can take so long to compile, we will compile without optimization.' 1>&2
echo 1>&2
echo 'NOTICE: clang might take about 4 minutes 40 seconds to compile' 1>&2
echo 'NOTICE: gcc   took so long to compile at the 4M level that we did not even try gcc the 16M level !!!' 1>&2
echo 1>&2
echo 'WARNING: Some buggy compilers may crash, especially in resource limited environments, while compiling test6.c !!!' 1>&2
echo 1>&2
echo 'WARNING: The executable may crash on some architectures because main() is larger than the max' 1>&2
echo '         code size between branch island clusters, leading to unreachable branches !!!' 1>&2
echo 1>&2
read -r -n 1 -p 'Press any key to compile and run: ' 1>&2
echo 1>&2
echo 1>&2
rm -f test6
echo "time ${CC} -O0 test6.c -o test6" 1>&2
time "${CC}" -O0 test6.c -o test6
status="$?"
if [[ $status -ne 0 || ! -x test6 ]]; then
    echo 1>&2
    echo 'NOTICE: This is not a code bug, this is a compiler mis-feature !!!' 1>&2
    echo 1>&2
    echo "ERROR: time ${CC} -O0 test6.c -o test6 error: $status" 1>&2
    exit 15
fi
echo 1>&2
rm -f test6.out
echo ./test6 '>' test6.out 1>&2
./test6 > test6.out
status="$?"
if [[ $status -ne 0 ]]; then
    echo 1>&2
    echo 'NOTICE: This is not a code bug, this is a linker and/or architecture limitation !!!' 1>&2
    echo 1>&2
    echo "ERROR: ./test6 > test6.out error: $status" 1>&2
    exit 16
fi
echo 1>&2

# verify the result #6
#
read -r -n 1 -p 'Press any key to compare random.16M.bin and test6.out: ' 1>&2
echo 1>&2
echo 1>&2
if cmp random.16M.bin test6.out; then
    echo 'PASS: random.16M.bin and test6.out are the same' 1>&2
else
    echo 'ERROR: random.16M.bin is NOT the same as test6.out !!!' 1>&2
    exit 17
fi
echo 1>&2

# get ready for try #7
#
read -r -n 1 -p '^^^^^ Press any key after viewing the results above ^^^^^: '
clear

# generate 64M of random data for #7
#
read -r -n 1 -p 'Press any key to generate 64M bytes of random data: ' 1>&2
echo 1>&2
echo 1>&2
rm -f random.64M.bin
echo 'dd if=/dev/urandom bs=64K count=1024 of=random.64M.bin' 1>&2
dd if=/dev/urandom bs=64K count=1024 of=random.64M.bin
echo 1>&2

# verify the result #7
#
read -r -n 1 -p 'Press any key to ./prog < random.64M.bin > test7.c: ' 1>&2
echo 1>&2
echo 1>&2
rm -f test7.c
echo ./prog '<' random.64M.bin '>' test7.c
./prog < random.64M.bin > test7.c
echo 1>&2

# view the result #7
#
read -r -n 1 -p 'Press any key to view the last 10000 characters of test7.c: '
echo 1>&2
echo 1>&2
echo ... 1>&2
tail -n 1 test7.c | rev | cut -c 1-10000 | rev
echo 1>&2
ls -l test7.c
echo 1>&2

# compile and run #7
#
echo 'NOTICE: Compiling and running the 64M byte random input data test' 1>&2
echo 1>&2
echo 'NOTICE: Because test7.c can take so long to compile, we will compile without optimization.' 1>&2
echo 1>&2
echo 'NOTICE: clang might take about 45 minutes to compile' 1>&2
echo 'NOTICE: gcc   took so long to compile at the 4M level that we did not even try gcc the 64M level !!!' 1>&2
echo 1>&2
echo 'WARNING: Some buggy compilers may crash, especially in resource limited environments, while compiling test7.c !!!' 1>&2
echo 1>&2
echo 'WARNING: The executable may crash on some architectures because main() is larger than the max' 1>&2
echo '         code size between branch island clusters, leading to unreachable branches !!!' 1>&2
echo 1>&2
read -r -n 1 -p 'Press any key to compile and run: ' 1>&2
echo 1>&2
echo 1>&2
rm -f test7
echo "time ${CC} -O0 test7.c -o test7" 1>&2
time "${CC}" -O0 test7.c -o test7
status="$?"
if [[ $status -ne 0 || ! -x test7 ]]; then
    echo 1>&2
    echo 'NOTICE: This is not a code bug, this is a compiler mis-feature !!!' 1>&2
    echo 1>&2
    echo "ERROR: time ${CC} -O0 test7.c -o test7 error: $status" 1>&2
    exit 18
fi
echo 1>&2
rm -f test7.out
echo ./test7 '>' test7.out 1>&2
./test7 > test7.out
status="$?"
if [[ $status -ne 0 ]]; then
    echo 1>&2
    echo 'NOTICE: This is not a code bug, this is a linker and/or architecture limitation !!!' 1>&2
    echo 1>&2
    echo "ERROR: ./test7 > test7.out error: $status" 1>&2
    exit 19
fi
echo 1>&2

# verify the result #7
#
read -r -n 1 -p 'Press any key to compare random.64M.bin and test7.out: ' 1>&2
echo 1>&2
echo 1>&2
if cmp random.64M.bin test7.out; then
    echo 'PASS: random.64M.bin and test7.out are the same' 1>&2
else
    echo 'ERROR: random.64M.bin is NOT the same as test7.out !!!' 1>&2
    exit 20
fi
echo 1>&2
