#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/yang3

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" all >/dev/null || exit 1

# clear the screen
#
clear

# check the running environment
missing_gcc="* Please install gcc (version 11.1 or newer)\n"
missing_clang="* Please install clang\n"
missing_ruby="* Please install ruby\n"
missing_perl="* Please install perl\n"

echo ""
echo "Check gcc:"
if ( gcc --version ); then
   if ( gcc --version | head -1 | awk '{exit ($3 >= "11" ? 0 : 1)}' ); then
      missing_gcc=""
   else
      missing_gcc="* Please upgrade gcc (need version 11.1 or newer)\n"
   fi
fi

echo ""
echo "Checking clang:"
if ( clang --version ); then
   missing_clang=""
fi

echo ""
echo "Checking ruby:"
if ( ruby --version ); then
   missing_ruby=""
fi

echo ""
echo "Checking perl:"
if ( perl --version ); then
   missing_perl=""
fi

if [[ z"$missing_gcc" != z"" || \
      z"$missing_clang" != z"" || \
      z"$missing_ruby" != z"" || \
      z"$missing_perl" != z"" ]]; then
   echo ""
   echo "Some tools used by this script appears to be unavailable:"
   echo -e -n "$missing_gcc"
   echo -e -n "$missing_clang"
   echo -e -n "$missing_ruby"
   echo -e -n "$missing_perl"
   echo ""
   echo "We will try to run anyway, but some commands might not work as planned"
   echo ""
   read -r -n 1 -p "Press any key to continue..."
fi

# clear the screen
#
clear

# Try encoding one message.
read -r -n 1 -p "Press any key to run: ./prog \"Hello world\\n\" > output1.c "
echo 1>&2
echo 1>&2
./prog "Hello world\n" > output1.c

read -r -n 1 -p "Press any key to run: cat output1.c "
echo 1>&2
echo 1>&2
cat output1.c
echo 1>&2

read -r -n 1 -p "Press any key to run: gcc output1.c -o output1 "
echo 1>&2
echo 1>&2
gcc output1.c -o output1
echo 1>&2

read -r -n 1 -p "Press any key to run: gcc output1.c -c -o /dev/null 2>&1 | ./output1 "
echo 1>&2
echo 1>&2
gcc output1.c -c -o /dev/null 2>&1 | ./output1
echo 1>&2

# Try encoding two messages.
read -r -n 1 -p "Press any key to run: ./prog \"\\x1b[1;31mLycoris\\x1b[0m\\n\" \"\\x1b[1;36mRecoil\\x1b[0m\\n\" > output2.c "
echo 1>&2
echo 1>&2
./prog "\x1b[1;31mLycoris\x1b[0m\n" "\x1b[1;36mRecoil\x1b[0m\n" > output2.c

read -r -n 1 -p "Press any key to run: cat output2.c "
echo 1>&2
echo 1>&2
cat output2.c
echo 1>&2

read -r -n 1 -p "Press any key to run: gcc output2.c -o output2 "
echo 1>&2
echo 1>&2
gcc output2.c -o output2
echo 1>&2

read -r -n 1 -p "Press any key to run: gcc output2.c -c -o /dev/null 2>&1 | ./output2 "
echo 1>&2
echo 1>&2
gcc output2.c -c -o /dev/null 2>&1 | ./output2
echo 1>&2

read -r -n 1 -p "Press any key to run: clang output2.c -o output2 "
echo 1>&2
echo 1>&2
clang output2.c -o output2
echo 1>&2

read -r -n 1 -p "Press any key to run: clang output2.c -c -o /dev/null 2>&1 | ./output2 "
echo 1>&2
echo 1>&2
clang output2.c -c -o /dev/null 2>&1 | ./output2
echo 1>&2

read -r -n 1 -p "Press any key to run: ruby output2.c | ./output2 "
echo 1>&2
echo 1>&2
ruby output2.c | ./output2
echo 1>&2

read -r -n 1 -p "Press any key to run: perl output2.c | ./output2 "
echo 1>&2
echo 1>&2
perl output2.c | ./output2
echo 1>&2
