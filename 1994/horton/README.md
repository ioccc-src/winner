## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./horton A B C D
```

`A`, `B`, `C` and `D` are numeric arguments.


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

This confuses cb greatly. See [horton.alt.c](%%REPO_URL%%/1994/horton/horton.alt.c) for an unobfuscated/enhanced
version.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./horton.alt A B C D
```

Where A, B, C and D are numbers like with `horton`.


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

Try to figure out how this program prints, for a given slope, the
right character.  And for extra credit, try to figure out which
character is at the bottom of this hint file.  :-)

You might be interested in the author's article that they cite towards the end
of their remarks, included as PDF files for your convenience, the full
newsletter and a PDF file of just the pages cited.


## Author's remarks:

Run it with any 4 numeric arguments, e.g. `./horton 3 2 1 0`.  Play with the
numbers to get a pleasing result, or use it for your high school algebra
class.


### NOTICE to those who wish for a greater challenge

**If you want a greater challenge, don't read any further**:
just try to understand the program via the source.

If you get stuck, come back and read below for additional hints and information.


### What this entry does:

As should be obvious from 20 feet away, the program is a cubic plotter.
It plots against certain artists, splattering their cubes with graphs
of their cubic equations.  Those dastardly arguments are mere coefficients,
cogs in the wheels of the grand plot to overthrow the cubics!

Oh, by the way, it uses a self-contained graphtab and frame buffer.
It's easily modified to graph *any* 96x160 bitmap on a dumb terminal.

See the [gtface](%%REPO_URL%%/1994/horton/gtface.c) program for another example.  Try:

``` <!---sh-->
    make gtface
    ./gtface < gtface.data
```


### How this entry works:

For more information, see my article

[Using GraphTab; USENIX ;login: Sept/Oct 1992, pages 28-31](login_sept92-pp28-31.pdf).

```
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
```


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
