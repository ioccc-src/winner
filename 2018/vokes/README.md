# Most connected

Scott Vokes  
Twitter: @silentbicycle  


## Judges' comments:
### To use:

    make
    ./prog < example-1.txt

### Try:

    ./prog < example-2.txt
    ./prog < example-tab.txt
    ./prog < ioccc.txt

### Selected Judges Remarks:

What this program does is not witchcraft and there are no spectres, but you
might have a meltdown trying to work it all out.

This entry is designed to mislead in many ways. However, if you find yourself
wanting to know the possibilities for navigating a graph, you will get the
answer you seek with no hocus pocus.


## Author's comments:
Introduction
------------

This program reads a directed graph (as lines with integer node IDs),
and prints the graph's nodes in reverse-topologically sorted order,
grouped into strongly connected components. Given a set of nodes
representing targets and edges representing dependencies between them,
it produces a build order with any dependency cycles gathered.

For example, the following input (provided as `example-1.txt`):

    0 4 8
    1 0
    2 1 3
    3 2
    4 1
    5 4 6
    6 5 2
    7 3 6 7

would be interpreted as:

    0 -> 4, 8
    1 -> 0
    2 -> 1, 3
    3 -> 2
    4 -> 1
    5 -> 4, 6
    6 -> 5, 2
    7 -> 3, 6, 7

So, node 0 has edges to / depends on nodes 4 and 8, node 1 depends on
node 0, and so on. Then, it groups the graph's nodes into
strongly connected components and prints them in reverse-topologically
sorted order:

    0: 8
    1: 0 1 4
    2: 2 3
    3: 5 6
    4: 7

It uses Tarjan's strongly connected components algorithm for the
grouping and reverse-topological sorting, along with a bonus hidden
implementation of counting sort, which sorts each group.

For other details about the input format, see "Issues and
Limitations".


Building
--------

To build:

    ${CC} -o prog prog.c -std=c11 -O3 \
        -Wall -Wextra -pedantic -Wno-missing-prototypes

`-Wno-missing-prototypes` is necessary because there aren't any
prototypes. (They would put the program well over the size limit.)

Note: The program can also be built with `-std=c99` or `-std=c89`.

If building with `-Weverything`, then `-Wno-strict-prototypes`
may also be necessary -- the function pointer declarations for
`_` and `B` may get warnings otherwise, for reasons described
under "Obfuscations".


Obfuscations
------------

- This entry uses functions that have a variable number of arguments,
  but despite what the rules say, there is no need to be careful about
  `va_list` implementation differences. :) . There are several
  references to a function pointer, `_`, but it's called with different
  numbers of arguments in different places. (In particular, look at
  `spell`.) Because the function pointer declaration has an empty list
  of parameters, the argument count and types are unconstrained. `_` is
  set to different functions in several places, but it is always called
  with appropriate argument(s) for its possible current functions. This
  is allowed by the standard -- The section on F,I,N,D,M,Y,C,L,U,E has
  further details.

- It uses `_` in three different scopes: as a goto label (function
  scope), as an enum name, and a `_` function pointer (which is required
  to have file scope, since it starts with '_'). There are also other
  `_`s: it appears in a string, obscured by a headecimal escape sequence
  (`\x5f`), and the cauldron is supported by a giant underscore.
  (Does this program qualify for Best One Liner?)

- Most of the variables are not only global, but used for unrelated
  purposes at different times, so just renaming them while studying the
  program should make it even more confusing. The few variables local to
  functions have their names reused for different things in other
  functions.

- There is an enum early on that defines several single-letter
  identifiers: F,I,N,D,M,Y,C,L,U,E. These are used for array offsets,
  both individually and in combination. The first several values are
  also a clue: ISO/IEC 9899:1999 chapter 6.7.5.3 verse 14 describes how
  function declarators with an empty parameter list behave. (As does
  3.5.4.3 for ANSI C, which explains the 0x3543 that appears soon
  after.)

- Several parts of the program's state are stashed in otherwise unused
  offsets of the node arrays. These locations are accessed in multiple
  ways, such as using `I[p]` (where I == 7) as well as `p[F+L]` (6+1),
  or `b[M-N]` (14-5) and `U[b]` (where U == 9).

- The other identifiers are misleading, punny, or both. `spectre` does
  not exploit CVE-2017-5753 or CVE-2017-5715, for example -- it just fits
  the witch theme. `cast` doesn't cast, `hex` has nothing to do with
  hexadecimal, `bubble` is not bubble sort, there is no undefined
  behavior in `nasal_demons`, and `main` has absolutely nothing to do
  with a hand.

- For well-formed input, how the program determines when to exit is a
  bit obscure. `main` ends with a `goto` leading back to an earlier `_`
  label, so it just loops forever, and `exit` only appears in code paths
  related to error-handling. It looks like `cast` calls `meltdown` with
  its second argument set to 0, which would call `exit`, but running in
  gdb with a breakpoint on `cast` reveals that it isn't being called...

- Instead of using `isdigit()`, the program checks the numeric value of
  each `char`, and literals that would suggest comparing against e.g. '0'
  are specified in octal in one place, and produced by arithmetic using
  the enum elsewhere.

- Common conventions are subverted: `i` is not a loop index, `argv` and
  `argc`'s names are swapped.

- `NULL` does not appear in the program. Instead, `argc[argv]` (which is
  required to be a null pointer) is saved and passed to where its value
  is needed.

- Oh, and the program is squashed into the shape of a bubbling cauldron,
  on top of a giant underscore, so there's that.


Issues and Limitations
----------------------

- Despite appearances, it does not handle numbers in hex, or provide
  a `curses(3)`-based interface.

- The expected input format is zero or more lines of space-separated
  integers. If other characters appear in the input, it will either
  reject the input entirely and exit with a non-zero status, or skip
  number(s) adjacent to the non-digit characters, depending on where the
  characters appear. Tabs and multiple consecutive spaces are handled
  correctly, however.

- Individual lines of input longer than `0x3543 - 1` bytes will be
  split and processed as if they were multiple lines of input, which can
  produce incorrect results. This magic number's significance is
  described earlier.

- The algorithm expects its input to represent a fully connected graph.
  While the output is otherwise topologically sorted, if there are nodes
  completely unconnected to the rest of the graph (with or without
  self-cycles), they will be output as soon as they are processed --
  this means that, when there are disconnected nodes, reordering the
  input lines can produce different output. Addressing this by adding
  another pass is would put the program over the size limit.

- While the node IDs don't need to be consecutive or start at 0, the
  implementation doesn't have special handling for sparse graphs. If you
  give it a graph with nodes numbered 0 and 2147483647, it will attempt
  to allocate sufficient memory (potentially around 32 GB) for the
  entire range of graph nodes, even if those are the only ones. If
  memory allocation returns NULL, it will gracefully exit, otherwise it
  will succeed, eventually, perhaps after a great deal of swapping.

- Node IDs >= 2147483648 will cause the program to print an error
  message and exit with a non-zero status. This shrinks the code that
  detects overflowing the array size by a bit.

- A very large group of nodes in a cycle can cause a stack overflow.
  This typically takes over 100,000 nodes, and depends on the order the
  nodes are visited. Addressing this would put the program over the size
  limit.

- The implementation depends on the characters '0', '1', ... '9' having
  the values 48 through 57, rather than using `isdigit()`. As noted
  above, this program has nothing to do with a hand.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2018, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
