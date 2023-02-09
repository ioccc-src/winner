# Best use of space and time

Gil Dogon  


## Judges' comments:
### To use:

    make

    ./prog < pattern.mc

### Try:

    ./prog < glider.mc

    ./prog < infinite_5x5.mc

    ./prog < mosquito5.mc
    # Press the minus key a few times until you see white specks,
    # then press space, and the ] key a few times.

    ./prog < message.mc

### Selected Judges Remarks:

[1991/davidguy](http://ioccc.org/years-spoiler.html#1991_davidguy),
[2011/blakely](http://ioccc.org/years-spoiler.html#2011_blakely),...

...This entry likely concludes the IOCCC category "Cellular automata simulators",
it would be very hard to beat it on its field.

FYI: The .mc extension stands for Golly macrocell format.

We truly have not much more to add, except two things:

* If a large sparse pattern is given, at the start of the program
  you are much more likely to see a blank board rather than the loaded configuration,
  and to see it, you may need to zoom out a few times.

* if you're using a virtual machine with less than 4 Gb of available
  model RAM, you'd want to reduce the value of the Z define in the Makefile
  to 0x10000000, otherwise the entry will promptly crash.

In the interest of saving lives, this entry was not fuzzed.

## Author's comments:
### What is it?
Just run with no arguments on an X11-compatible system using one of the supplied input .mc files as standard input. Press '-' several time to zoom out if neccessary, then press space. For acceleration press ']' several times. Thats rather quick dont you think?

### Historical Timeline.
 * 3.5 Billion years ago: Microrganism life appears on earth
 * 3000 BC: Ankh symbol is used in Egyptian hyroglyphs to represent life.
 * 1940s: John Von Neumann and Stanislav Ulam are interested in artificial life eventually kick starting research on Cellular Automata.
 * 1970: J.H. Conways research discovers a rather minimal set of rules that seems quite interesting. Conways game of life gets published in Gardners Scientific American column.
 * 1970's: According to Knuth, a significant portion of computer time in the world is spent simulating GOL, mostly without the awareness of the people footing the bill.
 * 1984: Bill Gosper invents the Hashlife algorithm. His implementation runs on Symbolics Lisp Machines. Unrelated to that, but in a cosmic coincidence the first IOCCC is run!
 * December 2000: Tom Rokicki has a breakthrough implementing Hashlife in C, efficient, stable and production ready for modern machines.
 * 2006: First version of Golly by Andrew Trevorrow and Tomas Rokicki. Brings the delights of hashlife to the masses.
 
Which brings us to the present moment in time.

### Full documentation and keys UI.
Yes, this program is Conway's game of life  graphic simulator implementing Bill Gosper's hash life algorithm. The entry's UI is rather terse and somewhat obfuscated, as it should be.  Also, when you accidentally, or not, press any of the keys not specified bellow, some stuff will happen or not, there is no guarantee whatsoever.

The program should be used as follows:

The standard input should contain a Golly macrocell format file for a two state automaton. See: http://golly.sourceforge.net/Help/formats.html. Of course only Conways GOL rules are supported, so rules in the files are ignored. The supplied  input examples should be quite interesting. Except one, all are taken from Golly's standard distribution. Information and credits to their designer are in the header comment of each. 

* For image navigation use the arrow keys, and zoom in and out by the +/- keys (without pressing the shift on the +)
* Space : Toggle start/stop.
* 0(zero): Toggle single step/free run mode.
* Backspace: Toggle direction for the arrow of time.
* ]: Increase  speed (time step) by a factor of 2.
* [: Decrease  speed (time step) by a factor of 2.

Notice that when going backward in time we ignore current timestep setting and just jump by the amount that was specified before. However going forward is always using the current time step.

There is a minimal text printout by the program, so you can know what Generation your are in(G:), Internal memory allocated till now (M:), and then which Level is the current macrocell (L) and which zoom Scale you are watching (S).


### Portability issues.
This entry is quite portable hopefully on most modern platforms. It assumes X Window support of course. More than 2GBytes memory is recommended. Configuration through makefile is provided for the display windows size and for the memory usage. The makefile provided configuration (Z=0x20000000) will need a system with 4GB DRAM to run nicely. There are several other salient assumptions though:

 * The entry assumes sizeof(long)=8. However it actually almost avoids using any pointers which are 64 bits this days, in order to save space. On machines with sizeof(long)=4 try adding #define long long long ...
 * The entry assumes the X11 displays default visual has 24 bit depth (RGB).
 * The entry assumes little endianity (in only one place though! if you have powerpc you can try and find that place to make it work), but more than this it assumes unaligned loads of 64 bits longs are supported, i.e. it assumes that a long can be loaded from any address that could hold an int otherwise. On non antiquated X86 you'll be fine.
 * The entry heavily relies on bit complement arithmetic (you dont say!).

### Limitations.
Foremost the entry is very strict, unsafe and picky regarding its input. Anything straying from the standard Golly macrocell legal format will result in undefined behavior, meaning mostly a very defined core dump. Since aforementioned core is rather large by default (about 4Gb) it is highly recommended to 'set limit coredumpsize 0' in the shell before playing with fire ...

This entry needs quite a lot of memory to be effective, but by modern standards that is not too much. It does not do any garbage collection, so sooner or later memory will run out, resulting, surprise, surprise, in a core dump. On the plus side, this enables the nice time reversal feature... Anyway the amount of memory used can be controlled by the Makefile -DZ=... argument. With the default Z, the program will support in total about 240 million 64bit longs for the internal memory, which should be sufficient for about 100 million nodes+leafs, as each node is 3 longs and each leaf is 2.
*Important:* Makefile Z define must be apower of two!

Zooming out past about S58 scale will enter a buggy twilight zone as only long integers are used in the drawing code. Reverting to doubles could have remedied that, but then I'd need to use a lot of ldexps which would take the program over the size limit.  Also the program will crash once the universe goes past level 64, though this is simply fixed by modifying a single constant in the program, can you find it ?  Anyway 2^58 squared is quite a big enough universe for such a tiny progam to simulate, no ?

In case cell memory did not run out, or your pattern did not grow too big, and you have had patience enough and did not increase speed too much, you can run out of the history buffer after 33333 steps.

If all of the above did not happen and result  in the expected core dump, you will encounter the final limitation, which is the absence of an escape key. Just close the window or use ^C to exit ....

### Warnings.
Oh don't get me started on the torrent of litanies gcc emits when used with -Wall ! Does it think I have not memorized by heart C's precious operator precedence table (or at least have a cheatsheet nearby) that it dares suggest extra parentheses that would take the program over the limit ? And what if I do not use a variable here or there, do I have to pay extra tax for every orphaned variable?

There is the reasonable warning about some longs printed as ints but its OK too, trust me.

Then there's the warning about 'gets' being unsafe, which is indeed the only one that appears by default in some versions of gcc linker. Yes Virginia, I know it is unsafe, and I would not recommend anyone using this entry as part of a web daemon, or a spaceship, no, Seriously Dont do that!

### Obfuscations.
Well almost none of the obfuscations are done on purpose, but mostly out of necessity, so all identifiers possible to be one character, are, and they are mercilessly reused. In the main There's even a nice little identifier first used as a global and then reused (shadowed) in the *same* scope, and this did not produce even a lile squeak of a warning from the compiler! Macro compression is raher sparingly used, however Magic numbers abound everywhere, and bit twiddling is magical too. Do you know for example why we have unsigned F=-1 ? (No warning there of course :) Hint:Later in the program you have F/=17. Did that make any sense?  Further hint: print the resulting F in hexadecimal...

And yes, the layout hint involves a mix of the most trendy typographical character juxtaposed against a very ancient one, Not to mention the program includes some famous name dropping and documents itself as usual.

### Further spoilers, engineering, and obfuscation galore.
Those wait for you, curious and interpid reader, in the attached apohlife.c file, Which is a partially obfuscated version of the program I wrote with a lot of helpful annotations and comments for myself and posterity, revealing some of the magic under the hood. This program is also a somewhat improved version which uses ldexps in the draw routine and has bigger constants, so it can zoom up to level 1024 if memory allows, and it tries its best to avoid dumping core on the poor user when its memory runs out, rather it enters freeze mode where you can still travel in calculated frozen space-time. Well, its no nice and tame, it even has an escape key, usage message, and to top it all it even avoids gets!

### Special thanks.
To Tom Rockiki, the original co-writer of Golly, a personal friend and hashlife master, who reviewed some earlier versions of the entry and freely shared some of his vast knowledge regarding GOL programming and hashlife. As a free bonus, Tom has allowed me to show his code which is probably the most efficient yet most obfuscated way of calculating the GOL function on a 64 bits 8*8 leaf:

````c
unsigned long life8x8(long a) { unsigned long aw = a << 1, ae = a >> 1, s0 = aw ^ ae, s1 = aw & ae, hs0 = s0 ^ a, hs1 = (s0 & a) | s1, hs0w8 = hs0 >> 8, hs0e8 = hs0 << 8, hs1w8 = hs1 >> 8, hs1e8 = hs1 << 8, ts0 = hs0w8 ^ hs0e8, ts1 = (hs0w8 & hs0e8) | (ts0 & s0); return (hs1w8 ^ hs1e8 ^ ts1 ^ s1) & ((hs1w8 | hs1e8) ^ (ts1 | s1)) & ((ts0 ^ s0) | a); }
````
This uses only 19 bitwise operations and six shifts to calculate the inner 6x6 next generation bits of the input 8x8 !

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2019, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
