# Most self deprecating

David Lowe  
434 Tenney Drive  
Rogue River, OR  
97537  
<j.david.lowe@gmail.com>  
<http://www.pootpoot.net/>  


## Judges' comments:
### To build:

    make dlowe

### To run:

    ./dlowe -<n_iterations> corpus1/ [...] corpus0/ < start.net > end.net

	NOTE: The directory entries MUST end in a /

    ./dlowe file [file ...] < trained.net

### Try:

    Download the dlowe-aux-data.tar.bz2 file from:

    	curl -O http://www.ioccc.org/2011/dlowe/dlowe-aux-data.tar.bz2

    tar -jxf dlowe-aux-data.tar.bz2

    ./dlowe dlowe.c < ioccc-winlose-trained.net
    ./dlowe dlowe < ioccc-winlose-trained.net

    ./dlowe xor-0/00 < xor-trained.net
    ./dlowe xor-0/11 < xor-trained.net
    ./dlowe xor-1/01 < xor-trained.net
    ./dlowe xor-1/10 < xor-trained.net

    ./dlowe hint.html < english-trained.net

    ./dlowe dlowe-aux-data.tar.bz2 < png-trained.net

### Selected Judges Remarks:

This entry is a ghoulish example of a brain (dead?) neural network classifier.
It comes with a set of corpora for you to try.

#### ioccc-winlose-trained.net

You can create your own trained networks.  For example, we trained a network
on the C code of entries that were supplied to the 20Th IOCCC.

The ioccc-winlose-trained.net was trained using the earlystop.pl tool:

    rm -f ioccc-winlose-trained.net
    ./earlystop.pl ioccc-winlose-trained.net ioccc_won_training/ ioccc_lost_training/ ioccc_won_test/ ioccc_lost_test/

where:

    ioccc_won_training/
    	1/2 of C code of the 20th IOCCC winners (except for dlowe.c from 2011)
	plus 1/2 of the C code winners from prior IOCCC contests

    ioccc_won_test/
    	1/2 of C code of the 20th IOCCC winners (except for dlowe.c from 2011)
	plus 1/2 of the C code winners from prior IOCCC contests

    ioccc_lost_training/
	1/2 of C code from entries that that did not win

    ioccc_lost_test/
	1/2 of C code from entries that that did not win

    NOTE: The above directies were not shipped and the C code from
    	  entries that that did not win was flushed to /dev/null.

The earlystop.pl tool wrote:

    training 1 to 1001...
    training 1001 to 2001...
    prior error = 56.746974766043; current error = 58.095691135305

The resulting ioccc-winlose-trained.net file was included in the
dlowe-aux-data.tar.bz2 file in the above mentioned URL.

The dlowe.c was explicitly excluded from this trailing set.  So this test is interesting:

    ./dlowe dlowe.c < ioccc-winlose-trained.net

The match of dlowe.c to the lose/win trailed network was:

    dlowe.c 0.125108

NOTE: The non-artificially intelligent decisions of the IOCCC judges include random
      quirks and their non-linear judgment calls not found in the ioccc trained network.
      Just because C code is or isn't scored highly by this network does not
      mean it will win or lose a future IOCCC.  On the other hand ... it just might!

#### other data sets to try

While we cannot supply you with the losing IOCCC source code, the author did supply a number
data sets on which to test:

We created the english-trained.net as follows:

    ./dlowe -8000 english-1/ english-0/ < /dev/null > english-trained.net

	english-0/
	    Non-English (French) text
	english-1/
	    English (non-French) text

We created the png-trained.net as follows:

    ./dlowe -8000 png-1/ png-0/ < /dev/null > png-trained.net

	png-0/
	    Non-png (gif) images
	png-1/
	    png (non-gif) images

We created the xor-trained.net as follows:

    ./dlowe -8000 xor-1/ xor-0/ < /dev/null > xor-trained.net

	xor-0/
	    Data that XORs to 0
	xor-1/
	    Data that XORs to 1

## Author's comments:
# Synopsis:
This is an artificially intelligent judging tool to help the IOCCC judges.
Here's to shorter, more frequent contests!

# Description:
This is a multilayer perceptron (a feedforward artificial neural network)
which can be trained, using on-line backpropagation, to classify input files.

It has a fixed topology of 2^16 input neurons, 6 hidden neurons and 1 output
neuron.

