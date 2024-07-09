## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: uses gets() - change to fgets() if possible
```

For more detailed information see [2019/dogon in bugs.html](../../bugs.html#2019_dogon).


## To use:

``` <!---sh-->
    ./prog < pattern.mc
```


## Try:

``` <!---sh-->
    ./try.sh
```

Make sure that you keep focus of windows in mind when going back and forth to
the program and the script.


## Judges' remarks:

[1991/davidguy](../../1991/davidguy/index.html),
[2011/blakely](../../2011/blakely/index.html), ...

...This entry likely concludes the IOCCC category "Cellular automata simulators";
it would be very hard to beat it on its field.

FYI: The `.mc` extension stands for `Golly macrocell` format.

We truly have not much more to add, except two things:

* If a large sparse pattern is given, at the start of the program
  you are much more likely to see a blank board rather than the loaded configuration,
  and to see it, you may need to zoom out a few times.

* If you're using a virtual machine with less than 4 Gb of available
  model RAM, you'd want to reduce the value of the Z define in the Makefile
  to `0x10000000`, otherwise the entry will promptly crash. To do this you can do:

        make clobber MEMORY=0x10000000 all

  Notice that that value must be a power of two!

In the interest of saving lives, this entry was not fuzzed.


## Author's remarks:

### What is it?

Just run with no arguments on an X11-compatible system using one of the supplied
input `.mc` files as standard input. Press `-` several time to zoom out if
necessary, then press space. For acceleration press `]` several times. That's
rather quick don't you think?


### Historical Timeline

 * Circa 3.77 - 4.28 Billion years ago: Microorganisms appear on Earth.
 * 3000 BC: Ankh symbol is used in Egyptian hieroglyph to represent life.
 * 1940s: John Von Neumann and Stanislav Ulam are interested in artificial life
 eventually kick starting research on Cellular Automata.
 * 1970: J.H. Conway's research discovers a rather minimal set of rules that
 seems quite interesting. [Conway's Game of
 Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) gets published in
 [Martin Gardner's Scientific American
 column](https://web.stanford.edu/class/sts145/Library/life.pdf).
 * 1970s: According to Knuth, a significant portion of computer time in the
 world is spent simulating GOL, mostly without the awareness of the people
 footing the bill.
 * 1984: Bill Gosper invents the
 [Hashlife](https://en.wikipedia.org/wiki/Hashlife) algorithm. His
 implementation runs on Symbolics Lisp Machines. Unrelated to that, but in a
 cosmic coincidence the [first IOCCC](../../years.html#1984) is run!
 * December 2000: Tom Rokicki has a breakthrough implementing
 [Hashlife](https://en.wikipedia.org/wiki/Hashlife) in C, efficient, stable and
 production ready for modern machines.
 * 2006: First version of Golly by Andrew Trevorrow and Tomas Rokicki. Brings
 the delights of [hashlife](https://en.wikipedia.org/wiki/Hashlife) to the masses.

Which brings us to the present moment in time.


### Full documentation and keys UI

Yes, this program is a Conway's Game of Life graphic simulator implementing Bill
Gosper's hashlife algorithm. The entry's UI is rather terse and somewhat
obfuscated, as it should be.  Also, when you, accidentally or not, press any of
the keys not specified below, some stuff will happen or not, there is no
guarantee whatsoever.

The program should be used as follows:

The standard input should contain a Golly macrocell format file for a two state
automaton. See: <http://golly.sourceforge.net/Help/formats.html>. Of course only
Conway's GOL rules are supported, so rules in the files are ignored. The supplied
input examples should be quite interesting. Except one, all are taken from
Golly's standard distribution. Information and credits to their designer are in
the header comment of each.

* For image navigation use the arrow keys, and zoom in and out by the `+`/`-` keys
(without pressing the shift on the `+`)
* Space : Toggle start/stop.
* 0 (zero): Toggle single step/free run mode.
* Backspace: Toggle direction for the arrow of time.
* `]`: Increase  speed (time step) by a factor of 2.
* `[`: Decrease  speed (time step) by a factor of 2.

Notice that when going backward in time we ignore the current time step setting
and just jump by the amount that was specified before. However going forward is
always using the current time step.

There is a minimal text printout by the program, so you can know what Generation
your are in (`G:`), Internal memory allocated till now (`M:`), and then which Level
is the current macrocell (`L`) and which zoom Scale you are watching (`S`).


### Portability issues

This entry is quite portable hopefully on most modern platforms. It assumes X
Window support of course. More than 2GB of memory is recommended. Configuration
through [Makefile](%%REPO_URL%%/2019/dogon/Makefile) is provided for the display windows size and for
the memory usage. The Makefile provided configuration (`Z=0x20000000`) will need a
system with 4GB DRAM to run nicely. There are several other salient assumptions
though:

* The entry assumes `sizeof(long)==8`. However it actually almost avoids using any
pointers which are 64 bits these days, in order to save space. On machines with
`sizeof(long)==4` try adding `#define long long long` ...
* The entry assumes the X11 displays default visual has 24 bit depth (RGB).
* The entry assumes little endianness (in only one place though! If you have
PowerPC you can try and find that place to make it work), but more than this it
assumes unaligned loads of 64 bits `long`s are supported, i.e. it assumes that a
`long` can be loaded from any address that could hold an `int` otherwise. On non
antiquated X86 you'll be fine.
* The entry heavily relies on bitwise arithmetic (you don't say!).


### Limitations:

Foremost the entry is very strict, unsafe and picky regarding its input.
Anything straying from the standard Golly macrocell legal format will result in
undefined behavior, meaning mostly a very defined core dump. Since
aforementioned core is rather large by default (about 4GG) it is highly
recommended to set the core dump size limit to 0 in the shell before playing
with fire ...

This entry needs quite a lot of memory to be effective, but by modern standards
that is not too much. It does not do any garbage collection, so sooner or later
memory will run out, resulting, surprise, surprise, in a core dump. On the plus
side, this enables the nice time reversal feature... Anyway the amount of memory
used can be controlled by the Makefile `-DZ=...` argument. With the default `Z`,
the program will support in total about 240 million 64bit `long`s for the internal
memory, which should be sufficient for about 100 million nodes+leafs, as each
node is 3 `long`s and each leaf is 2.

*Important:* Makefile `Z` define must be a power of two!

Zooming out past about S58 scale will enter a buggy twilight zone as only `long`
integers are used in the drawing code. Reverting to `double`s could have remedied
that, but then I'd need to use a lot of `ldexp()`s which would take the program
over the size limit.  Also the program will crash once the universe goes past
level 64, though this is simply fixed by modifying a single constant in the
program, can you find it ?  Anyway `2^58` squared is quite a big enough universe
for such a tiny program to simulate, no ?

In case cell memory did not run out, or your pattern did not grow too big, and
you have had patience enough and did not increase speed too much, you can run
out of the history buffer after `33333` steps.

If all of the above did not happen and result in the expected core dump, you
will encounter the final limitation, which is the absence of an escape key. Just
close the window or use `^C`/intr to exit ....


### Warnings

Oh don't get me started on the torrent of litanies gcc emits when used with
`-Wall`! Does it think I have not memorized by heart C's precious operator
precedence table (or at least have a cheat sheet nearby) that it dares suggest
extra parentheses that would take the program over the limit ? And what if I do
not use a variable here or there, do I have to pay extra tax for every orphaned
variable?

There is the reasonable warning about some `long`s printed as `int`s but its OK too,
trust me.

Then there's the warning about `gets(3)` being unsafe, which is indeed the only one
that appears by default in some versions of gcc linker. Yes Virginia, I know it
is unsafe, and I would not recommend anyone using this entry as part of a web
daemon, or a spaceship, no, seriously don' do that.


### Obfuscations:

Well almost none of the obfuscations are done on purpose, but mostly out of
necessity, so all identifiers possible to be one character, are, and they are
mercilessly reused. In the `main()` function there's even a nice little
identifier first used as a global and then reused (shadowed) in the *same*
scope, and this did not produce even a little squeak of a warning from the
compiler! Macro compression is rather sparingly used, however magic numbers
abound everywhere, and bit twiddling is magical too. Do you know for example why
we have `unsigned F=-1` ? (No warning there of course :) Hint: Later in the
program you have `F/=17`. Did that make any sense?  Further hint: print the
resulting `F` in hexadecimal...

And yes, the layout hint involves a mix of the most trendy typographical
character juxtaposed against a very ancient one, not to mention the program
includes some famous name dropping and documents itself as usual.


### Special thanks:

To Tom Rockiki, the original co-writer of Golly, a personal friend and hashlife
master, who reviewed some earlier versions of the entry and freely shared some
of his vast knowledge regarding GOL programming and hashlife. As a free bonus,
Tom has allowed me to show his code which is probably the most efficient yet
most obfuscated way of calculating the GOL function on a 64 bits `8*8` leaf:

``` <!---c-->
    unsigned long life8x8(long a) { unsigned long aw = a << 1, ae = a >> 1, s0 = aw
    ^ ae, s1 = aw & ae, hs0 = s0 ^ a, hs1 = (s0 & a) | s1, hs0w8 = hs0 >> 8, hs0e8 =
    hs0 << 8, hs1w8 = hs1 >> 8, hs1e8 = hs1 << 8, ts0 = hs0w8 ^ hs0e8, ts1 = (hs0w8
    & hs0e8) | (ts0 & s0); return (hs1w8 ^ hs1e8 ^ ts1 ^ s1) & ((hs1w8 | hs1e8) ^
    (ts1 | s1)) & ((ts0 ^ s0) | a); }
```

This uses only 19 bitwise operations and six shifts to calculate the inner 6x6
next generation bits of the input 8x8 !


### NOTICE to those who wish for a greater challenge:

**If you want a greater challenge, don't read any further**:
just try to understand the program via the source.

If you get stuck, come back and read below for additional hints and information.


### Further information, engineering, and obfuscation galore:

Those wait for you, curious and intrepid reader, in the attached
[apholife.c](%%REPO_URL%%/2019/dogon/apholife.c) file, which is a partially obfuscated version of the
program I wrote with a lot of helpful annotations and comments for myself and
posterity, revealing some of the magic under the hood. This program is also a
somewhat improved version which uses `ldexp()`s in the draw routine and has
bigger constants, so it can zoom up to level 1024 if memory allows, and it tries
its best to avoid dumping core on the poor user when its memory runs out, rather
it enters freeze mode where you can still travel in calculated frozen
space-time. Well, it's not nice and tame, it even has an escape key, usage
message, and to top it all it even avoids `gets(3)`!

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
