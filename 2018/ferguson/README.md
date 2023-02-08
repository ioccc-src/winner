# Best use of weasel words

Cody Boone Ferguson <weasel@xexyl.net>  
<https://ioccc.xexyl.net/2018/weasel>  
Twitter: @xexyl  


## Judges' comments:
### To use:

    make

    ./weasel

### Try:

    ./weasel words
    ./weasel -mq words
    ./weasel -q -r8 'EVOLUTION IS A PROVEN FACT'
    ./weasel -m 'INTELLIGENT DESIGN'

    make test

### Selected Judges Remarks:

Looking back over the strata of past IOCCC entries, this program marks a new
mutation on our understanding of sequencing of code.  In adaptation of the
modern scientific that the C language has evolved, this mutant of a program
may stress your understanding of taxonomy of the C syntax tree.

The phenotype of the source suggests a veritable sea of primordial ASCII soup.
The encoded logic of the watchmaker suggests a variation of thought experiment
formulated by Richard Dawkins: but without the need for feeding too many
evolutionary relatives of the primate order in which us Homo sapiens hang
from the phylogenetic tree of life.

If you wish your computer to maintain one branch in the Cretaceous C code era,
while using more Cenozoic minded code migration, read rpm.markdown.

If you find yourself in an evolutionary dead end, try:

    man ./weasel.man


## Author's comments:
    0. Preface
    1. What it is
    2. How it works
    3. Hints (Keyboards, Options, Spoilers, Example Invocations)
    4. Obfuscation (Techniques, Beauty)
    5. How to build (S and N Constants, Compilation, Portability, Installing)
    6. Final thoughts
    7. Winning comments, thanks, dedications, links, etc.

## **0. Preface**

**SPOILER WARNING: A great deal of this document and the man page is full of
spoilers of different types; as such I would recommend that you try running the
judges suggested invocations as well as running `make test` before you get into
the document or the man page, unless you don't mind any spoilers. I don't reveal
much in the way of obfuscation however so if you just want documentation on the
program, how to compile, etc. then there isn't need to heed this note.**

I was at a loss on how to present my remarks; on the one hand I wanted to give
everything to the judges so they didn't miss anything. But on the other hand I
didn't want to reveal as much publicly and many people don't like to read long
texts. To resolve this I think the best way is referencing the judges' comments:
if you want a quick rundown of the entry try what they suggest and view the man
page (it explains all the options and describes the program briefly):

    man ./weasel.man

