## An RPM: what kind of absolute MADNESS is this ?

What kind of crazy idea is this? Install an IOCCC entry? I realise it seems odd
(at best) so why did I make a rpm spec file and why did I hint at building RPMs
for others? I can't say precisely; **certainly I'm under no impression that
anyone else will want to use it** *but the entry was fun enough for me that I
actually will* (a number of my programs over the years are programs I actually
install and I already have done so with this entry).

I already have my own RPM repository and initially after having won I set it up
so that I could host the weasel rpm (binary and source) there. At the same time
though I feel the entry belongs on the IOCCC website; that is to say the only
place the raw files should be downloadable from is the IOCCC website itself.
Simon Cooper (the judge who at the time dealt with setting up the entries on the
IOCCC website) asked me if there is any real attachment in having the RPM built
as part of the entry and the answer is 'no'. He did suggest too that if I were
to have the RPM hosted on the IOCCC website not only would it place a burden on
me to keep it up to date (not that it ever needed to be updated) but it would
place a burden on the judges. This is no longer true with GitHub but anyway
since this was for personal reasons I decided that:


*   I would not host the actual source code or scripts on my website; they will
remain on the IOCCC website. This will most likely never change; instead I would
link to the entry directory so that they remain where they belong: the IOCCC
website itself. I have set up an [errata page][] however should there be anything
requiring a fix.

*   I am keeping the weasel.spec file in the entry as it was part of my
submission but I do not explain here how to set up the build environment or how
to build a RPM: if you know how to use **rpmbuild** then you should be able to
work it out. Again that's a crazy idea but again it was there and it was part of
the judges' comments (which I liked a lot) which is yet another reason I kept
it.

*   Because I strongly suspect (in other words since I know) I am the only one
who has any desire for actually installing an IOCCC entry I did not do anything
further. Nevertheless more information on my entry can be found at
[https://ioccc.xexyl.net/2018/weasel][].

[errata page]: https://ioccc.xexyl.net/2018/weasel/errata
[https://ioccc.xexyl.net/2018/weasel]: https://ioccc.xexyl.net/2018/weasel


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
