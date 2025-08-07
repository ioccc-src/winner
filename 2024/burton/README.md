## Award presentation:

Watch the [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse)
YouTube show for this entry:

> [IOCCC28 - 2024/burton - Prize in pentagrammatology](https://www.youtube.com/watch?v=PQGCfnVmmNA)


## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog dict
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

We were impressed with the algorithm, but one question remains: is there a
strategy which reduces the probability of a loss even further, at the cost of
requiring a higher average number of guesses?


## Author's remarks:

This program is an assistant for solving hard-mode [Wordle(tm)][1]
(you must use any revealed hints in all subsequent guesses)
accurately/efficiently - in the fewest guesses.
The program expects lower case input in two words: `guess color`,
followed by newline.

- `guess` is the 5 letter word you guessed,
- `color` is 5 letters from the set [g,y,b]

that correspond to the colors shown in Wordle: g=green, y=yellow, b=black.

[1]: https://www.nytimes.com/games/wordle/index.html

Start the program with a single argument, the name of a dictionary of words.
`/usr/share/dict/words` is a perfectly cromulent dictionary,
but the included file `dict` contains the 2315 target words from the original
Wordle game and consistently provides the fewest guesses.

As an example session, Wordle 226 has the target word `light`.
The recommended first guess (for all Wordle puzzles) is `blast`, `terns`,
or `crate` (see the [extra.html](extra.html) that accompanies this entry for details).

Enter `terns` in game 226 of Wordle, and click the enter button.
The letters will turn yellow, black, black, black, black.
This assistant prompts "? ", and the input expected is the guessed word
followed by the first letters of the color revealed for that guess:

``` <!---sh-->
    $ prog dict
    ? terns ybbbb
    loath
    ? loath gbbyy
    light
    $
```

The program responds with the recommended next guess.  Enter
this word `loath` into the game, which then reveals the colors
green, black, black, yellow, yellow.  Typing `loath gbbyy` into
this assistant shows the solution is `light`, and exits.
Type this word into the game, click enter, and viola!
Solved in 3 guesses: terns > loath > light.

This program averages better than 4 guesses on the 1566 starting words
without duplicate letters created by `./dups -n < dict`,
ranging from 3.587 to 3.997, with an overall average of 3.748 guesses.

This is excellent performance, and close to optimal.
See this YouTube presentation on [solving Wordle using information theory][2],
which shows a hard mode average of 3.562 when using `crane`
(time offset 29:58).  There is a small correction video changing
[`crane` to `salet`, `trace` or `crate`][3].
NB: These videos are NOT spoilers for this algorithm.

[2]: https://www.youtube.com/watch?v=v68zYyaEmEA
[3]: https://www.youtube.com/watch?v=fRed0Xmc2Wg

`prog` does NOT require you to use its offered guess.
If you think you have a better guess than offered,
simply type your guess and the Wordle/`gen` responses into `prog`;
it will internally re-adjust using your input instead of its guess,
and produce what it thinks is the best next guess after your input.


### A Feature

Caution: When there are duplicate letters in the guess word,
and one of them is marked black and the other non-black,
this program MUST have the black letter marked *yellow*.
The example session (Wordle 228) below demonstrates this:

```
    # do NOT do this
    $ prog dict
    ? terns bbbby
    shoal
    ? shoal gggbb
    shook
    ? shook gggbg  <<-- this is what Wordle shows
    xyzzy          <<-- no candidate words match

    # do THIS instead
    $ prog dict
    ? terns bbbby
    shoal
    ? shoal gggbb
    shook
    ? shook gggyg  <<-- not gggbg as shown in the game
    shock
    ? shock ggggg
    shock
```

In the guess word `shook`, there are 2 o's, but only one shown valid in
the puzzle.  If you mark the leftmost o as black (as according to the
Wordle game), this program cannot find the winning word (`shock`),
producing the error word `xyzzy`.

The included simulator `gen` produces the required transformation of b -> y.

The extra program `run` connects `gen` and `prog`, allowing for quick tests.

```
    make tools
    ./run dict terns shock  # test starting guess `terns` against target `shock`
```

Using `run` allows one to quickly and easily experiment with different
starting words for different target words, seeing how the guesses progress.

(A late tweak to the program improved its accuracy, and in the above example,
the progression is now terns > shoal > shock.  However, the caution remains
for any duplicate letter guesses.)


### Failure mode

The following 4 words from the included file `dict` are not guessed correctly
within 6 guesses when using the recommended (via exhaustive testing)
starting guess of `blast`.  Since this program is deterministic, these
four words always require 7 guesses when starting with `blast`, yielding
a failure rate of 4/2315, or a success rate of 99.8%.

```
    foyer  jaunt  shave  wound
```

Using the ancillary programs `run`, `exhaust`, and `mkresults`,
the starting word `blast` yields the fewest misses at these four words,
with an accuracy/efficiency of 3.67. See [extra.html](extra.html)
for more detail.

This program also has a benefit the game Wordle does not:
Wordle allows several thousand extra words to use in guesses not in `dict`.
This program does not restrict _any_ words, so one could enter any
combination of 5 letters as input, except these are unlikely to be accepted
by the Wordle game, and this program selects its words from the much more
limited set that is present in `dict`.  Using an expanded dictionary like
`/usr/share/dict/words` provides a richer set of guesses, but generally
increases the average number of guesses and the failure rate.


### Interesting questions

- How are candidate words chosen?
- How does the array of numbers relate to finding a word?
- It is interesting to see the final stages of picking a word.
  You might be interested to add observability?  (Hint: `make tfmt`)
  Although `clang-format` is unlikely to help you understand the code,
  `printf`'s will help you understand how the "tables" are used:

    "Show me your flowcharts and conceal your tables,
    and I shall continue to by mystified;
    show me your tables and I won't usually need your flowcharts...."
    -- Fred Brooks

- There is a plausible "tunable", not exposed.  It selects when to
  discard certain words.  What is this value, and how important is this
  value in optimizing results?
- There is a debatable "bug" in the code, but it actually _improves_ the
  results.  Where and why?
  Hint: the limit `for` a loop. ;-)
