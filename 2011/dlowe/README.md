## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: missing or dead link - please provide them
    STATUS: INABIAF - please DO NOT fix
```

For more detailed information see [2011/dlowe in bugs.html](../../bugs.html#2011_dlowe).


## To use:

``` <!---sh-->
    ./dlowe -<n_iterations> corpus1/ [...] corpus0/ < start.net > trained.net
```

NOTE: In the above command, the directory args MUST end in a `/`.

Then to use `trained.net`:

``` <!---sh-->
    ./dlowe file [file ...] < trained.net
```


## Try:

Try these pre-trained networks:

``` <!---sh-->
    ./try.sh
```

NOTE: The [dlowe-aux-data](%%REPO_URL%%/2011/dlowe/dlowe-aux-data) directory, which [try.sh](%%REPO_URL%%/2011/dlowe/try.sh) refers to, was
created by:


``` <!---sh-->
    tar -jxf dlowe-aux-data.tar.bz2
```


## Judges' remarks:

This entry is a ghoulish example of a brain (dead?) neural network classifier.
It comes with a set of corpora for you to try.


### `ioccc-winlose-trained.net`

You can create your own trained networks.  For example, we trained a network
on the C code of entries that were supplied to the 20Th IOCCC.

The `ioccc-winlose-trained.net` was trained using the
[earlystop.pl](%%REPO_URL%%/2011/dlowe/earlystop.pl) tool:

``` <!---sh-->
    rm -f ioccc-winlose-trained.net
    ./earlystop.pl ioccc-winlose-trained.net ioccc_won_training/ ioccc_lost_training/ ioccc_won_test/ ioccc_lost_test/
```

where:

- `ioccc_won_training/`
    1/2 of C code of the 20th IOCCC entries (except for [dlowe.c](%%REPO_URL%%/2011/dlowe/dlowe.c) from 2011)
    plus 1/2 of the C code winning entries from prior IOCCC contests

- `ioccc_won_test/`
    1/2 of C code of the 20th IOCCC entries (except for [dlowe.c](%%REPO_URL%%/2011/dlowe/dlowe.c) from 2011)
    plus 1/2 of the C code winning entries from prior IOCCC contests

- `ioccc_lost_training/`
    1/2 of C code from entries that that did not win

- `ioccc_lost_test/`
    1/2 of C code from entries that that did not win

NOTE: The above directories were not shipped and everything from the entries
that did not win were flushed to `/dev/null`.

The [earlystop.pl](%%REPO_URL%%/2011/dlowe/earlystop.pl) tool wrote:

```
    training 1 to 1001...
    training 1001 to 2001...
    prior error = 56.746974766043; current error = 58.095691135305
```

The resulting `ioccc-winlose-trained.net` file was included in the
[dlowe-aux-data.tar.bz2](dlowe-aux-data.tar.bz2) tarball.

The [dlowe.c](%%REPO_URL%%/2011/dlowe/dlowe.c) was explicitly excluded from this trailing set, so this
test is interesting:

``` <!---sh-->
    ./dlowe dlowe.c < dlowe-aux-data/ioccc-winlose-trained.net
```

NOTE: this is done in [try.sh](%%REPO_URL%%/2011/dlowe/try.sh).


The match of [dlowe.c](%%REPO_URL%%/2011/dlowe/dlowe.c) to the lose/win trailed network was:

```
    dlowe.c 0.125108
```

NOTE: The non-artificially intelligent decisions of the IOCCC judges include random
quirks and their non-linear judgment calls not found in the ioccc trained network.
Just because C code is or isn't scored highly by this network does not
mean it will win or lose a future IOCCC.  On the other hand ... it just might!


#### other data sets to try

While we cannot supply you with the losing IOCCC source code, the author did supply a number
data sets on which to test:

We created the [english-trained.net](%%REPO_URL%%/2011/dlowe/dlowe-aux-data/english-trained.net) as follows:

``` <!---sh-->
    ./dlowe -8000 dlowe-aux-data/english-1/ dlowe-aux-data/english-0/ < /dev/null > dlowe-aux-data/english-trained.net
```

- [dlowe-aux-data/english-0/](%%REPO_URL%%/2011/dlowe/dlowe-aux-data/english-0)
    Non-English (French) text

- [dlowe-aux-data/english-1/](%%REPO_URL%%/2011/dlowe/dlowe-aux-data/english-1)
    English (non-French) text

We created the [png-trained.net](%%REPO_URL%%/2011/dlowe/dlowe-aux-data/png-trained.net) as follows:

``` <!---sh-->
    ./dlowe -8000 png-1/ png-0/ < /dev/null > dlowe-aux-data/png-trained.net
