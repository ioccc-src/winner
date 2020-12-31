#!/bin/bash
# Do the compile and run loop for 10 seconds

transient_parrot=$(tempfile -s .c)
cp prog.c "$transient_parrot"

stop_dancing_deadline=$(($(date +"%s")+10))
while [[ $(date +"%s") -lt "$stop_dancing_deadline" ]]; do
  gcc "$transient_parrot" -o ./prog && ./prog | tee "$transient_parrot"
  sleep 0.01
done

rm -f "$transient_parrot"
