#!/usr/bin/env bash
# 'run' jar.1

# run/compile it
rm -f jar.1.o
cc jar.1.c -c
# we do it this way to prevent ShellCheck from whining about useless use of cat,
# a most ill-famed warning. Why is it ill-famed? Because there is no such thing
# as a useless cat! In fact, the fact cats exist is proof that the Earth is NOT
# flat: if it was flat they would have pushed everything off it by now! :-) And
# besides that, they provide hours and hours, years and years even, of joy and
# companionship to ailurophiles and, contrary to popular belief, they most
# certainly do have personalities and they can be very sociable too!
strings < jar.1.o
rm -f jar.1.o