```

- [dlowe-aux-data/png-0/](%%REPO_URL%%/2011/dlowe/dlowe-aux-data/png-0)
    Non-png (gif) images

- [dlowe-aux-data/png-1/](%%REPO_URL%%/2011/dlowe/dlowe-aux-data/png-1)
    png (non-gif) images

We created the [xor-trained.net](%%REPO_URL%%/2011/dlowe/dlowe-aux-data/xor-trained.net) as follows:

``` <!---sh-->
    ./dlowe -8000 dlowe-aux-data/xor-1/ dlowe-aux-data/xor-0/ < /dev/null > dlowe-aux-data/xor-trained.net
```

- [dlowe-aux-data/xor-0](%%REPO_URL%%/2011/dlowe/dlowe-aux-data/xor-0)
    Data that XORs to 0

- [dlowe-aux-data/xor-1/](%%REPO_URL%%/2011/dlowe/dlowe-aux-data/xor-1)
    Data that XORs to 1

**NOTE**: The directory args **must end in a** `/` for them to work.


## Author's remarks:

### Synopsis

This is an [artificially
intelligent](https://en.wikipedia.org/wiki/Artificial_intelligence) judging tool
to help the IOCCC judges.  Here's to shorter, more frequent contests!


### Description

This is a multilayer [perceptron](https://en.wikipedia.org/wiki/Perceptron), a
[feedforward artificial neural
network](https://en.wikipedia.org/wiki/Feedforward_neural_network),
which can be trained, using on-line
[backpropagation](https://en.wikipedia.org/wiki/Backpropagation), to classify input files.

It has a fixed topology of `2^16` input neurons, 6 hidden neurons and 1 output
neuron.

The neurons' activation function is the logistic function `1 / (1 + e ^ -x)`.


### Classifying

``` <!---sh-->
    ./dlowe file [file ...] < trained.net
```

To classify files, one specifies a trained network (on `stdin`) and one or more
files to classify. The program will output one line per successfully-classified
file to `stderr`, with the filename and the classification: a number between 0
and 1.

The interpretation of the classification number depends on how the network was
trained, but it's geared toward interpretation as a *probability* or a
*confidence*.


### Training

``` <!---sh-->
    ./dlowe -<n_iterations> corpus1/ [...] corpus0/ < start.net > end.net
