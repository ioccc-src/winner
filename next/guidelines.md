# 29th International Obfuscated C Code Contest Official Guidelines

<p class="leftbar">
Copyright &copy; 2025 Leonid A. Broukhis and Landon Curt Noll.
</p>

All Rights Reserved.  Permission for personal, education or non-profit use is
granted provided this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in
writing by [contacting the Judges](../contact.html).


# Guidelines Version

<p class="leftbar">
These Guidelines are version **29.06 2025-12-01**.
</p>

<p class="leftbar">
The <span style='font-size:28px;'><b>&verbar;</b></span> symbol indicates an **change** from the previous IOCCC.
</p>

<p class="leftbar">
Because the **IOCCC29**  was a substantial rewrite, only **important changes** from **IOCCC28** have been marked.
</p>

Be sure to read the [Rules](rules.html).


<div id="guideline1">
<div id="guideline1-c">
# Guidelines for [Rule 1 - C program](rules.html#rule1-c)
</div>
</div>

<p class="leftbar">
While you submission **MUST** be a C program, there is nothing wrong if your `prog.c`
file happens to also be a code for another language.
</p>

<p class="leftbar">
We would prefer if you do not use `#include` statements,
especially `#include` statements just to include lots of data,
to get around the
[Rule 2 - Size restrictions](rules.html#rule2-size-restrictions)
in an excessive way.
</p>

<p class="leftbar">
We would prefer if you do not require lots and lots of implicit defines on the C compiler command line
(i.e., lots of `-Dfoo`, and `-Dcurds=whey` style command line args to the C compiler)
to get around the
[Rule 2 - Size restrictions](rules.html#rule2-size-restrictions)
in an excessive way.
</p>

<p class="leftbar">
Some use of `#include` statements and/or implicit defines on the C compiler command line is perfectly reasonable.
</p>

<p class="leftbar">
As a guide, consider the level of `#include` statements and/or implicit defines on the C compiler command line
that are found in
[winning Entries](https://www.ioccc.org/years.html), and try to **NOT** set a new record.
</p>

<p class="leftbar">
If you believe you need to significantly abuse `#include` statements and/or implicit defines on the C compiler command line,
then try to make a case for why in your submission's `remarks.md` file: maybe the Judges won't reject your submission.
</p>


Jump to: [top](#)


<div id="guideline2">
<div id="guideline-2---size">
<div id="guideline2-size">
# Guidelines for [Rule 2 - Size restrictions](rules.html#rule2-size-restrictions)
</div>
</div>
</div>

<p class="leftbar">
You should pay attention to our observations on
[code size and Rule 2 remarks for IOCCC28](../2024/index.html#code-size-and-rule-2).
</p>

Your submission must satisfy **BOTH** the
[Rule 2a - Gross Size](rules.html#rule2a-gross-size)
**AND**
[Rule 2b - Net Size](rules.html#rule2b-net-size) rules.

To check your code against
[Rule 2 - Size restrictions](rules.html#rule2-size), use the `iocccentry(1)` tool.
For example:

``` <!---sh-->
    iocccsize prog.c
```

The `iocccsize(1)` algorithm can be summarized as follows:

> The size tool counts most C reserved words (keyword, secondary, and selected
preprocessor keywords) as 1.  The size tool counts all other bytes as 1
excluding ASCII whitespace, and excluding any '`;`', '`{`' or '`}`' followed by
ASCII whitespace, and excluding any '`;`', '`{`' or '`}`' byte immediately
before the end of file.
>
> ASCII whitespace includes ASCII tab, ASCII space, ASCII newline, ASCII formfeed, and ASCII carriage return.
>
> When '`;`', '`{`' or '`}`' are within a C string, they may still not be
counted by the IOCCC size tool.

In cases where the above summary and the algorithm implemented by
`iocccsize(1)` conflict, the algorithm implemented
by the minimum required version of `iocccsize(1)` is preferred by the [Judges](../judges.html).

Make sure `iocccsize` does not flag any issues with your `prog.c`.

**NOTE**: by default `iocccsize` will only report the size, unless the
code surpasses the limit.

There a much less need to `#define` C reserved words in an effort
to get around the size limits of
[Rule 2 - Size restrictions](rules.html#rule2-size)
because of the `iocccsize(1)` algorithm.

Yes Virginia, **the previous guideline sentence is an important hint**!

Don't expect the [Rule 2 - Size restrictions](rules.html#rule2-size) to
[change any time soon](../faq.html#size_slow_change).

See the
FAQ on "[How has the Rule 2 size restrictions rule changed over the years?](../faq.html#size_rule_history)".


Jump to: [top](#)


<div id="guideline3">
<div id="guideline3-register">
# Guidelines for [Rule 3 - Register for the IOCCC](rules.html#rule3-register)
</div>
</div>

<p class="leftbar">
If a group of people work on a submission, then they should
[register for the IOCCC](../quick-start.html#enter)
using either a valid group email address, or an email address for one of the authors.
</p>

<p class="leftbar">
Processing your registration is an activity overseen by a Judge.
Please be **patient** while a Judge processes your registration.
</p>

It can take a few days to process your registration and for the server to
email your details, therefore make sure to allow yourself ample time to
register and submit your entries; **DO NOT WAIT UNTIL THE FINAL DAYS**
to register!  The Judges are **NOT** responsible for delayed or lost
email or for those who wait until the last minute to try to register!

<p class="leftbar">
If after a few days you believe your registration hasn't been process, then
[contact the Judges](../contact.html).
</p>

<p class="leftbar">
After your UUID and temporary password are emailed to you, you have
up to fortnight (**14 days**) to login and change your temporary password.
If you fail to change your temporary password by that deadline, then you'll need to
[contact the Judges](../contact.html) by email to request a reset.
</p>

See [How to register for the IOCCC](register.html).

See [Entering the IOCCC: the bare minimum you need to know](../quick-start.html#enter).


Jump to: [top](#)


<div id="guideline7">
<div id="guideline7-original">
# Guidelines for [Rule 7 - Original Work](rules.html#rule7-original-work)
</div>
</div>

While it is **NOT** required, you are allowed to use tools or services such as:

* Code generators
* Static and runtime code analysis tools
* Machine learning tools
* Natural language models
* Large language models (LLMs)
* Code copilot tools
* So called "_AI services_"
* Etc.

The IOCCC has a rich history of remarkable winning entries created by
authors who skillfully employed various techniques to develop their code.
If you do make use of such tools or services, then we **ENCOURAGE you to
describe how you used such tools** in your `remarks.md` file.

<p class="leftbar">
In short: You created it, you own it, its an original work, or you have explicit permission to the work.
</p>

See the
FAQ on "[May I use AI, LLM, Virtual coding assistants, or similar tools to write my submission?](../faq.html#ai)".


Jump to: [top](#)


<div id="guideline8">
<div id="guideline8-submitting">
# Guidelines for [Rule 8 - Submitting requirements](rules.html#rule8-submitting-requirements)
</div>
</div>

Do **NOT** register more than one account just to try and get around the limit on the number of submission slots.


Jump to: [top](#)


<div id="guideline9">
<div id="guideline9-no-interactive-compiling-allowed">
<div id="guideline9-no-interactive">
# Guidelines for [Rule 9 - No interactive compiling allowed](rules.html#rule-9---no-interactive-compiling-allowed)
</div>
</div>
</div>

Don't forget that the building of your program should be done
**WITHOUT human intervention**.  So don't do things such as:

``` <!---makefile-->
    prog: prog.c
        #echo this next line requires data from standard input
        cat > prog.c
        ${CC} prog.c -o prog
```

However, you can do something cute such as making your program
do something dumb (or cute) when it is built 'automatically', and
when it is run with a human involved, do something more clever.
For example, one could put in their `Makefile`:

``` <!---makefile-->
    prog: prog.c
        ${CC} prog.c -DNON_HUMAN_COMPILE -o prog
        @echo "See remarks section about alternate ways to compile"
```

and then include special notes in your `remarks.md` file for
alternate / human intervention based building.


Jump to: [top](#)


<div id="guideline11">
<div id="guideline11-abuse">
<div id="guideline-11---abuse">
# Guidelines for [Rule 11 - Legal rule abuse](rules.html#rule11-legal-rule-abuse)
</div>
</div>
</div>

We do realize that there are holes in the [Rules](rules.html), and invite
submitters to attempt to apply creative rule interpretation.  A rule abuse though, even
if not rewarded, may result in a subsequent rule change for future contests.

We sometime award '**Best abuse of the rules**' or '**Worst abuse of the rules**',
or some variation, to a submission that creatively attempts to exploit a holes in the
[Rules](rules.html).

When we do need to plug a hole in the [Rules](rules.html)
or [Guidelines](guidelines.html), we will attempt to use a very small plug,
if not smaller.

Or, maybe not. :-)

Legal rule abuse may involve, but is not limited to, doing things that are
technically allowed by the [Rules](rules.html) and yet do not fit the spirit of what
we intended to be submitted.

Legal abuse of the [Rules](rules.html) is **NOT** an invitation to violate
the [Rules](rules.html) (especially [Rule 17 -
Use mkiocccentry](./rules.html#rule17-mkiocccentry)). A submission that violates the
[rules](rules.html) in the opinion of the [Judges](../judges.html),
**WILL** be disqualified.  **_RULE ABUSE CARRIES A CERTAIN LEVEL OF RISK!_**

If you intend to abuse the [Rules](rules.html),
indicate so in your `remarks.md` file.  You **MUST** try to justify, plead, beg,
why you consider your rule abuse to be allowed under the
[Rules](rules.html).  Humor or creativity help plead a case.

As there is no guarantee that you will succeed, you might consider submitting an
alternate version that conforms to the [Rules](rules.html), if it might
otherwise be interesting; one that does not abuse the [Rules](rules.html)
and one that does, making sure to note in the one that does not abuse the rules
that this is another version, so that the Judges do not assume you uploaded it
by mistake.

If you do bypass the `mkiocccentry(1)` warnings about
[Rule 2a - Gross Size](rules.html#rule2a-gross-size)
and/or about
[Rule 2b - Net Size](rules.html#rule2b-net-size)
or any other
rule and submit a submission anyway, you **MUST** try to justify why the
[Judges](../judges.html) should not reject your submission due to a rule
violation, and you would be wise to do this towards the top of your `remarks.md`
file so as not to be overlooked.

We are often asked why the contest [Rules](rules.html) and [Guidelines](guidelines.html) seem strange or contain mistakes, flaws, or
grammatical errors.  One reason is that we sometimes make genuine mistakes, but
in many cases such problems, flaws or areas of confusion are deliberate.

Changes to [Rules](rules.html) and [Guidelines](guidelines.html) in
response to rule abuses, are done in a minimal fashion.  Often we will
deliberately leave behind holes (or introduce new ones) so that future rule
abuse can continue.  A clever author should be able to read and "drive a
truck through the holes" in the [Rules](rules.html) and [Guidelines](guidelines.html).

At the risk of stating the obvious, this contest is a parody of the software
development process.  The [Rules](rules.html) and [Guidelines](guidelines.html)
are only part of the overall contest.  Even so, one might think the
contest [Rules](rules.html) and [Guidelines](guidelines.html) process as a parody
of the sometimes tragic mismatch between what a customer (or marketing) wants
and what engineering delivers. Real programmers must face obfuscated and
sometimes conflicting, ballooning specifications, and requirements from marketing, sales,
product management and even from customers themselves on an all too regular basis.
This is one of the reasons why the [Rules](rules.html) and
[Guidelines](guidelines.html) are written in obfuscated form.


Jump to: [top](#)


<div id="guideline12">
<div id="guideline12-utf8">
# Guidelines for [Rule 12 - UTF-8](rules.html#rule-12---utf-8)
[Rule 12 - UTF-8](rules.html#rule12-utf8)
</div>
</div>

The IOCCC no longer discourages the use of multibyte UTF-8 characters in `C` code.


<div id="guideline13">
<div id="guideline13-nocr">
# Guidelines for [Rule 13 - No carriage returns in prog.c](rules.html#rule-13---no-carriage-returns-in-prog.c)
</div>
</div>

We **DISLIKE** C code with trailing control-M's (`\r` or `\015`) that results
in compilation failures.

Some non-UNIX/non-Linux tools such as MS Visual C and MS Visual C++
leave trailing control-M's on lines.  Users of such tools should strip
off such control-M's before submitting their submissions.  In some cases
tools have a "Save As" option that will prevent such trailing control-M's
being added.

If your `prog.c` is near the
[Rule 2a Gross Size](rules.html#rule2a-gross-size) and/or
[Rule 2b Net Size](rules.html#rule2b-net-size)
limit, you are permitted to **NOT** end source with a newline.
If you need to do this, please document that in your `remarks.md` file.

If your complains about about not ending in a newline,
please this in your `remarks.md` file.


Jump to: [top](#)


<div id="guideline15">
<div id="guideline-15---building">
<div id="guideline15-gnu-makefile">
# Guidelines for [Rule 15 - GNU Makefile](rules.html#rule15-gnu-makefile)
</div>
</div>
</div>

Submissions will be judged in an environment that has no **IDE**.
Any submission that fails to compile/build because it requires
an **IDE** will be rejected.

<p class="leftbar">
We will use the GNU `make(1)` tool, your `Makefile`, as well as tools found in the
[Single UNIX Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
(UNIX-like) environments, and commonly found on systems that reasonably conform to the
[Single UNIX Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
in the building and compiling of your submission.
</p>

<p class="leftbar">
Your `Makefile` **MUST** be compatible with GNU `make` and we suggest you use
[Makefile.example](Makefile.example) as a template, renamed as `Makefile` of
course.
</p>

See the
FAQ on "[What are the detailed recommendations for a submission Makefile?](../faq.html#makefile_details)".


Jump to: [top](#)


<div id="guideline17">
<div id="guideline-17---packaging">
<div id="guideline17-mkiocccentry">
# Guidelines for [Rule 17 - Use mkiocccentry](rules.html#rule17-mkiocccentry)
</div>
</div>
</div>

<p class="leftbar">
We **STRONGLY** recommend you **do** install the most recent release of
[mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry)
because use of older versions of the mkiocccentry toolkit are **HIGHLY LIKELY** to be **REJECTED**!
</p>

<p class="leftbar">
If you submit your own JSON files (**OTHER THAN** `.auth.json` and
`.info.json`) then they do **NOT** have to be valid JSON.
</p>

<p class="leftbar">
However, if you do provide invalid JSON files, **PLEASE**
document and **clearly explain** this in your `remarks.md` file.
</p>

<p class="leftbar">
An _extra file_ is defined as a file that is not `prog.c`, `prog.alt.c`,
`try.sh`, `try.alt.sh`, `remarks.md`, `Makefile`, `.auth.json` and `.info.json`:
unless it's not in the top level directory, in which case it **IS** an _extra
file_.
</p>

<p class="leftbar">
The non-extra files (`prog.c`, `prog.alt.c`,
`try.sh`, `try.alt.sh`, `remarks.md`, `Makefile`, `.auth.json` and `.info.json`)
are considered _free files_, and do not count towards the
[Rule 17 - Use mkiocccentry](rules.html#rule17-mkiocccentry)
limit of **31** _extra files_.
</p>

<p class="leftbar">
If you use an optional filename for something other than their intended use
in order to get past the file limit, we will consider that an abuse of rules.
</p>

<p class="leftbar">
The `mkiocccentry` generated tarball does **NOT** reveal who you are!  For this
reason, the tarball **MUST** be a **v7 format** tarball.
</p>

<p class="leftbar">
You should NOT use a tarball as an _extra file_ for a test-suite unless you
have a very good reason for this: if you do include a tarball as an _extra file_,
then you **MUST** specify why in your `remarks.md` file.
</p>

<p class="leftbar">
If you **DO** include a tarball as an _extra file_, and the build process or the
program extracts said tarball(s), the make `clobber` rule **MUST** remove the
extracted files.
</p>

<p class="leftbar">
Instead of including a large test-suite that requires a lot of files as part of
your submission, if your submission doesn't require the test-suite to be
available to run, then in your `remarks.md` you could include URL where such a
test-suite may be downloaded from and how to use the test-suite to test your
submission, assuming it is not reveal who you are, eg. do not use a GitHub URL
which contains your username.
</p>

<p class="leftbar">
If you **DO** include a tarball then make sure it uses the v7 format. See the
FAQ on "[extra files](../faq.html#extra-files)"
for details on how to make a v7 tarball.
</p>

<p class="leftbar">
We recommend that all markdown files in your submission observe our
[IOCCC markdown guidelines](../markdown.html).
</p>

See the
FAQ on "[What should I do with the `try.sh` and `try.alt.sh` scripts?](../faq.html#try_scripts)".

See the
FAQ on "[What is a `.auth.json` file?](../faq.html#auth_json)".

See the
FAQ on "[What is a `.info.json` file?](../faq.html#info_json)".

See the
FAQ on "[How can I validate my submission directory?](../faq.html#chksubmit)".

See the
FAQ on "[What permissions may my files be and what if I need different permissions?](../faq.html#file_perms)".

See the
FAQ on "[What are the detailed recommendations for a submission Makefile?](../faq.html#makefile_details)".

See the
FAQ on "[What are the details behind Rule 17 - Use mkiocccentry?](../faq.html#rule17)".


Jump to: [top](#)


<div id="general">
<div id="general-guidelines">
# General Guidelines
</div>
</div>


<div id="general-overall-guidelines">
<div id="overall-guidelines">
## Overall Guidelines
</div>
</div>

These [Guidelines](guidelines.html) are **hints** and **suggestions**, **NOT** [Rules](rules.html).

While submissions that violate the [Guidelines](guidelines.html) are allowed,
submissions that remain within the [Guidelines](guidelines.html) are preferred.

You are encouraged to review the following [FAQs](../faq.html):

* [How to enter the IOCCC](../quick-start.html#enter)

* [Obtaining and compiling the most recent mkiocccentry toolkit](../faq.html#mkiocccentry)

* [How to upload your submission](./submit.html)

While the contest is **[open](../faq.html#open)**, you may modify your
previously uploaded submission by rebuilding your submission with the
[mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry),
and then re-uploading it to **the same slot number** on the
[submit server](https://submit.ioccc.org).

<p class="leftbar">
The **official locale** of the **IOCCC** is **C**.
</p>

You are **encouraged** to examine the [winners of previous contests](../years.html).

Because the [Rules](rules.html) change from year to year, some [past winning entries](../years.html)
may be rejected this year.  What was _was_ unique and novel one year _might be 'old' the next year_.

A submission is usually examined in a number of ways.  We typically apply
a number of tests to a submission:

* look at the original source
* C pre-process the source ignoring `#include` lines
* C pre-process the source ignoring `#define` _and_ `#include` lines
* run it through a C beautifier (such as `clang-format(1)`)
* examine the algorithm
* compile it (with flags to enable all warnings)
* execute it

You should consider how your submission looks in each of the above tests.
You should ask yourself if your submission remains obscure after it has been
'_cleaned up_' by the C pre-processor and a C beautifier.

Your submission need not pass all of the above tests as in certain cases,
a test is not important.

Submissions that compete for the
'**strangest/most creative source layout**' need not do as well as
others in terms of their algorithm.

Given two submissions, we are more inclined to pick the submission that
does something interesting when it's executed.

**IMPORTANT:** Be sure that **your submission works** as documented in your `remarks.md` file.

We sometimes make an effort to debug a submission
that has a slight problem, particularly in or near the final round.
On the other hand, we have seen some otherwise excellent submissions
fall down because they didn't work as documented.

If you submission has bugs and/or mis-features, you are **MUCH BETTER** off
documenting such bugs and/or mis-features in your `remarks.md` file.

Consider an example of a [prime number](https://en.wikipedia.org/wiki/Prime_number)
printing program that claims that 16 is a prime number.
Noting such a bug in your `remarks.md` file could save your submission:

> "_this submission sometimes prints the 4th power of a prime by mistake_"

Sometimes a strange bug or (mis-)feature can even help the submission!  Of course, a correctly
working submission might be better.

We tend to look down on a
[prime number](https://en.wikipedia.org/wiki/Prime_number)
printer that claims that 16 is a prime number.
Clever people will note that 16 might be prime under certain conditions.  ;-)
Wise people, when submitting something clever
will **fully explain such cleverness** in their submission's `remarks.md` file.

People who are considering to just use some complex mathematical
function or state machine to spell out something such as "_hello,
world!_" **really really, _and we do mean REALLY_, do need to be more creative**.

Consider using misleading or subtle tricks layered on top of or under
an appropriate level of obfuscation.

A clean looking program with misleading comments and variable names might be a
**VERY GOOD START** to a great submission!


Jump to: [top](#)


<div id="likes">
<div id="dislikes">
## Our Likes and Dislikes
</div>
</div>

We **VERY MUCH LIKE** submissions that use an edited variant of the
example `Makefile`, as described and linked to in the [Makefile section](#makefile),
renamed as `Makefile` of course.  This makes it easier for the [Judges](../judges.html)
to test your submission. And if your submissions wins, it makes it easier to integrate it into
the [Official IOCCC winner website](https://www.ioccc.org/index.html).

We **VERY MUCH LIKE** submissions that have some educational value. This does **NOT** mean
that your submission should not be obfuscated but rather that the IOCCC has moved away from
the idea of "spoilers". You should not encrypt or rot13 content in your `remarks.md` file.

The above statement does not mean encryption/decryption tools will not win, nor
does it mean that if you have such a submission that you could not encrypt some
remarks (such as obfuscation details), but if you do so please put them in a
separate file and indicate how to undo it. Please do **NOT** use any cipher to
encrypt your `remarks.md`.

It is **VERY MUCH** appreciated if your remarks have some educational
value. And although educational value is not required, it is an
**EXCELLENT** bonus.

We **LIKE** submissions that use an edited version of the
`try.sh` example script (and if you have alternate code,
the same applies with the `try.alt.sh` script):

- [view example try.sh](%%REPO_URL%%/next/try.sh)
- <a href="try.sh">download example try.sh</a>

- [view example try.alt.sh](%%REPO_URL%%/next/try.alt.sh)
- <a href="try.alt.sh">download example try.alt.sh</a>

Of course, it is quite possible that only one invocation is
possible, so it is not necessarily detrimental to your submission if you do not
include one, though we do like interesting and creative uses of submissions. See
also the
FAQ on "[submitting try.sh and try.alt.sh scripts](../faq.html#try_scripts)".

<p class="leftbar">
Even if it only has one invocation we still **LIKE** the try scripts.
</p>

<p class="leftbar">
If you do include a `try.sh` then **PLEASE** remove the `try` rule in the Makefile.
</p>

<p class="leftbar">
If you do include a `try.alt.sh` then **PLEASE** remove the `try.alt` rule in the Makefile.
</p>

<p class="leftbar">
If you don't have a prog.alt.c, then **PLEASE** remove the `try.alt` rule as well.
</p>


Jump to: [top](#)


<div id="about-cpp">
### About C preprocessor
</div>

Doing masses of `#define`s to obscure the source has become 'old'.  We
tend to 'see thru' masses of `#define`s due to our pre-processor tests
that we apply.  Simply abusing `#define`s or `-Dfoo=bar` won't go as far
as a program that is more well rounded in confusion.

**Many** C compilers **DISLIKE** the following code, and so do we:

``` <!---c-->
    #define d define
    #d foo             /* <-- don't expect this to turn into #define foo */
```

In other words, it is a compilation error, and in order to get older
IOCCC winning entries that did this to compile, we had to update them to not do this.

When declaring local or global variables, you should declare the type:

``` <!---c-->
    int this_is_fine;
```

and **NOT** like this:

``` <!---c-->
    this_is_not;       /* <-- Try to avoid implicit type declarations */
```

We really **DISLIKE** submissions that make blatant use of `#include` of
large data files to get around the source code size limit. This does not mean
`#include` of standard header files, just data files you provide.

On 28 January 2007, the Judges rescinded the requirement that the
`#` in a C preprocessor directive must be the 1st non-whitespace byte.


<div id="about-compilers">
### About compilers
</div>

We tend to **like _less_** a submission that requires either
`gcc` **OR** `clang`.  **We _prefer_ submissions** that can compile
under **BOTH** `gcc` **AND** `clang`. **Hint!**

We **RECOMMEND** that the compiler flags you use in your
submission's `Makefile` are supported by **BOTH** `gcc` **AND** `clang`.

We **DISLIKE** the use of obscure compiler flags, especially
if `gcc` and/or `clang` do not support it.  We **suggest**
that you not use any really obscure compiler flags if you can help it.


<div id="about-nested-functions">
<div id="nested-functions">
### About nested functions
</div>
</div>

One side effect of the above is that you cannot assume the use
of nested functions such as:

``` <!---c-->
     int main() {
|        void please_dont_submit_this() {
|           printf("The machine that goes BING!!\n");
         }
|        please_dont_submit_this();
     }
```

On 2012 July 20, the [Judges](../judges.html) rescinded the encouragement of
nested functions.  Such constructions, while interesting and sometimes
amusing, will have to wait until they are required by a C standard that are
actually implemented in **BOTH** `gcc` **AND** `clang`.

We **DISLIKE** submissions that require the use of `-fnested-functions`.


<div id="about-variadic-functions">
### About variadic functions
</div>

If your submission uses functions that have a variable number of
arguments, **be careful**. Systems implement `va_list` in a wide variety
of ways.  Because of this, a number of operations using `va_list` **are
not portable and _must not_ be used**:

* assigning a non-`va_list` variable to/from a `va_list` variable
* casting a non-`va_list` variable into/from a `va_list` variable
* passing a `va_list` variable to a function expecting a non-`va_list` arg
* passing a non-`va_list` variable to a function expecting a `va_list` arg
* performing arithmetic on `va_list` variables
* using `va_list` as a structure or union

In particular, do not treat `va_list` variables as if they were a `char **`.

We **DISLIKE** the use of `varargs.h`.  Use `stdarg.h` instead.


<div id="about-io">
### About I/O
</div>

We **DISLIKE** the use of `gets(3)`.  Use `fgets(3)` instead.


<div id="about-tarballs">
### About tarballs
</div>

We tend to **DISLIKE** the blatant use of tarballs in an attempt to simply get
around the extra file number limit. We realize there may be cases where a
tarball containing a number of extra files may be needed. Such a need for a
tarball **MUST** be explained in the `remarks.md` file.

<p class="leftbar">
Using a mass of `goto`s to obfuscate your code has become 'old' and is unlikely
to make it through the final rounds, if it even gets that far.
</p>


<div id="about-stdib">
### About stdlib
</div>

The `exit(3)` function returns `void`.  Some broken systems have `exit(3)`
return `int`; your submission should assume that `exit(3)` returns a `void`.


<div id="small">
### What it means to be small
</div>

Small programs are best when they are short, obscure and concise.
While such programs are not as complex as other winners, they do
serve a useful purpose: they are often the only program that people
attempt to completely understand.  For this reason, we look for
programs that are compact, and are instructional.

One line programs should be short one line programs: say around **80** to **132**
bytes long.  Going well beyond **132** bytes is a bit too long to be called
a one-liner in our vague opinion.

We suggest that you avoid trying for the '**smallest self-replicating**'
source.  The smallest, a [zero byte entry](../1994/smr/index.html), won in
[1994](../years.html#1994).

Programs that claim to be the smallest C source that does something, really
better be the smallest such program or they risk being rejected because
they do not work as documented.

We want to get away from source that is simply a compact blob of
bytes.   **REALLY TRY** to be more creative than blob coding. **HINT!**

Unless you are cramped for space, or unless you are entering the
'**Best one liner**' category, we suggest that you format your program
in a more creative way than simply forming excessively long lines.

The `Makefile` should not be used to try and get around the size limit.  It is
one thing to make use of a several `-D`s on the compile line to help out, but it
is quite another to use many bytes of `-D`s in order to try and squeeze the
source under the size limit.

Please do not use things like `gzip(1)` to get around the size limit. This was
done years ago; please try to be much more creative.

Your source code, post-pre-processing, should not exceed the size of
[Microsoft Windows](https://en.wikipedia.org/wiki/Microsoft_Windows). :-)


<div id="about-environment">
### About environment
</div>

We tend to **DISLIKE** programs that:

* are very hardware specific
* are very OS version specific (`index(3)`/`strchr(3)` differences are OK, but
sockets/streams specific code is likely not to be)
* dump core or have compiler warnings (it is OK only if
you warn us in your `remarks.md` file)
* won't compile or run in a [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
(UNIX-like) environment
* depend on a utility or application not normally found
in systems that conform to the [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
* abuse the build file to get around the size limit
* obfuscate by use of ANSI trigraphs
* obfuscate by use of digraphs
* are larger than they need to be
* have more lines than they need to have
* are "blob-ier" (just a pile of unformatted C code) than they need to be
* are rather similar to **[previous winners](../years.html)** :-(
* are **identical** to **[previous losers](https://en.wikipedia.org/wiki/Null_device)** :-)
* that mandate the exclusive use of a specific Integrated Development Environment (IDE)

In order to encourage submission portability, we **DISLIKE** submissions that
fail to build unless one is using an IDE. For example, do not
mandate that one must use Microsoft Visual Studio to compile
your submission.

The program must compile and link cleanly in a [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
(UNIX-like) environment. Therefore do not assume the system has a
[windows.h](https://en.wikipedia.org/wiki/Windows.h) include file:

``` <!---c-->
    #include <windows.h>  /* we DISLIKE this */
```

<p class="leftbar">
You should try to restrict commands used in the build file to commands found in
[Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
(UNIX-like) environments and systems that conform to the [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification).
</p>

You may compile and use your own programs.  If you do, try to build and execute
from the current directory.  This restriction is not a hard and
absolute one.  The intent is to ensure that the building of your
program is reasonably portable.

We prefer programs that are portable across a wide variety of UNIX-like
operating systems (e.g., Linux, GNU Hurd, BSD, UNIX, macOS, etc.).

Try to avoid submissions that play music that some people believe is copyrighted
music.

Did we remember to indicate that programs that blatantly use
some complex state machine to do something simple, are boring?
We think we did.  :-)

Given two versions of the same program, one that is a compact blob
of code, and the other that is formatted more like a typical C
program, we tend to favor the second version.  Of course, a third
version of the same program that is formatted in an interesting
and/or obfuscated way, would definitely win over the first two!
Remember, you can submit more than one submission.  See the
[Rules](rules.html)
for details (in particular,
[Rule 8 - Submitting requirements](rules.html#rule8-submitting-requirements)).

Please note that the C source below, besides lacking in obfuscation,
is **NOT** the smallest C source file that when compiled and run, dumps core:

``` <!---c-->
    main;
```

Unless you specify `-fwritable-strings` (see `COTHER` in the example
Makefile, described in the [Makefile section](#makefile)), do not assume this
sort of code will work:

``` <!---c-->
    char *T = "So many primes, so little time!";
    ...
    T[14] = ';';    /* modifying a string requires: -fwritable-strings */
```

Even so, one should probably not assume that this is universally accepted.

Initialized char arrays are OK to write over.  For instance, this is OK:

``` <!---c-->
    char b[] = "Is this OK";
    b[9] = 'k';     /* modifying an initialized char array is OK */
```

We prefer code that can run on either a 64-bit or 32-bit
processor.  However, it is **UNWISE **to assume it will run on an
some Intel-like x86 architecture**.

While programs that only run in a specific word size are OK, if you have
to pick, choose a 64-bit word size.

If your submission **MUST** run only on a 64-bit or 32-bit architecture,
then you **MUST** specify the `-arch` on your command line
(see `ARCH` in the example
Makefile, described in [Makefile section](#makefile)).  Do not assume a
processor word size without specifying `-arch`.  For example:

``` <!---make-->
    ARCH= -m64
```

Note, however, that some platforms will not necessarily support some
architectures. For instance, more recent versions of `macOS` do **NOT** support
32-bit, and more than zero Judges use it!


<div id="about-x">
### About X
</div>

X client submissions should be as portable as possible.  Submissions that
adapt to a wide collection of environments will be favored.  For
example, don't depend on a particular type or size of display.
Don't assume the use of a particular browser.  Instead assume a
generic browser that forms to a widely used [W3C standard](https://www.w3.org/standards/).
Don't assume a particular sound sub-system or video driver is installed
in the OS. Instead, make use of a well known and widely available open
source program (one that actually works) to display audio/visual data.

X client submissions should avoid using X related libraries and
software that are not in wide spread use.

As of Red Hat RHEL9.0, the X.org server is deprecated. See the
FAQ on "[Xorg deprecation"](../faq.html#Xorg_deprecated)"
for more details. This does not mean that a submission using this will
necessarily be rejected, but it would be better if it can support Wayland in
some way or another.

We **DISLIKE** submissions that use proprietary toolkits such as the `M*tif`,
`Xv*ew`, or `OpenL*ok` toolkits, since not everyone has them.  Use an
open source toolkit that is widely and freely available instead.

X client submissions should try to not to depend on particular items in
`.Xdefaults`.  If you must do so, be sure to note the required lines
in the your `remarks.md` file.  They should also not depend on any
particular window manager.


<div id="about-curses">
### About Curses
</div>

One should restrict libcurses to portable features found on both BSD
and Linux curses.

<p class="leftbar">
If you do `#include <curses.h>` make **CERTAIN** you link in curses (i.e.
`-lcurses`) and not ncurses (i.e. `-lncurses`).
</p>

Jump to: [top](#)


<div id="about_tab">
### About ASCII TAB
</div>

We **DISLIKE** the use of ASCII tab characters in markdown files, such as in the required `remarks.md` file.

We don't mind the use of ASCII tab characters in your C code.  Feel free
to use ASCII tab characters if that suits your obfuscation needs.  If is
perfectly **OK** to use tab characters elsewhere in your submission, just not in
markdown files as this tends annoy us when it comes time to
rendering your markdown content as it complicates the process.

If you do use ASCII tab characters in your non-markdown files, be
aware that some people may use a tab stop that is different than the common 8
character tab stop.

**PLEASE** observe our [Markdown Guidelines](../markdown.html)
when forming your submission's `remarks.md` file.  And if your submission
contains additional markdown files, please follow those same Guidelines for
those files. See also
[Rule 4 - Required files](rules.html#rule4-required-files),
and the
FAQ on "[markdown](../faq.html#markdown)".


Jump to: [top](#)

<div id="remarks">
### About remarks.md
</div>

You are better off explaining what your submission does in your
`remarks.md` file section rather than leaving it obscure for the
[Judges](../judges.html) as we might miss something and/or be too tired to
notice.

We freely admit that interesting, creative or humorous comments in
your `remarks.md` file help your chances of winning.  If you had to
read so many twisted submissions, you too would enjoy a good laugh or two.
We think the readers of the contest winners do as well.  We do read
your `remarks.md` content during the judging process, so it is worth your
while to write a remarkable `remarks.md` file.

It is a very good idea to, in your `remarks.md` file, tell us why you
think your submission is obfuscated.  This is particularly true if
your submission has some very subtle obfuscations that we might
otherwise overlook.  **<<-- Hint!**

Anyone can format their code into a dense blob.  A really clever
author will try format their submission using a "normal" formatting style
such that at first glance (if you squint and don't look at the details)
the code might pass for non-obfuscated C.  Deceptive comments,
and misleading formatting, in some cases, may be a plus.  On the
other hand, a misleading code style requires more source bytes.

If you do elect to use misleading formatting and comments, we
suggest you remark on this point in your `remarks.md` where you talk
about why you think your submission is obfuscated.  On the other hand,
if you are pushing up against the size limits, you may be forced
into creating a dense blob. Such are the trade-offs that obfuscators face!

If there are limitations in your submission, you are highly encouraged
to note such limitations in your `remarks.md` file.  For example if your
submission factors values up to a certain size, you might want to state:

We **LIKE** reading `remarks.md` files, especially if they contain
useful, informative, and even humorous content about your submission.  Yes, this
is a **hint**.  :-)

We **RECOMMEND** you put a reasonable amount effort into the content of the
`remarks.md` file: it is a required file for a reason.  :-)

Try to be even more creative!

Jump to: [top](#)


<div id="miscellaneous">
### Miscellaneous
</div>

While we recognize that UNIX is not a universal operating system, the contest
does have a bias towards such systems.  In an effort to expand the scope of the
contest, we phrase our bias to favor the [Single UNIX
Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)
(UNIX-like).

You are **well advised** to submit code that conforms to the [Single UNIX
Specification Version 4](https://unix.org/version4/overview.html).

To quote the [Judges](../judges.html):

We **LIKE** programs that:

* are as concise and small as they need to be
* do something at least quasi-interesting
* are portable
* are unique or novel in their obfuscation style
* make use of a **NUMBER OF DIFFERENT TYPES OF OBFUSCATIONS!**  **<== HINT!!**
* make us laugh and/or throw up  :-)  (humor really helps!)
* make us want to eat good chocolate

Some types of programs can't excel (anti-tm) in some areas.  Your
program doesn't have to excel in all areas, but doing well in several
areas really does help.

>   This submission factors values up `2305567963945518424753102147331756070`.
Attempting to factor larger values will produce unpredictable results.

The [Judges](../judges.html) might try to factor the value -5, so you want to might state:

>   This submission factors positive values up
`2305567963945518424753102147331756070`. Attempting to factor large values will
produce unpredictable results.

However the [Judges](../judges.html) might try to also factor 0, so you might want to state:

>   This submission factors values between 1 and
`2305567963945518424753102147331756070`.  Attempting to factor values outside
that range will produce unpredictable results.

Moreover they might try to also factor 3.5 or 0x7, or Fred, so you want to might state:

>   This submission factors integers between 1 and
`2305567963945518424753102147331756070`.  Attempting to factor anything else
will produce unpredictable results.

You submission might be better off catching the attempt to factor bogus values
and doing something interesting.  So you might want to code accordingly and state:

>   This submission factors integers between 1 and `2305567963945518424753102147331756070`.
>   Attempting to factor anything else will cause the program to insult your pet fish Eric.

The [Judges](../judges.html) might not have a pet fish named Eric, so you might want to state:

>   This submission factors integers between 1 and
`2305567963945518424753102147331756070`.  Attempting to factor anything else
will cause the program to insult your pet fish Eric, or in the case that you
lack such a pet, will insult the pet that you do not have.

When all other things are equal, a submission with fewer limitations will be judged
better than a submission with lots of limitations.  So you might want to code accordingly
and state:

>   This submission attempts to a factor value of any size provided that the
program is given enough time and memory.  If the value is not a proper integer,
the program might insult a fish named Eric.

Jump to: [top](#)


<div id="mkiocccentry">
<div id="mkiocccentry_toolkit">
## Guidelines for the mkiocccentry toolkit
</div>
</div>

The [IOCCC submit server](https://submit.ioccc.org), and related services
use the **most recent version** of the
[mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry):
submissions that package using older versions of the
[mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry)
are **LIKELY** to be **REJECTED**!

You **REALLY SHOULD** use the latest [mkiocccentry
toolkit](https://github.com/ioccc-src/mkiocccentry) to package your submission
as submissions that use an older version are **LIKELY** to be **REJECTED**!

The `mkiocccentry(1)` tool runs a number of checks by way of these
[mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry) tools:

* iocccsize(1)
* txzchk(1)
* fnamchk(1)
* chksubmit(1)
* chkentry(1)

Do **NOT** use `txzchk(1)` or `fnamchk(1)` command line options that are labeled
"**for TESTING purposes**" in their respective man pages.

Do **NOT** use `fnamchk(1)` command line options that are labeled "**for TESTING purposes**"
in the `fnamchk(1)` man page.

Do **NOT** use `chksubmit(1)` command line options that are labeled "**for the use by the Judges only**"
in the `chksubmit(1)` man page.
Similarly do **NOT** use `chkentry(1)` command line options marked "**for the use
by the Judges only**" in the `chkentry(1)` man page.

To view [mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry) man pages,
while your current directory is the top of the source tree:

``` <!---sh-->
    man soup/man/man1/mkiocccentry.1
    man soup/man/man1/iocccsize.1
    man soup/man/man1/txzchk.1
    man test_ioccc/man/man1/fnamchk.1
    man soup/man/man1/chksubmit.1
    man soup/man/man1/chkentry.1
```

The above `man(1)` commands will show the toolkit man pages without having to install them first.

So that you do not have to repeatedly answer all the `mkiocccentry(1)` questions,
use `mkiocccentry -a answers ...` to create a file containing the answers you first give,
so later enter `mkiocccentry -i answers ...` to reuse those same answers.

The `mkiocccentry -A answers ...` does the same thing except that the **answers file will be overwritten**.

The `mkiocccentry -i answers ...` will still be required to confirm "_Yes/No_" questions.

Use `mkiocccentry -Y -i answers ..` to force a yes answers with **great caution**
because it might force a yes answer to something you do **NOT** want, such as a
change in your code that violates a detected rule.
The `mkiocccentry -i answers ..` will still be required to confirm "_Yes/No_" questions.
While `mkiocccentry -Y -i answers ..` will force yes answers, use with **great caution**,
because it might force a yes answer to something you do **NOT** want.

To help with not having to repeatedly enter a UUID, put your UUID into a file and use
`mkiocccentry -u uuidfile ...`, or use `mkiocccentry -U UUID ...` to give the `UUID`
on the command line.

If you wish to **test** that your submission passes the `mkiocccentry(1)` tests
without having to type in answers each time, you can use the `-d` or `-s seed`
option to `mkiocccentry` for the tool to pseudo-randomly create answers for you.
For example:

``` <!---sh-->
    mkiocccentry -d workdir topdir
```

<p class="leftbar">
Do **NOT** submit a tarball formed by `mkiocccentry -d ...` **OR** by
`mkiocccentry -s seed ...` **OR** by using the `test` UUID!
</p>

<p class="leftbar">
The `mkiocccentry(1)` tool creates an `xz(1)` compressed **v7 format** tarball using a `tar(1)`
command of the form:
</p>

``` <!---sh-->
    cd workdir/UUID-slot_num && tar --format=v7 -cJf submit.UUID-slot_num.timestamp.txz UUID-slot_num
```

In many places the `mkiocccentry(1)` tool will prompt you to verify what you input, allowing you to
correct details as you go along.

<p class="leftbar">
Pressing the "_enter key_" at the `mkiocccentry(1)` tool prompts will allow you
to proceed with a default, however make sure the default is the **CORRECT** answer.
</p>

The `mkiocccentry(1)` tool will use code from `iocccsize(1)` which detects a number of
issues (such as [Rule 2 - Size restrictions](rules.html#rule2-size)) that you may ignore,
however ignoring such issues **comes with a SIGNIFICANT level of risk!**

Once the tarball is packaged it will
run `txzchk(1)`, which will also run `fnamchk(1)`, as part of its algorithm.

<p class="leftbar">
The use of `mkiocccentry -W ...` is **highly discouraged** as this may ignore
warnings about a problem that may cause your submission to be **REJECTED!**"
</p>

<p class="leftbar">
The same can be said of `mkiocccentry -Y ...` , and to a lesser extent `mkiocccentry -y ...`:
the `-y` is mostly for the test script and the `-Y` is like `-y` but even more aggressive.
</p>

If `mkiocccentry` encounters an **error**, the program will exit and the xz
compressed tarball **will NOT be generated**: this is a **feature, not a bug**!

If you encounter a **bug** with the
[mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry)
**PLEASE run the `bug_report.sh` script to help us out here!**

<p class="leftbar">
While you don't have to install the
[mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry),
if you don't, in order to run a tool outside the repo directory
you will have to specify `mkiocccentry(1)` command line options to locate required tools
such as `chkentry(1)` (`mkiocccentry -C chkentry ...`), `txzchk(1)` (`mkiocccentry -T txzchk ...`),
and `fnamchk(1)` (`mkiocccentry -F fnamchk ...`).
</p>

<p class="leftbar">
The `mkiocccentry(1)` tool will ignore any filename or directory that begins with a period (`.`).
</p>

<p class="leftbar">
The `mkiocccentry(1)` tool will ignore all files that begin with `COPYING`, `COPYRIGHT`, and `LICENSE`, regardless
of filename case.
</p>

<p class="leftbar">
The `mkiocccentry(1)` tool will reject any of the following files if they are found directly under
the top level directory (`topdir`):
</p>

<p class="leftbar">
* README.md
* index.html
* prog
* prog.alt
* prog.alt.o
* prog.orig.c
* filenames matching the `[0-9][0-9][0-9][0-9]_*.tar.bz2` file glob
</p>

<p class="leftbar">
The files listed in the above list are allowed to exist in sub-directories: just **NOT** directly under
the top level directory (`topdir`).
</p>

<p class="leftbar">
The `mkiocccentry(1)` tool evaluates all filenames and directory names in a case
independent way: thus `FOO`, `Foo`, and `foo` are considered the **SAME** file
even if your filesystem doesn't do the same.
</p>

<p class="leftbar">
Having two or more filenames that differ only by case **WILL** lead to problems
because of the previous statement.
</p>

<p class="leftbar">
When the `mkiocccentry(1)` tool ignores a file, that file is **NOT** included as
part of your submission.
</p>

<p class="leftbar">
When the `mkiocccentry(1)` tool ignores a directory, that directory,
and everything under that directory is **NOT** included as part of
your submission.
</p>

<p class="leftbar">
The `mkiocccentry(1)` tool will ignore all symlinks.
</p>

<p class="leftbar">
Creating a directory directly under the top level directory (`topdir`)
that is normally considered to be a regular file, such as a directory
named `Makefile`, `prog.alt.c`, `prog.c`, `remarks.md`, `try.alt.sh`,
or `try.sh` is **NOT** a good idea and will likely cause the
`mkiocccentry(1)` tool to abort with a **fatal error**.
</p>

<p class="leftbar">
The required `Makefile` and `remarks.md` files may **NOT** be empty. This
does not mean just 0 bytes but also that it **MUST** have **content**, and
content that is relevant (e.g. a Makefile with just comments is **NOT**
allowed). However, with the exception of the `Makefile`, the `mkiocccentry(1)`
tool will **ONLY** check file size.
</p>

<p class="leftbar">
If the optional file `try.alt.sh`, or `try.sh` exists and is an empty file,
the `mkiocccentry(1)` tool will abort with a **fatal error**.
</p>

<p class="leftbar">
If the `mkiocccentry(1)` tool encounters anything that isn't a file, isn't a
directory, and isn't a symlink (which the tool ignores), the `mkiocccentry(1)`
tool to abort with a **fatal error**.
</p>

See
FAQ on "[How do I report bugs in an `mkiocccentry` tool?](../faq.html#mkiocccentry_bugs)".

See [Rule 11 - Legal rule abuse](rules.html#rule11-legal-rule-abuse) for warnings about ignoring `mkiocccentry(1)` tool warnings.

See
FAQ on "[What is the `fnamchk` tool?](../faq.html#fnamchk)".

See
FAQ on "[What is mkiocccentry in simple terms?](../faq.html#about_mkiocccentry)".

See
FAQ on "[What is the mkiocccentry tool, how do I obtain it and how do I use it](../faq.html#mkiocccentry)".


Jump to: [top](#)


<div id="fun">
## Fun😄damental Guidelines
</div>

The reason for the times of day are so that key IOCCC events are **calculated**
to be a **fun**ctional UTC time.  :-)

At least 2 of several reasons for selecting the prime, 2503, for
[Rule 2b - Net Size](rules.html#rule2b-net-size)
may be found on the ["Curios!" about 2503](https://t5k.org/curios/page.php/2503.html).

The 2503 value for [Rule 2b - Net Size](rules.html#rule2b-net-size) is a decimal anagram
of the number of the kernel disk pack of one of the judge's [BESM-6](https://en.wikipedia.org/wiki/BESM-6).

<p class="leftbar">
There may or may not be fewer than 2^7+1 reasons why these
[Guidelines](guidelines.html) seem obfuscated.
</p>

<p class="leftbar">
Excessively "_dotty"_ use of the `chksubmit(1)` or `chkentry(1)` commands suggests that
either you like silly things, or that you [RTFS](https://en.wikipedia.org/wiki/RTFM)
with some level of care.
</p>

Some people might question what actually constitutes a valid JSON file, given
the state of the "_so-called_" JSON spec. :-)

We prefer programs that do not require a fish license: crayons and
cat detector vans not withstanding.

<p class="leftbar">
This _guideline_ has a change mark at the very start of this line.
</p>

While those who are used to temperatures found on [dwarf
planets](https://science.nasa.gov/dwarf-planets/)
(**yes Virginia, dwarf planets _ARE_ planets!**), such as
[Pluto](https://science.nasa.gov/dwarf-planets/pluto/), might be able to
explain to the Walrus why our seas are boiling hot, the question of
whether pigs have wings is likely to remain a debatable point to most.

At least one judge prefers to maintain the use of the
[leap-second](https://en.wikipedia.org/wiki/Leap_second)
as part of the world's time standard.  If your code prints time
with seconds, we prefer that your code be capable of printing the
time of day during a leap-second where the value in seconds
after the minute mark is **60**.

Other windows, on the other hand, might be OK: especially where "**X
marks the spot**".  Yet on the third hand, windows are best when they are
"unseen" (i.e., not dirty).  :-)

The [Judges](../judges.html), as a group, have a history giving wide degree of latitude
to reasonable submissions.  And recently they have had as much longitudinal
variation as it is possible to have on [Earth](https://science.nasa.gov/earth/).  :-)
Other windows, on the other hand, might be OK: especially where "**X
marks the spot**".  Yet on the third hand, windows are best when they are
"unseen" (i.e., not dirty).  :-)

The [Judges](../judges.html), as a group, have a history giving wide degree of latitude
to reasonable submissions.  And recently they have had as much longitudinal
variation as it is possible to have on [Earth](https://science.nasa.gov/earth/).  :-)

> You are in a maze of twisty _guidelines_, all different.

There are at least zero [Judges](../judges.html) who think that
[Fideism](https://en.wikipedia.org/wiki/Fideism) has little
or nothing to do with the Judging process.

> All generalizations are false, including this one. -- **Mark Twain**

<p class="leftbar">
There are more than about 1 typos in this very sentence.
</p>

This could be the only _guideline_ that contains the word
[fizzbin](https://en.wikipedia.org/wiki/List_of_games_in_Star_Trek#Fizzbin).

However, do you know how to play [fizzbin](https://en.wikipedia.org/wiki/List_of_games_in_Star_Trek#Fizzbin)?
You do?!?  (Except on Tuesday?)

OK, there are actually 2 _guidelines_ that contain the word
[fizzbin](https://en.wikipedia.org/wiki/List_of_games_in_Star_Trek#Fizzbin),
unless you count this one, in which case there are 3. :-)

**NOTE**: The previous _guideline_ in this spot has been replaced by this _guideline_:

<p class="leftbar">
You very well might not be completely prohibited from failing to not partly
misunderstand this particular _guideline_, but of course, we could not possibly
comment!  Nevertheless, you are neither prohibited, nor are you fully or partly
required to determine that this or the previous sentence is either false and/or
perhaps misleading.  Therefore, it might be wise for you to not fail to consider
to not do so, accordingly.  Thank you very much (allegedly).
</p>

Any complaints about the above _guideline_ could be addressed to the
Speaker of the House of Commons, or to the speaker of your national
parliament should you have one.

<p class="leftbar">
Please try to avoid this specific individual _guideline_, if it is at all possible.
</p>

We believe that Mark Twain's quote:

> Get your facts first, then you can distort them as you please.

... is a good motto for those writing code for the IOCCC.

<p class="leftbar">
We do not recommend submitting [systemd](https://systemd.io) source code to the IOCCC,
if nothing else because that code is likely to exceed
[Rule 2 - Size restrictions](rules.html#rule2-size).
This isn't to say that another highly compact and obfuscated
replacement of `init(8)` would not be an interesting submission.
</p>

<p class="leftbar">
The
[mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry)
is not an original work, unless you one of the
[several mkiocccentry toolkit contributors](https://github.com/ioccc-src/mkiocccentry/graphs/contributors).
in which case it is original!  :-)
Even so, most of the programs in the toolkit exceed the
[Rule 2 - Size restrictions](rules.html#rule2-size)
so they wouldn't qualify for the contest anyway.
</p>

<p class="leftbar">
If the [IOCCC judges](../judges.html) are feeling like it, they
might choose to compile your program for running on an Arduino or
a PDP-11.  Heck, should we ever find an emulator of 60-bit CDC Cyber
CPU, we might just try your submission on that emulator as well :-)
</p>

Do not fear if you're not 100% sure of the significance of
`2305567963945518424753102147331756070` as it is not of prime importance: or is
it?  :-)

<p class="leftbar">
With respect to [nested functions](#nested-functions), try `chkentry -b`.
</p>


Jump to: [top](#)


<div id="more-information">
<div id="information">
# Further Reading
</div>
</div>

See the [Official IOCCC website news](../news.html) for additional information.

For questions or comments about the contest, see [Contacting the IOCCC](../contact.html).

**Be SURE** to review the current [IOCCC Rules and Guidelines](index.html) as they
often change year to year.  Especially prior to submitting to the contest.

For the latest IOCCC news, follow the [IOCCC on Mastodon](https://fosstodon.org/@ioccc).  See our
FAQ on "[Mastodon](../faq.html#try_mastodon)"
for more information.

Also consider joining the [IOCCC Discord Server](https://discord.com/invite/Wa42Qujwnw)
for the latest news, discussions about The Rules, questions for the Judges, and `C` in general.

<hr style="width:10%;text-align:left;margin-left:0">
Jump to: [top](#)
