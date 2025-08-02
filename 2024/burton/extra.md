# extra

This readme provides a description of the extra files provided, how to use them,
analysis of their results, and a deeper investigation on the failed guesses.

The recommendation is to do:

``` <!---sh-->
    make tools

    ./run dict blast swept      # exhaust runs this command a LOT!
    ./run dict crate swept      # show the diff between starting words

    mkdir results               # create the results directory
    ./exhaust                   # exhaustive test of all words (~1 hour)
    echo terns | ./word.result  # add the word "terns" to results
    ./mkresults > results.avg   # proc exhaust into a single, small file
```

The files created as output from `exhaust` allow one to view, for each
starting word, how each of the solutions resolve, including the misses.
`mkresults` outputs a 1566 line report showing the starting word, its
average accuracy, and the number of missed words.  To show the number
of guesses and the actual missed words, run `rank` on the desired word:

``` <!---sh-->
    ./rank results/blast

    1 1         # blast guessed itself
    2 112       # 112 words guessed in 2 attempts
    3 867       # 867 words guessed in 3 attempts
    4 1019      # ...
    5 271
    6 41
    foyer       jaunt     shave     wound

    ./avg results/blast

    blast  3.673002       4

    grep blast results.avg

    blast  3.673002       4
```

The C programs allow for (automated) testing:

```
    gen.c - simulate wordle game by generating targets and scoring guesses
        ./gen dict [target]

    dups.c - remove words with(out) repeated letters
         (best starting words have no repeats)
        cat dict | wc -l        # all the words
        cat dict | ./dups | wc -l   # words with repeated letters
        cat dict | ./dups -n | wc -l    # words without repeated letters

    run.c - `gen` and `prog` connected via pipes; allows automated testing
        ./run dict [start [target]]
            start - the first guess
            target - force the target to be the named word
```


## Using More Guesses

If you wish to see the failed words in action, and if more guesses would
work, try:

```
    ./run dict blast jaunt | grep ^gen

    gen: target: jaunt
    gen: blast bbybg
    gen: daunt bgggg
    gen: haunt bgggg
    gen: gaunt bgggg
    gen: vaunt bgggg
    gen: taunt ygggg
    gen result end=0: n 6 lose: jaunt

    GUESSES=7 ./run dict blast jaunt | grep ^gen

    gen: target: jaunt
    gen: blast bbybg
    gen: daunt bgggg
    gen: haunt bgggg
    gen: gaunt bgggg
    gen: vaunt bgggg
    gen: taunt ygggg
    gen: jaunt ggggg
    gen result end=2: y 7 good: jaunt
```

Using `GUESSES=9` and `exhaust`, one gets a metric that scores words without
misses, allowing a better comparison on the average score.  Note, however,
that the game doesn't bend this way, and anything more than 6 guesses is a
loss.  Take this metric with a grain of salt.  Also, 9 is the limit of
guesses; the program will not work properly - if at all - with more than
9 guesses.

Ranking by fewest missed with GUESSES=6, the order is:

```
    blast palsy climb flash lapse
```

Ranking by average with GUESSES=6, the order is:

```
    crate slate trace crane least
```

Ranking by average with GUESSES=9, the order is:

```
    slate trace crate train least
```

To reproduce these results:

```
    GUESSES=9 ./exhaust results.9
    ./mkresults results.9 > results.9.avg
```


## Simple Analysis

The 1566 raw files produced by `exhaust` are ~370KB each (total ~562MB),
far too large to submit, so included are the compressed results files for
four starting words, and the summary file `results.avg`.

```
    blast   fewest missed
    crate   best average
    query   most missing
    terns   example used in remarks
```

The program `rank` allows one to see how the averages are calculated, as well
as the actual missed words.  Comparing the results for `blast` and `terns`:

```
    ./rank r.terns | awk 'NF==2' > a
    ./rank r.blast | awk 'NF==2' > b
    join a b | column -t

    guesses   terns  blast
    --------  -----  -----
    2           110    112
    3           909    867
    4           960   1019
    5           265    271
    6            53     41

    F            18      4  (failed puzzles)
```

In general, the program `avg` is easier to use, but conveys less information:

```
    ./avg r.terns; ./avg r.blast
    terns  3.641469      18
    blast  3.673002       4
```

You have to decide if you prefer a marginally lower average, but slightly
higher chance of losing, versus a marginally higher average and lower chance
of losing.  This is developed further in the following section.

It is interesting that the letter order makes a noticeable difference:

```
    ./avg r.terns; ./avg results/stern
    terns  3.641469      18     # lower average and fewer misses
    stern  3.658315      20
```

For completeness, using `GUESSES=9` and the full starting dictionary from
Wordle(tm), here are the results for the "best" starting words: `salet`,
`slate`, and `blast`.

```
    guesses  salet  slate  blast
    -------  -----  -----  -----
    1            0      1      1
    2          148    146    112
    3          932    939    867
    4          925    919   1019
    5          240    235    271
    6           56     57     41
    ---      -----  -----  -----
    7           11     13      4
    8            2      4      0
    9            1      1      0
    ---      -----  -----  -----
    avg      3.641  3.644  3.685
```