```

**NOTE**: The directory args **must end in a** `/` for them to work.

To train a network, one specifies a starting network (on `stdin`), two or more
corpora (directories containing training data), and the number of training
iterations to run. The program will write some progress data to `stderr` and,
when it's done, will serialize the updated network to `stdout`.

If no input network is given, a random new network will be generated as a
starting point (i.e. provide an empty `stdin`).

The first corpus will be assigned a target value of `1`. The last will be
assigned a target value of `0`. Intervening directories (if any) will be assigned
intermediate target values.

The learning rate is hard-coded as `0.3`. No momentum factor is used.


#### png corpora

The `dlowe-aux-data/png-1` corpus was obtained by manually scraping the first results from an
<https://images.google.com> search for "[obfuscate
filetype:png](https://www.google.com/search?tbm=isch&sxsrf=APwXEddqIU34dxhpFdjEa8emNJKHOkYXIw:1683049158657&source=hp&biw=1727&bih=952&ei=xkpRZLapJtLKkPIP8bGKkAk&iflsig=AOEireoAAAAAZFFY1nbmEUHC74Cmg3Y5rEY1fV7ocASZ&ved=0ahUKEwi2pPXZltf-AhVSJUQIHfGYApIQ4dUDCAY&uact=5&oq=obfuscate+filetype:png&gs_lcp=CgNpbWcQA1AAWABg9QNoAHAAeACAATuIATuSAQExmAEAoAECoAEBqgELZ3dzLXdpei1pbWc&sclient=img&q=obfuscate&tbs=ift:png)".

The `dlowe-aux-data/png-0` corpus was obtained by manually scraping the first results from an
<https://images.google.com> search for "[obfuscate
filetype:gif](https://www.google.com/search?tbm=isch&ved=2ahUKEwiowo7fltf-AhXSOUQIHbJBDp8Q2-cCegQIABAA&oq=obfuscate+filetype:gif&gs_lcp=CgNpbWcQAzoECCMQJzoHCAAQigUQQzoFCAAQgARQ6AxY6AxgpBJoAHAAeACAAUeIAcsBkgEBM5gBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=0UpRZOiVINLzkPIPsoO5-Ak&bih=952&biw=1727&q=obfuscate&tbs=ift:gif)".


##### Results:

* Using these corpora as a training set;
* Using several hundred random `*.gif` and `*.png` files from my home computer as
  a test set;
* Using the included [earlystop.pl](%%REPO_URL%%/2011/dlowe/earlystop.pl) script, which stopped after 67000 iterations.
* Interpreting output of `> 0.5` as "probably a `.png`" and `< 0.5` as "probably
  a `.gif`"

produced a network with about 87% accuracy


#### English corpora

The [english-1](%%REPO_URL%%/2011/dlowe/dlowe-aux-data/english-1) corpus was obtained by manually scraping the first results from
a <https://www.google.com/webhp?lr=lang_en> search for "[paris
filetype:txt](https://www.google.com/search?q=paris+filetype%3Atxt&lr=lang_en&tbs=lr%3Alang_1en&sxsrf=APwXEdeHXyUYdUxCYQQDHmJhbHzX9aARSA%3A1683049834430&source=hp&ei=ak1RZJHUGN_DkPIP26OtkA8&iflsig=AOEireoAAAAAZFFbejA0Xfqoq__FXx--Ok0S6GQjnGnA&ved=0ahUKEwiRsZOcmdf-AhXfIUQIHdtRC_IQ4dUDCAo&uact=5&oq=paris+filetype%3Atxt&gs_lcp=Cgdnd3Mtd2l6EANQAFgAYN4DaABwAHgAgAE-iAE-kgEBMZgBAKABAqABAQ&sclient=gws-wiz)".

The [english-0](%%REPO_URL%%/2011/dlowe/dlowe-aux-data/english-0) corpus was obtained by manually scraping the first results from
a <https://www.google.com/webhp?lr=lang_fr> search for "[paris
filetype:txt](https://www.google.com/search?q=paris+filetype%3Atxt&lr=lang_fr&tbs=lr%3Alang_1fr&sxsrf=APwXEddcsQ-gMhrqSUJo6omWFUl7jQMASg%3A1683049870736&source=hp&ei=jk1RZLevK_fKkPIPjbWN-AU&iflsig=AOEireoAAAAAZFFbnvExHGkcavB5H8F0xsLAWN2KfYFK&ved=0ahUKEwi3rrutmdf-AhV3JUQIHY1aA18Q4dUDCAo&uact=5&oq=paris+filetype%3Atxt&gs_lcp=Cgdnd3Mtd2l6EANQAFgAYLMDaABwAHgAgAE-iAE-kgEBMZgBAKABAqABAQ&sclient=gws-wiz)".


##### Results:

* Using these corpora as a training set;
* Using several dozen additional text files (obtained by the same methods) as a
test set;
* Using the included [earlystop.pl](%%REPO_URL%%/2011/dlowe/earlystop.pl) script, which stopped after
10000 iterations;
* Interpreting output of `> 0.5` as "probably English" and `< 0.5` as "probably
French"

produced a network with 100% accuracy.


### xor corpora

The [xor-1](%%REPO_URL%%/2011/dlowe/dlowe-aux-data/xor-1) corpus consists of two files containing `01`
and `10` respectively.

The [xor-0](%%REPO_URL%%/2011/dlowe/dlowe-aux-data/xor-0) corpus consists of two files containing `00`
and `11` respectively.


##### Results:

Using these corpora as a training set takes about 8000 iterations to learn xor
to within a tolerance of `<0.01`.


### Limitations

The program can't tell you anything meaningful about files with less than two
bytes in them (I'm looking at you, [smr.c](%%REPO_URL%%/1994/smr/smr.c)!)

You must include the trailing directory separator on training directories
(this allows the program to be portable without wasting precious bytes on
figuring out how to concatenate directory and file names...).

Serialized network files are only portable between systems with the same
[floating-point](https://en.wikipedia.org/wiki/Floating-point_arithmetic)
representation and [endianness](https://en.wikipedia.org/wiki/Endianness).

Making sure not to
[overfit](https://en.wikipedia.org/wiki/Overfitting#Machine_learning) the network to the training data is a bit of a
black art. I have enclosed [earlystop.pl](%%REPO_URL%%/2011/dlowe/earlystop.pl), a wrapper script that implements
a simple 'early stopping' algorithm; other techniques are possible.

Bad input (e.g. nonexistent files, non-numeric number of iterations, etc.)
tends to result in empty output.

Given exactly one corpus, the program will crash or produce garbage.

Leaks memory and file descriptors while processing files.

Will crash and die horribly if it runs out of memory.

The Microsoft C compiler doesn't provide a `dirent` API, so to get this working
on a Windows system you'll need cygwin+gcc (tested) or a `dirent` compatibility
library (untested, but they do exist).

Backpropagation doesn't always converge: if you play with this long enough,
you'll eventually have a training session that completely fails to converge.


### Obfuscation

- [Zombies](https://en.wikipedia.org/wiki/Zombie)! (Since neural networks are
modeled after [BRAINS](https://en.wikipedia.org/wiki/Brain), ya know? And
corpus sounds a lot like corpse. And I have 4- and 7-year-old kids ;) )
- Neural networks are interesting, and while the math isn't terribly difficult,
their behavior is difficult to fully understand.
- Had some extra space in one of the major data structures, and it seemed a
shame to waste it.
- Similarly, I think three file pointers ought to be enough for anyone.
- Lots of magic numbers expressed in various ways.
- Random abuse of random C trivia.
- Some textual changes were made to maximize the classification of this program
by a network trained to recognize [IOCCC entries](../../authors.html) ;)

... but mostly zombies!


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
