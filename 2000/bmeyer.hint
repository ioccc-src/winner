Best Utility:

    Bernd Meyer
    Monash University, Melbourne, Australia
    1/832 Blackburn Rd
    Clayton, VIC 3168
    Australia

    http://byron.csse.monash.edu.au/
    

Judges' Comments:

    To build:

	make bmeyer

	Compile with the maximum possible optimization on your system.
	If your system has 80-bit internal representation of floating
	point values (x86, some Motorola processors) and you want the
	compressed format to be portable across platforms, you need
        to set your FPU to use 64 bit mode. See the extra build lines
        in the Makefile, and read the author's comments below.

        If you cannot work out hwo to get into 64 bit mode, you can
        try using -ffloat-store if you compile with GCC (this may have
        a performance penalty). The resulting binary will have a good
        chance to produce portable files, but due to the resulting
        double-rounding (first internally to 80 bit, then to 64 bit
        on writing the value to memory), there is a small but very real
        chance any given file produced might not be portable.

    To run:

    	In a video window (white text on black background):

    	    ./bmeyer < michael.pgm > michael.glic

	Compare the michael.pgm to the screen output.

	To test that you are compressing and decompressing the same way the
	author was, try

	    ./bmeyer < lenna.glic

	Also try in a reverse video window:

	    ./bmeyer < michael.pgm 2>/dev/null | ./bmeyer > new.pgm

	Compare the michael.pgm to the screen output.  Compare the new.pgm file
	to the michael.pgm file.

	Create a large reverse video xterm, say 200 columns wide and try:

	    ./bmeyer 200 < lavabus.pgm > lavabus.glic

        Produce an even smaller output:
  
	    ./bmeyer -2 200 < lavabus.pgm > lavabus.glic2

        Decompress that smaller glic-file:

	    ./bmeyer -2 200 < lavabus.glic2 > new.pgm

        Compare the new.pgm file to the lavabus.pgm file by viewing
        them.

    Don't even think of supplying different compression factors (the
    dashed argument) for compression and decompression!  You've been warned.


