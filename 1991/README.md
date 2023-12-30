# 1991 marked the "The Eighth International Obfuscated C Code Contest"

Look at the README.md file for the given winning entry for information
on how to compile it and how to run the winning program.
Look at the winning source and try to figure how it does what it does!
You may then wish to look at the Author's remarks for even more details.

Instructions for use: Run `make` to compile entries.  It is possible that
on BSD or non-Unix systems the Makefile needs to be changed.

This year, we did not single out an entry that was better than all of
the rest.  We selected 3 entries that were, in our opinion, went beyond
all of the other entries this year:

- [Grand Prize](westley/README.md) by [Brian
Westley](https://www.ioccc.org/winners.html#Brian_Westley)
- [Most Well Rounded](dds/README.md) by [Diomidis
Spinellis](https://www.ioccc.org/winners.html#Diomidis_Spinellis)
- [Best Of Show](brnstnd/README.md) by [Daniel J.
Bernstein](https://www.ioccc.org/winners.html#Daniel_J._Bernstein)

Name and address information are separated from the actual program
prior to judging.  This eliminates any chance that we would bias our
judging for/against any person or group.  In the end, we are surprised
as you are to see who has won.  Even so, it is worth noting that
[Brian Westley](https://www.ioccc.org/winners.html#Brian_Westley) has submitted
a winning entry for the past 5 years!

## A few notes regarding possible changes to the contest:

We did not give awards to some traditional contest categories such as
"Best Layout" or "Worst Abuse of the Rules".  We felt that to do so
would deny awards to more deserving entries.  These categories have not
been eliminated, and will likely be considered in future years.

A number of entries made use of the following C pre-processor feature:

```c
#define X define
#X foo bar
```

This is not permitted under ANSI C.  Some ANSI C compilers do allow this.  In
the future, we do not want programs to use this feature.  Because this request
was not stated in the [1991 rules](rules.txt), we did not reject entries of this
type.  However we provided more portable versions so that more people could
compile these programs.

This year we received entries that made use of the X Window System.
Since this functionality is now available on many systems, we feel that
programs that use these are now portable enough to be valid entries.

We may allow programs to make use of the X Window System libs and include
files, provided that they can operate with a system running at the level
of at least X11r4.  Requiring the use of imake, a specific window manager,
specific display hardware, or a specific user interface (`Openl**k`,
`M*tif`, ...) is likely not to be allowed.  We will provide a more detailed
explanation of our viewpoint in next year's rules.

In order to encourage more 'normal' looking C programs, we are considering
the following change to the maximum size rule:

```
Your source, not counting any <space>, <tab>, and a <newline> character,
and not counting any ';', '{' and '}' character followed by a <newline>
character, must be 1536 bytes or less.  The entire source, counting all
characters, be 4096 bytes or less.
```

Some thought has been given to adding some C++ categories, however this
is not likely to happen soon.  We are waiting until C++ compilers become
common place on a wide number of systems.  We also need time to brace
ourselves for what obfuscation C++ could wield!

Be sure to wait until the 1992 rules are posted before submitting entries.
We may fine tune the rules to reflect the some ideas above.

Please send us comments and suggestions what we have expressed above.
Also include anything else that you would like to see in future contests.
Send such email to:

```
...!{sun,pacbell,uunet,pyramid}!hoptoad!judges
judges@toad.com
```


## Final Comments

**IMPORTANT NOTE**: The email addresses found above are for historical
purposes only, and should not be used today.  See
[contact.html](/contact.html) for up to date contact details
as well as details on how to provide fixes to any of the entries.
See also [the IOCCC FAQ](/faq.html) for addition information on the IOCCC.


## Credits:

We would like to thank Barbara Frezza for her role as official chef
of the contest.  Landon Noll appreciated the opportunity to serve
as assistant pizza chef.  Larry Bassel was official taste tester. Yummo!


# Copyright and License

Copyright (c) 1991,2023 Landon Curt Noll and Larry Bassel. All Rights Reserved.
This work is licensed under a [Creative Commons CC BY-SA 4.0 DEED Attribution-ShareAlike
4.0 International](https://creativecommons.org/licenses/by-sa/4.0/) license.
If you do use this work in some form, the [IOCCC judges](/judges.html) would appreciate
(but does not require) if you were to [send us a note about your use](/contact.html).
