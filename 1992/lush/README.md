# Worst Abuse of the C Preprocessor:

	Ed Luke
	Mississippi State University
	P.O. Box 6176
	Mississippi State, MS 39762, USA

## To build:

        make all

## To run:

	./runme.sh


[Yusuke Endoh](/winners.html#Yusuke_Endoh) supplied a patch which makes this
work with gcc. Due to how it works (see Judges' comments below) this will not
work with clang. Thank you Yusuke!

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) made it use `fgets()`
instead of `gets()` and also added the `runme.sh` script to demonstrate it
(using make was problematic). Cody notes that unfortunately this does not work
with clang due to different compiler messages. Thank you Cody!

For the original entry see [lush.alt.c](lush.alt.c) described in the `Alternate
code` section below.

### Alternate code:

For the original source (fixed to work with gcc) which uses gets() try:

```sh
make alt
```

Use `lush.alt` as you would `lush`.


## Judges' comments:

The program uses error messages issued by the C Preprocessor to
generate its message to the world.  One program's error is another 
program's data!

## Author's comments:

This program is yet another "Hello World." program with a twist.  The
string Hello World has been encoded in the error messages the compiler
generates when compiling the source.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
