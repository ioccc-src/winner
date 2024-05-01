# List of files in this entry with a brief description

- [prog.c](prog.c)
    *   This is the source file to the `weasel` program [1].
- [prog.alt.c](prog.alt.c)
    *	This is the source code file to the `weasel.alt` program [1].
- [test.sh](test.sh)
    *	Script provided to test the weasel program [1].
- [test-strings.txt](test-strings.txt)
    * The `test.sh` script reads from this file and runs the program with these
    target strings.

- [Makefile](Makefile)
    * The Makefile that simplifies compilation as well as providing some deep
    magic and other things designed by the IOCCC judges. There's also a `make
    test` target that runs the `test.sh` script. The index.html file shows how
    to pass options to the script itself [1].
- [weasel.1](weasel.1)
    * The man page for weasel.
- [README.md](README.md)
    * The source of the index.html file [3].
- [rpm.md](rpm.md)
    * This file briefly answers 'why' I submitted an rpm spec file 'weasel.spec'
    as well as the possibility of building the RPM for others (despite the fact
    I am confident that I'm the only one who would make use of it). This file
    isn't included in the RPM itself; it remains only on the IOCCC website.
- [weasel.spec](weasel.spec)
    * The RPM spec file for building the RPM. This is specific to the entry on
    the IOCCC website but would also be available in the source rpm file if it
    was built.
- [FILES.html](FILES.html)
    * This web page.
- [FILES.md](FILES.md)
    * The markdown source file for [FILES.html](FILES.html)



## Footnote

The follow footnotes are for if the weasel program is installed into the
system via the RPM file (that can be built by say `rpmbuild -bb weasel.spec` on
an RPM linux system).

As I noted before it was primarily personal reasons that I submitted the spec
file. Years later I thought of removing it but since I quite enjoyed the judges'
remarks I have kept it in place. Please note that the paths below are dependent
on the prefix used in installation; where I suggest `/usr` it is equally
possible it could be under '/usr/local', for example.

[1]			    Note that [prog.c](prog.c) and
			    [prog.alt.c](prog.alt.c) would be
			    linked to `weasel.c` and `weasel.alt.c`
			    (respectively) in the `/usr/src/weasel`
			    subdirectory.

[2]			    The file would most likely be compressed as
			    `weasel.1.gz` under the `/usr/share/man/man1`
			    subdirectory.

[3]			    These files would be in the `/usr/share/doc/weasel`
			    subdirectory.

<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
