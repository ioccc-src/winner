# Best Layout:

    Dean Swift
    Trinome Communications
    7, Jeffries Passage
    Guildford
    Surrey
    GU1 4AP
    England

    http://www.tc3.co.uk/~gandalf/G.HTML

## To build:

        make all

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to compile
and work with modern systems. As he loved the references in the code that could
not compile he just commented out as little as possible to get this to compile.
Thank you Cody for your assistance!

## To run

	./gandalf

## Try:


	PATH=.:$PATH
	./hatcat
	./cathat

And next try:

	./cathat
	`pwd`/cathat

Care to guess why these execute differently?  Only the
compiler knows ... ok maybe other things like the author,
the judges and maybe you too?

## Judges' comments

For mis-leading C pre-processor output, try:


	cc -E gandalf.c

## Author's comments

The program requires an ASCII system.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
