# Most in need to be tweeted

Christopher Mills  
Twitter: @MisterXopher  


## Judges' comments:
### To use:

    make

    make cpclean
    # Let this run for about about an hour and then kill it
    ./prog Shakespeare.txt
    ./prog < $(< ls -1tr cp* | tail -1) | head -100

### Try:

    # If you are on a 64-bit system:

    make test-64bit

    less IOCCC-Rules-Guidelines.output.txt

    less IOCCC-hints.output.txt

    less Eugene_Onegin.output.txt

    # However, as the binary model files used to produce the output are in an implementation-specific format,
    # your mileage may vary.

### Selected Judges Remarks:

Can a machine learn?

Some say so.

But can a machine learn to write like Shakespeare,

or tweet like [Trump](http://trumptwitterarchive.com)?

Can it write rules and guidelines for the IOCCC?

You decide. :-)


## Author's comments:

Welcome to OMLET! &#x1f373;
=================

OMLET is the _Obfuscated Machine Learning Environment Toolkit_, a
micro-framework for experimenting with [recurrent neural networks][1].  OMLET
lets you build, train and evaluate [deep neural networks][2].  Why invest
hours reading documentation and megabytes of disk space on a full-featured DNN
framework like [TensorFlow][3] or [Torch][4] when you can have full RNN
functionality in less than 4 KB!

OMLET has the following features:

  + User-programmable network configurations and hyperparameters
  + Support for various types of recurrent and feed-forward neural networks
    including vanilla RNNs, LSTMs and GRUs of depths of up to 99 layers
  + No limit on parameter size (except for those imposed by the system)
  + Training and inference modes, with periodic checkpointing
  + Advanced [Adam][42] optimizer with [weight decay][43] for simplified
    training
  + Hyperparamer support for batch sizing, learning rate schedule, weight
    decay and gradient clipping
  + Easily extensible (requires some expertise in the C programming language)
  + Friendly markdown documentation

