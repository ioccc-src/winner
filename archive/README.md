# archive IOCCC winning source

These zip2 compressed tarballs were preserved as an archive of the
winning source code that was available on the [official IOCCC web
site](https://www.ioccc.org) as of 2020 Dec 28.  These zip2 compressed
tarballs represent the "_released_" IOCCC winning source,
as modified by the IOCCC judges and winning authors
as of [2020 Dec 28](https://web.archive.org/web/20201228005211/http://www.ioccc.org/).

Yuo smight wish to note that the `archive/archive-all.tar.bz2` file
found in this archive produces a somewhat newer version of the
released IOCCC source for 1984, 1985, 1986 and 1987 in that the
winners for those years were still found in single year directories.
Thus the `archive/archive-1984.tar.bz2`, `archive/archive-1985.tar.bz2`,
`archive/archive-1986.tar.bz2`, and `archive/archive-1987.tar.bz2`
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
28)(https://web.archive.org/web/20201228005211/http://www.ioccc.org/).

*HINT*: To uncompress a given bzip2 compressed tarball file, use:

```sh
tar -jxvf file.tar.bz2
```

where "_file.tar.bz2_" is the name of a file found in this directory.

To uncompress all of the 2022 Dec 28 archive using the year based
bzip2 compressed tarball files:

```sh
for year in 198{4,5,6,7,8,9} 199{0,1,2,3,4,5,6,8} 200{0,1,4,5,6} 201{1,2,3,4,5,8,9} 2020; do
    rm -rf "$year"
    tar -jxvf "archive-$year.tar.bz2"
done
```
