#!/usr/bin/env bash
#
# run.sh - run 2018/endoh2 in a loop for 20 seconds

# set up trap so one can continue to next script if run from another script
EXIT=0
trap 'EXIT=1; rm -f prog_next.c prog_next' INT

transient_parrot=prog_next.c
./prog | tee "$transient_parrot"

stop_dancing_deadline=$(($(date +"%s")+20))
while [[ $(date +"%s") -lt "$stop_dancing_deadline" && "$EXIT" != 1 ]]; do
  cc "$transient_parrot" -o ./prog && ./prog | tee "$transient_parrot"
  sleep 1 
done
