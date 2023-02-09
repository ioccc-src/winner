# Most in need of wide space

Edward Giles  


## Judges' comments:
### To use:

    make prog
    ./prog infile.wav outfile.wav

### Try:

    play MonodyVocals.wav
    ./prog MonodyVocals.wav
    play out.wav

### Selected Judges Remarks:

Do you need to pretend enjoying a more spacious living environment than you actually are in,
or the great outdoors with mountains and canyons, when recording your outgoing voicemail message?
Then don't waste another minute! Record yourself, send the audio file through this entry,
and let your callers be surprised.

## Author's comments:
Description
-----------

This program takes a WAV audio file as input, and applies an artificial reverberation effect to it. It works by feeding the audio through a number of delay lines of various lengths, with various amounts of feedback, to create a smooth echo that fades away over time. A number of parameters of the effect can be altered, to change its sonic characteristics.

BlockDiagram.png is a block-diagram of the internal structure of the reverb algorithm, which is most likely easier to understand than the source code.

MonodyVocals.wav is for testing the program: It is an extract of the unprocessed vocals from [Monody by TheFatRat, featuring Laura Brehm](https://www.youtube.com/watch?v=B7xai5u_tnk). The track was published under a free license.

This program has also been successfully compiled on Windows, with both the [Tiny C Compiler](https://bellard.org/tcc/) and Microsoft's C/C++ compiler. However, the latter reports warnings about loss of information when converting floats, and that `void (*)()` and `void (*)(void)` are not the same thing.

Interesting fact: The size of the program from `./iocccsize -i` is 2019.

**How to use**:

    ./prog input [output [size [dry [wet [damping]]]]]
    prog.exe input [output [size [dry [wet [damping]]]]]
    
* `input`: The path to the input file. Required.
* `output`: The path to the output file. Optional, defaults to `out.wav`.
* `size`: The perceived size of the room, i.e. the approximate amount of time taken for the echo to fade away. Optional, default 1.6 seconds.
* `dry`: The amount of unprocessed signal ("dry" in audio terminology) to add to the output. Optional, default 0.3 or 30%.
* `wet`: The amount of processed ("wet") signal to add to the output. Optional, default 0.5 or 50%.
* `damping`: The amount by which high frequencies are damped out as the echo continues. This models the tendency for higher frequencies to be absorbed more than lower ones. Increasing this value causes the echo to be less "harsh" and more "muffled". Optional, default 0.06 or 6%.

The values `size`, `dry`, `wet`, and `damping` can be specified either as decimal numbers (e.g. 0.35) or as percentages (e.g. 35%).

The default settings are designed to make the effect obvious rather than subtle, so it may be a good idea to adjust the ratio of "dry" to "wet", to give a more pleasant result:

    ./prog in.wav out.wav 1.8 80% 15%

The program only supports WAV files, and only mostly. Other audio formats, such as MP3, are not supported because they are difficult to decode, but there are free programs such as `ffmpeg` that can perform the conversion. Some of the advanced features of the WAV file format are also not supported, such as metadata, 3 or more channels, or a bit depth other than 16 bits. Fortunately, WAV files that don't use these features are very common. The program validates the input file, so passing it a file it can't process will cause the program to print `Bad input file` or `Wave file must be 16 bits,1-2 channels.` depending on what it thinks the problem is. If the output file cannot be opened, the program will print `Can't open output file`.

Assumptions
-----------

1. The code is compiled using the C99 or C11 standard
2. Values are stored in memory in little-endian order
3. `float` is a floating-point type of any size, such that all zero bits represents the number zero
4. `int16_t` and `int32_t` are 2's-complement, `sizeof(int16_t) == 2` and `sizeof(int32_t) == 4`.

Obfuscations
------------

The main obfuscation is that digital signal processing algorithms are inherently opaque. They just consist of iterating through a list of floating-point numbers and performing a series of arithmetic operations on each value. Even if this entry were entirely cleaned of all other obfuscation, it will appear to the average programmer to do the following:

* Read and validate command-line arguments.
* Read and validate the header portion of the input file, and print some errors if that fails.
* Write a modified form of that header into the output file.
* Print the parameters read from the command-line arguments, in a human-readable format.
* Dynamically allocate some arrays of floating-point numbers, to be used later, with lengths based on the `size` parameter
* Read 16-bit audio samples from the input file, converting them to floating-point.
* For each audio sample, do a weird combination of addition, subtraction, and multiplication by constants, using the previously-allocated arrays to store results between iterations. Write the resulting audio samples to the output file, converting them back to 16-bit integers.
* Close all of the file handles and free the memory.

Note that no part of the above description of the code's function had anything to do with echoes in a room. The purpose of the code is therefore hidden.

The source code, on cursory inspection, appears to be a jumbled series of characters arranged into three arcs, representing sound waves. The overall layout distracts people from the fact that it is source code rather than only ASCII art, and the random appearance of the code discourages people from trying to decipher it.

`#define`s are used to abbreviate the code, which has a side effect of making it very slightly harder to read.

* `k` is just a general-purpose replacement for 16.
* `i` is the number of delay-lines to allocate and use (currently 24).
* `q` is an abbreviation for multiplying two elements of `w[]` together.
* `u()` is used to display percentages with proper rounding.
* `j()` imposes an upper limit on a floating-point value, and then negates it. This operation is used eight times.
* `D()` abbreviates a call to `setvbuf`, used to speed up file I/O.
* `l()` is used to clip audio samples to the acceptable range, and convert them to 16-bit integers for output.
* `g()` handles errors.
* `C()` contains the bulk of the signal-processing code, as well as a preprocessor obfuscation trick: If you were to read the body of the macro out of context, it will appear to have multiple mismatched square brackets, since `[` occurs more than `]`. However, this macro is always invoked with arguments such as `C(v],+10)` which contain an unmatched `]` character. When the macro is used in this manner, the extra `[`s in the macro's body are matched with the `]`s added through the first argument.

Every variable name is one letter long. This allows the code to fit into the IOCCC size limit, and it also makes the purpose of a given variable much less clear. For example, it is not evident from the name of the variable `t` that it contains pointers to the delay-line arrays.

As many values as possible have been crammed into arrays. `float w[]` contains:

* the input parameters (`w[0]` to `w[3]`)
* various constants needed for the reverb algorithm (`w[4]` to `w[9]`)
* temporary storage of floating-point audio samples (`w[10]` to `w[20]`)

`int32_t f[]` is even more multi-purpose. It contains:

* the header of the input file (`f[0]` to `f[11]`)
* the number of channels in the input file (`f[12]`)
* the number of samples of output to generate (`f[13]`)
* an end-of-file flag (`f[14]`)
* a variable that I forgot the exact purpose of (`f[15]`)
* indices into the circular buffers where audio samples should be inserted (`f[16]` to `f[39]`)
* indices where audio samples should be read out (`f[40]` to `f[63]`)
* lengths of the buffers (`f[64]` to `f[87]`)

All of the strings are concatenated together and "encrypted" by breaking the string into 4-byte chunks (by casting it to an `int32_t*`), and then XORing the sequence of ints with a known numeric sequence. The "decryption" is not done in-place, to avoid writing over the string constant.

`int32_t *c` is a pointer that points into `f[]`, except that it is often incremented or decremented when it is accessed. In order to determine which indices of `f[]` are being accessed through `c` at any given point in the code, you would have to locate the places where `c` is modified.

In order for this program to read and write WAV files, it needs to parse the header. The necessary information, such as the sample rate and channel count, is defined by the standard to be in somewhat arbitrary locations within the file. Therefore, even if you know which indices of `f[]` are being accessed, it takes extra effort to look up the WAV file format and determine which field that corresponds to.

Some array accesses (which make up most of the program) have been replaced with harder-to-interpret equivalents, for example:

* `X[1]` -> `1[X]`
* `f[14]` -> `10[f+4]`
* `X[0]` -> `*X`

Assignments return the assigned value, allowing them to be included into later expressions: `10[f]=f[13]<<2; f[1]=20+10[f]+k;` is replaced with `f[1]=20+(10[f]=f[13]<<2)+k;`

This technique is used in conjuction with the comma operator to further obscure where the data ends up. For example,

* `12[f]=4[++c]>>k;` was incorporated into `w[0]*=6[f];` to yield `w[0]*=(12[f]=4[++c]>>k,6[f]);`  
* `w[15]=w[k]=e[12[f]]; w[11]=w[10]=e[1];` becomes `w[11]=(w[15]=w[k]=e[12[f]],w[10]=e[1]);`

A few other miscellaneous obfuscations have also been done:

* `while(++f[15]<12);` is used instead of `f[15]=12;`
* `for(s=14[f]=0;s<f[13];s++)` is used instead of `f[14]=0; for(s=0;s<f[13];s++)`
* The line that contains `printf("Hello, world!");` is mostly commented out.


--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2019, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
