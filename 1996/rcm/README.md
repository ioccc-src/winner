## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./rcm < file.gz
```

where `file.gz` is some gzipped file.


## Try:

For more information try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

For a good no-op try:

``` <!---sh-->
    gzip -c < rcm.c | ./rcm
```

**NOTE**: this is done in the [try.sh](%%REPO_URL%%/1996/rcm/try.sh) script as
well, along with some other commands including a way to do the above command but
with more steps.


## Author's remarks:

Except for some silly requirements regarding input validation, CRC checking, and
similar unimportant fluff, this program is a fully compliant
[RFC1951](https://www.ietf.org/rfc/rfc1951.txt)/[RFC1952](https://www.ietf.org/rfc/rfc1952.txt)
[GNU Gzip](https://www.gnu.org/software/gzip/) file uncompressor.  Feed it a
`gzip` compressed file on standard input, and it will write the fully
uncompressed original file to standard output.


### ObJustifications for this entry:


#### The Design Trade-off Argument:

"The 184 characters worth of defines in the build file have been
carefully offset by 184 redundant and unnecessary '`{`', '`}`', and '`;`'
characters in the source file."


#### The Design Review Argument:

"Using only 216 characters out of a maximum of 256, the build file
meets and actually exceeds specification."


#### The Program Metrics Argument:

"The program source is less than 3,100 characters in length and uncompresses the
file
[emacs-19.34b.tar.gz](https://ftp.gnu.org/old-gnu/emacs/emacs-19.34b.tar.gz) in
about 130 seconds on my HP 9000/735.  The now obsolete source file `inflate.c`
from the GNU gzip source tree is 31,613 characters in length and uncompresses
the emacs distribution file in slightly under 25 seconds.  Thus:

> 3100 / 130 = 23.85

vs:

> 31613 / 25 = 1264.52

which represents a better than 530% improvement in the ratio of
source file size to execution time."


#### The Whining Programmer's Argument:

"The inflate algorithm requires that over 400 characters worth
of constants and tables be defined.  Which means the program
itself had to be squeezed down to about 1,100 IOCCC countable
bytes."


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
