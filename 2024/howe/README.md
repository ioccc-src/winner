## To build:

``` <!---sh-->
    make all
```


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: known bug - please help us fix**

For more detailed information see [2024/howe in bugs.html](../../bugs.html#2024_howe).


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

This is not your grandmother's 👵 `emacs(1)` 🤓, nor is it as limited as `ed(1)`, eh (🇨🇦)?

The source (and of this program) has fun with an UTF-8 conforming accent, in a manor of speaking 😉.

> TL;DR - to exit type **Q** or press **CTRL+C**.

As mentioned in the [COMMANDS section of prog.html](prog.html#commands), try these commands:

```
    | Key cmd  | Action                                                     |
    |----------|------------------------------------------------------------|
    | h j k l  | Left, down, up, right cursor movement                      |
    | H J K L  | Page top, page down, page up, page bottom                  |
    | b w      | Word left, word right                                      |
    | |        | Goto column (count) of physical line                       |
    | /ERE     | Find first occurrence of ERE pattern after the cursor      |
    | n        | Find next occurrence of ERE                                |
    | G        | Goto line (count) number; 1G top of file, G bottom         |
    | \        | Toggle text selection                                      |
    | d motion | Delete text selection or region given by motion            |
    | y motion | Yank (copy) text selection or region given by motion       |
    | P        | Paste last deleted or yanked text region before the cursor |
    | i        | Insert text mode before cursor, ESC or CTRL+C ends insert  |
    | u        | Toggle undo of last edit                                   |
    | x        | Delete character after the cursor, i.e., dl                |
    | W        | Write buffer to file                                       |
    | Q        | Quit                                                       |
    | CTRL+C   | Quit                                                       |
```

**NOTE**: Any other key will redraw the screen.


## Author's remarks:


### Building

Simply type `make` to build.  There are two macros that can be customised:

* `BUF` to set the buffer size; default 128KB.

* `MODE` to set the file creation mode; default 0600.


### What's Interesting

* This is an update with bug fixes of a previous IOCCC winner, with permission of the author.

* This entry requires Curses.  Some Linux might require NCurses built with wide character support, `-lncursesw`.

* The source is UTF-8.  When are `é` `ë` `ê` `è` not same as `e`?

* The documentation is found in [prog.html](prog.html).

* `prog` can view its own source.

* A regression test suite is available on demand.  The test suite requires `tic(1)` to build the specialised test terminal entry.

* Original unobfuscated more fully featured source available (search/replace, pipe-filter selection, markers, insert file, edit buffer grows, literal character input, multi undo/redo).  See [full version](https://github.com/SirWumpus/eh).

* The `iocccsize(1)` tool only counts bytes, not characters, i.e,. UTF-8 multibyte characters such that some characters cost 2, 3, or 4 bytes, thus penalising UTF-8 entries.

   > UTF-8 demands equal rights and respect as real characters!  The dominance of slim ASCII must end!  We are the UTF-8 People's Front for Freedom, Equality, and Brotherhood (oh that's been used already) - We are the UTF-8 Countless Tourist Defence Farce for One Voice, One World, One Character Set.

Furthermore:

* Refactor page framing to address original issue of scrolling and paging up/down when the file contains long lines.

* CTRL+C will exit insert mode as with `vi(1)`; CTRL+C will also quit, unlike `vi(1)`, for those who cannot find `Q`.

* Add extended regular expression forward search with buffer wrap-around.

* Add text selection with delete (cut), yank (copy), and put (paste).

* Add delete (cut), yank (copy) with motion.

* Replace start/end of line with goto-column command.

* Add counts for motion commands, delete, and put.

* Replace top/end of file with goto-line command.

* Fix word left to behave like `vi(1)`.

* Add basic UTF-8 support.


### Updates


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