The neurons' activation function is the logistic function 1 / (1 + e ^ -x).

## Classifying

    ./dlowe file [file ...] < trained.net

To classify files, one specifies a trained network (on stdin) and one or more
files to classify. The program will output one line per successfully-classified
file to stderr, with the filename and the classification: a number between 0
and 1.

The interpretation of the classification number depends on how the network was
trained, but it's geared toward interpretation as a *probability* or a
*confidence*.

## Training

    ./dlowe -<n_iterations> corpus1/ [...] corpus0/ < start.net > end.net

    NOTE: The directory args must end in a / for them to work.

To train a network, one specifies a starting network (on stdin), two or more
corpora (directories containing training data), and the number of training
iterations to run. The program will write some progress data to stderr and,
when it's done, will serialize the updated network to stdout.

If no input network is given, a random new network will be generated as a
starting point (i.e. provide an empty stdin).

The first corpus will be assigned a target value of 1. The last will be
assigned a target value of 0. Intervening directories (if any) will be assigned
intermediate target values.

The learning rate is hard-coded as 0.3. No momentum factor is used.

### png corpora

The png-1 corpus was obtained by manually scraping the first results from an
https://images.google.com search for "obfuscate filetype:png".

The png-0 corpus was obtained by manually scraping the first results from an
https://images.google.com search for "obfuscate filetype:gif".

Results:

 * using these corpora as a training set
 * using several hundred random *.gif and *.png files from my home computer as
   a test set
 * using the included "earlystop.pl" script, which stopped after 67000 iterations.
 * interpreting output of "> 0.5" as "probably a .png" and "< 0.5" as "probably
   a .gif"
 * produced a network with about 87% accuracy

### english corpora

The english-1 corpus was obtained by manually scraping the first results from
a https://www.google.com/webhp?lr=lang_en search for "paris filetype:txt".

The english-0 corpus was obtained by manually scraping the first results from
a https://www.google.com/webhp?lr=lang_fr search for "paris filetype:txt".

Results:

 * using these corpora as a training set
 * using several dozen additional text files (obtained by the same methods)
   as a test set
 * using the included "earlystop.pl" script, which stopped after 10000
   iterations.
 * interpreting output of "> 0.5" as "probably english" and "< 0.5" as
   "probably french"
 * produced a network with 100% accuracy

### xor corpora

The xor-1 corpus consists of two files containing '01' and '10' respectively.

The xor-0 corpus consists of two files containing '00' and '11' respectively.

Results:

 * using these corpora as a training set
 * takes about 8000 iterations to learn xor to within a tolerance of <0.01

# Limitations
The program can't tell you anything meaningful about files with less than two
bytes in them (I'm looking at you, smr.c!)

You must include the trailing directory separator on training directories
(this allows the program to be portable without wasting precious bytes on
figuring out how to concatenate directory and file names...)

Serialized network files are only portable between systems with the same
floating-point representation and endianness.

Making sure not to overfit the network to the training data is a bit of a
black art. I have enclosed 'earlystop.pl', a wrapper script that implements
a simple 'early stopping' algorithm; other techniques are possible.

Bad input (e.g. nonexistent files, non-numeric number of iterations, etc.)
tends to result in empty output.

Given exactly one corpus, the program will crash or produce garbage.

Leaks memory and file descriptors while processing files.

Will crash and die horribly if it runs out of memory.

The Microsoft C compiler doesn't provide a dirent API, so to get this working
on a Windows system you'll need cygwin+gcc (tested) or a dirent compatibility
library (untested, but they do exist).

Backpropagation doesn't always converge: if you play with this long enough,
you'll eventually have a training session that completely fails to converge.

# Obfuscation:

Zombies! (Since neural networks are modeled after BRAINS, ya know? And
corpus sounds a lot like corpse. And I have 4- and 7-year-old kids ;)

Neural networks are interesting, and while the math isn't terribly difficult,
their behavior is difficult to fully understand.

Had some extra space in one of the major data structures, and it seemed a
shame to waste it.

Similarly, I think three file pointers ought to be enough for anyone.

Lots of magic numbers expressed in various ways.

Random abuse of random C trivia.

Some textual changes were made to maximize the classification of this program
by a network trained to recognize ioccc winners ;)

... but mostly zombies!

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2012, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