If that isn't sufficient **I would recommend reading this section** *(and
possibly the next)* where I attempt to give a brief explanation of the sections
to make reading it easier and faster. In addition I want to point out a few
things. *If you want more details read this document more thoroughly (or just
the sections that seem relevant to what you're after).* The [FILES][] file is a
quick list of files and respective summaries in this entry. Because several
sections are quite long I have added a skip to link to skip to the next
subsection or section at the beginning of each section (and subsection).

**[What it is](#what):** This is a brief summary of the program; the man page is
more thorough than this.

**[How it works](#how):** Explain some of the basic concepts and terms of the
program; if you're familiar with genetic algorithms there won't be any problem
following this section but it might be of some value to read anyway. There is a
randomised mode that doesn't use a genetic algorithm; it can be triggered a
number of ways but the **`-m`** option enables it specially (I discuss this
thoroughly in **[Hints](#hints)**).

**[Hints](#hints):** Perhaps the longest part of this document because in it I
document the [keyboards](#keyboards), [options](#options), subtleties (including
features that might appear to be bugs but aren't - including an
[input error](#error)), an [Easter egg spoiler](#spoiler) and quite a few
[example invocations](#invocations). If you've read the man page you probably
don't need this unless there is something specific you're after.

**[Obfuscation](#obfuscation):** Some of the techniques that might not be used.

**[How to build](#build):** Here I describe briefly
[the constants that can be redefined](#constants) **`S`** and **`N`**: the
maximum size of the chromosome (target string; the maximum length is **`S - 1`**
but it must be >= the default 38) and the number of offspring, respectively. I
also give [example compiler invocations](#compiling), [portability
notes](#portability), an [more portability notes](#bugs) and a [note on
rpm.markdown](#rpm).

On the subject of **`S`** and **`N`**: As the judges' suggested runs imply you
can change the target string at runtime; **`make test`** runs a script
*`test.sh`* which reads from the file *`test-strings.txt`*, running the program
for each string in the file, waiting approximately two seconds before
continuing.  I explain how to pass options to the script in part of
**[Hints](#test)**.

**[Final thoughts](#thoughts):** You might enjoy what I included; they're
humorous pieces by [Dennis Ritchie](#dmr) and [Ken Thompson](#ken) themselves
from the infamous *UNIX-HATERS Handbook*.

**[Winning thoughts](#winning):** What it means to me to win as well as some
dedications and thanks. Here too I include a link to a website which will be
dedicated to this entry beyond what will be published on the IOCCC website

[FILES]: FILES
[rpm.markdown]: rpm.markdown

## **1. <a name="what">What it is</a>**

Skip to [How it works](#how).

It is an implementation of Richard Dawkins' [Weasel program][] (Wikipedia).
According to Wikipedia in chapter three of his book [The Blind Watchmaker][]
Dawkins wrote:

> I don't know who it was first pointed out that, given enough time, a monkey
> bashing away at random on a typewriter could produce all the works of
> Shakespeare. The operative phrase is, of course, *given enough time.* Let us
> limit the task facing our monkey somewhat. Suppose that he has to produce, not
> the complete works of Shakespeare but just the short sentence 'Methinks it is
> like a weasel', and we shall make it relatively easy by giving him a typewriter
> with a restricted keyboard, one with just the 26 (capital) letters, and a space
> bar.  How long will he take to write this one little sentence?

He refers to the [Infinite Monkey Theorem][] (Wikipedia). As he points out the
operative phrase is *given enough time*; but even if it's extremely unlikely
*technically the probability is greater than 0*. He simplified it for the
monkey; I thought the monkey had it too easy: unlike his limited keyboard I have
(besides space) every character in the ASCII range **`0<=126`** that
**`isprint()`** returns non-zero except that only capital letters are included;
the file *`prog-simple.c`* has a slightly smaller keyboard. There are some
additional features I have added (including two Easter eggs); amongst others:
ability to change the target string and maximum length. See 
**[How it works](#how)**, **[Hints](#hints)** and **[How to build](#build)** for
more details.

In its simplest invocation this program will work its way (using a genetic
algorithm) towards the solution of the string **`METHINKS IT IS LIKE A WEASEL`**
(note that I use **`toupper()`** so it doesn't matter what case the input is the
comparison and output will always be capitalised).

[Infinite Monkey Theorem]: https://en.wikipedia.org/wiki/Infinite_monkey_theorem
[Weasel program]: https://en.wikipedia.org/wiki/Weasel_program
[The Blind Watchmaker]: https://en.wikipedia.org/wiki/The_Blind_Watchmaker

## **2. <a name="how">How it works</a>**

Skip to [Hints](#hints).

Here you can find a general explanation of a *[genetic algorithm][]* as well as a
brief history. Although the link provides more information (including images to
try and show the way they work) for those interested I will cite the summary:

> Genetic Algorithms (GAs) are adaptive heuristic search algorithm based on the
> evolutionary ideas of natural selection and genetics. As such they represent an
> intelligent exploitation of a random search used to solve optimization problems.
> Although randomised, GAs are by no means random, instead they exploit historical
> information to direct the search into the region of better performance within
> the search space. The basic techniques of the GAs are designed to simulate
> processes in natural systems necessary for evolution, specially those follow the
> principles first laid down by Charles Darwin of "survival of the fittest.".
> Since in nature, competition among individuals for scanty resources results in
> the fittest individuals dominating over the weaker ones.

**SPOILER WARNING: Some of the below might help you follow the code more
easily.**

For each *generation* there is a total of **`N`** *offspring*; generation 0 is
the pseudo-randomly initialised array *without parents.* Each offspring has its
own *chromosome* to be compared to the *target string* and a *fitness score*;
the higher the fitness score the more likely it will be a *parent of the next
generation* (randomised mode notwithstanding) as part of the *selection process*
(As the generations go by the fitness of the offspring should be higher; when
the fitness matches that of the target it will be printed and the loop will be
broken out of).

After determining the two parents *crossover* occurs: each new offspring
inherits DNA from the parents; every character in the chromosome string is
pseudorandomly selected from one of the parents' respective character. Next,
based on the *mutation rate*, perform *mutation* of the chromosome of each
offspring; in other words *some of the characters in the chromosome will be
assigned a pseudo-random value from the keyboard (in normal mode; in random mode
every character will be assigned a value*). Before mutation the offspring
chromosome will be printed; after mutation it will show what it was mutated to
(on the same output line). After the new generation has been sequenced the loop
goes back to the top and it starts all over until the maximum number of
generations **`SIZE_MAX - 1`** is reached or the target chromosome has been
found.

Note that the generation is checked *before the scoring takes place* by a prefix
increment equality check; when the generation is **`SIZE_MAX - 1`** the fitness
test loop will not be entered; instead the outer loop will end after printing:

> Too many attempts, blaming the monkey Eric even if he isn't typing or doesn't exist. Bye.

Why '*Eric*'? Because the judges stated in the [2018 guidelines][] that when
there is a user input error the program should insult the pet fish Eric even if
such a fish (no, weasels do not equate monkeys to fish but see below) doesn't
exist. The second to last example limitation example note (it's improved in the
final but this is relevant) they give is:

> The judges might not have a pet fish named Eric, so might want to state:
> 
> 	This entry factors integers between 1 and 2305567963945518424753102147331756070.
> 	Attempting to factor anything else will cause the program to insult your
> 	pet fish Eric, or in the case that you lack such a pet, will insult the
> 	pet that you do not have.

After the final message they ask:

> BTW: **What is so special about 2305567963945518424753102147331756070**?  You tell us!

The answer is this: **it is the primorial prime of 97:** the product of all
prime numbers less than or equal to N; **and the primorial prime of `N == 97` is
`2305567963945518424753102147331756070`**. There is no reference to this number
in my entry but it's nonetheless possible to **change the default target to it
without modifying the source code**; there are two hints in this very
paragraph; the first sentence in fact: the answer to the judges' question and
the definition. Can you get the program to search the primorial prime of 97
without passing in specially?

**On user errors:** if the generation reaches **`SIZE_MAX - 1`** I consider it a
user (or monkey) error; if the user insists on being so petulant as to try such
a ridiculous set of parameters in an attempt to make it be no more successful
than a monkey typing *then it shouldn't be any more successful than a monkey; if
it by chance reaches the target it's because a monkey could too!* Either way
unless the number reaches **`SIZE_MAX - 1`** the monkey Eric won't be blamed. It
should be noted that depending on the parameters (size of chromosome, number of
offspring, the string itself) the program could take quite a lot of system
resources; and whether the OS kills it, Eric the monkey falls asleep or the
typewriter is taken from him the result could very well be not found without
blaming him. Of course the judges were talking about fish not monkeys. But since
this program is inspired by the Weasel program *which was inspired by the
[Infinite Monkey Theorem][]* I opted instead to target the monkey Eric even if
such a monkey isn't typing or even doesn't exist (because it's not the *Infinite
Fish Theorem*). So although the user might not be a monkey the program makes the
assumption that **the user could in fact be a monkey called Eric** *although it
isn't insolent enough to say the user is a monkey for certain!*

[genetic algorithm]: http://www.doc.ic.ac.uk/~nd/surprise_96/journal/vol1/hmw/article1.html
[2018 guidelines]: http://ioccc.org/2018/guidelines.txt


## **3. <a name="hints">Hints</a>**

Skip to [Obfuscation](#obfuscation).

I noted that there are a number of additional features and here I will document
some of them. 

### <a name="keyboards">Keyboards</a>

Skip to [Options](#options).

The keyboard, as noted, has more than just the alphabet and space. To be
precise the following characters are acceptable; it equates to this in C (note
it includes a literal space **`' '`** but it doesn't include other
**`isspace()`** characters) and this is why some of the characters are escaped:

	    const char keyboard[]=" !\"#$<%:>&'()*+,-./0123456789;=?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`{|}~";

The simpler keyboard looks like:

	    const char keyboard[]=" !\"&'(),.0123456789;?ABCDEFGHIJKLMNOPQRSTUVWXYZ";

The program makes sure that the target string only has characters the keyboard
can actually produce but there is a certain type of input error that might
*appear* to be a bug; see specifically [Input Error Example](#error).


### <a name="options">Options</a>

Skip to [Spoilers](#spoiler).

There are a number of options you can pass to the program besides the target
string; some I will document here (the summary being in the man page). You can
join options but there is a caveat with spaces and **`-r`** option as well as
the target string (see below).

**Enable quiet output:**

	    -q


This means don't print the generation and offspring output; only print (some) of
the options set (this is always done but wouldn't usually be seen due to verbose
output) and the final answer.

**Change the mutation rate to `<rate>`:**

	    -r<num>

Please note that there cannot be a space between the **`-r`** and the number.
This is to simplify the parsing of options. As for combining options you can do
any of the following (amongst others):

	    -r5q
	    -qr5
	    -qr
	    -q -r5

The third invocation will set quiet output and have no valid value to parse for
the mutation rate and **`strtol()`** in this case returns 0. **`strtol()`** can
legitimately return 0 but in no instance is it valid input in this program: the
valid mutation rate is **`>= 1 && <= 100`**.

When the mutation rate is out of range it does something interesting: take a
look at the output and compare it to the output when the range is valid. Can you
figure out another way to trigger this? In fact there are two more ways (one is
an option I've mentioned and the other one is to do with the number of
offspring)! If you want something of a walk through I suggest you follow the
following:

1.  Enable quiet mode and set an invalid mutation range; for example specify:

	    -qr101

2.  Take a look at the first few lines. Kill the program and try invoking it
with the following options:


	    -qr5
    
3.  Look at the first few lines again and compare it to the output of step \#1.
With the default string most modern systems shouldn't take much time to - given
decent parameters - come to an answer here but if necessary kill the program.

4. Repeat the steps only this time don't enable quiet mode. Look at the
offspring output. If you still don't see what it is and want to know see
**[Spoilers](#spoiler)** below.

Finally any argument that doesn't start with a **`-`** passed into the program
will become the target string. The same rule applies to the number for **`-r`**:
it must be a single parameter which means you'll need to quote the string if it
has more than one word (that is it contains spaces) or anything else interpreted
specially by your shell e.g. parentheses. For instance if you just want to find
**`METHINKS`** you could do one of:


	    $ ./weasel METHINKS
	    $ ./weasel "METHINKS"
	    $ ./weasel 'METHINKS'

If you wanted **`YOU ARE A MONKEY`**:

	    $ ./weasel "YOU ARE A MONKEY"
	    $ ./weasel 'YOU ARE A MONKEY'

If you do one of:

	    $ ./weasel "METHINKS IT IS A" "MONKEY"
	    $ ./weasel METHINKS IT IS A MONKEY

It will search for **`MONKEY`** in both cases; in other words it's the last one.
If the string is too long given the value of **`S`** (see 
**[How to build](#build)**) it will be truncated. 

If you actually do want to search for a string starting with a **`-`** you must
disable further parsing of options by using the **`-`** option itself; for
example if you were to do any of:

	    $ ./weasel -q- -- -test
	    $ ./weasel -q- -test
	    $ ./weasel -q -- -test

The target string will be: **`-TEST`**. This means though that here:

	    $ ./weasel -q -- -test -r5

The string to be searched would actually be **`-r5`** and the mutation rate
will remain the default because after the **`-`** option is seen it will no
longer parse additional options: only target strings if anything left on the
command line. Because of the joining of arguments this means that the first two
examples of the last set of three above are equivalent i.e. the following two
are equivalent:

	    -q- 
	    -q --
	    
As for the caveat I referenced what does the following do?

	    $ ./weasel -qr 5

In fact it will set quiet output and set the target string to be '5'. So the
mutation rate will be out of range, thus enabling that Easter egg, but it will
likely come to an answer fairly quickly because it's just a single character. A
note on the parsing of the **`-`** option; if the program is currently parsing
**`argv[N]`**, for example, and it encounters a **`--`** then depending on where
the other options are in the command line it might still parse the options. Thus
you have:

	    $ ./weasel -qr-r5
	    quiet output
	    mutation rate out of range
	    target 'METHINKS IT IS LIKE A WEASEL'
	    mutation rate 5
	    Generation  440 Offspring 20: METHINKS IT IS LIKE A WEASEL

Similarly this would set quiet output, then an invalid mutation rate and then a
mutation rate of 5:

	    $ ./weasel --qrr5


If you were instead to do one of (for example):

	    $ ./weasel -q -- -r
	    $ ./weasel -q -q- -r

Then it *would* set quiet output then see the **`--`** (the **`-`** option
itself) and then the target string would *literally* be set to **`-r`** because
it no longer cares about the **`-`** for option parsing. In other words options
are only parsed if the first character is **`-`** and if the parser hasn't seen
the **`-`** - *in an earlier element of `argv`. This is not a bug!*


### <a name="spoiler">Spoilers</a>

Skip to [Example Invocations](#invocations).

The Easter egg: Since Dawkins references the [Infinite Monkey Theorem][] it
simulates a monkey using a typewriter! This mode has the following changes:

Selection is omitted; this means no sorting by fitness score (*each offspring
is initially set to be the first two in the list*) but do pseudo-randomly
select characters for every character in the target string; that is to say if
the string is of length 28 (the default) then all 28 characters in each
offspring of each generation will be assigned a pseudo-randomly positioned
character in the keyboard. If you want to enable this specially you can use the
**`-m`** option (*-m for monkey*).

### <a name="invocations">Example Invocations</a>

Skip to [Input Error Example](#error).

The following examples are used to demonstrate better the command line parsing.
In order to do that though I had to first document the **`-m`** option because
if the mutation rate is out of range monkey mode is activated (that's the first
Easter egg). But what happens if you later set a valid mutation rate? Should
monkey mode be disabled? If yes how do we know if monkey mode was specially
requested?  There are at least two ways to go about it: I took the monkey safe
('fool safe') method; *if you explicitly request monkey mode you cannot disable
it in the same invocation of `weasel`*!


	    $ ./weasel -qr101r5r101r1r test
	    quiet output
	    mutation rate out of range
	    mutation rate out of range
	    mutation rate out of range
	    target 'test'
	    mutation rate 0
	    monkey at typewriter
	    Generation 16844        Offspring 22: TEST

So in this case I joined the options in the following order:

1.  **`-q`**

Quiet output.

2.  **`-r101`**

Mutation rate 101 (out of range).

3.  **`-r5`**

Mutation rate of 5 but note that during parsing I only print invalid mutation
rate (only after parsing do I print the final mutation rate whatever it ends up
being); so while it appears there is a bug, showing mutation rate out of range
three times, this is expected (given the next one, **`-r101`**). This means here
the typewriter was taken from Eric the monkey.

4.  **`-r101`**

Mutation rate to 101: this too is out of range (this is the second mutation rate
out of range message). The typewriter returns to Eric.

5.  **`-r1`**

Set mutation rate to 1. Take that typewriter away!

6.  **`-r`**

Set mutation rate to 0; when there are no valid characters passed to
**`strtol()`** it should return 0: this is the third message about being out of
range. Note here that **`rand()`** returns an **`int`** and **`strtol()`**
returns a **`long`** but I compare the return value of **`rand()`** to the
mutation rate; if there are any systems where the widths differ this *shouldn't
matter* because of truncation but I do in any case specifically check for **`R <
0 || R > 100`**. Either way the invalid range returns the typewriter to Eric. 

7.  **`test`**

Finally I requested it find the string **`test`** (will search for **`TEST`**).

Given that it was a short string it did find the answer relatively quickly, even
in monkey mode.

Another example:


	    $ ./weasel -q -r101 test -r5
	    quiet output
	    mutation rate out of range
	    target 'test'
	    mutation rate 5
	    Generation  109 Offspring 13: TEST

In this case I also enabled quiet mode but I didn't join the options; the
**`-r101`** reports that it's out of range and sets monkey mode. I then specify
the target string and then set a valid mutation rate. This disabled monkey mode
which means that it'll use the genetic algorithm. 

One more example of monkey mode:


	    $ ./weasel -q -mr101 test -r5
	    quiet output
	    mutation rate out of range
	    target 'test'
	    mutation rate 5
	    monkey at typewriter
	    Generation 465298       Offspring 10: TEST

Here I also requested quiet output and then *explicitly requested that Eric the
monkey types.* After this I set the mutation rate to be 101 which would have
set monkey mode (*in this case only temporarily as I later set it to a valid
number*) but since I have also requested monkey mode that won't matter. Then I
set the string to **`test`** and then set a valid mutation rate of 5. Now note
that it is actually set to 5 but also note that monkey mode remains active: it
also took a lot longer to come to a conclusion for even four characters. This
example does demonstrate one other thing in a subtle way though.

When the program prints out each iteration (I'll give an example next) it goes a
lot slower; this makes sense because it's an expensive operation. Here are the
times for the same but without quiet output enabled:

	    real    0m17.065s
	    user    0m1.245s
	    sys     0m2.402s

Whereas with quiet output:

	    real    0m0.127s
	    user    0m0.125s
	    sys     0m0.001s

Of course it isn't only down to the printing but the point is it slows it down
significantly. Adding an option to print every X lines would go over the limit
(**`iocccsize -i`** reports 2052!).

Finally I'll show a default example in normal output (I omit many lines showing
instead **[...]**). Note that the real/user/sys times are from the **`time`**
bash shell built-in utility: that isn't output from my entry.


	    target 'METHINKS IT IS LIKE A WEASEL'
	    mutation rate 1
	    Generation    0 Offspring  1: 4V YGY.GH/}_|>Q1M.R8;KD[=(05
	    Generation    0 Offspring  2: Y_^S0_HZ399^/|9,MP%^{817"XX#
	    Generation    0 Offspring  3: F%88H1&[V1P>QOI}- U]0[V-Y%*[
	    [...]
	    Generation    1 Offspring 23: AHA#.\=ZT'0>?~-S.;1A L|1<S:^ -> AHA#.\=ZT'0>?~-S.;1A L|1<S:| (mutation)
	    Generation    1 Offspring 24: AHA#.\=ZT'0>?~-S.;1A L|1<S:^ -> AHA#.\=ZT'0>?~-S.;1A L|1<S:^ (mutation)
	    Generation    1 Offspring 25: AHA#.\=ZT'0>?~-S.;1A L|1<S:^ -> AHA#1\=ZT'0>?~-S.;1A L|1<S:^ (mutation)
	    **
	    Generation    2 Offspring  1: AHA#.\=ZT'0>?~-S.;1A L|1<S:^ -> AHA#.\=ZT'0>?~-S.;1A L|1<S:^ (mutation)
	    Generation    2 Offspring  2: AHA#.\=ZT'0>?~-S.;1A L|1<S:^ -> AHA#.\=ZT'O>?~-S.;1A L|1<S:^ (mutation)
	    [...]
	    Generation  979 Offspring  1: METHINKS ITZIS LIKE A WEASEL -> METHINKS IT IS LIKE A WEASEL (mutation)
	    [...]
	    **
	    Generation  979 Offspring  1: METHINKS IT IS LIKE A WEASEL

	    real    0m0.074s
	    user    0m0.040s
	    sys     0m0.001s


Keep in mind the way I display the generations and the fact that generation 0
has no parents; it is generation 1 that starts working towards the goal. You'll
see also **(mutation)** at the end of the line at this point (if you enable
monkey mode you'll find that it shows something else). The lines that only have
`**` are separators: you won't see this between generation 0 and 1 but you will
between future generations - as well as the final answer (if the answer is in
generation 0 you won't see the `**`).

<a name="test"></a>
One final thing to consider is that **the program doesn't directly read from a
file**. This combined with the way the shell works could possibly confuse some
people. Take the following invocations:

	    (1) $ echo test > test
	    (2) $ ./weasel test
	    (3) $ ./weasel < test
	    (4) $ cat test | ./weasel 
	    (5) $ < test-strings.txt ./weasel
	    (6) $ cat | ./weasel

Only the first invocation of **`./weasel`** will search for **`TEST`** because
the string **`test`** was explicitly passed to the program (If the file *`test`*
wasn't found by that path it would still have searched for **`TEST`**).

The second invocation will search for the default string if there is a file or
directory called *`test`*; else you will get an error about no such file or
directory (unless your shell for some reason doesn't consider it an error; bash
most certainly does consider it an error and halts).

The third invocation would if there exists a file *`test`* cat that file and
pipe the output to **`./weasel`**; *however it will search for the default
string.* If there is no such file to cat then an error will be reported but
without quiet mode you'd probably not even see the error.

The fourth invocation will also search for the default string unless the file
doesn't exist in which case you'd get an error like in the second invocation.

The fifth invocation will actually search for the default string even with the
file *`test-strings.txt`* existing. As far as I am aware it's equivalent to the
third invocation except that the file exists in this case.

The final invocation will search for the default and then read from *`stdin`*;
it won't do anything with it however.

What this amounts to is *if you want input from a file you have to read from the
file and pass each string to the program itself*. I've included a script
*`test.sh`* and a file of sample input *`test-strings.txt`* that you can play
with.


Try:

		$ make test

This will essentially make sure the program is compiled and then do:

		$ chmod +x test.sh
		$ ./test.sh


The script will first try compiling the program (if necessary) and if it fails
for any reason it will exit; else it will read each line in the file
*`test-strings.txt`* (if the file doesn't exist or can't be read the script will
exit with return status of 1) and pass it to the program. After finding the
string it'll sleep approximately 2 seconds and then read the next string
(passing it to the program, continuing until all the strings have been read and
processed).

You can pass additional options directly to the script but remember that it
stops when there are no more strings in the file - so if you try:


	    $ ./test.sh -q test


The final string **`test`** won't be searched for; it will however run the program
in all invocations with quiet output enabled. The following are some notes about
how the shell and the program interact with each other:

Because the script quotes the strings that it reads from the file if you were to
put in the file: **`-q STRING`** quiet mode would be enabled; however the
default string would be searched for. If the quotes were removed from the script
it would print the final word specified. To be specific with the quotes: if in
the file you had the line **`-q STRING -m TEST`** it would enable quiet output
and monkey typewriter mode; but it would search for the default string. Without
the quotes on the other hand it would enable quiet output, monkey typewriter and
search for **`TEST`**. In other words **if you want to pass options to the
script you will have to directly pass the options to the script** like the above
example shows (but the strings will still only be read from the
*`test-strings.txt`* file).

### <a name="error">Input Error Example</a>

Skip to [Obfuscation](#obfuscation).

There is a type of input error, as I said, that might appear to be a bug. What
actually is going on though is due to a technicality on how spaces are printed
and the fact the program does not accept spaces other than a literal space 
**` `**; when a character in the string to be found isn't in the keyboard the
program prints an error message and then exits (returning 1). But since the
keyboard doesn't have **`'\n'`** if you were to type a **`'`** and send a
**`'\n'`** before the closing **`'`** you might see something like:


		$ ./weasel '!!
		> '
		
		'
		' not in keyboard " !"#$<%:>&'()*+,-./0123456789;=?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`{|}~"

I showed that **`'`** is in the keyboard already; however the user sent a
**`\n`** (hence the secondary prompt **`>`** on line two) before literally typing the
closing **`'`** (also line two). But in order to make it clear what character is invalid I
surround the character with **`'`**s so what you actually see after typing the
closing **`'`** and hitting Enter (or however you send the **`'\n'`**) there is
the third blank line; *but then the program prints* **`'`** followed by the
invalid character (**`'\n'`** itself which means another line break) and then
finally the closing **`'`**.  Specifically **`isspace()` characters aren't
distinctly seen like a letter, digit or symbol is: `isprint('\n') == 0 &&
isspace('\n') == 1`**. You can add these characters but the output will be
rather confusing and hard to read.


## **4. <a name="obfuscation">Obfuscation</a>**

### Techniques

Skip to [Beauty](#beauty).

The following might be some of the techniques used in this entry:

1.  Helpful and descriptive names for all variables and constants (like **`S`**)
as well as some C keywords.

2.  The way **`main()`** is declared is:

	    /* Special C main() handler (encapsulation): */
	    #define r(main) main
	    r(k main(k a, E **V)) {

    It appears to be recursively defined but is it? And is it truly
encapsulation? And is it executing code of any kind? It mightn't seem like it
isn't encapsulation and also isn't executing code but assuming it's
encapsulation and executing code is it actually nothing? And if it's nothing why
is it there? If it is something what is it doing? Could it be both? Or maybe it
really isn't nothing or nothing? :)

3. A special C parser called **`H()`**. It might help to observe that there
might be recursive calls and much of the program might use it. Or so it seems.
Then again it might not help to not notice it.

4.  Digraphs. In their simplest form it's probably not a big deal but consider:
some source code formatters don't like them at all (neither, incidentally, does
**`splint`**, which completely baulks). There also is a trick; if you try
translating them then depending upon how you do it there can be functional
changes in the program!

5.  The fact the program can by default print the primorial prime of 97 (*but that
default isn't the default - except when it IS the default!*) and yet that number
isn't seen at all. See also technique #7.

6.  Another usual suspect: the source is formatted in a beautiful design that
could be described artistic; on the other hand some might suggest it's just a
blob of octets *but I disprove this when discussing beauty later on in the next
section.*

7. The string **METHINKS IT IS LIKE A WEASEL** is searched for by default
(except when it's not searched by default) but it's nowhere to be found in the
source file in that form. Why? Because anyone familiar with the Weasel program
won't recognise the string and put together what it is by looking at the source
code.

In case you wondered deciphering #5 won't decipher #7 (neither will deciphering
\#7 help you decipher #5).


### <a name="beauty">Beauty</a>

Skip to [How to build](#build).

On the subject of beauty: the judges stated in the guidelines the following:

> We want to get away from source that is simply **a compact blob of
> octets.**   Really try to be more creative than **blob coding.** *HINT!*

And if you'll notice that although it *might look like a compact blob of octets*
at first glance if you look throughout the file you'll see two statements to
set your thinking straight:


> **NO BLOB CODING**


> **THIS IS NOT A COMPACT BLOB OF OCTETS**

So you see even if your eyes are trying to deceive you they're quite wrong. Yes
some of it might look like a blob but this is clearly false; *as all good
programmers know if something is potentially confusing or misleading it should
be made clear in the comments! :)*


## **5. <a name="build">How to build</a>**

### <a name="constants">S and N Constants</a>

Skip to [Compilation](#compiling).

These two **`#define`**d constants can be redefined at compilation to modify the
behaviour of the program in a number of ways (see the
**[Compilation](#compiling)** subsection for example invocations). Both are
capped to be no greater than **`SIZE_MAX - 1`**. This is handled by the C
preprocessor.


**`S`**    

This determines the maximum size of the target string but it **must be at least
38**; this is because **`38 >= 29`** and because **`strlen("METHINKS IT IS LIKE
A WEASEL") == 28`** (which is the default target string - it would hardly be an
implementation of the Weasel program otherwise).

There is obviously a reason **`38`** is the chosen size but the only hints I
provide are those in **[How it works](#how)** and specifically an Easter egg I
referenced there (it's *not the only Easter egg* but it's the only Easter egg I
won't spoil; yes this ironically and amusingly means I've left a rotten egg
somewhere!).

**`N`**

This is the number of offspring per generation. Anything less than 4 will be set
to 3 (that's not a typo!) and this is part of an Easter egg.

Be aware that depending on the size of **`S`** and **`N`** (individually and
together) the program will use varying amounts of memory and the larger the
values the more memory it'll require.


### <a name="compiling">Compilation</a>

Skip to [Portability](#portability).

The following options **must always be passed to the compiler:**

	    -DQ='typedef' -D'g(o)'='goto o;' -D'w(x)'="x:" -D'H(main)'='r(main)'

If you want to increase the number of offspring to **`50`** and the size of the
chromosome to **`75`** you would pass to the compiler:

	    -DQ='typedef' -D'g(o)'='goto o;' -D'w(x)'="x:" -D'H(main)'='r(main)' -DN=50 -DS=75

If you wanted to change **`N`** to **`3`**:

	    -DQ='typedef' -D'g(o)'='goto o;' -D'w(x)'="x:" -D'H(main)'='r(main)' -DN=3

Remember that it cannot be less than **`3`**; *more correctly if it's less than
4 it's redefined to 3* so you could have passed in **`-DN=2`** and have the same
result. Remember too that **`S`** cannot be less than **`38`**. Both **`S`** and
**`N`** are capped at **`SIZE_MAX - 1`**.

### <a name="portability">Portability</a>

Skip to [An aside on bugs](#bugs).

The entry works for both C99 and C11 (it *requires at least C99 even if you
translate digraphs*). The program doesn't require third-party libraries and
should work on any Unix based system. It works on both 64-bit and 32-bit (but
inevitably some data type sizes will be smaller and this I believe includes
**`SIZE_MAX`**). I don't think Windows gcc ports would have many issues (if any)
either but I have no way to test this. I have tested the following systems and
configurations:

	    Fedora 26:

	    $ clang --version|head -n1
	    clang version 4.0.1 (tags/RELEASE_401/final)
	    $ gcc --version|head -n1
	    gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
	    $ /lib64/libc-2.25.so |head -n1|cut -d',' -f1-1
	    GNU C Library (GNU libc) stable release version 2.25
	    $ lscpu |grep Endian
	    Byte Order:          Little Endian


	    CentOS Linux release 7.4.1708 (Core)

	    $ clang --version|head -n1
	    clang version 3.4.2 (tags/RELEASE_34/dot2-final)
	    $ gcc --version|head -n1
	    gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
	    $ /lib64/libc-2.17.so |head -n1 |cut -d, -f1-1
	    GNU C Library (GNU libc) stable release version 2.17
	    $ lscpu |grep Endian
	    Byte Order:            Little Endian


	    Fedora 27:

	    $ clang --version|head -n1
	    clang version 5.0.1 (tags/RELEASE_501/final)
	    $ gcc --version|head -n1
	    gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
	    $ /lib64/libc-2.26.so |head -n1|cut -d, -f1-1
	    GNU C Library (GNU libc) stable release version 2.26
	    $ lscpu |grep Endian
	    Byte Order:          Little Endian

	    
	    macOS:

	    System Version: macOS 10.13.4 (17E199)
	    Kernel Version: Darwin 17.5.0
	    $ gcc -v
	    Configured with: --prefix=/Library/Developer/CommandLineTools/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
	    Apple LLVM version 9.1.0 (clang-902.0.39.1)
	    Target: x86_64-apple-darwin17.5.0
	    Thread model: posix
	    InstalledDir: /Library/Developer/CommandLineTools/usr/bin
	    $ uname -srmv
	    Darwin 17.5.0 Darwin Kernel Version 17.5.0: Mon Mar  5 22:24:32 PST 2018; root:xnu-4570.51.1~1/RELEASE_X86_64 x86_64


#### <a name="bugs">An aside</a>

Skip to [Installing](#rpm).

Any undocumented bugs are the result of insolent monkeys tampering with any
number of things. That includes but is not limited to running the program on a
non-ASCII system; non little-endian; meddling with **`S`** or **`N`** too much,
changing the references to **`SIZE_MAX`** to be larger than **`SIZE_MAX`** or a
signed value (**`size_t`** is unsigned) or too small of a value; changing data
types or variables; expecting really long strings - including but not limited to
the complete works of Shakespeare (hint: **`isprint('\n') == 0`** so it won't
ever find any string with **`'\n'`**) - to be found by the program in a quick
and easy fashion if ever; or any other meddling including being petulant and/or
unreasonable monkeys. I will say though that there is at least one place I see
after having won that could be slightly more efficient (can you find it?); I am
however leaving it as it is because this is what won.


### <a name="rpm">Installing</a>

Skip to [Final thoughts](#thoughts).

I have included a RPM spec file for those with a Red Hat based Linux
distribution; see [rpm.markdown][] for details (including why I implemented
this) if for some (strange?) reason you're interested.

[rpm.markdown]: rpm.markdown


## **6. <a name="thoughts">Final thoughts</a>**

Skip to [Winning comments](#winning).

The judges suggested that making them laugh helps entries chance of winning.
Well *laughter helps everything* so in case you haven't seen - and *even if you
have seen* - Dennis Ritchie's anti-foreword to the ghastly *UNIX-HATERS
Handbook* or Ken Thompson's revelation that C and Unix are a hoax (at the end of
that book) I include it below; because I agree that looking at a lot of twisted
code must be quite difficult (though maybe not as much as if you were to have to
look at Microsoft Windows code or code for Windows in any case ? :)) and these
two things I think are rather amusing (in order of least to most):

<a name="dmr">Dennis Ritchie's</a> Anti-Foreword:

> Anti-Foreword

> By Dennis Ritchie
> From: dmr@plan9.research.att.com
> Date: Tue, 15 Mar 1994 00:38:07 EST
> Subject: anti-foreword

> To the contributers to this book:

> I have succumbed to the temptation you offered in your preface: I do write you
> off as envious malcontents and romantic keepers of memories.  The systems you
> remember so fondly (TOPS-20, ITS, Multics, Lisp Machine, Cedar/Mesa, the Dorado)
> are not just out to pasture, they are fertilizing it from below.

> Your judgments are not keen, they are intoxicated by metaphor. In the Preface
> you suffer first from heat, lice, and malnourishment, then become prisoners in
> a Gulag. In Chapter 1 you are in turn infected by a virus, racked by drug
> addiction, and addled by puffiness of the genome.

> Yet your prison without coherent design continues to imprison you. How can
> this be, if it has no strong places? The rational prisoner exploits the weak
> places, creates order from chaos: instead, collectives like the FSF vindicate
> their jailers by building cells almost compatible with the existing ones, albeit
> with more features. The journalist with three undergraduate degrees from MIT,
> the researcher at Microsoft, and the senior scientist at Apple might volunteer a
> few words about the regulations of the prisons to which they have been
> transferred.

> Your sense of the possible is in no sense pure: sometimes you want the same
> thing you have, but wish you had done it yourselves; other times you want
> something different, but can't seem to get people to use it; sometimes one
> wonders why you just don't shut up and tell people to buy a PC with Windows or a
> Mac. No Gulag or lice, just a future whose intellectual tone and interaction
> style is set by Sonic the Hedgehog. You claim to seek progress, but you succeed
> mainly in whining.

> Here is my metaphor: your book is a pudding stuffed with apposite
> observations, many well-conceived. Like excrement, it contains enough undigested
> nuggets of nutrition to sustain life for some. But it is not a tasty pie: it
> reeks too much of contempt and of envy.

> Bon appetit!

Yes he misspelt *'contributors'*! But then again we're talking about obfuscation
and since it doesn't break his message it's not broken - it's just obfuscated
albeit not very much (and it still *'compiles'!*); and isn't that what this
contest is about? :)

<a name="ken">Ken Thompson's</a> ending:

> Creators Admit C, Unix Were Hoax

> FOR IMMEDIATE RELEASE

> In an announcement that has stunned the computer industry, Ken Thompson,
Dennis Ritchie, and Brian Kernighan admitted that the Unix operating system and
C programming language created by them is an elaborate April Fools prank kept
alive for more than 20 years. Speaking at the recent UnixWorld Software
Development Forum, Thompson revealed the following:

> "In 1969, AT&T had just terminated their work with the GE/AT&T Multics
project.  Brian and I had just started working with an early release of Pascal
from Professor Nichlaus Wirth's ETH labs in Switzerland, and we were impressed
with its elegant simplicity and power. Dennis had just finished reading Bored of
the Rings, a hilarious National Lampoon parody of the great Tolkien Lord of the
Rings trilogy. As a lark, we decided to do parodies of the Multics environment
and Pascal. Dennis and I were responsible for the operating environment. We
looked at Multics and designed the new system to be as complex and cryptic as
possible to maximize casual users' frustration levels, calling it Unix as a
parody of Multics, as well as other more risque allusions.

> "Then Dennis and Brian worked on a truly warped version of Pascal, called "A."
When we found others were actually trying to programs with A, we quickly added
additional cryptic features and evolved into B, BCPL, and finally C. We stopped
when we got a clean compile on the following syntax:

	    for(;P("\n"),R=;P("|"))for(e=C;e=P("_"+(*u++/
	    8)%2))P("|"+(*u/4)%2);

> "To think that modern programmers would try to use a language that allowed
such a statement was beyond our comprehension! We actually thought of selling
this to the Soviets to set their computer science progress back 20 or more
years. Imagine our surprise when AT&T and other U.S. corporations actually began
trying to use Unix and C!  It has taken them 20 years to develop enough
expertise to generate even marginally useful applications using this 1960s
technological parody, but we are impressed with the tenacity (if not common
sense) of the general Unix and C programmer.

> "In any event, Brian, Dennis, and I have been working exclusively in Lisp on
the Apple Macintosh for the past few years and feel really guilty about the
chaos, confusion, and truly bad programming that has resulted from our silly
prank so long ago."

> Major Unix and C vendors and customers, including AT&T, Microsoft,
Hewlett-Packard, GTE, NCR, and DEC have refused comment at this time.  Borland
International, a leading vendor of Pascal and C tools, including the popular
Turbo Pascal, Turbo C, and Turbo C++, stated they had suspected this for a
number of years and would continue to enhance their Pascal products and halt
further efforts to develop C. An IBM spokesman broke into uncontrolled laughter
and had to postpone a hastily convened news conference concerning the fate of
the RS/6000, merely stating "Workplace OS will be available Real Soon Now." In a
cryptic statement, Professor Wirth of the ETH Institute and father of the
Pascal, Modula 2, and Oberon structured languages, merely stated that P. T.
Barnum was correct.

**So is it a hoax about a non-hoax, a non-hoax about a hoax, a non-hoax about a
non-hoax or is it a hoax about a hoax ? :) And if it's any of those what does it
mean about Unix and C?** And if a hoax is involved *what is the hoax?* The pedant
and Tolkienist that I am has to state that **Tolkien didn't consider The Lord of
the Rings a trilogy** *(and he made that very clear)* but that doesn't take away
from the humour by any stretch (*if anyone wants me to elaborate or debate the
matter do send me an email - I love Tolkien's legendarium and having another
person to talk about it with is more than welcome!*). Ken suggested that there
is a lack of common sense but since he was part of its creation I don't think
it's a bad thing; **on the contrary it makes all of us C programmers even more
talented! :)** I do wonder if he tested that bit of C code though:

	    for(;P("\n"),R=;P("|"))for(e=C;e=P("_"+(*u++/
	    8)%2))P("|"+(*u/4)%2);
	   
How is **`R=;`** valid? Since I don't have the context maybe there is something
I'm missing but either way it's a funny piece. It could also be for irony itself
(actually I had previously thought of somehow implementing something like that
for the contest but decided for the message by itself in the end). I would
prefer believing that whether true or not.

## **7. <a name="winning">Winning comments, thanks, dedications, links, etc.</a>**

I feel incredibly honoured, privileged and I am extremely happy and proud to
have won! I am more proud and happy about this than anything I have ever done in
my life and I don't think there can be anything else I can be more proud of in
the future (except winning again should I find or think of another interesting
thing to try and implement in an obfuscated way). Because winning is one thing;
but to be included amongst very clever and talented veterans whom I highly
respect is an incredible badge of honour that I will proudly wear (literally too
as I hope to get my entry on a shirt) for the rest of my life. This type of
badge is something I feel most only dream of but never come close to earning.
That I did is by far the best feeling I can think of.

Thank you Simon Cooper, Landon Curt Noll and Leonid A. Broukhis, and thank you
to everyone who has been an important and special part of my life. I want to
specially name some:

I dedicated this program to my beloved but recently late dog Venus; instead of
drowning in grief I channelled it to creativity. And to have won a contest
requiring creativity, cleverness and novelty is a tribute to an equally
creative, clever and unique dog that she was. I miss you terribly Venus but I'm
so happy to have had you in my life.

But I want to also dedicate it to (and thank) my dear friend Martijn Schoemaker
whom provided me with the spark a very long time ago (and whom has stood by me
and helped me in more ways than he can know - **`#including C`**); if it wasn't
for you Martijn I wouldn't have been able to win so consider this a recursive
thank you thank you! :) I would also like to give thanks and much love to my
best and closest friend Vicky Wilmore who means the absolute world to me; thank
you for being such a wonderfully beautiful person and friend - that truly is
what 'just you' means, sweetheart, and don't you forget it! <3 Finally I would
like to thank my mother for being the best mum anyone could ask for, who's
always been here for me and whom I also inherit the keen analytical mind from. I
love you all!

I want to also thank Dave Burton for acknowledging me in his hint.markdown file
for as he put it 'being relentless with pursuit of bugs'. To think that it was
circumstantial to my entry too makes it all the more unlikely but that doesn't
take away the significance of it; for I am a very symbolic person and being
acknowledged for this type of thing is great but to be acknowledged for it by
someone who has won more than once is even more special to me: thank you Dave!
It means a great deal to me and I am glad I could help! :)

I would also like to say to the judges about their commentary as well as the
category title: they're all very dear to me and that includes not just the
remarks but the example invocations. They fit my views precisely. As for the
test-strings.txt file modifications: very amusing and I certainly do not object.
Thank you again for such an honour and privilege! That this isn't a dream is the
best reality imaginable! :)

Congratulations to one and all for winning; it's an honour to win such a
wonderful contest requiring creativity, cleverness, uniqueness and
inventiveness but to win beside all the other wonderful entries is truly
special!

Shortly after the entry has been published I will have more information on the
winning entry at [https://ioccc.xexyl.net/2018/weasel][] including how to
contact me (besides what's already published on the IOCCC website). There also
is an [errata page][] so that in the case I find anything I would like to
correct in the documentation or other supplementary files I can note them there.

If you wish to contact me please do so; although I have a Twitter account I don't
really use it so please send me an email instead. I do have Facebook as of a
little under two years but I'll worry about that at such a time (I presume in
fact 'if') it becomes relevant.

[https://ioccc.xexyl.net/2018/weasel]: https://ioccc.xexyl.net/2018/weasel
[errata page]: https://ioccc.xexyl.net/2018/weasel/errata

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2018, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