OMLET is based on [Andrej Karpathy's][40] [character-level language model][41]
as described in his blog post [_The Unreasonable Effectiveness of Recurrent
Neural Networks_][44].  I've included a small sample dataset to use for
training, but you can have even more fun by downloading some larger datasets:

  + [Linux kernel source][30]
  + [_War and Peace_][31]
  + [Donald Trump's 2016 campaign speeches][32]


Getting started with OMLET
--------------------------

OMLET has three operating modes:

  + _Training_, which trains a network from scratch
  + _Continuation_, which trains starting from an existing checkpoint
  + _Inference_, which uses an existing trained network to make predictions

For your first OMLET experiment, we will try training a simple single-level
RNN to write some [Shakespere][5] plays.  Start by typing

    make

After it builds, train it using

    ./prog shakespere.txt

This will immediately start outputting gibberish to the output, e.g.

    ./prog shakespere.txt
     sins ohennAu
    T-teooclelp tiThoWy
    
    g
    nlakuafy 
    e
    sselW usnsofueB Aoee pasfUsuslhe ooM ot Wou moy
    me neltAl -no IoyI mhuyakse  inT-l chu ghenn ffo? fnsoe yhyye
    ue nnfrlass heUthole saounlcesyee pee 
    t,
    T0:0% 3.210888
    o',,vU
     An ,hTf lnm  Far rur:s moilt WoEgrv wonds mith Aog thernw
    Rni So
    co Nnd :
    For an bImy pgafoun:
    Wf'r hom wortiverita
    int fod mous Eheledet,
    Tho he theket nonS wnu-ang dorlaMSp
    nrocWiSe tflg 'o.
    T0:0% 2.995950
    d whecedhencrysesil yr bn,
    we hh y thiwt
    
    
    hut fithlot,
    Fmdy s he alt
    Vh th no dh foud bobt werw:s Aotnf Fhwi't whe, eusu
    
    lhh thele wewcond ary soupfy wind tDont couc ths:
    er fucwald oncli hen bos, f
    T0:1% 2.878945

The gibberish is the networks attempt to write a play.  So far, it's not very
successful!  Between the chunks of gibberish are training progress reports
that look like

    T0:1% 2.878945

This tells you that we are 1% through training epoch 0, and that the training
[loss][6] is about 2.88.  As the training continues, the training loss will
reduce and the generated snippets will improve quickly:

    ses, kuth
    LAs of the wish,
    As, I nos you,
    Yov not to nalll,
    Tr tot wonds.
    
    First Sondy, llt lrte, our, tw.
    
    First.
    
    BRUTUS:
    Helsting the kith gops of hoch Whay, fars surd what to,
    The cownens golt te.
    T0:12% 2.259114
    eplerrotrur tandans one wiok thy or thach and cullice ded yourssting
    And wours:
    Whed ur surt.
    
    SINENIUS:
    On we lain bith
    rerytund: tich lon hyivetetgor.
    
    VOLUONIA:
    He brich nom dove worthan then wise,
    T0:13% 2.254926

It's already started to figure out things about Shakespere plays -- how to
spell short English words, how long lines tend to be, and that characters take
turns speaking with their names capitalized.  The training loss has dropped to
2.25 and the improvement is noticeable.

Eventually, we will finish with the training data set and move on to a
validation cycle:

    y fath onother,
    I sucess,
    For I me the west crare.
    
    TRANIO:
    Whow and'd have not to had you you one in my lapteny she very ame come me a gut and shourd aghir you as ignested; shend to make I strem
    To h
    T0:99% 1.924063
     notnce gaud and is nicked thou day, ha the dusing you disaid: in thim, you things in ere thee thus erile Iht that tare theme my hast thesp thou shay: thou not eaten-or-ho-bess resing: I the but had d
    T0:99% 1.923128
    V0:0% 1.678907
    V0:9% 1.700527
    V0:18% 1.733179
    V0:27% 1.714891
    V0:36% 1.716672
    V0:45% 1.782946
    V0:54% 1.835629
    V0:63% 1.876108
    V0:72% 1.906814
    V0:81% 1.924096
    V0:90% 1.954492
    V0:99% 1.969287
    serfs you'll alliencseard:
    We
    got you? before
    I say.
    
    Farstred dentlentecaly, sir, I it one bosticield
    All me the backnour mino,
    Whith capitaned mid! but stell the ifvemion
    Willerity.
    
    First Cumfol of
    T1:0% 1.885619

Validation cycles are used to test the network to see if it has learned to
generalize -- how well performs on data it hasn't seen before (as opposed to
the training data that the network will see many times as it trains).  Progress
on the validation set is also displayed with a validation progress report that
looks like

    V0:36% 1.716672

which means we are 36% of the way through the validation for epoch 0, and the
validation loss is about 1.72.  Comparing the validation loss and the
training loss will give you an idea of how well the network is learning and
can let you know if the network is [overfitting or underfitting][7].

As part of the training process, the data set (which for OMLET is the
`shakespere.txt` file you gave on the command line) is divided into
[training and validation sets][8] (by default, 95% of the data is used for
training, but like most OMLET parameters, you can change this at compile-time).

At the end of the validation run, OMLET writes out a checkpoint file with a
name like `cp01_1.970`.  This saves the state of the run at the start of the
epoch 1, after computing a validation loss of 1.970.  The checkpoint is
helpful if you need to stop and restart training.  You can stop training by
doing `Control-C`.

You can continue training from a previous checkpoint by providing the
checkpoint file name as the second parameter, for example:

    ./prog shakespere.txt cp01_1.970

After the validation cycle finishes, OMLET begins the next epoch by restarting
training at the beginning of the training set.  Training continues forever,
until you quit it with `Control-C`.  You should monitor the checkpoints to
see that the validation loss continues to drop.  If it rises, the network has
probably started to overfit on the training data.

Once you've trained the validation loss as low as it will go, you can use
OMLET to run the network in inference mode which uses the frozen checkpoint
parameters to generate data.  Inference mode takes the checkpoint file as
*standard input* (not on the command line) and hence must be run with a
command like

    ./prog < cp55_1.807

Running it produces an infinite amount of generated output, until you hit
`Control-C` to stop it.

Note that if you decide to change networks or use a different input file, you
will want to delete all the checkpoint files because the format depends on
both the network and the input -- using the wrong checkpoint is likely to
cause a crash.

Experimenting with different networks
-------------------------------------

The default network for OMLET (the one you get if you type `make` with the
executable name `prog`) is the simplest recurrent neural network.  It looks
like

    h = tanh(Wxh * x + Whh * h' + Bh)
    y = Why * h + By

where

  * `x` is the *input vector*
  * `y` is the *output vector*
  * `h` is the *hidden state vector*
  * `h'` is the previous value of `h`
  * `Wxh`, `Whh`, and `Why` are *weight matrices*
  * `Bh` and `By` are *bias vectors*.
  * `tanh` is the [hyperbolic tangent function][9]

The `W`'s and `B`'s are the trainable parameters of the network, and the
process of training is optimizing the values of these parameters to minimize
the loss of the network across the training set.

It is the presence of the hidden state vector that allows the RNN to
"remember" the past.  We can see what would happen if we removed this hidden
state.  If you type

    make lin1

OMLET will create an [ADALINE][10] network that does

    y = Wxy * x + By

This simple [linear][11] [feed-forward network][12].  You can run it with

    ./lin1 shakespeare.txt

The linear network won't be able to get past the gibberish stage, because it
lacks history:

    ./lin1 shakespeare.txt
    UERond w,
    
    
    Gir:
    KINof s, mesther s thouth.
    E:
    KINTret, at fu,
    GOMy t, as sth kesewit sooos atse ang k, ck,
    Sotheouserivesthecowhet been's, t he, h nre; t and, har wiread of pincer cedst sur has, ut:
    
    T14:67% 2.465115
    UKESpan,
    NGaromy soreate e m esewfoure pamitherarjulthengeoly tl.
    NG s at e! w.
    
    WAllinoully?
    Wamisw ofilem:
    I'delandinarrstath har aksubly s cath Whern t Is, weciss:
    
    GLat s; llde.
    Y aterit dsthence 
    T14:67% 2.465404

It is able to guess at what character is likely to follow the current one
(by doing a [linear regression][13]), but it lacks any history beyond that to
guide it.

You might be wondering about the role of the `tanh` function in the RNN.
`tanh` acts as an [activation function][14] which adds [nonlinearity][15]
to the network and allows it to solve complicated problems.  Without
nonlinearity, all of the linear functions would fold together into a single
matrix-vector multiply and you'd effectively regress to the linear network
above.  Alas, even adding a nonlinearity to the feed-forward network
(creating a [perceptron][16]) does not improve the performance because we
still lack the history provided by the hidden state vector (although if you
want to try it yourself, you can do so with `make per1`).

Going deeper
------------

We can try to improve the RNN's performance by stacking RNN modules atop each
other:

    h1 = RNN(h1', x)
    h2 = RNN(h2', h1)
    y = Why * h2 + By

with `RNN(h, x)` defined as above.  Each RNN module has its own set of
parameters and its own hidden state vector.  This will improve the network's
performance, at the cost of a much larger parameter space

> **IMPORTANT NOTE**: Since OMLET uses the system stack for network storage,
> larger networks may cause OMLET to crash (typically with a message like
> `Segmentation fault`) unless the system stack size is first increased.
> The exact command for doing so depends on your shell and your system's
> hard limits.  On `sh`/`ksh`/`bash` shells, you can view the hard limit
> with `ulimit -Hs` and set it with `ulimit -s 65532` (replacing `65532`
> with the actual hard limit).  On `csh`/`tcsh` shells, you can view
> the hard limit with `limit -h stacksize` and set it with
> `limit stacksize 65532` (replacing `65532` with the actual hard limit).

You can try the deeper network by doing

    make rnn2

(or even `make rnn3` if you want a three-layer RNN) and train it with

    ./rnn2 shakespeare.txt

The additional depth should allow the network to make better predictions (it
can represent more complicated history), but it may take a long time to train
-- both because the network (being larger) now requires more time to train and
because of the [vanishing and exploding gradient problem][17], which might
keep it from ever reaching its potential.

LSTMs and GRUs
--------------

RNNs are particularly hard to train because the they are trained using
[bankpropagation through time][18].  The RNN is trained by effectively
converting it into a non-recurrent network by making many copies of it
and propagating the hidden state through the copies.  During training,
the backpropagation through many clones of the network amplifies the
gradient, worsening the exploding and vanishing gradient problem.

[Long Short Term Memory][19] networks (also called LSTMs) were developed to
solve this problem.  Christopher Olah gives a good description of them
at his [blog posting][20].  You can build a two-level LSTM by doing

    make lstm2

and train with it with

    ./lstm2 shakespeare.txt

The LSTM is much easier to train because it explicitly decides how to update
its hidden state via "gates".  These gates are called

  * _input gate_, which decides what part of the input to pay attention to
  * _forget gate_, which decides what part of the hidden state to forget
  * _output gate_, which decides what part of the hidden state is used to
    produce the output

The basic LSTM equations are

    f = sigmoid(Wxf * x + Whf * h' + Bf)
    i = sigmoid(Wxi * x + Whi * h' + Bi)
    o = sigmoid(Wxo * x + Who * h' + Bo)
    c = f * c' + i * tanh(Wxc * x + Whc * h' + Bc)
    h = o * tanh(c)

Where

  * `x` is the input vector
  * `h` is the hidden state (and the output to the next layer)
  * `c` is the _cell state_ which represents the "memory" of the LSTM
  * `h'` and `c`' are the previous values of `h` and `c` respectively
  * `f` is the _forget gate_ that tells the LSTM what portion of the hidden
    state to forget
  * `i` is the _input gate_ that tells the LSTM what portion of the input
    vector to pay attention to
  * `o` is the _output gate_ that tells the LSTM what portion of the cell
    state to use to generate the hidden state
  * `Wxf`, `Whf`, `Wxi`, `Whi`, `Wxo`, `Who`, `Wxc`, and `Whc` are trainable
    parameter matrices
  * `Bf`, `Bi`, `Bo`, and `Bc` are trainable bias vectors
  * `tanh` is the hyperbolic tangent function
  * `sigmoid` is the [logistic function][21]

There are several LSTM variants (see [C. Olah's blog post][20] for more
examples).  One important one is the [gated recurrent unit][22].  GRUs are
simplified versions of an LSTM which combine the gates together, meaning they
require fewer learned parameters.  This allows them to train faster than a
generic LSTM.  You can build a two-layer GRU with

    make gru2

Building your own networks
--------------------------

The OMLET `Makefile` comes with one-, two- and three-layer RNNs, LSTMs and
GRUs, along with simpler feed-forward networks like multi-layer perceptrons and
a linear network.  This isn't the limit of OMLET's power -- you can create your
own networks by modifying the `Makefile`.  Networks are passed in on the
compiler's command-line by using `-D` directives.  The network is defined by
a `-DNW='...'` command which consists of a series of comma-separated
assignments.  For example, the simple one-layer RNN could be defined like

    -DNW=` x  = I(n), hp = I(128),                  \
           h  = C(hp, T(A(L(128, x), L(128, hp)))), \
           y  = L(n, h)'

The network declares `x` as an input vector (there must be a declaration for
`x`).  It is declared as `I(n)`, which is an input vector of size `n`, which
is the number of characters of the input alphabet (OMLET computes this from
the input file at the start of training).  OMLET will arrange to present the
input character as a [one-hot][23] vector based on the current input
character.

The second declaration, `hp`, declares the previous hidden state vector (what
we called `h'` above).  We declare this to be of size 128 -- an arbitrary
choice.  A larger state vector can (theoretically) carry more state, but at
a cost of larger parameter matrices and longer training time.  You can
experiment with increasing the hidden vector size and see.

The third line is the core of the RNN.  It sets `h`, the hidden vector output
to be the sum of two linear elements specified by `L`.  The `L` function
takes two parameters -- the output vector size (which must match the size of
`h`) and the input vector.  `L` will compute `y = W * x + B` where each `L`
has its own `W` (weight) and `B` (bias) training parameters.  Both `x` and
`hp` are sent through `L` and the result passed through the `A` function,
which does vector addition.  That result is passed through `T` which does
element-wise `tanh` activation.

Next, we wrap the whole thing with the `C` function.  `C` connects `hp`
with `h`, causing the new value of `h` to be passed to the `hp` vector on
the next iteration of the algorithm (allowing the RNN to retain state in `h`).

Finally, the whole result is passed through another instance of `L`, this time
producing a vector of size `n`, which will have the negative log
[likelihood][24] function.  This is assigned to `y`, which is the output of
the network (and hence must also be declared).

OMLET will take the `y` result and pass it through the [softmax][25] function,
which converts the log probabilities into a probability distribution.  In
inference mode, this is used to select the next character to emit.  In
training mode, this is used to generate the loss which is backpropagated.

As an example of a more complicated network, we can look at a two-layer
GRU network:

    -DHS=128,                                 \
    -DNW=' x  = I(n),                         \
           y  = L(n, MD(MD(x)))'              \
    -DBK=' hp = I(HS),                        \
           z  = S(A(L(HS, x), L(HS, hp))),    \
           r  = S(A(L(HS, x), L(HS, hp))),    \
           c  = T(A(L(HS, x), L(HS, hp))),    \
           zc = OG(1, -1, z),                 \
           h  = C(hp, A(M(zc, hp), M(z, c))), \
           y  = h'

We are using a few new tricks here -- first, we are defining `HS` as the size
of the hidden and cell vectors.  There's nothing special about this name, its
just convenient to specify it so we don't have a bunch of constants in the
code.  Second, the network itself is very simple -- it declares `x` and has
the matrix that converts the `HS`-sized hidden vector back to the `n`-sized
alphabet vector... but it now calls `MD`, which is the user-definable
module (here we are using it twice, to have two cascaded GRU blocks).  The
`MD` function performs the sub-network defined by the `BK` compile-time
parameter (specified in the `-DBK='...'` setting).  This sub-module again
takes an `x` parameter and produces a `y` output.  Inside it, we declare
`hp` and `h`, the previous and current state vector, plus equations for the
various GRU gates (these use `S` for the sigmoid activation function).
One final new call is `OG` which does offset and gain, performing
`y = offset + gain * x` where `offset` (the first parameter) and `gain` (the
second) are constants.  We are using this here to compute `(1 - z)` for the
GRU's linear interpolator.

The full set of available function blocks follows:

  * `I(s)`: declares a vector (input or state) of size `s`
  * `L(s, x)`: learnable linear function `y = W * x + B` with an output vector
    size of `s`
  * `CM(x)`: learnable element-wise gain function `y = W * x`
  * `A(a, b)`: element-wise add: `y = a + b`
  * `M(a, b)`: element-wise multiply: `y = a * b`
  * `S(x)`: sigmoid activation function `y = sigmoid(x)`
  * `T(x)`: hyperbolic tangent activation function `y = tanh(x)`
  *  `C(xp, x)`: copy `x` to `xp` in the next time step (propagate through
     time)
  *  `OG(o, g, x)`: apply a constant offset and gain: `y = o + g * x`
  *  `MD(x)`: apply the sub-network specified by `BK`

Note: even if you don't use `MD` in your network, you should still define
`BK` by adding `-DBK='y=x'` to the command line, otherwise you will get a
compile-time error.

Hyperparameters
---------------

OMLET has a large number of training and inference parameters which can be
changed by the user.  All of these are set by `-D` on the compile command line.
The list of hyperparameters follows:

  * `TP`: Temperature parameter for use in inference mode.  This divides the
    log probabilities before softmax.  A low temperature makes the model choose
    safer but more boring choices.  A high temperature takes more risks but
    makes more mistakes.  Default is 1.0, which uses the computed
    probabilities.
  * 'N': Batch size.  This is the number of times the RNN is unrolled, so it
    controls how far back in the past the RNN can see.  The default is 50.
    Larger batch sizes update the weights less frequently and allow the RNN to
    see farther back in time, but at a cost of proportionally more memory.
  * `TR`: The percentage of batches in the input data set that will be used
    for training.  The default value of 0.95 sets this as 95%.
  * `LR`: The initial learning rate,  The default is 0.002.
  * `LE`: The epoch where the learning rate will start decaying.  Defaults to
    epoch 10.
  * `LD`: Learning rate decay, per epoch (after `LE` epochs).  The learning
    rate is scaled by this number.  Default is 0.97
  * `WD`: Weight-decay parameter, to promote [regularizaiton][27].  The default
    is 0.00008.
  * `RS`: The random scale for weight initialization.  Weight parameters will
    be initialized to be between `-RS` to `+RS`.  The default is 0.15.
  * `CL`: Clamp value for gradients.  Gradients will be limited to the range
    `-CL` to `+CL`.  Default is 5.
  * `B1`: Momentum mean parameter for Adam optimizer.  Set to 0.9.
  * `B2`: Momentum variance parameter for Adam optimizer,  Set to 0.999.
  * `EP`: Epsilon parameter for Adam, to provide numerical stability.  Set to
    0.00000001.
  * `DI`: How often to print a training or validation progress message and
    inference snippet.  The default prints every 100 training batches.
  * `SL`: The number of characters to print when doing an inference snippet.
    Default is 200.
  * `PF`: Format string for the checkpoint filename.  The default is
    `"cp%02d_%.3f"` which includes the epoch and validation loss.  You may
    wish to add a subdirectory to the name to keep checkpoint files out of
    the current directory.


  [1]: https://en.wikipedia.org/wiki/Recurrent_neural_network
  [2]: https://en.wikipedia.org/wiki/Deep_learning
  [3]: https://www.tensorflow.org
  [4]: http://torch.ch
  [5]: https://en.wikipedia.org/wiki/William_Shakespeare
  [6]: https://en.wikipedia.org/wiki/Loss_function
  [7]: https://en.wikipedia.org/wiki/Overfitting
  [8]: https://en.wikipedia.org/wiki/Training,_validation,_and_test_sets
  [9]: https://en.wikipedia.org/wiki/Hyperbolic_function
 [10]: https://en.wikipedia.org/wiki/ADALINE
 [11]: https://en.wikipedia.org/wiki/Linear_map
 [12]: https://en.wikipedia.org/wiki/Feedforward_neural_network
 [13]: https://en.wikipedia.org/wiki/Linear_regression
 [14]: https://en.wikipedia.org/wiki/Activation_function
 [15]: https://en.wikipedia.org/wiki/Nonlinear_system
 [16]: https://en.wikipedia.org/wiki/Perceptron
 [17]: https://en.wikipedia.org/wiki/Vanishing_gradient_problem
 [18]: https://en.wikipedia.org/wiki/Backpropagation_through_time
 [19]: https://en.wikipedia.org/wiki/Long_short-term_memory
 [20]: http://colah.github.io/posts/2015-08-Understanding-LSTMs/
 [21]: https://en.wikipedia.org/wiki/Logistic_function
 [22]: https://en.wikipedia.org/wiki/Gated_recurrent_unit
 [23]: https://en.wikipedia.org/wiki/One-hot
 [24]: https://en.wikipedia.org/wiki/Likelihood_function
 [25]: https://en.wikipedia.org/wiki/Softmax_function
 [26]: https://en.wikipedia.org/wiki/Dropout_(neural_networks)
 [27]: https://en.wikipedia.org/wiki/Regularization_(mathematics)

 [30]: https://cs.stanford.edu/people/karpathy/char-rnn/linux_input.txt
 [31]: https://cs.stanford.edu/people/karpathy/char-rnn/warpeace_input.txt
 [32]: https://github.com/ryanmcdermott/trump-speeches

 [40]: https://cs.stanford.edu/people/karpathy/
 [41]: https://github.com/karpathy/char-rnn
 [42]: https://arxiv.org/abs/1412.6980
 [43]: https://www.fast.ai/2018/07/02/adam-weight-decay/
 [44]: http://karpathy.github.io/2015/05/21/rnn-effectiveness/


--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2019, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
