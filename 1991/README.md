1991 marked the "The Eighth International Obfuscated C Code Contest"

Copyright (c) 1991, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.

Instructions for use: Run make to compile entries.  It is possible that
on BSD or non-unix systems the makefile needs to be changed.

Look at the source and try to figure out what the programs do, and run
them with various inputs.  If you want to, look at the hints files for
(minor) spoilers.

This year, we did not single out an entry that was better than all of
the rest.  We selected 3 entries that were, in our opinion, went beyond 
all of the other entries this year:

	Grand Prize			by Brian Westley
	Most Well Rounded		by Diomidis Spinellis
	Best Of Show    		by Daniel J. Bernstein

Name and address information are separated from the actual program
prior to judging.  This eliminates any chance that we would bias our
judging for/against any person or group.  In the end, we are surprised
as you are to see who as won.  Even so, it is worth noting that
Brian Westley has submitted a winning entry for the past 5 years!


A few notes regarding possible changes to the contest:

We did not give awards to some traditional contest categories such as
"Best Layout" or "Worst Abuse of the Rules".  We felt that to do so
would deny awards to more deserving entries.  These categories have not
been eliminated, and will likely be considered in future years.

A number of entries made use of the following C pre-processor feature:

	#define X define
	#X foo bar

This is not permitted under ANSI C.  Some ANSI C compilers do allow
this.  In the future, we do not want programs to use this feature.
Because this request was not stated in the 1991 rules, we did not
reject entries of this type.  However we provided more portable
versions so that more people could compile these programs.

This year we received entries that made use of the X Window System.
This functionality is now available on many systems, we feel that 
programs that use these are now portable enough to be valid entries.  

We may allow programs to make use of the X Window System libs and include 
files, provided that they can operate with a system running at the level 
of at least X11r4.  Requiring the use of imake, a specific window manager,
specific display hardware, or a specific user interface (Openl**k, 
M*tif, ...) is likely not to be allowed.  We will provide a more detailed 
explanation of our viewpoint in next year's rules.

In order to encourage more 'normal' looking C programs, we are considering 
the following change to the maximum size rule:

    Your source, not counting any <space>, <tab>, and a <newline> character,
    and not counting any ';', '{' and '}' character followed by a <newline>
    character, must be 1536 bytes or less.  The entire source, counting all
    characters, be 4096 bytes or less.

Some thought has been given to adding some c++ categories, however this
is not likely to happen soon.  We are waiting until c++ compilers become
common place on a wide number of systems.  We also need time to brace
ourselves for what obfuscation c++ could wield!

Be sure to wait until the 1992 rules are posted before submitting entries.  
We may fine tune the rules to reflect the some ideas above.

Please send us comments and suggestions what we have expressed above.
Also include anything else that you would like to see in future contests.
Send such email to:

	...!{sun,pacbell,uunet,pyramid}!hoptoad!judges
	judges@toad.com


Credits:

We would like to thank Barbara Frezza for her role as official chef 
of the contest.  Landon Noll appreciated the opportunity to serve
as assistant pizza chef.  Larry Bassel was official taste tester. Yummo!
