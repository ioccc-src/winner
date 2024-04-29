# Opening crawl ROT13 decoder

The program contains dedicated font data for all uppercase alphabet letters.

The source code of the font is [glyphs.txt](glyphs.txt), which is a sequence of
chunks that is a ASCII code (65-90) followed by points data: `x,y,ctrl`.

If `ctrl` is 1, the point is used as control point for quadratic bezier curve.

[code.c](%%REPO_URL%%/2020/endoh2/spoiler/code.c) is the main logic for the program, which has some placeholders
for font data and something.

It decompresses the font data and renders a given text by projection.  It
exploits `C99`'s `double complex` type to represent 2D points, but carefully
coded so that it does not require any `math.h` functions; you don't have to pass
`-lm` to `cc`.

[tmpl.txt](tmpl.txt) is a template for the program.  [gen.rb](%%REPO_URL%%/2020/endoh2/spoiler/gen.rb) composes
the all items and generates [prog.c](%%REPO_URL%%/2020/endoh2/prog.c).


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
