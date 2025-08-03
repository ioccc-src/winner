# eh(1)


## NAME

    eh - Edit Here - vi(1) the good parts version


## SYNOPSIS

    eh filename


## DESCRIPTION

A minimalist version of `vi(1)`.  It is an example of the "Buffer Gap" method outlined in the [The Craft Of Text Editing](http://www.finseth.com/craft/) used by many Emacs style editors.  (Yep I mixed `vi` and `emacs` in the same paragraph; I'm going to hell for that one.)

Create or read a text file to edit.  Text files consists of lines of printable UTF-8 text, tabs, or newline characters.  A physical line can be of arbitrary length and is delimited by either a newline or the end of file.  Tab stops are every eight columns.  The behaviour of non-printable characters may vary depending on the implementation of the Curses library, `stty(1)` settings, or terminal emulator.


## COMMANDS

The commands are similar, but not the same as `vi(1)`.  Most commands can be prefixed by a repeat count, eg. `5w`, `123G`, `2dw` (`d2w`), or `2d3w` (`d6w`).  Motion commands, optionally prefixed by a count, are those that move the cursor without modifying the buffer.  Some edit commands can be followed by a motion.

    h j k l     Left, down, up, right cursor movement.
    H J K L     Page top, page down, page up, page bottom.
    b w         Word left, word right.
    |           Goto column (count) of physical line.
    /ERE        Find first occurrence of ERE pattern after the cursor.
    n           Find next occurrence of ERE.
    G           Goto line (count) number; **1G** top of file, **G** bottom.
    \           Toggle text selection.
    d motion    Delete text selection or region given by motion.
    y motion    Yank (copy) text selection or region given by motion.
    P           Paste last deleted or yanked text region before the cursor.
    i           Insert text mode before the cursor, **ESC** or **CTRL+C** ends insert.
    u           Toggle undo of last edit.
    x           Delete character after the cursor, i.e., **dl**
    W           Write buffer to file.
    Q           Quit.
    CTRL+C      Quit.

    Any other key will redraw the screen.


## ENVIRONMENT

* `TERM` : The user's terminal type.  If the environmental variable `TERM` is not set or insufficient then terminate with non-zero exit status.

* `TERMINFO` : The absolute file path of a `terminfo` database.  See `terminfo(5)`.


## EXIT STATUS

- 0     Success
- 1     Insufficient capabilities for `TERM`.
- 2     Read file error


## SEE ALSO

`ed(1)`, `ex(1)`, `vi(1)`


## NOTES

* Has UTF-8 support.

  - Loads UTF-8 files as-is and internally remains UTF-8 (not converted to `wchar_t`).
  - UTF-8 input will likely require an intl. keyboard or enabling [US Intl. dead-key keyboard](https://en.wikipedia.org/wiki/QWERTY#US-International) support.  See also [Unicode Input](https://en.wikipedia.org/wiki/Unicode_input).

* The display of long physical lines that are larger than the terminal screen is untested, so considered undefined.

* CRLF newlines (DOS, Windows) and other non-spacing control characters are not visible.  Consider converting newlines using SUS tools like `awk(1)` or `sed(1)`:

        $ sed -e's/^V^M$//' dos.txt > unix.txt
        $ sed -e's/$/^V^M/' unix.txt > dos.txt

  `^V` is the default `stty(1)` insert literal prefix key.


## REFERENCES

* Craig A. Finseth, "Craft Of Text Editing", 1999
  <http://www.finseth.com/craft/>

* Single Unix Specification, Curses issue 7
  <https://pubs.opengroup.org/onlinepubs/9699909599/toc.pdf>

* Single Unix Specification, Base Specification 2018, vi(1)
  <https://pubs.opengroup.org/onlinepubs/9699919799/utilities/vi.html>
