## To build:

``` <!---sh-->
    make all
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please **DO NOT** fix
    STATUS: known bug - please help us fix
```

For more detailed information see [1992/westley in bugs.html](../../bugs.html#1992_westley).


## To use:

If lost:


``` <!---sh-->
    ./whereami.sh lat long
```

Where `lat` and `long` correspond to your latitude and longitude.

NOTE: you **MUST** have a terminal that is at least 80 columns for this to show
properly. The `whereami.sh` and `whereami.alt.sh` scripts check this but if you
do not have such a terminal you can run the `whereami` (or for the alternate code
described below, `whereami.alt`) directly.


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

The author provided a version for the US which we added. To build:


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./whereami.alt.sh lat long
```

NOTE: this alternative version also needs a terminal with at least 80 columns
but if you do not have such a terminal you can run `whereami.alt` directly.


### Alternate try:

The [try.sh](%%REPO_URL%%/1992/westley/try.sh) script uses both the original
entry and the alternate code so one can try the same script for both:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

To find the approximate place where this entry was judged, type:

``` <!---sh-->
    ./whereami.sh 37 -122	# NOTE: - means west of meridian

	# or if you don't have at least 80 columns and want to see what it
	# looks like anyway:
    ./whereami 37 -122	# NOTE: - means west of meridian
```

If you wish to see this on the US map:

``` <!---sh-->
	make alt
    ./whereami.alt.sh 37 -122	# NOTE: - means west of meridian

	# or if you don't have at least 80 columns and want to see what it
	# looks like anyway:
    ./whereami.alt.sh 37 -122	# NOTE: - means west of meridian
```


## Author's remarks:

Run the program with your latitude & longitude as integer
arguments; it will produce a map made up of `'!'` with the given
position marked with either a `'"'` (if the position is over a `'!'`)
or a `#` (if the position is over a space).  Southern latitudes
and western longitudes are entered as negative numbers.  For
example, to find San Francisco, run with `./whereami 38 -122`.  The
resolution of the map is five degrees horizontally, ten degrees
vertically.  The map is a Mercator projection with equal spacing
of the latitudes, so the areas near the poles are very distorted.
Latitudes near the poles and Antarctica are not shown.

The program requires the ASCII character set, `putchar()`, `atoi()`,
and a display that auto-wraps at 80 characters(!).  If your display
does not work this way, you will have to massage the output;
for example, you can redirect it to a file and edit it with vi,
which will do auto-wrap for you.

Lint complains that `main()` returns a random value and I'm not
checking the value that `putchar()` returns.  Scandalous!

If you run it with fewer than 2 arguments, it will likely
give you an exception, as it will access arguments that
don't exist and characters before a string constant.


### How it works:

The map is printed as one long string of `' '` and `'!'` characters,
with the auto-wrap used to stack up slices of 80.  The map data is
a string; the first character is how many `!`s are printed
(`'A'`=1, `'B'`=2, etc), the second character is how many `' '`s, the
third is how many `!`s, etc.  ASCII characters less than `'A'`
print no characters but still change the polarity, so any map
of `' '`s and `'!'`s is possible.  This is done in the `putchar()`
argument as `33^l&1`, where `l` is the character `position+4`; if
`l` is odd, `' '` is printed, if `l` is even, `'!'` is printed.

The position of latitude & longitude is changed into a single
character position within the one long string via the first
expression `d = latitude/10*80 - longitude/5 - offset`. The
latitude is divided by ten because the vertical resolution is
ten degrees, then multiplied by 80 because of the 80 character
wrap (i.e. each ten degrees moves the position up or down one
entire row).  The longitude is divided by five and added, because
five degrees of change moves the location one character.  The signs
are opposite because latitude is decreasing and longitude is
increasing as you go from upper left to lower right.  The offset
is where the origin (latitude=0, longitude=0) is found.

The position counting down to zero changes the `putchar()` from
printing (`'!'` or `' '`) to printing (`'"'` or `'#'`).

The `"H E L L O,   W O R L D!"` string inside the data string
prints the line of blanks past [Tierra del
Fuego](https://en.wikipedia.org/wiki/Tierra_del_Fuego) and the last
blank line.  It's just for show, really.

Since the resolution is coarse, a few coastal cities are shown to
be just off the map; this is an unavoidable artifact.  The map
is reasonably accurate.


### Here are some cities you might like to try:

```
    New York	    41  -74
    London			52   0
    Moscow			56   38
    New Delhi	    29   77
    Sydney			-34   151
    Los Angeles	    34  -118
    Paris			45   2
    Rio de Janeiro  -23  -43
    Beijing			40   116
    Tokyo			36   140
```


For a domestic (US) version with higher resolution, try:

``` <!---c-->
    main(l,a,n,d)char**a;{for(d=atoi(a[1])/2*80-atoi(a[2])-2043;
    n="bnaBCOCXdBBHGYdAP[A M E R I C A].AqandkmavX|ELC}BOCd"
    [l++-3];)for(;n-->64;)putchar(!d+++33^l&1);}
```

The code will test the 80-column wrap and document itself if it is
joined together as one 160-character line and listed.  You should see:

``` <!---c-->
    main(l,a,n,d)...
    [A M E R I C A]...
```

...going down the left edge if your terminal auto-wraps at 80 characters.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
