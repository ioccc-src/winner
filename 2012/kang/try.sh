#!/usr/bin/env bash

make everything || exit 1

echo "$ echo Nineteen hundred and eighty-four | ./kang"
echo Nineteen hundred and eighty-four | ./kang

echo "$ echo uno | ./kang"
echo uno | ./kang

echo "$ echo trois | ./kang"
echo trois | ./kang

echo "$ echo fier | ./kang # notice the issue here, see alternate code instead"
echo fier | ./kang # notice the issue here, see alternate code instead

echo "$ echo \"shest'\" | ./kang"
echo "shest'" | ./kang
