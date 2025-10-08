## Award presentation:

Watch the [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse)
YouTube show for this entry:

> [IOCCC28 - 2024/endoh1 - Prize in patient pointillism](https://www.youtube.com/watch?v=-BORKHexSPM)


## To build:

``` <!---sh-->
    make all
```


## Try:

``` <!---sh-->
    ./try.sh
```

**HINT**: You have to be **VERY** patient while the above script runs to completion.


## Judges' remarks:

When you `make all` you see what looks like a C program, `rt.c`.
However if you try to compile `rt.c`, you will fail: even if you try to
define the symbols `X`, `Y`, `W`, and `H`.

Well, the purpose of the C program, `rt.c` is to generate the red, green, and blue colors of
a single pixel, in the C Preprocessor!!!

For the patient, an image may be rendered a slow pixel at a time.
Think of this as digital [Pointillism](https://en.wikipedia.org/wiki/Pointillism).  :-)

For the truly impatient who wishes to get right to the point without trying to dot around
waiting for the [try.sh](%%REPO_URL%%/2024/endoh1/try.sh) to finish, you may view these images:

* [tiny 8x8 image](ref.8.png)
* [small 32x32 image](ref.32.png)
* [medium 128x128 image](ref.128.png)
* [large 512x512 image](ref.512.png)

**FUN FACT**: We were able to determine on an "_x86-64 processor_" running
"_RHEL 9.6_" using "_gcc version 11.5.0_", one could theoretically render
a **2147483647 x 2147483647** pixel image.  At the rate it took to render
the **512 x 512** pixel image, and without using any parallelism, such an
image would take about **169 billion years** to fully render on a single
CPU core!  Fully rendering such large images is **NOT** recommended.  :-)


### Parallel make

**SUGGESTION**: The [2024/endoh1/Makefile](%%REPO_URL%%/2024/endoh1/Makefile),
by default, uses a single CPU core, can make use of parallel operations.
If you have access to a "_parallel make_", can achieve the above in a shorter
around of time.  If you have "_n_" CPU cores available, consider running
a parallel make with "_n-1_" jobs that run simultaneously.  For example:

``` <!---sh-->
    RESERVE="-2"
    NPROC=$(nproc)
    ((JOBS=NPROC-RESERVE))
    SIZE=512
    make clobber all
    nohup time make -j "$JOBS" out.ppm H="$SIZE" W="$SIZE" > make.out 2>&1 < /dev/null &
```

Where `SIZE` is the size of the image to generate.

Where `RESERVE` is the number of CPU cores to reserve for other things
such as the operating system, daemons, terminal window, etc.  You can even
"_oversubscribe_" by setting RESERVE to a negative number (e.g., `RESERVE="-2"`).

**NOTE**: The [try.sh](%%REPO_URL%%/2024/endoh1/try.sh) script follows the above
example for `SIZE` values of 8, 32, 128, and then 512.

The optimal `RESERVE` will depend on your hardware, operating system,
a C compiler.  Making `RESERVE` too small (i.e., too negative) may slow
down the result.  We recommend that experiment various values of `RESERVE`
with moderate `SIZE` of **32** in order to try to find an optimal `JOBS`
value before attempting to try a larger size such as **512** and beyond.


<div id="larger">
### Be first to build images larger than 2048x2048
</div>


#### On the 2048x2048 rendering:


[Joel Yliluoma](../../thanks-for-help.html#bisqwit) rendered:

- [2048x2048 image](endoh1-2048.png)

Here is the fun saga of how the above image was rendered.

> The above image was started on **Thu Sep 11 10:14:24 AM UTC 2025**
> using 118 parallel jobs, then was suspended or 1 hour at the `Y=217` mark,
> was interrupted accidentally at the `Y=254` mark.  After a quick
> edit to the his version of the `try.sh` script  so that it will not delete
> existing work when restarted, he started again a minute later, at the
> **Thu Sep 11 01:36:08 PM UTC 2025**.  The rendering was interrupted again
> at the `Y=972` mark for a couple of minutes, and interrupted again
> on `Y=1017` mark, due to a system crash (due to memory exhaustion not
> entirely related to the rendering).  The rendering resumed 4 hours later,
> this time using 49 parallel jobs, on **Fri Sep 12 09:23:04 PM UTC 2025**
> when the rendering was finished on **Sat Sep 13 06:24:39 PM UTC 2025**.
> However files at `Y=1017` were corrupt by the system crash, so rendering
> re-resumed on **Sat Sep 13 06:25:56 PM UTC 2025** and truly finished on:
> **Sat Sep 13 06:29:51 PM UTC 2025**!  :-)

The hardware used to render was:

```
     CPU: AMD Ryzen Threadripper 3960X 24-Core Processor
     between 49 and 118 threads
     GCC 14.2.0-19 14.2.0
     Debian Testing (currently Debian 14…ish?)
     GNU Make 4.4.1
```

A summary of [Joel Yliluoma](../../thanks-for-help.html#bisqwit) valiant effort
to render the above image is as follows:

User time: **22 days 9 hours 13 minutes 54.094 seconds**<br>
Sys time: **18 days 18 hours 58 minutes 30.936 seconds**


#### On the 1024x1024 rendering:

[Joel Yliluoma](../../thanks-for-help.html#bisqwit) rendered:

- [1024x1024 image](endoh1-1024.png)

The above image was rendered between **Wed Sep 10 09:21:22 PM UTC 2025** and
**Thu Sep 11 09:48:40 AM UTC 2025** using 78 jobs in parallel on:

```
     CPU: AMD Ryzen Threadripper 3960X 24-Core Processor
     48 threads
     GCC 14.2.0-19 14.2.0
     Debian Testing (currently Debian 14…ish?)
     GNU Make 4.4.1
```


#### Question

**QUESTION**: Do you have the patience to build an even larger image?
If you do, **using the program as it is written of course**, please [send the IOCCC](../../judges.html)
the following:

* Image Height x Width in pixels
* URL of the fully rendered image (in PPM form or better yet converted to PNG)
* How long it took (perhaps using the time(1) command or using the `time` shell builtin)
* The starting and ending dates (using `date -u`) of your rendering
* Number of CPU cores, Operating system, Compiler, Compiler version, and make version
* The number of jobs you ran in parallel
* Anything else you may have done to optimize
* Your name, (GitHub handle (optional)), (Mastodon handle (optional)), (home page URL (optional)), Country (or XX to be anonymous)

**PLEASE** do not attempt to optimize the general algorithm used by this entry to build PPM images.
Please remain "_faithful to the spirit_" of this wonderful entry when attempting to build larger PPM images.

The first people to render a new record sized image **using the general algorithm used by this entry**,
will be given credit in the [thanks for the help](../../thanks-for-help.html) web page.


## Author's remarks:


### A Ray Tracer in the C Preprocessor

Ever since the iconic 1988 IOCCC winning entry [1988/applin](../../1988/applin/index.html),
bending the C preprocessor to one's will has been a time-honored tradition in the IOCCC.
This entry sets out to be the culmination of that legacy: a ray tracer implemented entirely with C macros!


#### How to Run

The initial program, `./prog` (compiled from `prog.c`), outputs the main code, `rt.c`.
To get started, compile and execute it:

``` <!---sh-->
    make all
```

Note: `rt.c` is not a valid C program -- it's written for C preprocessor.

To get the color of a single pixel at position (16, 16) in a 32 x 32 image, run:

``` <!---sh-->
    cc -E -P -DX=16 -DY=16 -DW=32 -DH=32 rt.c
```

This will produce:

```
    129
    62
    129
```

These three values represent the red, green, and blue components respectively.

* Red = 129 (0x81)
* Green = 62 (0x3e)
* Blue = 129 (0x81)

In other words, this indicates that the pixel at position (16, 16) has the color #813e81.


#### How to Generate the Full Image

To generate the entire image, you need to run the preprocessor for every pixel.
For example, to form a 32x32 image:

``` <!---sh-->
    mkdir -p pixel
    cc -E -P -DX=0  -DY=0  -DW=32 -DH=32 rt.c > pixel/pixel-00-00.txt
    cc -E -P -DX=1  -DY=0  -DW=32 -DH=32 rt.c > pixel/pixel-00-01.txt
    cc -E -P -DX=2  -DY=0  -DW=32 -DH=32 rt.c > pixel/pixel-00-02.txt
    ...
    cc -E -P -DX=30 -DY=0  -DW=32 -DH=32 rt.c > pixel/pixel-00-30.txt
    cc -E -P -DX=31 -DY=0  -DW=32 -DH=32 rt.c > pixel/pixel-00-31.txt
    cc -E -P -DX=0  -DY=1  -DW=32 -DH=32 rt.c > pixel/pixel-01-00.txt
    cc -E -P -DX=1  -DY=1  -DW=32 -DH=32 rt.c > pixel/pixel-01-01.txt
    cc -E -P -DX=2  -DY=1  -DW=32 -DH=32 rt.c > pixel/pixel-01-02.txt
    ...
    cc -E -P -DX=30 -DY=31 -DW=32 -DH=32 rt.c > pixel/pixel-31-30.txt
    cc -E -P -DX=31 -DY=31 -DW=32 -DH=32 rt.c > pixel/pixel-31-31.txt
```

Then, concatenate the results with a PPM header to create the image:

``` <!---sh-->
    echo P3 32 32 > out.ppm
    echo 255 >> out.ppm
    find pixel -type f -print | LANG=C sort | xargs cat >> out.ppm
```

Now open `out.ppm` with any image viewer that supports the PPM format.


#### Automating with Makefile

To form a 32x32 image:

``` <!---sh-->
    make clean targets out.ppm H=32 W=32
```

Now open `out.ppm` with any image viewer that supports the PPM format.


#### Generating a Larger Image

To form a 256x256 image:

``` <!---sh-->
    make clean targets out.ppm H=256 W=256
```

Now open `out.ppm` with any image viewer that supports the PPM format.

For reference, the 512x512 image took about 10 hours to render.


#### Technical Challenges

Below is a technical explanation of the implementation.


##### Copying a Macro Definition

One core challenges was how to "copy" the value of a macro.

For example, in C macros:

``` <!---c-->
    #define X 10
    #define Y X

    #undef X
    #define X 20

    Y // expands to "20", not "10"
```

The C preprocessor uses lazy evaluation, meaning macro values are always resolved at the time of use.
With this observation, some people claim it's impossible to copy a macro's value.

One known workaround is encoding one bit by whether or not a macro is defined (as seen in `applin.c` from IOCCC 1988 and `vik2.c` from IOCCC 2004).
However, this approach is too inefficient for our purposes -- ray tracing requires operations like multiplication, and even square root.

Instead, we discovered an efficient way to "copy" a macro's value.
The key observation is that `#if` eagerly evaluates the definition of a macro at that point in preprocessing.
For example:

``` <!---c-->
    #if X % 2
    # define X_b0 1  // The LSB of X is 1
    #else
    # define X_b0 0  // The LSB of X is 0
    #endif
```

This technique copies the least significant bit of `X`.
By applying this for each bit, we can reconstruct the full value:

``` <!---c-->
    #define X 10

    #if X % 2
    # define X_b0 1
    #else
    # define X_b0 0
    #endif

    #if X / 2 % 2
    # define X_b1 2
    #else
    # define X_b1 0
    #endif

    #if X / 4 % 2
    # define X_b2 4
    #else
    # define X_b2 0
    #endif

    ...

    #define Y (X_b0 + X_b1 + X_b2 + ...)

    #undef X
    #define X 20

    Y // replaced with "0 + 2 + 0 + 8 + ..." = 10
```

Even if `X` is later redefined, `Y` remains unchanged.

This technique resembles ["information flow"][information-flow] in the information security.
To our best knowledge, there has been no literature that mentions this technique in terms of the C preprocessor programming.

[information-flow]: https://en.wikipedia.org/wiki/Information_flow_(information_theory)


##### Macro Expansion Explosion

Using macros for complex expressions often causes memory issues.

For instance, consider this Newton's method implementation for square roots:

``` <!---c-->
    #define sqrt0(x, guess) (guess ? (x/guess+guess)/2 : 0)
    #define sqrt(x) sqrt0(x,sqrt0(x,sqrt0(x,sqrt0(x,sqrt0(x,10000)))))
```

The subroutine `sqrt0` is one step of Newton's method, and `sqrt` applies it five times.
There are three occurences of the argument `guess` in the body of `sqrt0`.
Thus, applying `sqrt` repeats its argument expression at least 5^3 = 243 times.
This easily leads to the explosion of macro expansion.

We avoid this issue by using the earlier "copy" trick -- reducing the size of macro expansions by materializing their values.


##### Encoding Vectors

In theory, it is trivial to encode a 3D vector in the C preprocessor: you can just define three macros for x, y, and z components.
However, it creates bloated code -- unsuitable for IOCCC size limits.

Instead, we encode vectors as simple tuples:

``` <!---c-->
    #define vec 1,2,3
```

The vector projection can be implemented as follows.

``` <!---c-->
    #define fst(x,y,z) x
    #define snd(x,y,z) y
    #define thd(x,y,z) z
    #define call(f,a) f(a)
```

Example usage:

``` <!---c-->
    call(fst, vec) // expands to 1
    call(snd, vec) // expands to 2
    call(thd, vec) // expands to 3
```

The auxiliary macro `call` is required.
This is a hassle of the C preprocessor, but, `call(fst, vec)` is expanded to `fst(1,2,3)`, which results in `1`.

We can define a vector addition by using the projections.

``` <!---c-->
    #define vec3_add(a,b) fst(a)+fst(b),snd(a)+snd(b),thd(a)+thd(b)
```

Now, we can simply write `vec3_add(v1, v2)` to add two vectors.
One identifier represents one vector.
It is also elegantly possible to nest expressions like `vec3_add(v1, vec3_add(v1, v2))`.

``` <!---c-->
    #define v1 0,1,2
    #define v2 2,1,0

    int main() {
      printf("(%d %d %d)\n", vec3_add(v1, v2));                // prints "(2 2 2)"
      printf("(%d %d %d)\n", vec3_add(v1, vec3_add(v1, v2)));  // prints "(2 3 4)"
    }
```


##### Ray Tracing via Self-Inclusion

Ray tracing involves recursive calls for reflection.
In `rt.c`, this is done via:

``` <!---c-->
    #include __FILE__
```

In the implementation, only spheres reflect rays, and only one sphere exists.
Thus, the recursion depth is limited to one.

Theoretically, it is possible to support multiple reflections, but this would require implementing a "stack" to keep "local variables" in a stack frame.


##### Outputting a Pixel

The preprocessed result of `rt.c` contains some preprocessor directives (starting with `#`) and three integers (red, green, and blue).

``` <!---sh-->
    cc -E -DX=16 -DY=16 -DW=32 -DH=32 rt.c
```

This will produce:

``` <!---c-->
    # 0 "rt.c"
    # 0 "<built-in>"
    # 0 "<command-line>"
    # 1 "/usr/include/stdc-predef.h" 1 3 4
    # 0 "<command-line>" 2
    # 1 "rt.c"
    # 3481 "rt.c"
    # 1 "rt.c" 1
    # 2090 "rt.c"
    # 1 "rt.c" 1
    # 2091 "rt.c" 2
    # 3482 "rt.c" 2
    # 3582 "rt.c"
    129
    # 3684 "rt.c"
    62
    # 3786 "rt.c"
    129
```

Interestingly, these are valid in the PPM format (lines starting with `#` are commments in PPM).
Thus, just concatenating the results for all pixels (and prefixing a small header) will work to create a PPM image file.

When render a large image, we recommend use the `-E -P` flags as in:

``` <!---sh-->
    cc -E -P -DX=16 -DY=16 -DW=32 -DH=32 rt.c
```

This will only produce:

```
    129
    62
    129
```

Note that values appear as expressions like `(0 + 2 + 0 + 8 + ...)` because we use the "copy" trick.
To print them as to ordinary decimal values, we use macro logic like:

``` <!---c-->
    // assume red is (0 + 2 + 0 + 8)

    #if red / 100 % 10 == 0
    #  define digit0(digits) 0##digits
    #elif red / 100 % 10 == 1
    #  define digit0(digits) 1##digits
    #else
    #  define digit0(digits) 2##digits
    #endif

    #if red / 10 % 10 == 0
    #  define digit1(digits) digits0(0##digits)
    #elif red / 10 % 10 == 1
    #  define digit1(digits) digits0(1##digits)
    #elif ...
    ...
    #endif

    #if red % 10 == 0
    #  define digits digit1(0)
    #elif red % 10 == 1
    #  define digits digit1(1)
    #elif ...
    ...
    #endif

    digits // outputs "10"
```


#### Customizing the Scene

You can modify the scene by editing the top of `rt.c`.


##### Example Defaults

``` <!---c-->
    #define p 0,500,4000            // sphere center position
    #define q 2000                  // sphere radius
    #define r 300,300,300           // sphere color (default: light gray)
    #define s(x) 900,200+K*7100,900 // plane color (default: checkered colors of white for K=1 and purple for K=0)
    #define t -2000,4000,1000       // light position
    #define u 50000,50000,50000     // light color (default: white)
    #define v(x) 500-x,500-x,500    // background color (default: gradation from blue to white)
```


##### Variant Example

``` <!---c-->
    #define p 0,0,8000
    #define q 2000
    #define r 300,300,900
    #define s(x) 200,500-x*300,200+x*800
    #define t 2000,4000,3000
    #define u 30000,40000,30000
    #define v(x) 500,x,10
```

Features:

* Grounded blue sphere
* Blue and green checkered floor
* Sunset-style lighting

See `ref.512-variant.png` for the rendered result.


#### Limitations

Currently, this program supports:

* One sphere
* One floor
* One light

Adding more lights is relatively simple.
Adding multiple spheres would require stack support for recursive ray tracing (see "Ray Tracing by Self-Inclusion" section).

Note: we recommend GCC for performance; Clang is slower for C preprocessor-heavy tasks like this one.


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
