### Spoilers


`calc` is a recursive-descent parser.  It allocates from the stack deep enough
that all expressions are exhausted before the recursion stack depth reaches the
allocations.  The memory map and source is documented in
[src.doc.txt](src.doc.txt).  Tokens are encoded using values 0-20, where 0 is an
invalid token, 1 is minus, 2 is space, 3 is plus, etc.  The necessary constants
are derived at the start of the program, using the guarantee that globals are
initialized to zero; so a correct NULL pointer is obtained from an uninitialized
global pointer variable, and the integers from uninitialized global `int`
variables.  If `x` is a global `int`, then `!x` is `1`, and the derivation
proceeds from there, using some identities that are confusingly similar and
interestingly combined (increasing obfuscation):

```
    obc    clr
    ---    ---
    -~x    x+1
    ~-x    x-1
    y-~x   y+x+1
```

The derived constants are a compromise between simple expressions, maximum utility,
and minimum number of variables used.

Command line arguments are copied into the upper half of the input buffer,
separated by a space.  This allows the code to have a single input parser by using
a pointer-to-func to either `getchar(3)` if live, or a `getchar(3)` simulator.

A small amount of obfuscation comes from `void` functions declared `int`, but
missing `return`.  This is necessary to allow these functions in ternary `?:`
expressions and paired with `&&` and `||`; but the requisite returns would add
symbol count at no benefit to obscurity or functionality.  Function
decomposition was mostly chosen to avoid curly braces: if a `for`-loop required
multiple statements, the body became a new function.  Last, but not least:
sharing state via global variables is an ancient and honored form of
obfuscation, and remarkably effective.


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
