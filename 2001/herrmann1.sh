#!/bin/sh

name=herrmann1

# Make sure things are clean to start with...
rm -f ${name} ${name}-1.c ${name}-2.c ${name}-3.c

defs=""
for p in ${1+"$@"}; do
   defs="$defs \"-D$p\""
done

cp ${name}.c ${name}-1.c
touch ${name}-3.c

until cmp -s ${name}-1.c ${name}-3.c > /dev/null; do
   eval ${CC:-cc} -E ${name}-1.c -o ${name}-2.c -P $defs 2> error || exit
   mv -f ${name}-1.c ${name}-3.c
   sed -e 's/  */ /g' -e 's/^ //' -e '/^$/ d' -e 's:^/ \*:/*:' \
       < ${name}-2.c > ${name}-1.c
   head ${name}-1.c
done

eval ${CC:-cc} ${name}-1.c -o ${name} 2> error && rm error

eval ./${name}

# Clean up intermediates...
rm -f ${name}-1.c ${name}-2.c ${name}-3.c
