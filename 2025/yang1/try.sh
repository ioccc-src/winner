#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/yang1

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

# Demonstrate slash function
#
read -r -n 1 -p "Press any key to see the usage message for: ./prog "
echo 1>&2
echo 1>&2
./prog
echo 1>&2

read -r -n 1 -p "Press any key to run: seq 5 | ./prog 2 "
echo 1>&2
echo 1>&2
seq 5 | ./prog 2
echo 1>&2

read -r -n 1 -p "Press any key to run: seq 5 | ./prog -2 "
echo 1>&2
echo 1>&2
seq 5 | ./prog -2
echo 1>&2

# Demonstrate chop function
#
read -r -n 1 -p "Press any key to see the usage message for: ruby prog.c "
echo 1>&2
echo 1>&2
ruby prog.c
echo 1>&2

read -r -n 1 -p "Press any key to run: seq 5 | ruby prog.c 2 "
echo 1>&2
echo 1>&2
seq 5 | ruby prog.c 2
echo 1>&2

read -r -n 1 -p "Press any key to run: seq 5 | ruby prog.c -2 "
echo 1>&2
echo 1>&2
seq 5 | ruby prog.c -2
echo 1>&2

# Demonstrate head function
#
while true; do
   read -r -p "Enter an integer between 1 and 41: " line_number
   echo 1>&2

   if ! [[ "$line_number" =~ ^[0-9]+$ ]]; then
      continue
   fi

   if (( line_number >= 1 && line_number <= 41 )); then
      break
   fi
done

read -r -n 1 -p "Press any key to run: ./prog ${line_number} < prog.c > prog_head.c && diff -u --color prog.c prog_head.c "
echo 1>&2
echo 1>&2
./prog "${line_number}" < prog.c > prog_head.c && diff -u --color prog.c prog_head.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ${CC} prog_head.c -o prog_head "
echo 1>&2
${CC} prog_head.c -o prog_head
echo 1>&2

read -r -n 1 -p "Press any key see the usage message for: ./prog_head "
echo 1>&2
echo 1>&2
./prog_head
echo 1>&2

read -r -n 1 -p "Press any key to run: seq 5 | ./prog_head 2 "
echo 1>&2
echo 1>&2
seq 5 | ./prog_head 2
echo 1>&2

# Demonstrate tail function
#
while true; do
   read -r -p "Enter an integer between 42 and 62: " line_number
   echo 1>&2

   if ! [[ "$line_number" =~ ^[0-9]+$ ]]; then
      continue
   fi

   if (( line_number >= 42 && line_number <= 62 )); then
      break
   fi
done

read -r -n 1 -p "Press any key to run: ./prog ${line_number} < prog.c > prog_tail.c && diff -u --color prog.c prog_tail.c "
echo 1>&2
echo 1>&2
./prog "${line_number}" < prog.c > prog_tail.c && diff -u --color prog.c prog_tail.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ${CC} prog_tail.c -o prog_tail "
echo 1>&2
echo 1>&2
${CC} prog_tail.c -o prog_tail

read -r -n 1 -p "Press any key see the usage message for: ./prog_tail "
echo 1>&2
echo 1>&2
./prog_tail
echo 1>&2

read -r -n 1 -p "Press any key to run: seq 5 | ./prog_tail 2 "
echo 1>&2
echo 1>&2
seq 5 | ./prog_tail 2
echo 1>&2

# Demonstrate number classifier
#
read -r -n 1 -p "Press any key to run: ./prog_head -40 < prog.c | ./prog_tail -12 > prog_generate.c "
echo 1>&2
echo 1>&2
./prog_head -40 < prog.c | ./prog_tail -12 > prog_generate.c

read -r -n 1 -p "Press any key to run: ${CC} prog_generate.c -o prog_generate && ./prog_generate > prog_classify.c "
echo 1>&2
echo 1>&2
${CC} prog_generate.c -o prog_generate && ./prog_generate > prog_classify.c

while true; do
   while true; do
      read -r -p "Enter an integer between 1 and 9999, or 0 to quit: " number
      echo 1>&2

      if ! [[ "$number" =~ ^[0-9]+$ ]]; then
         continue
      fi

      if (( number >= 0 && number <= 9999 )); then
         break
      fi
   done

   if (( number == 0 )); then
      break
   fi

   read -r -n 1 -p "Press any key to run: ./prog ${number} < prog_classify.c > output.c "
   echo 1>&2
   echo 1>&2
   ./prog "${number}" < prog_classify.c > output.c

   read -r -n 1 -p "Press any key to run: ${CC} output.c -o output && ./output "
   echo 1>&2
   echo 1>&2
   ${CC} output.c -o output && ./output
   echo 1>&2

   read -r -n 1 -p "Press any key to run: ${CC} -E -P output.c | ./prog_tail 1 "
   echo 1>&2
   echo 1>&2
   ${CC} -E -P output.c | ./prog_tail 1
   echo 1>&2
done

# Final parting messages
#
read -r -n 1 -p "Press any key to run: perl prog.c "
echo 1>&2
echo 1>&2
perl prog.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./bf prog.c "
echo 1>&2
echo 1>&2
./bf prog.c
echo 1>&2
