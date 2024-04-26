## To build:

``` <!---sh-->
    make all
```


## Try:

To test the official C entry, one might try:

``` <!---sh-->
    echo "Quartz glyph jocks vend, fix, BMW." | compress | ./btoa | ./jaw
```

which should apply the identity transformation to a minimal holoalphabetic
sentence.


#### Also try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

The program, in its base form, implements two useful utilities:


- `atob` - ASCII to binary conversion
- `zcat` - decompression filter

Included with this entry is a shell script (with comments edited down to reduce
it to 1530 bytes) which implements the complete shark utility. The script,
[shark.sh](%%REPO_URL%%/1990/jaw/shark.sh), contains a `jaw.c` embedded within it!

The sender must have `compress` and `btoa`. To send, try:


``` <!---sh-->
    ./shark.sh jaw.* README.md > receive
```

The resulting file, `receive`, unpacks the input files
even if the receiver lacks `uncompress` and `btoa`:

``` <!---sh-->
    mkdir -p test
    cd test
    sh ../receive
    cmp ../jaw.c jaw.c
    cmp ../README.md README.md
```

NOTE: a limitation is that the script should be in the parent directory of the
directory it is run from.


## Authors' remarks:

### ABSTRACT

#### Minimal, Universal File Bundling (or, Functional Obfuscation in a Self-Decoding Unix Shell Archive)

```
    "Use an algorithm, go to jail."

    -- anon., circa 1988
```

**HISTORICAL NOTE**: This entry was submitted just before the
[Morris worm](https://en.wikipedia.org/wiki/Morris_worm) era.

Myriad formats have been proposed for network-mailable data. A major difficulty
undermining the popularity of most file/message bundlers is that the sender
assumes prior installation of the computational dual of such bundling software
by the receiver. Command shell archives alleviate this problem somewhat, but
still require standardization for the function of data compression and
mail-transparency encoding. On Unix, these coding format quandaries are overcome
by planting a novel [Trojan
Horse](https://en.wikipedia.org/wiki/Trojan_horse_&#x28;computing&#x29;) in the archive
header to perform negotiation-less decoding.

Specifically, we outline the development of an extraordinarily compact portable
bundler/extractor to (dis)assemble data-compressed, binary-to-ASCII-converted,
length-split, and checksummed directory structures using standard Unix tools.
Miniature versions of counterparts to a Lempel-Ziv coder (`compress` or
`squeeze`) and an efficient bit packetizer (`btoa`) are compiled on-the-fly at
mail destination sites where they may not already exist. These are written in
purposefully obfuscated-C to accompany similarly-shrunk shell command glue. This
resulting shell archiver is dubbed `shark`.

`shark` procedure overhead consumes as few as three dozen shell commands (or
`~1100` bytes), commensurate with the size of many Internet mail headers; it
amortizes favorably with message size. `shark` is portable across Unix
variants, while the underlying technique is inherently generalizable to other
encoding schemes.

In the function-theoretic sense of minimal Chaitin/Kolmogorov complexity, and
within a modified Shannon model of communication, the 'shark' effort aims to
construct a "shortest program" for source decoding in the Turing-universal Unix
environment.

```
    Oh, the shark has pretty teeth, dear--
    And he shows them pearly white
    Just a jackknife has Macheath, dear--
    And he keeps it out of sight.

    -- Bertolt Brecht, Threepenny Opera
```


### Portability

We have ported this program to a wide variety of systems. Among
these are:

- SunOS 4.1 / Sun SPARCstation 1 (using both 'cc' and 'gcc 1.37.1')
- SunOS 4.0.3 / Sun 3
- BSD 4.3 / VAX 8650
- SEIUX / Sumitomo Electric Ustation/S
- Sony NEWS-OS 3.3 / Sony NEWS (fairly vanilla 4.3BSD)
- System V.? / Hitachi 2050
- System V.? / NEC EWS 4800
- UNIOS-B / Omron Luna
- Dynix / Sequent Balance ('cc' for Natl. Semi. base + 'gcc 1.36')
- Unicos / Cray 2

### Obfuscation

We (the authors) feel this program is obfuscated for the
following reasons:


0. This is one of the few programs you'll see _WHOSE VERY UTILITY DEPENDS ON ITS
OBFUSCATION_!

1. The contest entry may be used to send its wonderful self to anyone in the
Unix world! Virus writers need not apply...

2. The basic idea is twisted enough to be patentable, but is, out of the
kindness of our hearts (as well as to maintain eligibility for the large IOCCC
prize fund), dedicated to the public domain. Claude Shannon, meet Alan Turing.

3. Meta-obfuscation is via obfuscated description (see _ABSTRACT_).

4. "Literary" allusion. Production code contains a reference to self-reference,
preserved at amazing cost for sheer perversity.

5. Many, many micro obfuscations below, honed over three years time, in shell as
well as C. Ask about the 'tar' pit escape, the `argv[0]` flip, Paul's
`&4294967295` portability hack, the "void where prohibited by flaw" fix, the
`scanf()` space-saver, shift shenanigans, signal madness, `exit()`ing stage
left, and source-to-source transformations galore.

### For extra credit:

Construct `sharkmail`, to auto-split `sharkives` into mailable segments and mail
them. Here's a simple one, which could be extended to enable auto-reassembly
with one shell cmd at the far end.

``` <!---sh-->
    #!/bin/sh
    m=$1; shift
    shark $* | split -800 - /tmp/shark$$
    n=`ls /tmp/shark$$* | wc -l | sed 's/ *//'`
    p=0
    for f in `ls /tmp/shark$$*`
    do
	 p=`expr $p + 1`
	 mail -s "bundle ($p of $n) from '`whoami`'" $m < $f
    done
    rm /tmp/shark$$*
```


### Shark history:

- May 1987: Karl Fox introduces 1023-byte `zcat.c` to USENET.
	     It's too late for the 4th IOCCC.

- May 21, 1987: James A. Woods extends idea to construct self
	     decompressing `shar` Trojan horse, utilizing `cc`, `shar`,
	     `zcat`, & `btoa`; size: 2303 bytes.

- May 23, 1987: `jaw` trims 250 bytes without much thought.

- June 2, 1987: 52 lines of shell, 1991 bytes, now made with `tar`,
	     short-circuit C-compile at far end, dual-use main.c,
	     portability mods. (jaw)

- Mar-May 1988: abortive run at 5th IOCCC.
	     `jaw.c` - 1529 bytes. compile line: 152 bytes.
	     generated funny code with `execvp()` to invoke shell.

- Aug 29, 1988: production version, now at 1830 bytes.

- Jan 1990: Paul Eggert does tour-de-force shark re-engineering.

- May 24, 1990: collaboration yields 999-byte `jaw.c` core (see above)
	     and 1530-byte production shell code (w/comments).
	     Eggert comes through with lion's share of improvements.
	     7th IOCCC code now faster than the `btoa`/`zcat` it replaces.

- May 1990: `jaw` develops experimental replacement using
	     Dan Bernstein's high-compression 'squeeze'.


To which we add:

- June 1990: `shark` wins the IOCCC, finally! :-)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
