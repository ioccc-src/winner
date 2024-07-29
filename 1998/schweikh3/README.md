## To build:

``` <!---sh-->
    make all
```

The author stated:

> In the remote event that the input has more than `8192` files with the same
size (on systems where `sizeof (char *) == 4`, or `4096` when `sizeof (char *)
== 8`), increase the manifest constant 32767 on [line
31](%%REPO_URL%%/1998/schweikh3/schweikh3.c#L31).

An alternate version allows one to fix this; see [Alternate
code](#alternate-code) below.


## To use:

If `dir` is the directory (or a directory tree) where you keep
all your favorite pictures off the Internet or from
`alt.binaries.pictures.*`, do

``` <!---sh-->
    find dir -type f -print | ./samefile
```

Maybe you will not need to buy another 10 GB disk to store them.  :-)


## Try:

If you're in this winning entry's directory:

``` <!---sh-->
    ./try.sh
```

Notice that the tool finds some files that are duplicates.


## Alternate code:

If you run into the problem that the author described (above) you can redefine
the size as described; this was done with the `SZ` macro defined in the Makefile
which if (in the code) is unset will be set to the default, 32767.


### Alternate build:

If you wish to change the size to say, 55555:


``` <!---sh-->
    make clobber SIZE=55555 alt
```

or whatever you wish to redefine it to.


## Judges' remarks:

This program is not as smart as to detect identity of JPEG files with the same
picture but with different compression levels. On the other hand compression can
make a thing look/sound/feel different so these probably aren't duplicates
anyway. :-)

Some time after this entry won, the Internet Systems Consortium (ISC) added the
samefile utility to its treasure of software gems! See the author's page about
the tool as well at <http://www.schweikhardt.net/samefile>.


## Author's remarks:

The source is expected to conform to IEEE Std 1003.1-1990 ("POSIX").
Thank God the IEEE does not standardize a coding style...


### What this program does

This is best explained in the man page. The troff source for this man page can
be found in the file [samefile.1](%%REPO_URL%%/1998/schweikh3/samefile.1). To
render try:

``` <!---sh-->
    `man ./samefile.1
```

Otherwise:


### SAMEFILE(1)                User Manuals               SAMEFILE(1)


#### NAME

`samefile` - find identical files


#### SYNOPSIS

``` <!---sh-->
    ./samefile
```

#### DESCRIPTION

`samefile`  reads  a  list  of file names (one file name per
line) from `stdin`.  For each file name pair with identical
contents, a line consisting of six tab separated fields is
output: The size in bytes, two file names,  the  character
`=`  if the two files are on the same device, `X` otherwise,
and the link counts of the two files.  The  output
is sorted in reverse order by size.

`samefile` uses two stages to give optimum performance.

In  the  first  stage,  all  non-plain  files are silently
ignored (directories, devices,  FIFOs,  sockets,  symbolic
links)  as  well  as  files  for  which `stat(2)` or `open(2)`
fails.  The result of the first stage (the file names)  is
written  into  a  binary tree with one node for every file
size. Each node is in turn a linked  list  of  file  names
along  with  inode  and device information.  It is also at
this first stage where checks for  hard  links  are  done.
For  any  inode  only  one  filename  will be added to the
binary tree.

In the second stage all files having  the  same  size  are
compared  against  each  other.  The rules of mathematical
logic are applied to reduce  work  and  output  noise:  if
files  `A`,  `B`,  and `C` have the same size and samefile finds
that `A = B` and `A = C` then it will not compare `B` against `C`
(and will not output a line for `B` and `C`) but only for `A =
B` and `A = C`. The algorithm  will  detect  equality  across
arbitrarily  long chains.  Note however, that because only
the first filename per inode gets into  the  first  stage,
the  output  for a group of identical files with different
inode numbers is also  minimized.  Suppose  you  have  six
identical  files  of size 100 in an inode group consisting
of the three inodes with numbers 10, 20 and 30:

``` <!---sh-->
    $ ls -i   # output edited for readability:
      10 file1     20 file4     30 file6
      10 file2     20 file5
      10 file3
    $ ls | ./samefile
    100     file1   file4   =       3       2
    100     file1   file6   =       3       1
```

The sum of the sizes in the first column is the amount  of
disk  space  you could gain by making all 6 files links to
only one file or remove all but one of the  files.  To  be
precise,  disk  space  is  allocated  in blocks - you will
probably gain two blocks  here,  rather  than  200  bytes.
Note  that it is not enough to just remove `file4` and `file6`
(you  would  gain  only  100  bytes  because  `file5`  still
exists.)


#### LIMITATIONS

`samefile` was written with no limits in mind. The number of
input lines is unlimited. The size of the actual files  is
only limited by available virtual memory needed to compare
one pair of files.  The only hard limit is the  constraint
that there should not be more than about `8192` files having
the same size. Experience has shown that there are  rarely
more than a couple dozen files of the same size.

#### EXAMPLES

For everybody:

What are the duplicates under my home directory?

``` <!---sh-->
    find $HOME | ./samefile
```

For the sysadmin folks:

Report all duplicate files under /usr larger than 16k:

``` <!---sh-->
    find /usr -size +16384c -a -type f | ./samefile
```

For the ftp and WWW admins:
How much space is wasted below our site's /pub directory?

``` <!---sh-->
    find /pub -type f | samefile | awk '{sum += $1} END {print sum}'
```


#### EXIT > STATUS

If  `samefile` runs out of memory the exit status is 1, zero
otherwise.

#### SEE ALSO

`find(1)`, `ln(1)`, `rm(1)`


### NOTICE to those who wish for a greater challenge

**If you want a greater challenge, don't read any further**:
just try to understand the program via the source.

If you get stuck, come back and read below for additional hints and information.


### Why I think it is obfuscated

- The code is commented but this gives only an *extremely* faint clue.
- The layout does not reflect the program structure, or does it?
- The data structure the program builds is an ordered binary tree
  where each node consists of a linked list. This is probably too
  heavy to comprehend for N percent of all programmers ;-)
- The tree is built and traversed by recursive function calls.
- Why does this program look at `dev_t` and `ino_t`? Heavy wizardry.
- Can you find out how the algorithm works that detects identity
  of files across arbitrarily long chains? In my private unobfuscated
  source there are 17 lines describing just that. A classical case for
  the well known `/* You're not supposed to understand this */` comment.
- Would Dijkstra consider this `goto` harmful?
- The only string literal is split in more than a dozen substrings.
- For the task at hand the code is pretty terse. Some dynamic memory
  is even freed as soon as it's no longer needed. I have tried to
  make the preprocessor directives as short as possible. This means
  no spaces after `#include` and no spaces after some of the macro
  names.

Are you an algorithms guru? If so you should know why the output
appears sorted without any use of `qsort(3)` or `system("sort")`.

Rewrite (hah!) the program to use memory mapping of files instead
of `read(2)`. Does this affect performance noticeably?

It's easy to write a script that takes `samefile`'s output and
hard links (or symlinks) identical files. Writing such a script is
left as an exercise for the deobfuscator.

When you run `samefile` on some directory tree, try to estimate
how much you think it will find. Is the actual result anywhere
near your estimate? How many copies of the GPL `COPYING` file
are there on your filesystems? :-)

In the remote event that the input has more than `8192` files with
the same size (on systems where `sizeof (char *) == 4`, or `4096` when
`sizeof (char *) == 8`), increase the manifest constant 32767 on line
31.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
