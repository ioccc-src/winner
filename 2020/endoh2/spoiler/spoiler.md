# Opening crawl ROT13 decoder

The program contains dedicated font data for all uppercase alphabet letters.

The source code of the font is [glyphs.txt](glyphs.txt), which is a sequence of
chunks that is a ASCII code (65-90) followed by points data: `x,y,ctrl`.

If `ctrl` is 1, the point is used as control point for quadratic bezier curve.

[code.c](code.c) is the main logic for the program, which has some placeholders
for font data and something.

It decompresses the font data and renders a given text by projection.  It
exploits `C99`'s `double complex` type to represent 2D points, but carefully
coded so that it does not require any `math.h` functions; you don't have to pass
`-lm` to `cc`.

[tmpl.txt](tmpl.txt) is a template for the program.  [gen.rb](gen.rb) composes
the all items and generates [prog.c](prog.c).
