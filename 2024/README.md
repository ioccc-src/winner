# Twenty Eighth International Obfuscated C Code Contest


## Where to start

See below for links to the [2024 winning IOCCC entries](#inventory).

Check out the `index.html` web pages for each winning entry.  They have
most of the information you need to compile and run the winning program.
Take a look at the winning source code and try to figure out how it works.
You might also want to check out the author's remarks for even more details.

You may [download all winning entries](2024.tar.bz2) in the form
of a compressed tarball, for this year's contest.


## General remarks on this contest

This year marked the [40th anniversary of the IOCCC](../faq.html#ioccc_start).
The **IOCCC28** opened submissions from **2025-03-05 23:19:17.131107 UTC** to **2025-06-05
04:03:02.010099 UTC** after a 4 year pause.

A significant portion of those 4 years was an effort by a [number of people](../thanks-for-help.html),
with over 6168+ commits, to rebuild the [Official IOCCC website](../index.html)
in what became known as the **Great Fork Merge**.

Another portion of those 4 years went into retooling the IOCCC, including the creation of
the [mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry), a new
[IOCCC registration process](../next/register.html), and a new
[IOCCC submit server](https://submit.ioccc.org/) (which may not be up if the contest is closed).

The **major motivation** for the above was to:

* Present [IOCCC winners](../years.html) that that honors the contributions of all of the [winning authors](../authors.html) from [around the world](../location.html),

* Reduce the administrative effort required by the [IOCCC Judges](../judges.html) to run the contest, and

* Minimize the time between when the winners of the IOCCC are selected and when the source is made available.

On the last point, for **IOCCC28** the Judging started on **2025-06-05 04:03:02.010099 UTC** and then the winners were selected by the [IOCCC Judges](../judges.html) on **2025-07-07 20:05:07.000000 UTC**:

* Winners were announced during a live the [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse) YouTube Channel that started on **2025-08-02 18:00:00.000000 UTC**

* Near the end of the 2 hour XXX-add-show-URL-here-XXX YouTube show, the **source code** of the [IOCCC28 winning entries](#inventory) was published on [IOCCC GitHub winner repo](https://github.com/ioccc-src/winner) and on the [Official IOCCC website](../index.html).

**No longer will there be many months** between when the winners are
announced and their source code is made available.  For **IOCCC28**
the time was **less than 2 hours**.  :-)


### Increased submission quantity and quality

The submissions to **IOCCC28** were remarkable when compared with previous contests, in both the
**increased quantity and quality** of the submissions.  As a result the judging process for **IOCCC28**
was more challenging and required greater effort.  Thankfully due to the above mentioned improvements,
the judging process **took only 33 days**.  Under the previous system it **would have taken much longer**!

One thing that began to emerge after we exits the early rounds of judging and entered the middle rounds
of judging was that we were very likely to have more winning entries than in previous contests.
Even so, the final rounds of judging required more rounds and tool longer than in any previous IOCCC.

At the end of the final round of the final rounds of judging, we had a record **23 winners of IOCCC28**,
eclipsing the record of 15 winners!

While we suspect that the 4 year gap between **IOCCC27** and **IOCCC28** allowed
people extra time to improve their submissions, we also believe that people
submitting to the IOCCC have become more adept in adept in obfuscation and have
become more skilled in the programming in the C language.


### Code size and Rule 2

We were pleased to observe that while the [IOCCC size limit](../faq.html#size_rule_history)
increased by about 21%, we received many submissions that were well under the new
[Rule 2 size limit](../next/rules.html#rule2) including a fair number of quality
small and medium sized submissions.  Half of the **IOCCC28 winners** were less than
_2/3 of the size limit_, and 10 of the **IOCCC28 winners** were less than
_1/2 of the size limit_!

**IMPORTANT NOTE**: The [IOCCC size limit](../faq.html#size_rule_history) increase for **IOCCC28**
was the first size increase in over 10 years.  Given the quality of submissions we received
that were well under the limit, we do **NOT** expect to change the
[Rule 2 size limit](../next/rules.html#rule2) for **at least another 10 years** (and likely longer).

**IMPORTANT HINT**: Only 3 of 23 the **IOCCC28 winners** came close to the [Rule 2 size limit](../next/rules.html#rule2).
Large code size isn't everything.  :-)   Those submitting to future contents should
**take a careful note** of that fact.


### Rules and Guidelines for this contest

Here are the final versions of the IOCCC rules and guidelines that were in effect for this contest:

* [2024 rules](rules.html) version **28.30 2025-03-03**
* [2024 guidelines](guidelines.html) version **28.47 2025-03-15**


### Looking forward to the next contest

The [IOCCC Judges](../judges.html) realize that the [IOCCC rules](../next/rules.html) and
the [IOCCC guidelines](../next/guidelines.html) need to be **greatly improved and streamlined**.
We decided to not overhaul them for **IOCCC28** so as to **NOT** delay the opening of the contest.

After the [IOCCC Judges](../judges.html) take a short _IOCCC Vacation_ (we have been working solid
on **IOCCC28** since **2020 Dec 30**), we plan to update, improve and streamline the
[IOCCC rules](../next/rules.html) and the [IOCCC guidelines](../next/guidelines.html) for **IOCCC29**.
Then we will address whatever bug fixes in the form of GitHub Pull Requests to both the
[IOCCC GitHub winner repo](https://github.com/ioccc-src/winner) and the
[mkiocccentry toolkit repo](https://github.com/ioccc-src/mkiocccentry) that may be pending.

Once we are all caught up, we will set the opening date for **IOCCC29**.  It is our plan
to open **IOCCC29** sometime in **2025 December**.


## Remarks on some of the winning entries

There were a number of remarkable winning entries for **IOCCC28**.  We wish to call
attention to a few of them:

* [2024/kurdyukov1](kurdyukov1/index.html)

This entry is a fun revisit of the theme of [2000/natori](../2000/natori/index.html),
only better and without using any floating point arithmetic.  You are invited
to try and understand why the constant `2551443` is common to both entries.

* [2024/cable1](cable1/index.html)

This entry claims to be "_the world's smallest LLM (large language
model) inference engine_": running open-source model based on Meta's
LLaMA 2 with 7 billion parameters.  After downloading the model via the
[2024/cable1/get_model.sh](%%REPO_URL%%/2024/cable1/get_model.sh) script,
we invite you explore this **ChatIOCCC** tool.  While not super fast,
the tool's output can be amusing.

You might wish to ask **ChatIOCCC**: "_Why did this entry win IOCCC28?_"?

We encourage you to read and understand the
[2024/cable1/prog.c source code](%%REPO_URL%%/2024/cable1/prog.c).  Then see
if the **ChatIOCCC** tool can offer any new, or even correct insights
into the code's obfuscation.  :-)

* [2024/howe](howe/index.html)

"_Eh_"?  The source code, with its UTF-8 conforming accent gives you a
polite editor that is more functional an `ed(1)`.

We invite you to use the program to view the UTF-8 fun in the
[2024/howe/prog.c source code](%%REPO_URL%%/2024/howe/prog.c).

**HINT to emacs users**: type **Q** or press **CTRL+C** to exit. 🤓

* [2024/stedolan](stedolan/index.html)

When you view the [prog.c source code](%%REPO_URL%%/2024/stedolan/prog.c),
notice magic numbers.  This **one liner** packs a significant amount
of obfuscation in only 135 bytes!

Try giving 10 hex digits to standard input of the program.  Then try a
different hex digits value.  Then feed the MD5 hash of the
[2024/stedolan/prog.c source code](%%REPO_URL%%/2024/stedolan/prog.c) and
"_C_" what happens.  :-)

* [2024/endoh1](endoh1/index.html)

The [2024/endoh1/try.sh](%%REPO_URL%%/2024/endoh1/try.sh) will carry you on
a journey that tests your patience as well as the patience of the C-preprocessor.

Building a 8x8 image requires order of 20 seconds of C-preprocessor
time, when running 6 jobs on 4 CPU cores in parallel.  Unfortunately,
with such a tiny image, it is hard to appreciate the image being rendered.

So you might try building a 32x32 form of the image, invoking the
C-preprocessor 1024 times.  When using 6 jobs on 4 CPU cores in parallel,
this might take about 5.5 minutes to complete.  However, the small image
only gives you a hint of the image being rendered.

If you have the time you might try building a 128x128 image, invoking
the C-preprocessor 16384 times.  With 6 jobs on 4 CPU cores in parallel,
this will take about 1.5 hours.  At this scale you might consider it
worthwhile to render a more detailed image.

Using 6 jobs on 4 CPU cores in parallel, to build a 512x512 image invoking
the C-preprocessor 262144 times over a period of about 23.5 hours, you
will be given an image with a reasonable amount of detail to appreciate
what is being rendered.

One fun aspect of the [2024/endoh1/prog.c source code](%%REPO_URL%%/2024/endoh1/prog.c)
is that when it is compiled an executed, the program outputs C code.
That C code, call it `rt.c` will fail to compile!  But that is OK because the C-preprocessor
has enough work to do without bothering the C compiler.  :-)

We plan to recognise those who report that they [rendered a new record sized image](endoh1/index.html#larger).

* [2024/weaver](weaver/index.html)

As the expression goes, “Seeing (and hearing) is believing”: or at least can lead to better understanding of the code. :o)

After studying the [2024/weaver/prog.c source code](%%REPO_URL%%/2024/weaver/prog.c),
we suggest you compile and run the program for more information.

* [2024/mills](mills/index.html)

This won the "**Prize in ℤ₃**", but what does that mean?  Well,
the "_double-struck Z_" is **NOT** a reference to a set of integers,
nor is the "_double-struck Z subscript 3_" a reference to a ring of
3-adic integers.  Instead, it is a reference to the 3rd version of a
certain [virtual machine](https://en.wikipedia.org/wiki/Z-machine).

If you use the [2024/mills/try.sh](%%REPO_URL%%/2024/mills/try.sh) script, you will first be given
an opportunity to view the [2024/mills/prog.c source code](%%REPO_URL%%/2024/mills/prog.c).
Then you will be given 10 choices to play.

**HINT**: If you select **0**: Try to not be eaten by a Grue when
reading/navigating the twisty mazes of this source code! :-)

* [2024/codemeow](codemeow/index.html)

As you study the [2024/codemeow/prog.c source code](%%REPO_URL%%/2024/codemeow/prog.c),
try not to lose track of the forest of obfuscation while tracking down the execution path trees.

We think this code will "grow on you" as the C expression goes just a compiled C code  "_grows on parse trees_".  :-)

* [2024/kurdyukov2](kurdyukov2/index.html)

If seeing is believing, and you believe you understand the
[2024/kurdyukov2/prog.c source code](%%REPO_URL%%/2024/kurdyukov2/prog.c),
then you might be able to see how the code words.

**QUESTION**: How many of the "_magic numbers_" in the program do you understand?

* [2024/kurdyukov3](kurdyukov3/index.html)

The prize, "**virtual quietus**", is a virtual reference to the doom that awaits you when
you run this code: let alone when your try to figure out how the author was able to
encode the virtual machine in under **2.5K bytes** of [prog.c source code](%%REPO_URL%%/2024/kurdyukov3/prog.c)!

**NOTE**: The implementation runs without sound or mouse
input.  You will need reply on your keyboard skills.  The
[2024/kurdyukov3/try.sh](%%REPO_URL%%/2024/kurdyukov3/try.sh)
demonstration script will give you some useful keyboard hints.

* [2024/cable2](cable2/index.html)

To those who follow the concept of "_seeing is believing_" will very
likely be "_deceived_" when they try to see the source in terminal window:

``` <!---sh-->
    cat 2024/cable2/prog.c
```

Viewing the [prog.c source code](%%REPO_URL%%/2024/cable2/prog.c) in most editors
might suggest that the is something fishy 🐠 with the code.

* [2024/macke](macke/index.html)

Have you ever wondered would what would happen if you recursively removed
files starting from the root directory?  Are you curious what happens when
you launch a [fork bomb](https://en.wikipedia.org/wiki/Fork_bomb)?
You can safely give those and other scenarios under this virtual machine.

We invite you to explore the [prog.c source code](%%REPO_URL%%/2024/macke/prog.c)
to explore this interesting virtual machine implementation.  And as a bonus, a
full-fledged C64 emulator is included!

* [2024/ferguson2](ferguson2/index.html)

The "**Prize in yil-tas**" provides a hint as to what this marvelous
winning entry is doing, provided that you are someone familiar in at
least 3 languages (**hint**: One of them is C, another is English).

The IOCCC is honored to present this entry for your enjoyment and for you to
ponder the [prog.c source code](%%REPO_URL%%/2024/ferguson2/prog.c).

* [2024/carlini](carlini/index.html)

The IOCCC has seen a number of winning entries that allow code designed to
run on early Intel processors, however none of them emulate a processor as
early as the [Intel 4004](https://en.wikipedia.org/wiki/Intel_4004).
Launched in 1971, the 4004 was the core of the first commercially marketed
microprocessor chipset.

The [2024/carlini/prog.c](%%REPO_URL%%/2024/carlini/prog.c)
code runs rather slow, so patience is required to watch
[4004](https://en.wikipedia.org/wiki/Intel_4004#/media/File:Intel_C4004.jpg)
code run.  This is very understandable when you realize that the
[2024/carlini/prog.c](%%REPO_URL%%/2024/carlini/prog.c) is actually
emulating the entire
[4004 chip circuit](https://en.wikipedia.org/wiki/Intel_4004#/media/File:Chip_layout_from_the_development_phase_of_the_Intel_4004_from_1971,_the_first_microprocessor_of_the_world_(cropped_and_edited_image).jpg)
by computing the output of each gate in a loop, effectively running the CPU and associated RAM/ROM chips!


### Remarks on some of submissions that did not win

* Depending on the address of a variable, as not all platforms support
[ASLR](https://en.wikipedia.org/wiki/Address_space_layout_randomization),
as the single source of pseudo-randomness isn't a good idea.  It's
much better to mix in other sources of variability (e.g. time, process
ID, etc.) so that subsequent runs will behave differently.

* If a submission's obfuscation strongly resembles a past IOCCC winning
entry, and the submission's obfuscation is mainly in the C code source,
then the submission likely to not make it into the final rounds of judging.

* When working with modern C compilers, it's crucial to explicitly
declare variable and function types. Don't assume they'll
automatically default to an `int`.

* Sadly, K&C-style C code does not compile well under modern C compilers.

* A submission that only works under gcc or clang does not work as well
as submissions that can work under either compiler.

* Shrinking an existing open-source program to meet rule 2 size might
be an impressive feat of code shrinking, but it might not be enough to
make it into the final rounds of judging. Originality is key, and this
might not be the most innovative approach.

* If your submission relies on mathematical algorithms, be sure that the
C code that implements the mathematics is well obfuscated.

* Just a friendly reminder that before you upload your submissions,
uncompress the compressed tarball into a different directory. This way,
you can be sure you didn't miss uploading any important files!

* Using a lot of goto statements to make your code harder to understand
might not help it pass the final rounds of judging.


### Encouragement for those who did not win this year

We know many of you that submitted to the IOCCC put in a ton of effort
into your submissions for this year's IOCCC.  We can't just give out
awards to everyone.  That would mean taking away from the submissions
that we think are the best and deserve to win.

Sometimes, a final round submission might be good enough to be a
winning IOCCC entry, only to be beaten by a similar, but slightly better
submission.  If you think this happened with your submission, consider
submitting an enhanced version to the next IOCCC.

**PLEASE DO NOT** give up hope! There are some submissions that have been
submitted with revisions, multiple times before rising to the level of
a winning IOCCC entry.  You might also want to try with a different type
of submission altogether for the next IOCCC.

If you're not planning to improve and resubmit your non-winning entry
for the next IOCCC, you're welcome to publish it.


## On Compiling and running winning entries

Some C compilers aren't as great as they could be. If yours isn't
working well, you might want to try compiling with an updated version
of clang and/or gcc instead.

If you encounter problems in compiling and/or running the winning entries, see the FAQ on:

* [Compiling IOCCC entries](../faq.html#compiling)
* [IOCCC entry dependencies](../faq.html#dependencies)
* [Problems compiling entries](../faq.html#compile_problems)
* [Running IOCCC entries](../faq.html#running_entries)

For additional information on how to submit fixes, see the FAQ on:

* [How to submit a fix](../faq.html#fix_an_entry) - how to submit a fix to an entry
* [Update author information](../faq.html#fix_author) - how to correct or update an IOCCC author's information


### For even more information

* [Reporting an IOCCC website problem](../faq.html#report_website_problem)
* [Submitting a fix to the IOCCC website](../faq.html#fix_website)
* [How to contact the IOCCC](../contact.html) - up to date contact details
* [IOCCC FAQ](../faq.html) - additional information on the IOCCC
* [www.ioccc.org](https://www.ioccc.org) - the primary IOCCC website


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
