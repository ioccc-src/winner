#!/usr/bin/env bash

make clobber all
cc -include stdio.h -o lush lush.c|& ./lush
