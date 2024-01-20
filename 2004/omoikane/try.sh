#!/usr/bin/env bash


read -r -n 1 -p "Press any key to run: ./omoikane omoikane.info omoikane.info omoikane.output: "
echo 1>&2
./omoikane omoikane.info omoikane.info omoikane.output
echo 1>&2
exit 0
