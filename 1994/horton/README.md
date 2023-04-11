# Best Utility

Mark Horton
AT&T Bell Labs
Rm 1H-117
6200 E Broad St.
Columbus OH 43213
USA

## To build:

        make all

## To run:

```sh
./horton A B C D
```

A, B, C, D are numeric arguments.

## Try: 

```sh
./horton 3 2 1 0
```

### Alternative code:

This confuses cb greatly. See [horton.alt.c](horton.alt.c) for an unobfuscated/enhanced
version. To run this alternate version:

```sh
make horton.alt
./horton.alt A B C D
```

(Use `horton.alt` as you would `horton` above.)


## Judges' remarks:

Try to figure out how this program prints, for a given slope, the
right character.  And for extra credit, try to figure out which
character is at the bottom on this hint file.  :-)

## Author's remarks

Run it with any 4 numeric arguments, e.g. prog 3 2 1 0.  Play with the
numbers to get a pleasing result, or use it for your high school algebra
class.

### SPOILER:

As should be obvious from 20 feet away, the program is a cubic plotter.
It plots against certain artists, splattering their cubes with graphs
of their cubic equations.  Those dastardly arguments are mere coefficients,
cogs in the wheels of the grand plot to overthrow the cubics!

Oh, by the way, it uses a self-contained graphtab and frame buffer.
It's easily modified to graph *any* 96x160 bitmap on a dumb terminal.

See the [gtface](gtface.c) program for another example.  Try:

	make gtface
	./gtface < gtface.data

For more information, see
Using GraphTab; USENIX ;login:
Sept/Oct 1992; Pages 28-31


              MMMM,M,MM"MM,,,
           ,,MMMMMMMMM"""""""",
          ,MMMMM"""            ",
         ,MMM"                   "
         MMM                      M
         MM
         MM" "                     M
          M " , ,,,,,     ,,,,,,,,,MM
          "MMMM"M,MMMMM MMMM M M"MMM,
         ,M"MMMM"MM"MMM""M""MMMM""M"M
          , MM M M,M M"  "M",, M "M "
          M ,M,"    ,M    "M, ,,,", M
           M , M"MMM",,M,M,,""" , ,
          ",," , " "MMMMMMMM "   , "
           ,M , ""M,MMMMMMMM,M " ,,
           ,MM, MMMMMMMMMMMMMM,", M,
            M,M,MM"M"M" """M"MM,M M
           ,MMMMMM M,MMMMM"M MM""M
          M MMMMMM,M M"M"" M MMMM", ,
           "M"MMMMMMMMMM"M ,MMMMM M  ,,
         "" MMMMMMM,M,MM,M,,,MMM"M    ,
       ," , "MMMMMMM"MM"M,,,,MMMMM ,   ,,
       M  ," MMMMMM"MM""M ,MMMMM,M,    M
      ,      MMMM,MMMM"M"M"M,MM,M,",    "

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