Obviously, `salet` produces the best results, excepting the losses (14).
Just re-arranging the letters into `slate` produces almost the same,
but there are more losses (18).  If attempting to minimize losses,
then `blast` is the optimal starting guess, since it never takes more
than 7 guesses and has the fewest losses (4) of any starting word in the
combined full Wordle(tm) dictionary.

NB: The averages for `GUESSES=9` are larger than the default,
because the misses are essentially folded into the average.
The averages are more accurately compared when using the higher limit,
although minimizing losses remains the priority (who likes to lose?).


## Seek These

The starting words with the fewest misses with `dict`:

```
    sort -k3n results.avg | sed 18q | awk '{print $1, $3}' | column -t | pr -t -3

    blast  4        ralph  7        crawl  8
    palsy  6        ranch  7        crumb  8
    climb  7        shawl  7        grasp  8
    flash  7        tramp  7        lymph  8
    lapse  7        clash  8        spark  8
    prowl  7        clasp  8        swamp  8

The starting words with the best accuracy:

    sort -k2n results.avg | sed 18q | pr -t -3

    crate  3.586609  20 irate  3.611231  31 trice  3.617279  15
    slate  3.586609  18 slice  3.612095  22 cater  3.620302  26
    trace  3.588769  18 stale  3.612959  19 satin  3.621598  19
    crane  3.595248  26 train  3.613391  14 snail  3.621598  19
    least  3.599568  19 trade  3.613823  20 stare  3.621598  19
    plate  3.606479  22 leant  3.616415  18 dealt  3.622462  15

    Note the word with fewest misses, `blast`, is relatively far
    down the list in accuracy at 178th best:

    sort -k2n results.avg | pr -t -n | grep blast

    178 blast  3.673002  4
```

Versus starting words with fewest misses:

```
    egrep 'terns|lapse|blast|climb|crate' results.avg

    blast  3.673002  4
    climb  3.772354  7
    crate  3.586609  20
    lapse  3.664795  7
    terns  3.641469  18

             weighted avg
    #  blast  crate  blast   crate    improvement
    -  -----  -----  ---------------  -----------
    1      1      1  1.0000  1.0000    0.0000
    2    112    147  1.9912  1.9932   -0.0020
    3    867    952  2.8837  2.8645   -0.0192
    4   1019    884  3.4527  3.3951   -0.0576
    5    271    250  3.6374  3.5775   -0.0599
    6     41     61  3.6794  3.6429   -0.0365

    F      4     20  -16    +16 (0.26% blast vs 1.28% crate)
```

Notice the difference in the average and weighted average.  The program
`avg` simply takes the total guesses as a percentage of the total words.
The program `wavg` takes each of the six scores and weights them by the
score.  I wrote `wavg` later to track my progress playing the online game,
and it is a more accurate score IMHO, but both are useful for comparisons.

``` <!---sh-->
    $ ./avg results/blast
    blast  3.673002  4
    $ ./rank results/blast
    1 1
    2 112
    3 867
    4 1019
    5 271
    6 41
    foyer         jaunt     shave     wound
    $ ./wavg 1 112 867 1019 271 41
    3.6794
```

The program `wrank` (weighted rank) makes this latter calculation much easier.
It takes the output from `rank` and invokes `wavg` with these numbers,
saving a lot of typing and errors.

``` <!---sh-->
    ./wrank blast
    blast 3.6794
```

In words, `crate` as a first guess gets more correct answers in 2 and 3
guesses, reducing its cost.  It looks to be a stronger candidate, but it
misses 16 more words (therefore losing the game more often).  Your task
is to determine your risk profile, and decide among the variety of possible
starting points, then let `prog` recommend your next guess.

A somewhat laborious calculation provides the answer to which starting word
has the most answers in two words and three words:

```
    # two words
    for n in results/*; do
        rank $n | awk -v word=$n '/^2/ {print word,$2}';
    done | sort -k2nr | sed 3q

    trace 149
    crate 147
    slate 146

    # three words
    for n in results/*; do
        rank $n | awk -v word=$n '/^3/ {print word,$2}';
    done | sort -k2nr | sed 4q

    crate 952
    train 944
    trace 939
    slate 936

    # versus the averages
    sort -k2n -k3n results.avg | sed 3q
    slate  3.586609      18
    crate  3.586609      20
    trace  3.588769      18
```


## Avoid These

The starting words with the worst accuracy:

```
    sort -k2nr results.avg | sed 18q | pr -t -3

    jumpy  3.997408  21 juicy  3.954212  39 squib  3.927862  28
    jumbo  3.996976  25 quake  3.952052  38 quark  3.926566  30
    buxom  3.995248  23 jerky  3.950756  31 quoth  3.920950  33
    quick  3.987041  36 equip  3.939957  22 gawky  3.918790  22
    quack  3.974514  23 quasi  3.938661  32 unzip  3.915335  24
    quirk  3.964147  40 epoxy  3.934773  27 judge  3.914903  33
```

The starting words with the most failures (missed words):