- This solver/assistant is pretty interesting to play with, experiment with.
  Can you improve it?


### Did you notice?

- Wordle is spelled in the code several different ways, one is obscure.
  If you need help, try this command (which requires `clang-format`):

```
    make spoiler
```

- My second favorite language is spelled out thrice in the source code.
- Variables are mostly generic a,b,c and i,j,k,l and reused in different
  scopes.  Have fun!
- The Sierpinski[4] number?  What in the world is a Sierpinski number?

[4]: https://planetmath.org/sierpinskinumber


### Time Passages (Apologies to Al Stewart)

This code was written in mid January 2022, before the NYT purchased Wordle[tm].

I have since used this assistant to play the game for more than a year,
confirming my local experiments.

![wordle stats](./2024_01_18_wordle_stats.png)

The dictionary changed in 2023!  In late March 2023, I encountered the first
word not in `dict`: `guano`.  In a bit of a surprise, I tried:

```
    blast bbgbb
    reach bbgbb
    piano bbggg
    xyzzy
```

What?  The only word in `dict` ending in `ano` is `piano`.  So I tried again
using `/usr/share/dict/words`:

```
    blast bbgbb
    crane bbggb
    guano ggggg
```

Blending the two, the puzzle was guessed in 4 tries total:

```
    blast > reach > piano > guano
```

So caveat emptor: while `dict` used to be authoritative, we know some words
were deemed offensive and removed.  More problematic, some words were added,
although I am presently unaware of which words.  The existence proof is the
above mentioned `guano`.  There are almost certainly other words missing.

With `guano` added to `dict`, it is guessed in 3 using `blast` as the
starting word:

```
    blast bbgbb
    reach bbgbb
    guano ggggg
```

NB: `dict` has not been changed. `gauno` was NOT added to `dict`.
Adding this word changes the statistics, and thus requires a change
to all this material.  It has a *slightly* negative impact, except
for it finds the word `guano`.  Essentially, as you add new words
to `dict`, the permutations expand, and the scores decrease.  This is
why `/usr/share/dict/words` scores worse than `dict` - and loses more often.

April 9, 2023, this problem repeated with the target word `snafu`.
That seems apropos.

```
    $ ./prog dict
    blast bbgyb
    share gbgbb
    spank gbgyb
    xyzzy

    $ ./prog /usr/share/dict/words
    blast bbgyb
    share gbgbb
    spank gbgyb
    snafu ggggg
```

And on June 9, 2023, again.  This time, it cost nothing, and won on the
second guess.

```
    $ ./prog dict
    blast gyygb
    xyzzy

    $ ./prog /usr/share/dict/words
    blast gyygb
    balsa ggggg
```

June 19, 2023, another one wasn't working, so time for a better dictionary:

```
    $ ./prog dict
    blast bbybb
    ramen bgbbb
    vapid bgbbb
    wacky bgbyb
    xyzzy

    # a copy of /usr/share/dict/words with five letters and no capitals:
    grep '^.....$' /usr/share/dict/words | grep -v '[A-Z]' > ./usdw

    $ ./prog usdw
    blast bbybb
    redan bbbyb
    campo bgbbg
    wahoo bgbgg
    kazoo ggggg
```

As of June 19, 2023, it is known that at least these words have been added
(more are likely).  Using `./usdw` as above, `prog` guesses these words in:

```
    guano 3
    snafu 4
    balsa 2
    kazoo 5
```

