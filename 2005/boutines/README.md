## To build:

``` <!---sh-->
    make
```


## To use:

You will need an [SVG](https://www.w3.org/TR/SVG11/expanded-toc.html) viewer or
a converter like [ImageMagick](https://imagemagick.org/index.php)'s `convert`.
See
FAQ on "[ImageMagick](../../faq.html#imagemagick)".

Look here to find some [SVG Viewer
Implementations](https://www.w3.org/Graphics/SVG/WG/wiki/Implementations).

``` <!---sh-->
    ./boutines < input > output.svg
```


## Try:

``` <!---sh-->
    ./try.sh
```

If `ruby` is installed [try.sh](%%REPO_URL%%/2005/boutines/try.sh) will generate an SVG file by:

``` <!---sh-->
    ruby -e '20.times{puts "#{rand} #{rand}"}' | ./boutines > test.svg
```

It will also create an SVG file with the file [input.txt](input.txt).

The script will check if `convert` is available and if so it will try converting
the SVG file(s) to PNG file(s) which you should be able to view in most any
graphics viewer, editor or web browser.

If you have a program that opens
[SVG](https://www.w3.org/TR/SVG11/expanded-toc.html) files then you could open
the `test.svg` and `result.svg` files directly. An example program is
[Inkscape](https://inkscape.org). See the
[list](https://www.w3.org/Graphics/SVG/WG/wiki/Implementations) cited above for
others.


## Judges' remarks:

Can you explain the author's remark "[generated files] are not as scalable as
their name suggests"?


## Author's remarks:

_In memory of my father Pierre Boutines-Vignard._


### Walk-through

My program works as follows:


#### Input

A list of 2D points in the [unit
square](https://en.wikipedia.org/wiki/Unit_square).


#### Output

A [Voronoi diagram](https://en.wikipedia.org/wiki/Voronoi_diagram) of the set as
an [SVG](https://www.w3.org/TR/SVG11/expanded-toc.html) stream.

This will possibly save a compressed SVG file and may be useful:

``` <!---sh-->
    ./boutines | gzip > result.svg.gz
```

Input consists of a list of floating points values separated by whitespaces
(ranging preferably in `[0,1]`). Alternating a horizontal coordinate, a
whitespace then the other coordinate (pointing downwards in the resulting
graph) and a newline will just go fine:

```
    0  0
    0  1
    1  0
    1  1
    .5 .5
```

Strictly speaking, you have to provide a **set** of points. If there are
duplicates in the list, there is no guarantee on the one to be shown (in
addition their labels will overlap) in the resulting colored [Voronoi
diagram](https://en.wikipedia.org/wiki/Voronoi_diagram).


### Caution

This program might have been a lot shorter, but nearly impractical even for
medium sized datasets. On the other hand it could have been a lot faster, but
hard to qualify under the IOCCC size limit. So guess what I did? A compromise
favoring innermost obfuscation, sacrificing sometimes speed and other tedious
factors.

Therefore this entry is limited to

<img src="eqn.png"
 alt="equation of the limit of the entry"
 width=232 height=43>

points and won't even be suitable for more than a few thousand; although
generated files did pass the [W3C SVG
Validator](https://validator.w3.org/#validate_by_upload+with_options), and are
highly compressible, they are not as scalable as their name suggests... For
serious applications about [Voronoi
diagrams](https://en.wikipedia.org/wiki/Voronoi_diagram), see
[Qhull](http://www.qhull.org/), [CGAL](https://www.cgal.org) and the like but
you may still encounter large output volumes (and have to handle some sort of
clipping in order to represent properly infinite regions of the diagram in
[SVG](https://www.w3.org/TR/SVG11/expanded-toc.html).

Beware, compilation may report warnings about precision loss, linting may be a
disaster, but the code should remain portable, and the output accurate enough
for most devices (including many inkjet printers). If you ever miss precision
on a particular dataset or peripheral, you may want to dive in and let `U` be
the next power of `__LINE__`.

NOTE: bad inputs will be sanctioned by the production of the 42nd [Mersenne
prime](https://en.wikipedia.org/wiki/Mersenne_prime) (i.e. 2^25964951 -1);
memory will be kept.


### Why I think this code is Obfuscated ?

I'm quite divided on the subject because I wrote:

* Clear [SVG](https://www.w3.org/TR/SVG11/expanded-toc.html) keywords but
complicated output statements.
* No nested loops but loads of function calls.
* Easy recursion but no clear data structure.
* Easy maths but no use of `math.h`.
* A single `if`.

Be sure to check the antepenultimate line of code.


### Missing Features


#### Color control

Cell colors are chosen randomly (with a questionable rejection scheme). It
might have been useful to input them along with sites coordinates, turning the
application into a puzzling graphics engine.


#### Site labelling

The points are implicitly numbered in the order they were entered
(starting at one). This can be overridden however, via a simple XSL
transformation.


#### Site radius

The site radius is hardcoded in the code, I still wonder why I did not
design it as a function of the underlying cell's area (which can be averaged
for free) or at least a command line parameter. Same with the char set, the
viewport and potentially every
[SVG](https://www.w3.org/TR/SVG11/expanded-toc.html) property.


### See Also

- [Voronoi at Wikipedia](http://en.wikipedia.org/wiki/Voronoi_diagram),
- [An Excerpt from The Algorithm Design Manual](http://www2.toki.or.id/book/AlgDesignManual/BOOK/BOOK4/NODE187.HTM),
- [Voronoi and Art](http://www.snibbe.com/scott/bf)


### Example Output

<img src="Voronoi.png"
 alt="image of example output: 5 regions of a 5-pointed star with 5 external regions beyond it"
 width=542 height=542>


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