```
    sort -k3nr results.avg | sed 18q | pr -t -3

    query  3.893305  43 juicy  3.954212  39 enjoy  3.890713  37
    quite  3.835421  42 quota  3.881641  39 gauze  3.878186  37
    yield  3.740821  41 quake  3.952052  38 oxide  3.888121  37
    juice  3.847084  40 quiet  3.857451  38 fiery  3.772786  36
    quirk  3.964147  40 quote  3.829374  38 quail  3.893737  36
    axion  3.796544  39 unify  3.862203  38 quick  3.987041  36
```

The worst target words, for any starting word (N out of 1566):

```
    ./worst

    wound 1340    jaunt 1254    hatch 1157    foyer 1109    waste 1057
    found 997     shave 945     wight 943     willy 790 catch 779
    boxer 762     jolly 751     graze 626     rower 611 fatty 598
    roger 568     taunt 520     watch 497     witty 483 wooer 451
    tight 449     bound 442     swore 415     taste 405 mower 378
    hover 374     bunch 371     shake 358     racer 348 rarer 294
    paper 289     water 285     stave 271     ferry 250 fever 242
    fully 241     paddy 239     fight 225     parer 219 taffy 207
    frown 196     joker 195     filly 188     batty 179 lowly 179
    staff 176     jazzy 174     piper 152     vying 152 swear 151
```


## SPOILER Deep Dive on Near Misses SPOILER

Dissecting the failed targets when starting with `blast`.  Recall `blast`
only misses 4 words out of all 2315:

```
    foyer       jaunt     shave     wound
```

These four words have common sub-patterns, which in hard-mode is difficult
to disambiguate.  Using `run dict blast $word`, here are the grep sub-patterns
and counts for these four words as revealed in the output:

```
    foyer   25  grep '^.o.er' dict | wc -l
    jaunt    6  grep '^.aunt' dict | wc -l
    shave    7  grep '^sha.e' dict | wc -l
    wound    8  grep '^.ound' dict | wc -l
```

Looking at the patterns, the program is making guesses that just happen to
select the correct word last in its choices.  In all cases, on the seventh
guess, the program has the correct answer using `blast` as the starting guess.
It is easy to do an exhaustive look for only four words, but as the count
goes up, so does the work.

Several variations were attempted, including randomization of the few results
remaining.  Besides being non-deterministic (this time it wins, next time it
loses), better results were obtained with other changes to the selection
algorithm.  Some small insight into the algorithm used may be seen by the
`grep` command lines, although there are additional insights used within
the program that improve significantly upon these results.

```
    ./run dict blast foyer | grep ^gen
    gen: target: foyer  2315
    gen: blast bbbbb    429 grep -v '[blast]' dict | wc -l
    gen: drone byyby    27  grep r dict | grep o | grep e | grep -v '[blastdn]' | wc -l
    gen: cower bgbgg    8   grep '^.o.er' dict | grep -v '[blastdncw]'
                        foyer homer hover joker
                        mover poker roger rover
    gen: mover bgbgg    4   grep '.o.er' dict | grep -v '[blastdncwmv]'
                        foyer joker poker roger
    gen: poker bgbgg    rm poker joker (foyer roger)
    gen: roger ygbgg    rm roger (foyer)
    gen result end=0: n 6 lose: foyer

    ---------------

    ./run dict blast jaunt | grep ^gen
    gen: target: jaunt  2315
    gen: blast bbybg    46  grep 't$' dict | grep a | grep -v '[bls]' | wc -l
    gen: daunt bgggg    5   grep '^.aunt$' dict | grep -v '[blsd]'
                        gaunt haunt jaunt taunt
                        vaunt
    gen: haunt bgggg    rm haunt (gaunt, jaunt, taunt, vaunt)
    gen: gaunt bgggg    rm guant (jaunt, taunt, vaunt)
    gen: vaunt bgggg    rm vaunt (jaunt, taunt)
    gen: taunt ygggg    rm taunt (jaunt)
    gen result end=0: n 6 lose: jaunt

    ---------------

    ./run dict blast shave | grep ^gen
    gen: target: shake  2315
    gen: blast bbgyb    52  grep '^..a' dict | grep s | grep -v '[blt]' | wc -l
    gen: share gggbg    5   grep '^sha.e' dict | grep -v '[bltr]'
                        shade shake shame shape
                        shave
    gen: shade gggbg    rm shade (shake shame shape shave)
    gen: shape gggbg    rm shape (shake shame shave)
    gen: shame gggbg    rm shame (shake shave)
    gen: shake gggbg    rm shake (shave)
    gen result end=0: n 6 lose: shave

    ---------------

    ./run dict blast wound | grep ^gen
    gen: target: wound  2315
    gen: blast bbbbb    429 grep -v '[blast]' dict | wc -l
    gen: drone ybygb    7   grep 'n.$' dict | grep d | grep o | grep -v '[blastre]' | wc -l
    gen: pound bgggg    4   grep '^.ound' dict | grep -v '[blastreh]'
                        found hound mound wound
    gen: mound bgggg    rm mound (found, hound, wound)
    gen: hound bgggg    rm hound (found, wound)
    gen: found bgggg    rm found (wound)
    gen result end=0: n 6 lose: wound
```
