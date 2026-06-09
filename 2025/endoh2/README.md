Award: Most likely to shock

## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./prog.alt
```


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

While lightning can strike twice, when the final discharge is well
grounded, then sparks fly.

The randomly generated spanning tree simulates current flow in ASCII,
with current intensity represented in terminal escape sequence brightness.

Run and rerun the program to see electrical discharge is conveyed in
Lichtenberg-like patterns on the screen.


### A fun challenge

Create an alternative form of [prog.c](%%REPO_URL%%/2025/endoh2/prog.c) (i.e., `prog.alt.c`)
that prints a line instead of using varying spectral color,
and varying brightness of a yellow line, using
[256 ANSI Color Codes](https://color-palette.hexdocs.pm/ansi_color_codes.html).
Choose a colors/brightness palette to represent the charge intensity.

**UPDATE**: We are in the process of changing how we present fun challenges,
and present potential solutions to those challenges.  Please stay tuned for an update.


## Author's remarks:


### Terminal Discharge Simulator ✨

A terminal is where electrical discharge happens. A terminal is also
where this program displays it. It simulates terminal discharge --
inside your terminal.

Take a look at the source code -- it is shaped like a lightning bolt itself.

#### How to Run

``` <!---sh-->
    make
    ./prog
```

A terminal emulator that supports ANSI escape sequences is required. The
program uses the current (adj., not noun) terminal dimensions via
preprocessor definitions. The Makefile automatically passes `$COLUMNS` and
`$LINES` to the compiler, so just resizing your terminal and recompiling
will change the canvas size.

To compile manually:

``` <!---sh-->
    cc -Dw=$COLUMNS -Dh=$LINES -o prog prog.c
```


#### What You'll See

The output is a [Lichtenberg
figure](https://en.wikipedia.org/wiki/Lichtenberg_figure) -- a branching
electrical discharge pattern -- rendered with `\`, `/`, and the ANSI
underline attribute for horizontal connections. Brighter (bold) segments
indicate paths carrying more "charge," while dimmer segments represent
thinner branches. Each run produces a different figure, seeded by the
process ID (PID).


#### How It Works

Real [dielectric
breakdown](https://en.wikipedia.org/wiki/Electrical_breakdown) works like
this: an electrical field builds up in an insulating material. At random
weak points along the boundary of the discharge, the insulation fails and
the channel extends. Many tiny "streamers" branch outward, but only the
paths that carry enough current survive -- the rest fade into darkness. The
result is the fractal branching pattern that Lichtenberg captured on film.

This program faithfully simulates that process. The algorithm has three phases.


##### 1. The Grid

The program builds a triangular lattice from the terminal dimensions.
For a terminal of width `w` and height `h`, the lattice has `M = w+1`
columns and `H = h/2` rows, giving each node six neighbors:

```
      up-left (i=1) *   * up-right (i=2)
                     \ /
        left (i=3) *--*--* right (i=4)
                     / \
    down-left (i=5) *   * down-right (i=6)
```

Each node maps to a pair of terminal characters. Diagonal
edges (up-left/down-right) are rendered as `\`, diagonal edges
(up-right/down-left) as `/`, and horizontal edges (left/right) as a
two-character-wide underline via the ANSI underline attribute.


##### 2. Tree Construction -- The Breakdown

A terminal -- the electrical kind this time -- is placed near the center
of the lattice. From it, the discharge grows outward:

* Maintain a *frontier*: the set of lattice nodes adjacent to the tree but not yet part of it. This is the boundary where the insulation is under stress.
* At each step, pick a random frontier node (using a 16-bit LCG seeded by `getpid()`), add it to the tree, and check its six neighbors. Any unvisited neighbor is added to the frontier.
* Each newly visited node records the direction it was reached from (1--6) and a pointer back to its parent.
* This continues until the frontier is empty and the tree spans the entire reachable lattice.

The result is a random spanning tree rooted at the seed point -- a
network of every possible discharge path, most of them too faint to see.


##### 3. Charge Accumulation -- The Current Flows

Now current flows. The tree is traversed from leaves back to the root, and each node passes "charge" upward to its parent:

* A leaf contributes a base charge of 8.
* An internal node contributes its own accumulated charge (from all its children) plus 8.
* The charge is stored in the upper bits of each cell's value; the lower 3 bits preserve the direction.
* Nodes whose total charge is too small (below `N/20`, where `N = W*H`) have their direction bits masked out, effectively making them invisible during rendering.

Many thin streamers converge into fewer, thicker channels toward the
root. The tree of all possible paths is still there, but only the
high-current paths will be visible -- just like in a real discharge.


##### 4. Rendering -- The Flash

The lattice is traversed and each edge of the spanning tree is drawn:

* **Diagonal edges** (`/` for directions 2 and 5, `\` for directions 1 and 6) are drawn only if the node's direction bits survived the masking step. Thin branches, whose direction was masked to 7, produce spaces instead -- they fade into darkness.
* **Horizontal edges** (directions 3 and 4) are rendered using the ANSI underline attribute (SGR 4) rather than the `_` character. This allows a diagonal edge and a horizontal edge to overlap at the same node -- for example, `/` with underline produces a shape resembling `∠`.
* **Brightness** is determined by the total charge of three adjacent nodes (the cell and its two lower neighbors). Bold (SGR 1) for the thickest main channels, normal for medium branches, and dim (SGR 2) for thin ones.

The overall effect: only the thick, high-current paths glow brightly as
yellow slashes, while countless fine tendrils vanish into the background,
producing the characteristic branching pattern of a Lichtenberg figure.


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
