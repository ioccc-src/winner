Award: Most obfuscated options

## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog decode < file.b64 > file.bin
    ./prog encode < file.bin > file.b64
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Thankfully, the Cyrillic capital letter **Ч** is quite distinct from the digit 4.
That's all we'll say.

For the rest, it is [RTFS](https://en.wikipedia.org/wiki/RTFS). :-)


### A fun challenge

Explain how the argument to `./prog` determines if input is encoded or decoded.

**UPDATE**: We are in the process of changing how we present fun challenges,
and present potential solutions to those challenges.  Please stay tuned for an update.


## Author's remarks:


### Description

Obfuscated Base64 encoder/decoder.


### Running

Supply parameters indicating whether to encode or decode. (Default action if no
parameter given is to decode from Base64)

```
    ./prog encode < test-4k.bin > test-4k.b64
```

or

``` <!---sh-->
    ./prog decode < test-4k.b64 > test-4k.bin.new
```

or for a primitive validation test in one line:

``` <!---sh-->
    ./prog encode < test-4k.bin | ./prog decode | diff -s - test-4k.bin
```

The program will also respond to the magic numbers 2503 and its string-reverse 3052:

``` <!---sh-->
    # this encodes to base 64
    ./prog 3052 < test-4k.bin > test-4k.b64 # this encodes to base 64

    # this decodes from base 64 (you'll likely need to reset your terminal afterwards)
    ./prog 2503 < test-4k.b64
```

The legacy magic number 2053 (and its reverse 3502) also yield the same set of results.

One can use polite or rude language:

```
    ./prog Would you please encode this < test-5k.bin
    ./prog fucking decode this < test-4k.b64
```

Additionally, the obscenities can be censored:

``` <!---sh-->
    ./prog "#$@!ing decode this" < test-4k.b64
    ./prog "Would you #@%!ing encode this" < test-4k.bin
```

One gets unexpected results with

``` <!---sh-->
    ./prog fucking encode this < secret.txt
    cat infile.b64 | ./prog Would you please decode this
    cat infile.b64 | ./prog --decode
    ```

But the following behaves as expected

``` <!---sh-->
    ./prog --encode < test-4k.bin
```


### Provided test data

There are 2 primary files containing random binary data (read from `/dev/urandom`
on the author's system), named to indicate their size:

* test-100k.bin
* test-4k.bin

There are also 6 tiny text files (ranging from 1 to 6 bytes in size) - these
were used during development in order to test the padding functionality. Files
are named to indicate their size in bytes. No trailing newlines exist in these
files.

* 1.txt
* 2.txt
* 3.txt
* 4.txt
* 5.txt
* 6.txt

Lastly there is a file containing a not-so-secret message, used in one of the examples above:

* secret.txt


### Obfuscation techniques

* This entry makes heavy use of short-circuiting to reduce the need of if/else blocks.
* Variables have short names.
* Magic constants are derived from characters in static strings, using multiple layers of array indexing.
* Constants are also contrived from manipulations of the number 64
* Static strings are split but adjacent in the source file, masking their true nature.
* The encoding/decoding algorithm uses a needlessly convoluted state machine driven by recursive calls to main().
* There are preprocessor #defines to hide some punctuation. (This likely makes syntax highlighting unhappy)
* The definitions for L and R are misleading.
* Code blobs and misleading indentation
* The functions `encode()` and `decode()` have their names switched to what one would expect outside of the world of obfuscation.
* The value four is not a constant.
* Some values may look like 64, but they are not.
* Some comments lie and some are misleading. One is intended to be educational.
* There are some unreachable paths in the code, placing unnecessary burden on deobfuscation.
* The identifiers are lexically, visually and phonetically similar. (Well-configured editors should highlight suspicious characters, but distinction is harder when handling the file raw such as with `cat`)
* A superficial knowledge of Greek and Russian languages will give a *token*istic advantage but fluency in either language is unlikely to assist


### Limitations

* Results are unpredictable if one attempts to decode invalid input - whether
  due to improper padding or due to supplying characters outside of the Base64
  character set.
* Assumes an ASCII encoding. Likely very badly behaved with EBCDIC. The author
  has not tested the code on an EBCDIC system.
* Although the program responds to current and legacy magic integers 2503 and
  2053, and their string reverses, attempting to update the appearance of the
  legacy values in the source code does not have the desired effect. Fixing
  this is non-trivial. In the spirit of obfuscation, the author does not
  consider this a bug.
* Due to the recursive nature, large files are not handled correctly. The
  definition of "large" will vary across different systems. The author has
  achieved valid results up to 150k.


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