See the [extra.html](extra.html) for more details on the program `run`:

```
    for n in guano snafu balsa kazoo; do
        ./run usdw blast $n;
    done | grep good
```

As of April 22, 2024, add the word `laser` in 3 guesses.

```
    $ ./prog usdw
    blast byyyb
    solea ybygy
    laser ggggg
```

And May 8, 2024 brings on `pious` in 4 guesses (after the failure with `dict`):

```
    $ prog dict
    blast bbbyb
    siren ygbbb
    ficus bgbgg
    xyzzy

    $ prog usdw
    ? blast bbbyb
    serio
    ? siren ygbbb
    pisco
    ? ficus bgbgg
    pious
    ? pious ggggg
```

Notice here that the suggested word was NOT used, instead the original
guesses were used, and it found the correct answer in 4 guesses.
However, doing

```
    ./run usdw blast pious
```

gets the answer correct in 3 guesses: blast > serio > pious.

And Sep 17, 2024 brings us the word `beaut`.

```
    $ prog dict
    blast gbgbg
    xyzzy

    $ prog usdw
    blast gbgbgb
    beant -- not allowed, so removed beant from usdw
    brant gbgbg
    beaut ggggg
```

Three guesses using an alternate dictionary and having to remove `beant`.
This word isn't even a word I can find in Webster's.  I hope your version
of `/usr/share/dict/words` has more cromulent words.

Oct 9, 2024 brings the word `mommy`.

```
    $ prog dict
    blast bbbbb
    drone bbybb
    pouch bgbbb
    foggy bgbbg

    $ prog usdw
    blast bbbbb
    drone bbybb
    pouch bgbbb
    foggy bgbbg
    mommy ggggg
```

Fortunately, the program is good enough that failing with one
dictionary still allows you to switch dictionaries and win.

Nov 13, 2024 brings `primp`.

```
    $ ./prog dict
    blast bbbbb
    drone bgbbb
    crimp bgggg
    xyzzy

    $ ./prog usdw
    blast bbbbb
    drone bgbbb
    crimp bgggg
    primp ggggg
```

Jan 20, 2025 brings the word `squid`.

```
    $ ./prog dict
    blast bbbyb
    siren gybbb
    skimp gbybb
    sushi <<-- last plausible word

    $ ./prog usdw
    blast bbbyb
    siren gybbb
    skimp gbybb
    sushi sgbby
    squid ggggg
```

As of Jan 20, 2025, the ten known words not in `dict` are
(scores are using `usdw`, not `dict`, which lacks these words):

```
    guano 4
    snafu 5
    balsa 3
    kazoo 4
    laser 3
    pious 4
    beaut 3
    mommy 4
    primp 5
    squid 4
```

Feb 18, 2025 adds a word not in `dict` nor `usdw`.  "indie".

```
    $ ./prog dict
    blast bbbbb
    drone ybbyg
    undue bggbg
    xyzzy

    $ ./prog usdw
    blast bbbbb
    drone ybbyg
    undue bggbg
    xyzzy

    I grep'd the dictionaries.  No plausbile hits.
    So I solved it the old fashioned way: I guessed.

    blast bbbbb
    drone ybbyg
    undue bggbg
    indie ggggg

    This solved it in 4, but the program could not win.
    So add to the summary list above:

    indie 4
```


### Compilation

Compiles cleanly with `-Wall -Wpedantic -Wextra`,
on MACOS M2 Clang/GCC 14 and Linux X86 Gcc 8.5.

If you are using `-Weverything`,
which IMHO is exceptionally noisy about non-problems,
and given the requirements of obfuscation and layout,
there are a few `-Wno-` flags required to achieve a
quiet compilation:

```
    -Wno-poison-system-directories \
    -Wno-missing-variable-declarations \
    -Wno-shadow \
    -Wno-vla \
    -Wno-missing-prototypes \
    -Wno-shorten-64-to-32 \
    -Wno-format-nonliteral \
    -Wno-implicit-int-conversion \
    -Wno-declaration-after-statement \
    -Wno-comma \
    -Wno-array-bounds-pointer-arithmetic \
    -Wno-sign-conversion
```

The code uses variable length arrays, omitted the keyword `static`
for functions and global variables, and collide `size_t` with `int`
for return types. There are no pedantic prototypes for functions.
There is no misuse of the comma operator, but try getting the compiler
to ignore it.  The code has been run on MacOS M2 and Linux x86 with
no failures observed.  And as documented in [deobfuscated.html](deobfuscated.html),
pointer bounds are intentionally abused for obfuscation, but the
code is correct as documented.
This is obfuscated C, so yes, variables are intentionally shadowed.
`printf()` is also abused, passing in non-literals as the format.

Perhaps there is some platform out there that won't work correctly
due to the omissions noted above, but I am unaware of these.


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
