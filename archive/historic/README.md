# Historic archive of IOCCC winning entries


## Historic archives as bz2 compressed tarballs

**WARNING:** These historic archives contain lots of code that will no longer compile,
contains lots of typos, has broken links, has missing files, and contains many programs that will not
run in modern systems.
<br><br>
These archives provided for historic purposes and are
**NOT RECOMMENDED** for casual viewing.
<br><br>
**Instead of using these archives, you should use the code from the** [Winning Entries](../../years.html) and related links.

* [archive-all.tar.bz2](archive-all.tar.bz2)
* [archive-1984.tar.bz2](archive-1984.tar.bz2)
* [archive-1985.tar.bz2](archive-1985.tar.bz2)
* [archive-1986.tar.bz2](archive-1986.tar.bz2)
* [archive-1987.tar.bz2](archive-1987.tar.bz2)
* [archive-1988.tar.bz2](archive-1988.tar.bz2)
* [archive-1989.tar.bz2](archive-1989.tar.bz2)
* [archive-1990.tar.bz2](archive-1990.tar.bz2)
* [archive-1991.tar.bz2](archive-1991.tar.bz2)
* [archive-1992.tar.bz2](archive-1992.tar.bz2)
* [archive-1993.tar.bz2](archive-1993.tar.bz2)
* [archive-1994.tar.bz2](archive-1994.tar.bz2)
* [archive-1995.tar.bz2](archive-1995.tar.bz2)
* [archive-1996.tar.bz2](archive-1996.tar.bz2)
* [archive-1998.tar.bz2](archive-1998.tar.bz2)
* [archive-2000.tar.bz2](archive-2000.tar.bz2)
* [archive-2001.tar.bz2](archive-2001.tar.bz2)
* [archive-2004.tar.bz2](archive-2004.tar.bz2)
* [archive-2005.tar.bz2](archive-2005.tar.bz2)
* [archive-2006.tar.bz2](archive-2006.tar.bz2)
* [archive-2011.tar.bz2](archive-2011.tar.bz2)
* [archive-2012.tar.bz2](archive-2012.tar.bz2)
* [archive-2013.tar.bz2](archive-2013.tar.bz2)
* [archive-2014.tar.bz2](archive-2014.tar.bz2)
* [archive-2015.tar.bz2](archive-2015.tar.bz2)
* [archive-2018.tar.bz2](archive-2018.tar.bz2)
* [archive-2019.tar.bz2](archive-2019.tar.bz2)
* [archive-2020.tar.bz2](archive-2020.tar.bz2)


## Notes on these archives

These zip2 compressed tarballs were preserved as an archive of the
winning source code that was available on the [official IOCCC web
site](https://www.ioccc.org) as of 2020 Dec 28.  These zip2 compressed
tarballs represent the "_released_" IOCCC winning source,
as modified by the IOCCC judges and winning authors
as of [2020 Dec 28](https://web.archive.org/web/20201228005211/https://www.ioccc.org/).

You might wish to note that the
[archive/historic/archive-all.tar.bz2](archive-all.tar.bz2) file
found in this archive produces a somewhat newer version of the
released IOCCC source for 1984, 1985, 1986 and 1987 in that the
winning entries for those years were still found in single year directories.  Thus the
[archive/historic/archive-1984.tar.bz2](archive-1984.tar.bz2),
[archive/historic/archive-1985.tar.bz2](archive-1985.tar.bz2),
[archive/historic/archive-1986.tar.bz2](archive-1986.tar.bz2),
[archive/historic/archive-1987.tar.bz2](archive-1987.tar.bz2),
zip2 compressed tarballs represent a somewhat earlier form of the
"_released_" IOCCC winning source for those years.
This a somewhat earlier set of IOCCC winning source may
be found in the archive/archive-YYYY.tar.bz2 files.

In addition the `archive/archive-all.tar.bz2` file has
a slightly newer version of the 2011 rules and guidelines.
as well as a newer version of 2012/tromp hint files.

For your convenience we keep an archive of the zip2 compressed
tarballs as found in the [Internet Archive Wayback
Machine](https://web.archive.org) as of [2022 Dec
28)(https://web.archive.org/web/20201228005211/https://www.ioccc.org/).


## How to unpack

*HINT*: To uncompress a given bzip2 compressed tarball file, use:

``` <!---sh-->
    tar -jxvf file.tar.bz2
```

where "_file.tar.bz2_" is the name of a file found in this directory.

To uncompress all of the 2022 Dec 28 archive using the year based
bzip2 compressed tarball files:

``` <!---sh-->
    for year in 198{4,5,6,7,8,9} 199{0,1,2,3,4,5,6,8} 200{0,1,4,5,6} 201{1,2,3,4,5,8,9} 2020; do
	rm -rf "$year"
	tar -jxvf "archive-$year.tar.bz2"
    done
```


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
