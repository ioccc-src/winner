## Award presentation:

Watch the following [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse) YouTube show:

> [IOCCC28 - 2024/cable1 - Prize in bot talk](https://www.youtube.com/watch?v=ZrGyUELYW2M)


## To build:

``` <!---sh-->
    make all

    ./get_model.sh
```

**NOTE**: You must accept the license to run the program.


## To use:

**NOTE**: You must have successful run the
[2024/cable1/get_model.sh](%%REPO_URL%%/2024/cable1/get_model.sh) script
before running the program.

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    echo 'Describe yourself.' | ./prog

    echo 'Describe yourself.' | ./linux

    echo 'ls' | ./linux

    echo 'Describe yourself.' | ./eeyore

    echo 'Why are you so sad?' | ./eeyore

    echo 'Describe yourself.' | ./snoop

    echo 'Tell me a silly joke.' | ./snoop

    echo 'Describe yourself.' | ./rainman

    echo 'How 2+2 can equal 5?' | ./rainman
```

**PLEASE NOTE**: The above examples are "_one shot_" examples.
However you can have an extended conversation.  For example:

``` <!---sh-->
    ./prog
```

or:

``` <!---sh-->
    ./linux
```

etc.


### Fun things to try

Here are some fun things give as input:

> Why did this entry win IOCCC28?

> Translate "Plurima responsa non recta esse supponamus"

> Write a C program that writes a C program.

> Write a sentence so that contains a split infinitive.

> Rewrite the previous sentence so that it ends in a preposition.

> How much wood does a woodchuck?

> Tell me a silly joke.

> Write a poem about a poet who is illiterate.

> Give examples, based on mathematics, where 2+2 can equal 5.

Please note that the quality and accuracy of the answers you receive may vary.  :-)
We do **NOT** recommend believing everything you read from this program.
**Caveat lector!**


## Alternate code:


### Alternate build:

**NOTE**: You must have successful run the
[2024/cable1/get_model.sh](%%REPO_URL%%/2024/cable1/get_model.sh) script
before running the program.

``` <!---sh-->
    make openmp
```


### Alternate use:

``` <!---sh-->
    ./prog_openmp
```


## Judges' remarks:

This entry may benefit from OpenMP (via `prog_openmp`) for platforms that
support compiling with OpenMP.  Even on a cheap 8-core laptop, this produces
tokens with a tolerable speed, at least for the first few lines.
Without OpenMP, one must patiently await answers.

To preserve this entry for posterity, one thing to explore is to find the
minimal model which exhibits a sensible behavior: for example, printing
"Hello, world!" as the response to any input.

We took the liberty of making the program terminate gracefully at the end
of input, at the cost of 2 extra bytes, and preserving the original in
`prog.orig.c`.

**NOTE**: Even with OpenMP, this tool is not the fastest.  A mild level of patience is advised.

**DISCLAIMER**: _riPlurima responsa non recta esse supponamus_!


### IMPORTANT Download

ChatIOCCC runs Meta's open source `llama2-7b-chat` model. Before using ChatIOCCC, you'll need to accept Meta's license
and download the model weights (~7GB):

``` <!---sh-->
    ./get_model.sh
```


## Author's remarks:

ChatIOCCC - the world's smallest and best LLM inference engine


### About

ChatIOCCC is the world's smallest LLM (large language model) inference engine - a "generative AI chatbot" in
plain-speak. ChatIOCCC runs a modern open-source model (Meta's LLaMA 2 with 7 billion parameters) and has a
good knowledge of the world, can understand and speak multiple languages, write code, and many other things. Aside from
the model weights, it has no external dependencies and will run on any 64-bit platform with enough RAM.

LLM inference engines are extremely complex, incorporating a tokenizer (SentencePiece or byte-pair encoding), embedding layer,
transformer layers (including multi-head self-attention, feed-forward neural network, activation, layer norm and
residual connections), key/value caching for performance, output projection, decoding, and a state machine to control
the data flow. Implementing all of that machinery, with no external dependencies, generally takes thousands or tens of
thousands of lines of code. ChatIOCCC is a full LLM implementation in under 1800 bytes of C, and even supports
UTF-8/Unicode input and output and parallel processing over multiple CPU cores via OpenMP.

The author was inspired by [llama2.c](https://github.com/karpathy/llama2.c) which aims to foster understanding of how LLMs work via a simple
implementation. Unfortunately, even AI experts don't actually understand why LLMs work at all. This core truth led to
an epiphany: as LLMs are already maximally incomprehensible, obfuscation cannot make them more so. So, in the spirit of
the IOCCC we can set aside the futility of aiming for comprehensibility, and instead focus purely on size.

Since smaller is always better, and ChatIOCCC is the world's smallest LLM inference engine, it is therefore also the
world's best LLM inference engine.

Whether or not you fail to disagree that this paragraph, and those above, are or are not in and of themselves maximally
incomprehensible, they represent in either case the origin story of this IOCCC submission, which implements an LLM
inference engine in an impossibly minimal quantity of maximally incomprehensible C code.


### Requirements

In addition to using `./get_model.sh` to download the `llama2-7b-chat` model (see above), you'll need around 11GB of free RAM to run ChatIOCCC.


### Fun things to ask

Here are some fun things you can ask ChatIOCCC to do for you:

> Tell me a surprising fact about an animal of your choice.

> Write a short story for a 5 year old girl, featuring Sobieski the dog and Pepe the cat.

> Write a C program which sorts a list using the bubble sort algorithm.

> Write a poem about a little boy who builds a rocket to fly to the moon. In Japanese, please.

> Translate into English: 这个项目会成为 2024 年 IOCCC 的赢家吗？

> Tell me about the IOCCC and its history. Then, write a poem in French about it.


### Personalities

ChatIOCCC allows the LLM's system prompt to be defined at compile time (by using `-DS="prompt..."`).
The supplied `Makefile` includes three example personalities (set via system prompts) you can try: `eeyore`, `snoop` and `linux` (and
their OpenMP versions, `eeyore_openmp`, `snoop_openmp`, `linux_openmp`).
The `eeyore` and `snoop` personalities are self-explanatory. The `linux` personality makes ChatIOCCC act like a Linux
machine. Try for example:

``` <!---sh-->
    make linux
    ./linux
```

Or for much better performance:

``` <!---sh-->
    make linux_openmp
    ./linux_openmp
```

Then try typing some Linux commands. You can even run an imaginary C compiler inside the LLM:

``` <!---sh-->
    pwd
    cat /etc/passwd
    echo 'int main() { for (int i = 1; i <= 10; i++) printf("IOCCC %d\n", i); }' > test.c; gcc test.c; ./a.out
    ls -la a.out
```


### Limitations

The `llama2-7b-chat` model has a context window of 4096 tokens (around 2000 words). As you use
ChatIOCCC, the context window fills up from your prompts and from the model's responses,
and the model gets progressively slower due to the attention mechanism needing to do more work. This is normal.

When the context window is full, ChatIOCCC will clear it and at that point the model will
'forget' prompts/responses from earlier in the session. Various more sophisticated techniques
exist to handle context window overflow (summarization, rolling window, NTK-aware scaled RoPE etc.), the implementation
of which is left to the reader with too much time on his/her hands.


### Footnotes

The length of this entry's source code is 1750 bytes. Many interesting things happened in 1750, including:

- The Industrial Revolution begins in Great Britain
- British astronomer Thomas Wright first proposes that the Milky Way is a disk-shaped system of stars, with our Solar System near its center
- Benjamin Franklin first proposes the idea that lightning is electrical in nature
- Adwaita the giant tortoise, who lived until 2006, is born
- Johann Sebastian Bach dies

As a final note, the author is pleased to report that this entry is [absolutely totally impossible](https://chatgpt.com/share/6839d275-c644-8004-9301-0ea781d8f5aa) according to ChatGPT. But, to quote Walt Disney, "it's kind of fun to do the impossible".


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