Selected Author's Comments:

    GLICBAWLS

    A) Function
    ===========

    "GLICBAWLS" stands for:

        "Grey Level Image Compression By Adaptive Weighted Least Squares".

    And that's exactly what this program does --- feed it a .PGM file
    (either raw [i.e. P5] or ascii [i.e. P2]) on stdin, and it will
    output a compressed version to stdout. Feed it a compressed file
    on stdin, and it will decompress it to stdout --- as either raw or
    ascii .PGM, depending on what format it was compressed from. For
    example:

       ./bmeyer < michael.pgm > michael.glic

    and then

       ./bmeyer < michael.glic > michael.decoded.pgm

    As it turns out, glicbawls compresses greyscale images (or, more
    precisely, "natural" greyscale images) better than any other
    program I am aware of (with the exception of the not-yet-published
    program developed for my PhD thesis). Of course, this might take
    some time, so a progress indicator is provided.  To make things
    more interesting, instead of a boring bar or percentage display,
    an ASCII rendition of the image being compressed/decompressed is
    output to stderr (assuming white text on black background). If you
    have trouble recognizing the image, try squinting at it ;-).

    If you still have trouble, simply use a terminal or xterm with
    more than 80 columns, and tell glicbawls about it by giving the
    number of columns as an argument. For example

       ./bmeyer 260 <lavabus.pgm >lavabus.glic

    will allow glicbawls to use up to 260 columns, which makes things
    much more recognizable.

    Still running out of space? Need to compress those images just a
    tad more?  And maybe you can handle some loss due to the
    compression? If so, you can use glicbawls' "near lossless"
    compression mode. In that mode, the decoded pixel values are
    allowed to differ from tbe originals, but there is an upper limit
    on the magnitude of the difference. For example, if a maximum
    error of 2 is allowed, an original pixel value of 37 could be
    decoded as 35,36,37, 38 or 39. In order to use this mode, simply
    give the maximum allowed error as an argument, with a dash ('-')
    before it. For example

       ./bmeyer -2 < graph.pgm > graph.2.glic

    will compress in a way that allows decompression with a maximum
    error of two. You can combine both types of arguments, i.e.

       ./bmeyer -3 180 < graph.pgm >graph.3.glic

    will compress with a maximum error of 3, using a 180 column
    terminal for the progress display, and

       ./bmeyer -3 180 < graph.3.glic > graph.3maxerr.pgm

    will decompress the result on such a terminal.

    But wait, there is more --- you can also feed glicbawls .PPM files
    (i.e.  colour images), raw or ascii, your choice. Glicbawls will
    compress and decompress them just fine. However, it only does
    "reasonably well" on them; It beats PNG easily, but there are
    certainly programs out there that can compress colour images
    considerably better. And don't even *think* about using it for
    so-called "artistic" images (i.e. anything that wasn't scanned
    from a photo or camera)....

    *****************************************************************
    *                                                               *
    *    WARNING WARNING WARNING WARNING WARNING WARNING WARNING    *
    *                                                               *
    *                                                               *
    *         Glicball is rather CPU and FPU intensive. Don't       *
    *         run it on anything slow. Things start to be           *
    *         usable around 300+MHz, with 600+ being highly         *
    *         desirable.                                            *
    *                                                               *
    *****************************************************************



    B) Compile Instructions
    =======================

    Unlike most compression program, glicbawls makes heavy use of
    floating point maths --- and not all FPUs are created equal. Most
    importantly, the x86 and 68k FPUs use 80 bit floating point
    formats internally, while most other processors use IEEE 64 bit
    formats by default. If not taken care of, this means that a
    glicbawls file compressed on one CPU cannot generally be
    decompressed on another.

    Fortunately, just about all current FPUs can be put into IEEE 64
    bit mode (or at least something close enough for
    glicbawls). Unfortunately, there is no standard way of doing
    so. For this reason, the build file contains *three* compile
    lines; One for machines that already use 64 bit mode by default
    (most RISC processors), one for linux/x86 machines using libc4,
    libc5 or glibc2.0, and one for linux/x86 machines using glibc2.1
    (glibc2.1 no longer exports the __setfpucw function, necessitating
    the use of gcc inline assembly.  *Grumble*).

    So, if you are building on a machine that does not, by default,
    use IEEE 64 bit floating point doubles, you'll have to define Y to
    be a command that switches it into that mode. If you fail to do
    so, your glicbawls executable will still be able to decompress its
    own compressed files, but you may be unable to exchange files with
    glicbawls on other machines.


    C) Obfuscation
    ==============

    Most of the obfuscation of this program was driven by the
    desperate struggle to fit all of glicbawls' features into code
    that fits the IOCCC's size limits. All identifiers names are
    single-character, which was only possible by ruthless exploitation
    of scope. There is a function M() that handles nearly all input
    from stdin, handles all output to stdout, and also recursively
    calculates one of the mathematical expressions needed for error
    modelling. There is a function that calculates (A^(-1)*b)*x with A
    a matrix and b and x being vectors, and does so in a very
    efficient way --- but one would be hard pressed to find it. There
    is an arithmetic coder that is even less recognizable. A lot of
    loop variables don't get initialized, but instead the code is
    arranged in such a way that they just happen to have the right
    value when control flow reaches the loops. Lots of functions use
    the same two global scratch variables.  Variables change their
    meaning all the time, and the differences between compressing and
    decompressing are handled in rather subtle ways all over the
    program. The string that holds the ascii values for displaying the
    progress image doubles as a description on how to find a pixel's
    causal neighbours. And then there are a few #define's that really
    are just in there to save a few characters, but as an added
    "benefit" make the source ever more unreadable.

    In short --- running it through the preprocessor and the
    pretty-printer will give you something that looks slightly less
    like line noise and slightly more like a C program, but unless you
    are a true wizard, it is unlikely to gain you any insights into
    what is actually going on....[0]


    D) Bugs, Assumptions and TODOs
    ==============================

    Glicbawls assumes that characters are 8 bit wide, and that the
    character set used is ASCII. If one of these isn't true, all hell
    will break loose.

    The .PGM headers are not checked very thoroughly --- glicbawls
    will happily try to encode lots of files that it shouldn't
    touch. The old adage of "garbage in, garbage out" holds in that
    case. Furthermore, even if glicbawls detects an incorrect input,
    it fails to provide a meaningful error message, and instead
    simply aborts.

    When decompressing a near-losslessy encoded image, the maximum
    allowed error is required as a command line parameter. This should
    really be saved in the compressed file!

    Glicbawls relies on the decimal representation of all integers
    having less than 255 digits. While ANSI C does not guarantee this,
    it seems rather unlikely that anyone in the foreseeable future
    would use images with 10^255 rows, columns or different levels of
    grey.  Also, it is assumed that any integer used can be cast to a
    double and back without loss of precision. This limits the number
    of rows, columns and grey levels to 9 quintillion, which should
    also be sufficient for the next few years.

    There is a theoretical chance that you might get a division by
    zero error. You have a MUCH better chance of getting hit by
    lightning the very second you realize that you just won a few
    million in a lottery.  But if it happens to you, don't say I
    didn't warn you! Instead, go out and buy a lightning rod and a
    lottery ticket ;-)

    At one point, a pointer to int is used as the target of a "%1[#]"
    conversion in a scanf, which makes gcc rather unhappy, but
    shouldn't really cause anyone any trouble. The same goes for a
    couple of assignments which are used as truth values.


    E) Algorithm
    ============

    An exhaustive explanation of the algorithm used would go beyond
    the scope of an info file, and would also be quite difficult in
    pure ASCII, so the following is just a rough outline, and contains
    some compression-speak...

    The image is handled in scanline ordering. For each pixel, an
    expected value is calculated by creating a least squares predictor
    of order 12 based on all of the previously encoded/decoded
    pixels. However, the contribution of each pixel is weighted
    according to its Manhattan-distance from the current pixel,
    D. That weight used is pow(0.8,D). [1][2][3]


    In a similar way, the prediction *errors* for all previous pixels
    are combined --- a weighted average (with weight pow(0.7,D)) of
    the squares of all previous prediction errors is taken, and the
    square root of the (appropriately scaled) result is called sigma.

    The predicted value and sigma are then used as the parameters of a
    Student or t-distribution (which is similar to a normal
    distribution, but has more weight in the tails), providing a
    probability distribution for the current pixel.

    Next, the possible interval of values for the current pixel is
    halved, and through integration of the probability distribution, a
    probability is calculated for the pixel value being in the lower
    half. During encoding, the actual value is examined, and the
    result encoded using an arithmetic coder. During decoding, the
    arithmetic decoder provides the information which half the actual
    value is in.  In both cases, the interval borders are adjusted
    accordingly, the arithmetic coder/decoder updated, and the
    interval halving repeated until the precise value has been
    en/decoded[4].


    [0] Yes, this could be seen as a challenge....
    [1] Actually, the weight is pow(0.8,D)/s, where s is the sigma
        used for en/decoding the particular previous pixel. Dividing
        by s is a rather arbitrary action justified only by the
        improvement in results.  Mathematically, I can only justify
        dividing by s^2, or not dividing at all....
    [2] Obviously, these least squares predictors are not calculated
        from scratch for each pixel. Some clever reuse of earlier
        results allows O(1) calculation, rather than the
        O(previous_rows*columns) this description would suggest.
    [3] As anyone who has ever tried local least squares knows from
        bitter experience, there is a lot of numerical instability
        associated with them. So glicbawls adds a bias towards an
        averaging predictor to the equation system the least squares
        predictor is calculated from.  The weight that is given to
        this bias is constantly adjusted throughout coding/decoding,
        thus justifying the 'a' in "glicbawls".
    [4] In the case of near-lossless coding, the interval is not
        necessarily *halved*, but rather split at a convenient point
        (the split points are chosen in such a way as to minimise the
        expected number of bits needed for coding). Also, the
        iteration ends as soon as the interval is small enough to
        guarantee decoding within the requested maximum error.

    ####################################################################

    Photo Credit:

	Lavabus was taken by the judge, Landon Curt Noll.  Michael was
	provided by the author.  Lenna is a 1972 Playboy centerfold.

	michael.pgm

	    The author's Godchild and nephew.

	lavabus.pgm

	    A bus that was trapped by lava from Kilauea volcano in
	    Hawaii, USA.  Nobody was in the bus at the time, BTW.
	    Photo date: 1981.

	lenna.glic

	    A November 1972 Playboy centerfold was scanned in long ago and
	    has been used for image compression research since then.  Playboy
	    originally threatened to prosecute unauthorized use, but
	    eventually granted that, having been in use for image compression
	    testing for so long, it was now a useful benchmark.  (Note:  This
	    picture doesn't show very much.)
