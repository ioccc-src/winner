# IOCCC FAQ Table of Contents

This is FAQ version **28.1 2024-10-20**.

<!--
    NOTE: when updating the table of contents, make sure to use unordered
    NOTE: lists to make it easier to add entries in the middle of a section,
    NOTE: without having to update all the entries after that entry.
-->


## 0. [Entering the IOCCC: the bare minimum you need to know](#enter_questions)
- <a class="normal" href="#submit">How can I enter the IOCCC?</a>
- <a class="normal" href="#mkiocccentry">What is the `mkiocccentry` tool and how do I use it?</a>
- <a class="normal" href="#compile_mkiocccentry">How do I compile `mkiocccentry` and its related tools?</a>
- <a class="normal" href="#platform">What platform should I assume for my submission?</a>
- <a class="normal" href="#makefile">What should I put in my submission Makefile?</a>
- <a class="normal" href="#remarks">What should I put in the remarks.md file of my submission?</a>


## 1. [Entering the IOCCC: more help and details](#submitting_help)
- <a class="normal" href="#answers_file">Is there a way to not have to re-enter the same information, when making a change to my submission?</a>
- <a class="normal" href="#prog_c">May I use a different source or compiled filename than prog.c or prog?</a>
- <a class="normal" href="#markdown">What are the IOCCC best practices for using markdown?</a>
- <a class="normal" href="#mkiocccentry_bugs">How do I report bugs in an `mkiocccentry` tool?</a>


## 2. [IOCCC Judging process](#judging)
- <a class="normal" href="#questions">What is the best way to ask a question about the IOCCC rules, guideline and tools?</a>
- <a class="normal" href="#feedback">How can I comment or make a suggestion on IOCCC rules, guidelines and tools?</a>
- <a class="normal" href="#warnings">Are there any compiler warnings that I should not worry about?</a>
- <a class="normal" href="#frequent-themes">What types of entries have been frequently submitted to the IOCCC?</a>
- <a class="normal" href="#rule_2_broken">How did an entry that breaks the size rule 2 win the IOCCC?</a>
- <a class="normal" href="#submissions">How many submissions do the judges receive for a given IOCCC?</a>
- <a class="normal" href="#judging_time">How much time does it take to judge the contest?</a>
- <a class="normal" href="#judging_rounds">How many judging rounds do you have?</a>
- <a class="normal" href="#grand_prize">Why do some IOCCC entries receive the Grand Prize or Best of Show award?</a>
- <a class="normal" href="#winners">How are winning IOCCC entries announced?</a>
- <a class="normal" href="#lost">Why don't you publish submissions that do not win?</a>


## 3. [The mkiocccentry toolkit: finer details](#mkiocccentry_details)
- <a class="normal" href="#mkiocccentry_checks">What sort of checks does the mkiocccentry tool perform?</a>
- <a class="normal" href="#txzchk">How can I validate my submission tarball?</a>
- <a class="normal" href="#fnamchk">What is the `fnamchk` tool?</a>
- <a class="normal" href="#chkentry">How can I validate my `.auth.json` and/or `.info.json` files?</a>
- <a class="normal" href="#auth_json">What is a `.auth.json` file?</a>
- <a class="normal" href="#info_json">What is a `.info.json` file?</a>
- <a class="normal" href="#author_handle_faq">What is an `author handle`?</a>
- <a class="normal" href="#author_handle_json">What is an `author_handle.json` file and how are they used?</a>
- <a class="normal" href="#find_author_handle">How can I find my author handle?</a>
- <a class="normal" href="#entry_id_faq">What is an `entry_id`?</a>
- <a class="normal" href="#entry_json">What is a `.entry.json` file and how is it used?</a>
- <a class="normal" href="#jparse">How can I validate any JSON document?</a>


## 4. [Compiling IOCCC entries](#compiling)
- <a class="normal" href="#makefile_rules">What Makefile rules are available to build or clean up IOCCC entries?</a>
- <a class="normal" href="#gmake">What kind of make&lpar;1&rpar; compatibility does the IOCCC support and will it support other kinds?</a>


## 5. [Dependencies for some IOCCC entries](#dependencies)
- <a class="normal" href="#X11">How do I compile and run an IOCCC entry that requires X11?</a>
- <a class="normal" href="#SDL">How do I compile and install SDL1 or SDL2 for entries that require it?</a>
- <a class="normal" href="#curses">How do I compile and install &lpar;n&rpar;curses for entries that require it?</a>
- <a class="normal" href="#sound">How do I compile and run an IOCCC entry that requires sound?</a>
- <a class="normal" href="#tcpserver">How do I compile and install tcpserver for entries that require it?</a>
- <a class="normal" href="#netpbm">How do I compile and install netpbm for entries that require it?</a>
- <a class="normal" href="#libjpeg">How do I compile and install libjpeg-turbo for entries that require it?</a>
- <a class="normal" href="#imagemagick">How do I compile and install ImageMagick for entries that require it?</a>
- <a class="normal" href="#OpenGL">How do I compile and install OpenGL for entries that require it?</a>
- <a class="normal" href="#download">How do I download individual winning entries or all winning entries of a given year?</a>
- <a class="normal" href="#zlib">How do I compile and install zlib for IOCCC entries that require it?</a>
- <a class="normal" href="#ruby">How do I install Ruby for entries that require it?</a>
- <a class="normal" href="#rake">How do I install rake for entries that require it?</a>


## 6. [Problems compiling IOCCC entries](#compile_problems)
- <a class="normal" href="#compile_errors">Why don't certain IOCCC entries compile?</a>
- <a class="normal" href="#clang">Why does clang or gcc fail to compile some IOCCC entries?</a>
- <a class="normal" href="#macos_compile">Why do some IOCCC entries fail to compile under macOS?</a>
- <a class="normal" href="#weverything">Why do Makefiles use -Weverything with clang?</a>


## 7. [Running IOCCC entries](#running_entries)
- <a class="normal" href="#try">What are `try.sh` and `try.alt.sh` scripts and why should I use them?</a>
- <a class="normal" href="#sanity">An IOCCC entry messed up my terminal application, how do I fix this?</a>
- <a class="normal" href="#64bit">Why does an IOCCC entry fail to run on my 64-bit system?</a>
- <a class="normal" href="#eof">How do I find out how to send interrupt/EOF etc. for entries that require it?</a>
- <a class="normal" href="#unsupported">Why does an IOCCC entry fail to compile and/or fail to run?</a>


## 8. [Changes made to IOCCC entries](#changes)
- <a class="normal" href="#diff">How can I find out what was changed in an IOCCC entry source code?</a>
- <a class="normal" href="#fgets">Why were some calls to the libc function gets&lpar;3&rpar; changed to use fgets&lpar;3&rpar;?</a>
- <a class="normal" href="#consistency">Why do author remarks sometimes not match the source and/or inconsistent with the entry?</a>
- <a class="normal" href="#orig_c">What is the meaning of the file ending in .orig.c in IOCCC entries?</a>
- <a class="normal" href="#alt_code">What are alternate versions and why were they added to some entries?</a>
- <a class="normal" href="#main_args">Why was arg count and/or type changed in main&lpar;&rpar; in some older entries?</a>
- <a class="normal" href="#files">Why were files added to, removed from or changed in some entries?</a>
- <a class="normal" href="#prog_orig_c">What is the original source file?</a>
- <a class="normal" href="#renaming_files">Why were some filenames changed?</a>


## 9. [Helping the IOCCC](#help)
- <a class="normal" href="#how_to_help">How can I help the IOCCC?</a>
- <a class="normal" href="#bugs">Is there a list of known bugs and &lpar;mis&rpar;features of IOCCC entries?</a>
- <a class="normal" href="#fix_an_entry">How can I submit a fix to an IOCCC entry?</a>
- <a class="normal" href="#pull_request">How do I make a pull request to the GitHub repo?</a>
- <a class="normal" href="#report_website_problem">How can I report an IOCCC website problem?</a>
- <a class="normal" href="#fix_website">How can I submit a fix to the IOCCC website?</a>
- <a class="normal" href="#fix_author">How can I correct or update an IOCCC author's information?</a>
- <a class="normal" href="#fix_link">What should I do if I find a broken or wrong web link?</a>
- <a class="normal" href="#supporting_ioccc">How can I support the IOCCC?</a>
- <a class="normal" href="#deobfuscated">I deobfuscated some entry code, may I contribute the source?</a>
- <a class="normal" href="#reporting_bugs">How do I report a bug in an IOCCC entry?</a>


## 10. [Miscellaneous IOCCC](#misc)
- <a class="normal" href="#mirrors">May I mirror the IOCCC website?</a>
- <a class="normal" href="#ioccc_copyright">May I use parts of the IOCCC in an article, book, newsletter, or instructional material?</a>
- <a class="normal" href="#first_person">Why do you sometimes use the first person plural?</a>
- <a class="normal" href="#dot_files"> What is the purpose of the `.top`, `.allyear`, `.year` and `.path` files?</a>
- <a class="normal" href="#terms"> What is the current meaning of the IOCCC terms Author, Entry, and Submission?</a>
- <a class="normal" href="#licence">Am I allowed to use IOCCC content?</a>
- <a class="normal" href="#try_mastodon">What is Mastodon and why does IOCCC use it?</a>
- <a class="normal" href="#tabstops">How do I set certain tabstops for viewing source code in vi&lpar;m&rpar;?</a>
- <a class="normal" href="#menus">How do the menus on the website work and what can I do if they don't work?</a>
- <a class="normal" href="#author-information">How do I find more information about a winning author of an entry?</a>
- <a class="normal" href="#cb">What is this cb tool that is mentioned in the IOCCC?</a>


## 11. [History of the IOCCC](#ioccc_history)
- <a class="normal" href="#ioccc_start">How did the IOCCC get started?</a>
- <a class="normal" href="#missing_years">Why are some years missing IOCCC entries?</a>
- <a class="normal" href="#website_history">What is the history of the IOCCC website?</a>
- <a class="normal" href="#size_rule_history">How has the IOCCC size limit rule changed over the years?</a>
- <a class="normal" href="#great_fork_merge">What is the **Great Fork Merge**?</a>
- <a class="normal" href="#bof">What is an IOCCC BOF?</a>
- <a class="normal" href="#explain_IOCCC">I do not understand the IOCCC, can you explain it to me?</a>


Jump to: [top](#)


# The IOCCC FAQ

<hr style="width:50%;text-align:left;margin-left:0">
<hr style="width:50%;text-align:left;margin-left:0">


<div id="enter_questions">
## Section 0: Entering the IOCCC: the bare minimum you need to know
</div>

Jump to: [top](#)


<div id="submit">
<div id="register">
### Q: How can I enter the IOCCC?
</div>
</div>

To submit your code to the IOCCC, you **MUST** follow these steps:


#### 0. Verify that the IOCCC is open for submissions

Check the [current status of the IOCCC](status.html) see of the IOCCC is open.

You may **only register for the IOCCC when the IOCCC is OPEN**.

You may **only submit your entries to the IOCCC when the IOCCC is OPEN**.

See also the [IOCCC news](news.html#news) for more information.


#### 1. Read the latest IOCCC rules and review the IOCCC guidelines

Please pay close attention to the [official IOCCC rules](next/rules.html).

You are also **highly encouraged** to review the
[official IOCCC guidelines](next/guidelines.html) as they contain important
suggestions, useful hints, and IOCCC humor.  :-)


#### 2. Register for the IOCCC

The **IOCCC registration procedure** is still being designed.
<!--XXX--> As such, we do not yet have instructions on how to
use the **IOCCC registration procedure**.  Once **IOCCC
registration procedure** is ready, we will update this section
with the proper instructions.  Watch the [IOCCC news](news.html)
for an announcement about the **IOCCC registration procedure**.

Once you have been registered, you will receive an email message for how to
prepare your entries for submission, and how to upload the compressed tarballs
to our submission portal.


#### 3. Obtain the latest mkiocccentry toolkit

If you do not have an mkiocccentry tool directory:

```sh
    cd some_directory
    git clone git@github.com:ioccc-src/mkiocccentry.git
    cd mkiocccentry
```

If you already have an mkiocccentry tool directory:

```sh
    cd mkiocccentry
    git fetch
    git rebase
```

#### 4. Make the mkiocccentry toolkit

```sh
    make clobber all
```

#### 5. Run the mkiocccentry tool to form your submission tarball

```sh
    mkiocccentry work_dir prog.c Makefile remarks.md [file ...]
```

where:

* `work_dir`

    directory where the entry directory and tarball are formed

* `prog.c`

    path to the C source for your entry

* `Makefile`

    Makefile to build (make all) and cleanup (make clean & make clobber)

* `remarks.md`

    Remarks about your entry in markdown format: see the
    FAQ on "[remarks.md](#remarks_md)"
    for more info.

* [file ...]

    Optional extra data files to include with your entry

**NOTE**: Please see our [IOCCC markdown guide](markdown.html) for **important information** on using markdown in the IOCCC.

**NOTE**: It is *NOT* necessary to install the tools to use them as you can run
the tools from the top of the `mkiocccentry` repo directory just fine. However,
installing it will make it easier for you as you can run it from your
submission's directory.

If the `mkiocccentry` tool indicates that there is a problem with your entry,
especially if it identifies a [Rule 2](next/rules.html#rule2) related problem,
you are **strongly** encouraged to revise and correct your entry and
then re-run the `mkiocccentry` tool.

If you choose to risk violating rules, be sure and explain your reason
for doing so in your `remarks.md` file.

See also [Rule 17](next/rules.html#rule17)!


#### 6. Upload your entry to the IOCCC submit server

The **IOCCC submit server** is still being written.
<!--XXX--> As such, we do not yet have instructions
on how upload your entry to the **IOCCC submit server**.  Once
**IOCCC submit server** is ready, we will update this section
with the proper instructions.  Watch the [IOCCC news](news.html)
for an announcement of the availability of the **IOCCC submit server**.

Jump to: [top](#)


<div id="mkiocccentry">
### Q: What is the `mkiocccentry` tool and how do I use it?
</div>

This tool comes from the [mkiocccentry
repo](https://github.com/ioccc-src/mkiocccentry) and it is **required** that you
use it to package your submission. Not doing so puts you at a great risk of
violating the [Rules](next/rules.html) and in particular [Rule
17](next/rules.html#rule17). The `mkiocccentry` tool first gathers your source
code, your Makefile, your remarks, other information about your submission,
information about the author (or authors) and then runs a lot of tests before (if
all is OK) forming your tarball. After this is done it will additionally run the
`txzchk(1)` tool (which runs the `fnamchk(1)` tool) on the submission tarball.

See the
FAQ on "[submitting to the IOCCC](#submit)"
for details on how to register for the IOCCC.

Once you have registered, you will need to package your entry with the
`mkiocccentry` tool. The below details discuss this very important tool. As it
is complicated we will explain how to use this tool.

As the [Guidelines](next/guidelines.html) state, the synopsis is:

``` <!---sh-->
    mkiocccentry [options] work_dir prog.c \
         Makefile remarks.md [file ...]
```

... where `work_dir` is a directory that will be used to build the submission
tarball, `prog.c` is your submission source code, `Makefile` is your submission's
`Makefile`, `remarks.md` are your remarks (that will be the basis of the
`README.md` file which will be used to form the `index.html` file, if your
submission wins) and the remaining args are the paths to any other files you
wish to submit.

The `work_dir` **MUST** already exist, as a directory, and it is an error if it
is not a directory that can be written to. In **this** directory your **submission
directory** will be created, with the name based on your IOCCC registration
username, which is **in the form of a UUID** and submission number; see the
[rules](next/rules.html) for more details on this, and in particular [Rule
17](next/rules.html#rule17).

If the **_subdirectory_ in the _work directory_** already exists, you will have to
move it, remove it or otherwise specify a different work directory (**NOT** the
subdirectory), as it needs to be empty and the `mkiocccentry(1)` tool does not
check this for you as it could not do anything about anyway.

This _subdirectory is where your files will be **copied** to_. Your _submission
tarball_ (which you will upload to the submit server) that `txzchk(1)` will
validate _will be placed in the **work directory**_, and **its _contents_ will
be the _subdirectory_ with your submission's files**.

The `mkiocccentry(1)` tool will ask you for information about your
submission _as well as author details_ (that will only be looked at if the
submission wins), run some tests and run a number of other tools, as already
mentioned and as described below.

Jump to: [top](#)


<div id="mkiocccentry_compile">
<div id="compile_mkiocccentry">
### Q: How do I compile `mkiocccentry` and its related tools?
</div>
</div>

After you
[download the mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/blob/master/FAQ.md#download)
by running:

``` <!---sh-->
git clone https://github.com/ioccc-src/mkiocccentry.git
```

or downloading the zip file, you should change to the `mkiocccentry` directory so you can compile the tools. See the
FAQ on "[compiling mkiocccentry](https://github.com/ioccc-src/mkiocccentry/blob/master/FAQ.md#compiling)"
at the `mkiocccentry` repo.

See also the
[mkiocccentry repo FAQ](https://github.com/ioccc-src/mkiocccentry/blob/master/FAQ.md)
for more up to date information on downloading, compiling, and related FAQ information.

Jump to: [top](#)


<div id="SUS">
<div id="platform">
<div id="portability">
### Q: What platform should I assume for my submission?
</div>
</div>
</div>

Your entry must compile with **clang** or **gcc** and run under at least one flavor of a UNIX
system that conforms to the [SUS](https://en.wikipedia.org/wiki/Single_UNIX_Specification),
otherwise known as the [The Single UNIX Specification Version 4](https://unix.org/version4/)
or [later SUS](https://unix.org/online.html).

Jump to: [top](#)


<div id="makefile">
<div id="submission_makefile">
### Q: What should I put in my submission Makefile?
</div>
</div>

We recommend starting with the [sample
Makefile](https://github.com/ioccc-src/mkiocccentry/blob/master/Makefile.example)
as found in the [mkiocccentry GitHub repo](https://github.com/ioccc-src/mkiocccentry),
(renamed as `Makefile` of course) as a starting point for your
entry's `Makefile`.

The `Makefile` is a file used by the `make(1)` command that contains
rules and UNIX shell-style commands.

The first and default rule should be the `all` rule and should build your entry's executable file.

If your entry depends on a particular source file name during compilation or execution,
your `Makefile` should copy `prog.c` into the desired filename.  For example:

If you are not familiar `Makefile`s, you might consider the following tutorials:

- [GNU make](https://www.gnu.org/software/make/manual/make.html#Introduction)
- [What is a Makefile and how does it work?](https://opensource.com/article/18/8/what-how-makefile)
- [Learn Makefiles](https://makefiletutorial.com)

For the `make(1)` _connoisseur_: As of 2023, IOCCC judges use [GNU
make compatible](https://www.gnu.org/software/make/) `make(1)`
command that is compatible with GNU Make version 3.81.

Jump to: [top](#)


<div id="remarks_md">
<div id="remarks">
<div id="readme">
### Q: What should I put in the remarks.md file of my submission?
</div>
</div>
</div>

First, **PLEASE** read the [IOCCC markdown guidelines](markdown.html).

Next, while you may put in as much or as little as you wish into your entry's
`remarks.md` file, we do have few important suggestions:

We recommend that you explain how to use your entry.  Explain the
command line (if any command line options and arguments are used)
and any input or actions if applicable.

We highly recommend that you explain why you think your entry is
well obfuscated.

For those entries that win the IOCCC, we often use much of text from the
`remarks.md` file in the _Author's remarks_ section of the `index.html` file.
For this reason, a well written `remarks.md` file is considered a plus.

While not required, consider adding bit of humor to your `remarks.md`
as most people who are not humor impaired, as well as the IOCCC judges
appreciate the opportunity for a fun read as well as a chuckle or two.


#### What helps:

- explaining what your entry does
- how to entice it to do what it is supposed to do
- what obfuscations are used
- what are the limitations of your entry in respect of portability and/or input data
- how it works (if you are really condescending)


#### What does not help:

- admitting that your entry is not very obfuscated (you see, the contest is
called the **IOCCC**, not the **INVOCCC** :-) ); but even if you do not admit
it, not very obfuscated entries have a minuscule chance to win (although
[2000/tomx](2000/tomx/index.html) is a notable counterexample).
- mentioning your name or any identifying information in the remark section (or
in the C code for that matter) - we like to be unbiased during the judging
rounds; we look at the author name only if an entry wins. See the guidelines if
this is not clear!
- leaving the remark section empty.

Jump to: [top](#)

<hr style="width:50%;text-align:left;margin-left:0">
<hr style="width:50%;text-align:left;margin-left:0">


<div id="submitting_help">
## Section 1: Entering the IOCCC: more help and details
</div>

Jump to: [top](#)


<div id="answers_file">
### Q: Is there a way to not have to re-enter the same information, when making a change to my submission?
</div>

Yes! The `mkiocccentry(1)` tool has some options to help write _OR_ read from an
answers file so you do not have to input the author(s) or the submission
details (like the abstract, summary etc.), just to change a file.

To write to `answers.txt` try:

``` <!---sh-->
    mkiocccentry -a answers.txt ...
```

Alternatively, if you wish to overwrite a file, you can use the `-A`
flag with the same option argument. Be **very careful** that you do not accidentally
overwrite your `prog.c` or some other important file!

To make use of the answers file, use the `-i answers` option like:

``` <!---sh-->
    mkiocccentry -i answers.txt ...
```

Jump to: [top](#)


<div id="prog_c">
### Q: May I use a different source or compiled filename than prog.c or prog?
</div>

While your entry's source filename, as submitted, must be `prog.c`, your entry's `Makefile`
may copy `prog.c` to a different filename as part of the compiling/building process.  For example:

``` <!---make-->
    # Makefile continues above ...

    all: desired_name

    desired_name: desired_name.c
            rm -f $@
            cc desired_name.c -o $@

    desired_name.c: prog.c
            rm -f $@
            cp -f prog.c $@

    clean:
            rm -f desired_name.o

    clobber: clean
            rm -f desired_name.c desired_name

    # Makefile continues below ...
```

We recommend that the `make clobber` rule remove files that your entry
creates as part of the compiling/building process.

You may also copy the compiled `prog` into a different file as part of compiling process.
For example:

``` <!---make-->
    # Makefile continues above ...

    all: desired_name

    different_name: prog
            rm -f $@
            cp -f prog $@

    clean:
            rm -f prog.o

    clobber: clean
            rm -f desired_name

    # Makefile continues below ...
```

Jump to: [top](#)


<div id="markdown">
<div id="md">
### Q: What are the IOCCC best practices for using markdown?
</div>
</div>

The IOCCC makes extensive use of [markdown](https://daringfireball.net/projects/markdown/).
For example, we [submitting to the IOCCC](#submit), we have people
to submit remarks about entry in markdown format.  Every
[winning IOCCC entry](years.html) uses a `README.md` markdown file
as the basis for forming the `index.html` web page for that entry.
All generated HTML pages on the [Official IOCCC website](https://www.ioccc.org/index.html)
start with some markdown content.

**IMPORTANT**: Please read the [IOCCC markdown best practices](markdown.html) guide
as it lists things you **should not use** in markdown files.

See the [markdown syntax](https://www.markdownguide.org/basic-syntax) guide.
See also [CommonMark Spec](https://spec.commonmark.org/current/).

Jump to: [top](#)


<div id="mkiocccentry_bugs">
### Q: How do I report bugs in an `mkiocccentry` tool?
</div>

As the [mkiocccentry toolkit](https://github.com/ioccc-src/mkiocccentry) is
crucial in the contest, both for submitters and the judges, if you find a bug
(or you think you find a bug) we would be grateful if you were to report it at
the [mkiocccentry issues
page](https://github.com/ioccc-src/mkiocccentry/issues).

Please see the
FAQ on "[reporting bugs and other issues in the mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/blob/master/FAQ.md#bugs)"
in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry).

Jump to: [top](#)

<hr style="width:50%;text-align:left;margin-left:0">
<hr style="width:50%;text-align:left;margin-left:0">


<div id="judging">
## Section 2: IOCCC Judging process
</div>

Jump to: [top](#)


<div id="question">
<div id="questions">
### Q: What is the best way to ask a question about the IOCCC rules, guideline and tools?
</div>
</div>

We realise that the [IOCCC rules](next/rules.html), [IOCCC guidelines](next/guidelines.html)
and the [IOCCC mkiocccentry tools](https://github.com/ioccc-src/mkiocccentry)
can be confusing or even seem overwhelming to some people.

The [IOCCC judges](judges.html) do welcome questions about the IOCCC
and will be **happy to help**.

Chances are, if you have a question, there are a number of other people who
have similar questions.  So we recommend first view the
[GitHub discussions for this repo](https://github.com/ioccc-src/winner/discussions)
so see if someone else asked already.  Feel free to join in on such a discussion,
even if to just say:

> I have this question too.

Feel free to provide additional feedback in the existing discussion as needed.

**BTW**: If your question is just about the
[IOCCC mkiocccentry tools](https://github.com/ioccc-src/mkiocccentry), please
view the [mkiocccentry repo discussions](https://github.com/ioccc-src/mkiocccentry/discussions)
instead.

If you do not find a suitable open discussion, please consider opening a
[new IOCCC repo discussion](https://github.com/ioccc-src/winner/discussions/new/choose) with
your question.  Doing this may be of help to others with a question similar to yours.

**BTW**: If your question is just about the
[IOCCC mkiocccentry
tools](https://github.com/ioccc-src/mkiocccentry/discussions), and you do not
see a suitable open discussion over there, then please consider opening a
[new mkiocccentry discussion](https://github.com/ioccc-src/mkiocccentry/discussions/new/choose)
over there.

If you do not feel, for some reason, comfortable asking your question in public
(although we hope you consider asking it in public for the benefit of others),
then use the [How to contact the IOCCC](contact.html) information to ask
a private question.

**IMPORTANT**: When you ask your question (in public or as a private question)
**PLEASE** try to **NOT** discuss detailed information about any pending submission.
Try to ask for question in a more generic way as this will help others
with a similar question and this will not **give away** what you might be doing
with your submission.  If the [IOCCC judges](judges.html) truly need more
information, they will ask (either in public or suggest a private conversation).

Again, **please** don't hesitate to ask: Your question may be something that
others are wondering about as well!

See also the
FAQ on "[rules, guidelines, tools feedback](#feedback)".

Jump to: [top](#)


<div id="feedback">
<div id="comments">
### Q: How can I comment or make a suggestion on IOCCC rules, guidelines and tools?
</div>
</div>

The [IOCCC judges](judges.html) to welcome feedback on the [IOCCC
rules](next/rules.html), [IOCCC guidelines](next/guidelines.html)
and on the [IOCCC mkiocccentry tools](https://github.com/ioccc-src/mkiocccentry).

To comment on the [IOCCC rules](next/rules.html) or the
[IOCCC guidelines](next/guidelines.html) please view the
[GitHub discussions for this repo](https://github.com/ioccc-src/winner/discussions).
If there is an on-going discussion that seems relevant to what you
have to say, consider adding comments to that particular discussion.
Otherwise consider opening a [new IOCCC repo
discussion](https://github.com/ioccc-src/winner/discussions/new/choose).

To comment on [IOCCC mkiocccentry tools](https://github.com/ioccc-src/mkiocccentry),
please view the [mkiocccentry repo discussions](https://github.com/ioccc-src/mkiocccentry/discussions).
If there is an on-going discussion that seems relevant to what you
have to say, consider adding comments to that particular discussion.
Otherwise consider opening a [new mkiocccentry
discussion](https://github.com/ioccc-src/mkiocccentry/discussions/new/choose).

Jump to: [top](#)


<div id="forced_warnings">
<div id="warnings">
### Q: Are there any compiler warnings that I should not worry about?
</div>
</div>

There are unfortunately some warnings that cannot be disabled; they are always
enabled whatever warning options you have enabled. Also, there is a warning that
is enabled whenever you act on `char *`s, saying it is unsafe buffer usage, even
when it's not (this might be enabled by `-Weverything` but it might not be; for
more details on why we use `-Weverything` in Clang see the FAQ on
"[`-Weverything`](#weverything)"), and it is not detrimental to your submission
if you disable this. This warning happens to be `-Wno-unsafe-buffer-usage`.

So in short, no you should not worry about these as they are sometimes
inevitable in obfuscated code and even non-obfuscated code.

If you *can* work past this it might be good but this is not something that
should be worried about too much as this is on the compiler developers, not you.

Jump to: [top](#)


<div id="frequent-themes">
### Q: What types of entries have been frequently submitted to the IOCCC?
</div>

There are types of entries that are frequently submitted to the IOCCC.
While we **do not wish to prevent** people from sending
a submission to the IOCCC on a frequently submitted theme,
we do wish to provide a **fair warning** to those who do.


#### Fair warnings on frequently submitted themes:

**IMPORTANT HINT**: It is **not fatal** to send in those types of
entries, it is just **HARDER to win** with such a submission.  A
submission on a frequently submitted theme will have to do something
in a **really unique AND interesting way** to even make it into the
final judging rounds.  It will have to compete with previous IOCCC
winners based on the same theme.

**IMPORTANT HINT**: If you really wish send in a submission on a
frequently submitted theme, be sure that it is obfuscated in several
new and novel ways.

**IMPORTANT HINT**: Be sure to **clearly explain** near the beginning
of your `remarks.md` file, see the
FAQ on "[remarks.md](#remarks_md)",
**why you are submitting an entry based on a frequently
submitted theme** and **how compares with previous IOCCC winners**
of the same theme.


#### Examples of frequently submitted themes


##### Maze generator

- [1985/shapiro](1985/shapiro/index.html)
- [1991/buzzard](1991/buzzard/index.html)
- [1995/cdua](1995/cdua/index.html)
- [1995/dodsond2](1995/dodsond2/index.html)
- [1998/bas1](1998/bas1/index.html)


##### Tic-Tac-Toe/Noughts and Crosses/Xs and Os game

- [1991/westley](1991/westley/index.html)
- [1996/jonth](1996/jonth/index.html)
- [2020/carlini](2020/carlini/index.html)


##### Solitaire/Othello game

- [1987/lievaart](1987/lievaart/index.html)
- [1994/dodsond1](1994/dodsond1/index.html)


##### Generating small primes (below is the list of all prime related winning entries)

- [1985/august](1985/august/index.html)
- [1988/applin](1988/applin/index.html)
- [1994/weisberg](1994/weisberg/index.html)
- [1995/makarios](1995/makarios/index.html)
- [1996/dalbec](1996/dalbec/index.html)
- [2000/bellard](2000/bellard/index.html)


##### Self-reproducing program

- [1990/scjones](1990/scjones/index.html)
- [1994/smr](1994/smr/index.html) - _do not claim your program is the smallest without seeing this entry_!
- [2000/dhyang](2000/dhyang/index.html) - _this entry set a high bar for entries of this theme_


##### Entries that just print "Hello, world!"

- [1984/anonymous](1984/anonymous/index.html)
- [1985/applin](1985/applin/index.html)
- [1986/applin](1986/applin/index.html)
- [1986/holloway](1986/holloway/index.html)
- [1989/jar.1](1989/jar.1/index.html)
- [1992/lush](1992/lush/index.html)
- [2000/tomx](2000/tomx/index.html)


##### Entries that use some complex state machine/table to print something

- [1988/isaak](1988/isaak/index.html)
- [1988/phillipps](1988/phillipps/index.html)
- [2018/ciura](2018/ciura/index.html)
- [2018/giles](2018/giles/index.html)


##### ROT13

- [1985/sicherman](1985/sicherman/index.html)
- [1989/westley](1989/westley/index.html)
- [1990/dg](1990/dg/index.html)
- [1991/fine](1991/fine/index.html)


##### **pi** or **e** computation

- [1986/august](1986/august/index.html)
- [1988/robison](1988/robison/index.html)
- [1988/westley](1988/westley/index.html)
- [1989/roemer](1989/roemer/index.html)


####  The above list of frequently submitted themes is not exhaustive


#### Some final thoughts on frequently used themes

While it is possible to win a new IOCCC with one of these
**frequently submitted** types of entries, level of the competition from
previous IOCCC entries make it more challenging to be successful.

It is also important to note that the [guidelines](next/guidelines.html) often
state something along the lines of:

```
    We tend to dislike programs that: are similar to previous winning entries.
```

**FAIR WARNING**: Be sure to **clearly explain** near the beginning
of your `remarks.md` file, see the
FAQ on "[remarks.md](#remarks_md)",
**why you are submitting an entry based on a frequently
submitted theme** and **how compares with previous IOCCC winners**
of the same theme.

Jump to: [top](#)


<div id="rule_2_broken">
<div id="rule_breaking_entry">
### Q: How did an entry that breaks the size rule 2 win the IOCCC?
</div>
</div>

As entries have been fixed it is entirely possible that some of the entries no
longer fit within the year's size restrictions. Invariably the length of columns
and/or number of rows have also changed.

The `winner.orig.c` file contains the original source code that was
subjected to rule 2 of the given IOCCC.  You may also wish to see
the [archive](archive) directory where you can find all the
original winning entries as compressed tar files for a given year.

In some cases the entry may have abused rule 2 and declared an
"abuse of the rules" (although now blatant abuse of the rules to
get around rule 2 size limits is discouraged).

Jump to: [top](#)


<div id="how_many">
<div id="submissions">
### Q: How many submissions do the judges receive for a given IOCCC?
</div>
</div>

By tradition, we do not say.

Jump to: [top](#)


<div id="judging_time">
### Q: How much time does it take to judge the contest?
</div>

It takes a fair amount of time to setup, run, respond to messages, process entries,
review entries, trim down the set entries to a set of winning entries, doing the
write-up of the entries, announcing the entries, reviewing final edits of the
winning entry set, posting the winning entries, being flamed :-), tell folks who send in
late entries to wait until the next contest, etc... It takes a few weekends and
a number nights of study and work ... which is hard given that we are busy with
many other activities as well.

Note that we do not contact the author if an entry does not compile or does not
work as advertised; we might attempt to fix obvious compilation problems or
incompatibilities, but no more than that - so be sure that your entry does work
on at least a couple different platforms, at least one of them being UNIX or
SUS-conforming. See the
FAQ on "[SUS](#SUS)"
for more information.

Jump to: [top](#)


<div id="rounds">
<div id="judging_rounds">
### Q: How many judging rounds do you have?
</div>
</div>

Are you trying to trick us? :-)

By tradition, we do not say how many judging rounds we have in a given IOCCC.

We often report when the IOCCC judges start the 1st round, and then usually
report when the IOCCC judges start near final judging rounds, and sometimes we
also report when we enter what we believe is the final judging round, so you may
guess that we have at least 3 rounds.  :-)  The actual number of rounds is
certainly more than 3.

Jump to: [top](#)


<div id="best">
<div id="best_of_show">
<div id="grand_prize">
### Q: Why do some IOCCC entries receive the Grand Prize or Best of Show award?
</div>
</div>
</div>

In some years, the IOCCC judges discover a truly amazing IOCCC entry that
stands out among all of the other IOCCC entries received that year.
For such an IOCCC entry, the IOCCC judges award a "Grand Prize"
or "Best of Show award.

In 1984-1987, the grand prize winning entries are:

- [1984/mullender](years.html#1984_mullender)
- [1985/shapiro](years.html#1985_shapiro)
- [1986/wall](years.html#1986_wall)
- [1987/lievaart](years.html#1987_lievaart)

Starting from 1988, the entry we liked the most in that year is called
"Best of Show". Here are the "Best of Show" entries:

- [1988/applin](years.html#1988_applin)
- [1989/jar.2](years.html#1989_jar.2)
- [1990/theorem](years.html#1990_theorem)
- [1991/brnstnd](years.html#1991_brnstnd)
- [1992/vern](years.html#1992_vern)
- [1996/august](years.html#1996_august)
- [1998/banks](years.html#1998_banks)
- [2000/jarijyrki](years.html#2000_jarijyrki)
- [2020/carlini](years.html#2020_carlini)


In 1993, 1994 and 1995 the judges were unable to select a clear overall
winning entry. So to give a nod to the entry that had the highest approval ranking
from the judges, they used the following awards:

- [1993/rince](years.html#1993_rince) - Most Well Rounded
- [1994/shapiro](years.html#1994_shapiro) - Most Well Rounded
- [1995/leo](years.html#1995_leo) - Best Use of Obfuscation

These could be considered the 'best entry' for those years with 1 or
more other entries that came in close behind.

Jump to: [top](#)


<div id="announcing_winners">
<div id="announce">
<div id="winners">
### Q: How are winning IOCCC entries announced?
</div>
</div>
</div>

Once the [IOCCC](index.html) closes, the judges will:

* Judge the submissions.

* Select the [winning entries](years.html) and announce them on the [@IOCCC
mastodon feed](https://fosstodon.org/@ioccc).

* Notify the authors of entries that won the IOCCC via email using their previously
registered email address.

* Announce who are authors of this year's winning IOCCC entries via the [@IOCCC mastodon
feed](https://fosstodon.org/@ioccc).

* Upload the winning code to the [Official IOCCC winner
repo](https://github.com/ioccc-src/winner).

* Update the [Official IOCCC website](index.html), and in particular
display this year's winning IOCCC entries at the top of the [IOCCC
winning entries page](years.html). This is done by updating this repo.

* Update the [IOCCC news](news.html) page, also by updating this repo.

Jump to: [top](#)


<div id="losing_submissions">
<div id="lost">
### Q: Why don't you publish submissions that do not win?
</div>
</div>

Because the publication on the IOCCC site **_IS_** the award!
Anyone is free to put their IOCCC hopefuls, lookalikes and/or
entries that do not win on their web page for everyone to see.

Jump to: [top](#)

<hr style="width:50%;text-align:left;margin-left:0">
<hr style="width:50%;text-align:left;margin-left:0">


<div id="mkiocccentry_details">
## Section 3: The mkiocccentry toolkit: finer details
</div>


Jump to: [top](#)
<div id="mkiocccentry_checks">
### Q: What sort of checks does the mkiocccentry tool perform?
</div>

`mkiocccentry(1)` will check and warn about the following conditions:

- If the files do not exist, are not regular files or cannot be read.
- If `prog.c` violates [Rule 2](next/rules.html#rule2) (see
[iocccsize.c](https://github.com/ioccc-src/mkiocccentry/blob/master/iocccsize.c)).
- If `prog.c` is empty.
- If `prog.c` has any high bit char (see
[iocccsize.c](https://github.com/ioccc-src/mkiocccentry/blob/master/iocccsize.c)).
- If `prog.c` has any NUL char (see
[iocccsize.c](https://github.com/ioccc-src/mkiocccentry/blob/master/iocccsize.c)).
- If `prog.c` has any unknown or invalid trigraph (see
[iocccsize.c](https://github.com/ioccc-src/mkiocccentry/blob/master/iocccsize.c)).
- If `prog.c` triggers a word buffer overflow (see
[iocccsize.c](https://github.com/ioccc-src/mkiocccentry/blob/master/iocccsize.c)).
- If `prog.c` triggers an `ungetc(3)` error (see
[iocccsize.c](https://github.com/ioccc-src/mkiocccentry/blob/master/iocccsize.c)).
- If the first rule in the `Makefile` is not `all`.
- If the `Makefile` does not have a `clean` rule.
- If the `Makefile` does not have a `clobber` rule.
- If the `Makefile` does not have a `try` rule.
- If the `remarks.md` is empty.

Conditions that one must correct, and which `mkiocccentry(1)` will prompt until
they are correct, are:

- Your _title_ is not in the range of 1 through `MAX_TITLE_LEN` chars (see
[limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)).
- Your _title_ does not match the regexp `^[0-9a-z][0-9a-z._+-]*$`.
- Your _abstract_ is not between 1 and `MAX_ABSTRACT_LEN` chars
(see [limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)).
- the author count is not 1 through `MAX_AUTHORS` (see
[limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)).
- An author _name_ is not 1 through `MAX_NAME_LEN` chars (see
[limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)).
- Duplicate author _name_.
- _Country code_ is invalid (not ISO 3166-1 2 character
codes).
- An _email_, if provided, is not in the format of `x@y` or
if `x` or `y` contain a `@`, are empty or if the total length is longer than
`MAX_EMAIL_LEN` (see [limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)).
- A _URL_ or _alt URL_, if provided, does not start with `http://`
or `https://` or is longer than `MAX_URL_LEN` chars (see
[limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h))
or does not have anything after the `http://` or `https://`.
- A _mastodon handle_, if provided, is not in the form of
`@user@site` (i.e. starts with an `@`, has text following it and then another
`@` followed by more text and has no other `@`)  or is longer than `MAX_MASTODON_LEN` (see
[limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)).
- A _GitHub account_, if provided, does not start with an `@`,
has more than one `@` or is longer than `MAX_GITHUB_LEN` (see
[limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)).
- An _affiliation_, if provided, is longer than
`MAX_AFFILIATION_LEN` (see [limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)).
- An _author handle_, if the default is not accepted, does
not match the regexp `^[0-9A-Za-z][0-9A-Za-z._+-]*$`.
- An _author handle_ is repeated.
- The output of `ls` on the submission directory is incorrect.

Although the `mkiocccentry(1)` tool will verify everything for you, you may wish
to validate different parts individually with the different tools. As the
[rules](next/rules.html) state, each of these tools has a `-h` option.

See the
FAQ on "[jparse](#jparse)",
the
FAQ on "[.auth.json](#auth_json)",
the
FAQ on "[.info.json](#info_json)",
the
FAQ on "[chkentry](#chkentry)",
the
FAQ on "[txzchk](#txzchk)"
and the
FAQ on "[fnamchk](#fnamchk)"
for more details on the tools that `mkiocccentry` either executes directly or
indirectly as part of the packaging process, especially if you wish to run one
or more of these tools manually.

See also the [Guidelines](next/guidelines.html) and the [Rules](next/rules.html)
(and in particular [Rule 17](next/rules.html#rule17)).

Jump to: [top](#)


<div id="txzchk">
<div id="tarball">
<div id="xz">
### Q: How can I validate my submission tarball?
</div>
</div>
</div>

The tool that validates submission tarballs can be obtained from the [IOCCC
mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry). The
`mkiocccentry` tool itself will run the validator **after** forming the tarball.
However, you may wish to manually validate the tarball. The tool that does this
is `txzchk`.

If you wish to validate the tarball without running the `mkiocccentry(1)` tool,
for instance the tarball
`submit.12345678-1234-4321-abcd-1234567890ab-2.1720636351.txz` you can, after
installing the tools, do:

``` <!---sh-->
    txzchk submit.12345678-1234-4321-abcd-1234567890ab-2.1720636351.txz
```

Assuming that the tarball exists and is valid, you should see no output.

If you wish to see the contents, for instance like `mkiocccentry(1)` does, you
could do:

``` <!---sh-->
    txzchk -v 1 submit.12345678-1234-4321-abcd-1234567890ab-2.1720636351.txz
```

As the [guidelines state](next/guidelines.html#txzchk), it is beyond the scope
of this document to discuss the many tests that `txzchk(1)` runs; if you must
know we refer you to the [source
code](https://github.com/ioccc-src/mkiocccentry/blob/master/txzchk.c).

Jump to: [top](#)


<div id="fnamchk">
<div id="tarball_filename">
### Q: What is the `fnamchk` tool?
</div>
</div>

This tool, which is in the [mkiocccentry
repo](https://github.com/ioccc-src/mkiocccentry), validates the directory name
of your submission.

Rather than `mkiocccentry` running this tool manually, `txzchk`'s algorithm uses
the output of this tool. If you wish to validate your tarball filename manually,
you can do so. For instance:

``` <!---sh-->
    fnamchk submit.12345678-1234-4321-abcd-1234567890ab-2.1720636351.txz
```

Assuming everything is OK, it would show:

> `12345678-1234-4321-abcd-1234567890ab-2`

See also the
FAQ on "[validating your submission tarball](#txzchk)"
for more information.

Jump to: [top](#)


<div id="validating_auth_info_json">
<div id="chkentry">
### Q: How can I validate my `.auth.json` and/or `.info.json` files?
</div>
</div>

If you want to validate the `.auth.json` or `.info.json` files you
should use `chkentry(1)` from the [mkiocccentry
repo](https://github.com/ioccc-src/mkiocccentry).

The `chkentry(1)` tool uses the IOCCC version of the [jparse
API](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse/man/man3/jparse.3)
to perform **additional** checks on these two IOCCC specific JSON files. It is
_possible_ that this version will at times differ from the [official jparse
API](https://github.com/xexyl/jparse/blob/master/man/man3/jparse.3) at the
[official jparse repo](https://github.com/xexyl/jparse) and this is one of the
reasons the tools' `-V` (version option) show the JSON parser version as well.

See the
FAQ on "[.auth.json](#auth_json)"
and
FAQ on "[.info.json](#info_json)"
for more details on these files.

The `chkentry(1)` tool accepts more than one command line form.
If you pass a single argument, it is expected to be a directory that has both
`.auth.json` and `.info.json` in it. You can also specify a `.auth.json` and/or
`.info.json` file. An argument of "`.`" will skip that file. For instance:

``` <!---sh-->
    # test entry directory test_work:
    chkentry test_work

    # run checks on .info.json:
    chkentry .info.json .

    # run checks on .auth.json:
    chkentry . .auth.json

    # run checks on .info.json and .auth.json:
    chkentry .info.json .auth.json
```

If there is a [JSON](https://www.json.org/json-en.html) issue detected by
`jparse(3)` API, then there is a [JSON](https://www.json.org/json-en.html) error and
`chkentry(1)` will report it as an **error**. If the parsing is OK (i.e. valid
JSON) but there is an issue in one or both of the
[JSON](https://www.json.org/json-en.html) files in **the context of the IOCCC**,
it will report this as an **error**. Thus, if you were to package your
submission manually then you would be violating [Rule
17](next/rules.html#rule17).

Jump to: [top](#)


<div id="auth_json">
### Q: What is a `.auth.json` file?
</div>

This file is constructed by the `mkiocccentry(1)` **prior to** forming the xz
compressed tarball of your submission. The `.auth.json` file contains
information about the author or authors of the submission, in JSON format.

In order of the file's contents we describe each required field, below:

- `no_comment` (double quoted string)
    * We can provide `no comment` about `no_comment` other than to state that unless
    `no_comment` matches this quote:

>   "mandatory comment: because comments were removed from the original JSON spec"

    your submission **WILL BE** rejected!

    Are we suggesting that removing comments from the JSON spec was a mistake?

>    "You might very well think that; but of course I couldn't possibly comment." -- Francis Urquhart

- `IOCCC_auth_version` (double quoted string)
    * The current version of the `.auth.json` file.

    **NOTE:** this **MUST** match **THIS** IOCCC's `.auth.json` version, defined as
    `AUTH_VERSION` in
    [soup/version.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/version.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

- `IOCCC_contest` (double quoted string)
    * Which contest number this is (e.g. 1 for 1984, 2 for 1985, 27 for 2020).

    **NOTE:** this **MUST** match **THIS** IOCCC's contest value, defined as
    `IOCCC_CONTEST` in
    [soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

- `IOCCC_year` (number)
    * The year this contest was run in.

    **NOTE:** sometimes an IOCCC year runs into another year and the contest year
    might not match when it ends.

    **NOTE:** this **MUST** match **THIS** IOCCC's contest, defined as
    `IOCCC_YEAR` in
    [soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

- `mkiocccentry_version` (double quoted string)
    * The version of `mkiocccentry` that formed this `.auth.json` file.

    **NOTE:** this **MUST** match **THIS** IOCCC's `mkiocccentry` version,
    defined as `MKIOCCCENTRY_VERSION` in
    [soup/version.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/version.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

- `chkentry_version` (double quoted string)
    * The version of `chkentry` that was used to validate this `.auth.json`,
    assuming that it was created by `mkiocccentry`.

    **NOTE:** this **MUST** match **THIS** IOCCC's `chkentry` version, defined
    as `CHKENTRY_VERSION` in
    [soup/version.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/version.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

- `fnamchk_version` (double quoted string)
    * The version of `fnamchk` that `txzchk` uses to validate the filename of
    the xz compressed tarball.

    **NOTE:** this **MUST** match **THIS** IOCCC's `fnamchk` version in order for it
    to be valid. If this is not the case your submission **WILL BE** rejected!

- `IOCCC_contest_id` (double quoted string)
    * The IOCCC contestant ID used as a username in the form of **in the form of
    a UUID** and submission number; see the [Rules](next/rules.html) for more details
    on this, and in particular [Rule 17](next/rules.html#rule17).

    **NOTE:** if the contest ID is **NOT** in this format then `fnamchk` will
    report it as an **error** and your submission **WILL BE** rejected for
    violating [Rule 17](next/rules.html#rule17)!

- `tarball` (double quoted string)
    * The xz compressed tarball filename.

    **NOTE:** this **MUST** match the actual tarball's **filename** in order for
    this to be valid. If there is a mismatch you stand a great risk of having
    your submission rejected for violating [Rule 17](next/rules.html#rule17)!
    Moreover, it is possible that `txzchk` will report a problem through
    `fnamchk(1)` which also puts you at great risk of violating [Rule
    17](next/rules.html#rule17). If `txzchk` does not detect this, though, it
    does not mean it's a bug but rather that the directory in the tarball
    matches the filename.

- `submit_slot` (number)
    * The submission number.

    **NOTE:** this **MUST** be within the range of 0 **THROUGH**
    `MAX_SUBMIT_SLOT` (see
    [soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/)). If
    this is not the case you stand a great risk of having your submission
    rejected for violating [Rule 17](next/rules.html#rule17)!

- `author_count` (number)
    * How many authors this submission has.

    **NOTE:** this **MUST** be within the range of 1 **THROUGH**
    `MAX_AUTHORS` (see
    [soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/)). If
    this is not the case you stand a great risk of having your submission
    rejected for violating the [Rules](next/rules.html)! Moreover, if the
    `author_count` is inconsitent with how many authors are in the `authors`
    array your submission **will be** invalid.

- `test_mode` (boolean)
    * `true` if the `test` ID was used to form the tarball, else `false`.

    **NOTE:** if `true` then this may **NOT** be submitted to the contest! Please do
    **NOT** email the [Judges](judges.html) your submission!

Next, the JSON `authors` **array** holds the following information about the
author(s) of the submission:

- `name` (double quoted string)
     * The **name** of this author.

- `location_code` (double quoted string)
     * The **location code** of this author (an ISO 3166-1 2 character code).
     See
     <https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements>
     for a list of valid codes.

     **NOTE:** in `mkiocccentry` use `XX` if you want your location to be anonymous.

- `email` (`null` or double quoted string)
     * The **email** of this author in the form of `x@y`, or `null` if not provided.

- `url` (`null` or double quoted string)
     * The primary **URL** of this author, or `null` if not provided.

- `alt_url` (`null` or double quoted string)
     * The **alt URL** of this author, or `null` if not provided.

- `mastodon` (`null` or double quoted string)
     * The Mastodon handle of this author in the form of `@user@domain`, or
     `null` if not provided.  See the
     FAQ on "[Mastodon](#try_mastodon)"
     for more information.

- `github` (`null` or double quoted string)
     * The **[GitHub](https://github.com) account** of this author in the form of `@user`, or `null` if not
     provided.

- `affiliation` (`null` or double quoted string)
     * This author's **affiliation**, if any, or `null` if not provided.

    **NOTE:** if provided, the length of the **affiliation** **MUST** be within
    the range of 1 **THROUGH** `MAX_AFFILIATION_LEN` (see
    [soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/)). If
    this is not the case you stand a great risk of having your submission
    rejected for violating [Rule 17](next/rules.html#rule17)!

     **NOTE:** an **affiliation** does **NOT** have any affect on whether you will win or not.

- `past_winning_author` (boolean)
     * `true` if this author claims to have won a past IOCCC, `false` if this
     author has **NOT** won before.

     **NOTE:** this has **NO** effect on whether you will win or not.

- `default_handle` (boolean)
     * `true` if this default handle was accepted, `false` if one is provided
     by this author.

- `author_handle` (double quoted string)
     * This author's handle (custom or default provided).

     **NOTE:** if you have won before, we **ENCOURAGE** you to use the same handle of
     your previous winning entries, to help in organising the
     [authors.html](authors.html) page and the author JSON file.
     See the
     FAQ on "[author handle](#author_handle_faq)"
     and the
     FAQ on "[author_handle.json](#author_json)"
     for more information.

- `author_number` (number)
     * This author number in the `authors` array.

After the `authors` **array** the remaining of a `.auth.json` file holds:

- `formed_timestamp` (number)
    * Seconds since epoch when `.auth.json` was formed (see `gettimeofday(2)`).  See also the
    FAQ on "[.info.json](#info_json)"
    for more information.

    **NOTE:** this **MUST** be greater than or equal to `MIN_TIMESTAMP` (see
    [soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/)). If
    this is not the case your submission **WILL BE** rejected.

- `formed_timestamp_usec` (number)
    * Microseconds since the tstamp (seconds since epoch when `.auth.json` was
    formed - see `gettimeofday(2)`) second.

    **NOTE:** this **MUST** be within the range `MIN_FORMED_TIMESTAMP_USEC`
    **THROUGH** `MAX_FORMED_TIMESTAMP_USEC` and is validated by
    `test_formed_timestamp_usec()` in
    [soup/entry_util.c](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/entry_util.c)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case `chkentry(1)` will report an **error** and your
    submission **WILL BE** rejected!

- `timestamp_epoch` (double quoted string)
    * `"Thu Jan 01 00:00:00 1970 UTC"`  (`gettimeofday(2)` epoch).

    **NOTE:** this **MUST** be `"Thu Jan 01 00:00:00 1970 UTC"` which is `#define`d
    as `TIMESTAMP_EPOCH` in
    [soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

- `min_timestamp` (number)
    * Minimum number of second since epoch for **this** IOCCC.

    **NOTE:** this **MUST** be >= `MIN_TIMESTAMP` defined in
    [soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

This file will be verified with the `chkentry(1)` tool and if there are any
problems **it is an error**. If there is an error the tarball will **NOT** be
formed by `mkiocccentry`; otherwise the `txzchk(1)` tool will be executed on the
tarball.

This file will **NOT** be looked at unless the submission wins! Nonetheless,
`chkentry(1)` **WILL BE** used on the file as part of the judging process.

At the risk of stating the obvious, if your `.auth.json` file is invalid JSON or
is reported invalid by `chkentry` your submission will almost certainly be
rejected for violating the [Rules](next/rules.html) and in particular [Rule
17](next/rules.html#rule17).

An obvious example where `chkentry` would fail to validate `.auth.json` is if
there is a mismatch of type in the JSON file with what is expected, for
instance, if in `.auth.json` the `no_comment` that we chose to not comment on is
not a string. Another obvious example is when things are out of range (see above
for list). Two more examples would be if a field is missing or if an unknown
filed is in the file. In these cases (and any others that must be established as
valid by `chkentry`) your submission would be rejected for violating [Rule
17](next/rules.html#rule17) and in particular because `chkentry` would not
validate the `.auth.json` file.

If you wish to **verify** that your `.auth.json` file is valid **JSON** then see the
FAQ on "[validating JSON documents](#validating_json)".

Jump to: [top](#)


<div id="info_json">
### Q: What is a `.info.json` file?
</div>

This file is constructed by the `mkiocccentry(1)` **prior to** forming the xz
compressed tarball of your submission. The `.info.json` file contains
information about the submission, in JSON format. The
JSON `manifest` array contains information about the files of the submission,
**including** the **mandatory** `.auth.json` file,
the  **mandatory** `remarks.md` file,
and the **mandatory** C source file.
See the
FAQ on "[.auth.json](#auth_json)"
and the
FAQ on "[remarks.md](#remarks_md)"
for more information.

In order of the file's contents we describe each required field, below:

- `no_comment` (double quoted string)
    * We can provide `no comment` about `no_comment` other than to state that unless
    `no_comment` matches this quote:

>   "mandatory comment: because comments were removed from the original JSON spec"

    your submission **WILL BE** rejected!

    Are we suggesting that removing comments from the JSON spec was a mistake?

>    "You might very well think that; but of course I couldn't possibly comment." -- Francis Urquhart

- `IOCCC_info_version` (double quoted string)
    * The current version of the `.info.json` files.

    **NOTE:** this **MUST** match **THIS** IOCCC's `.info.json` version, defined as
    `INFO_VERSION` in
    [soup/version.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/version.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

- `IOCCC_contest` (double quoted string)
    * Which contest number this is (e.g. 1 for 1984, 2 for 1985, 27 for 2020).

    **NOTE:** this **MUST** match **THIS** IOCCC's contest value, defined as
    `IOCCC_CONTEST` in
    [soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

- `IOCCC_year` (number)
    * The year this contest was run in.

    **NOTE:** sometimes an IOCCC year runs into another year and the contest year
    might not match when it ends.

    **NOTE:** this **MUST** match **THIS** IOCCC's contest, defined as
    `IOCCC_YEAR` in
    [soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

- `mkiocccentry_version` (double quoted string)
    * The version of `mkiocccentry` that formed this `.auth.json` file.

    **NOTE:** this **MUST** match **THIS** IOCCC's `mkiocccentry` version,
    defined as `MKIOCCCENTRY_VERSION` in
    [soup/version.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/version.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

- `iocccsize_version` (double quoted string)
    * The version of `iocccsize` that was used for this `.info.json` file.

    **NOTE:** this **MUST** match **THIS** IOCCC's `iocccentry` version,
    defined as `IOCCCSIZE_VERSION` in
    [soup/version.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/version.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

- `chkentry_version` (double quoted string)
    * The version of `chkentry` that was used to validate this `.info.json`,
    assuming that it was created by `mkiocccentry`.

    **NOTE:** this **MUST** match **THIS** IOCCC's `chkentry` version, defined
    as `CHKENTRY_VERSION` in
    [soup/version.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/version.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

- `fnamchk_version` (double quoted string)
    * The version of `fnamchk` that `txzchk` uses to validate the filename of
    the xz compressed tarball.

    **NOTE:** this **MUST** match **THIS** IOCCC's `fnamchk` version, defined
    as `FNAMCHK_VERSION` in
    [soup/version.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/version.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

- `txzchk_version` (double quoted string)
    * The version of `txzchk` used to validate the xz compressed tarball.

    **NOTE:** this **MUST** match **THIS** IOCCC's `txzchk` version, defined
    as `TXZCHK_VERSION` in
    [soup/version.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/version.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

- `IOCCC_contest_id` (double quoted string)
    * The IOCCC contestant ID used as a username in the form of **in the form of
    a UUID** and submission number; see the [rules](next/rules.html) for more details
    on this, and in particular [Rule 17](next/rules.html#rule17).

    **NOTE:** if the contest ID is **NOT** in this format then `fnamchk` will
    report it as an **error** and your submission **WILL BE** rejected for
    violating [Rule 17](next/rules.html#rule17)!


- `submit_slot` (number)
    * The submission number.

    **NOTE:** this **MUST** be within the range of 0 **THROUGH**
    `MAX_SUBMIT_SLOT` (see
    [soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/)). If
    this is not the case you stand a great risk of having your submission
    rejected for violating [Rule 17](next/rules.html#rule17)!

- `title` (double quoted string)
    * A short name (length >= 1 **THROUGH** `MAX_TITLE_LEN`, defined in
    [soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/)) that
    matches the regexp `[a-z0-9][a-z0-9_+-]*`.

    **NOTE:** if this is **NOT** the case you stand a great risk of having your submission
    rejected for violating [Rule 17](next/rules.html#rule17)!

- `abstract` (double quoted string)
    * A one line summary of your submission, with a length of 1 **THROUGH**
    `MAX_ABSTRACT_LEN`, defined in
    [soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/))

    The `abstract` may not contain a `;` (semicolon), nor `&` (ampersand), nor `,` (comma).

    **NOTE:** if your abstract is 0 in length or > the maximum abstract length you
    stand a great risk of having your submission rejected for violating [Rule
    17](next/rules.html#rule17)!

- `tarball` (double quoted string)
    * The xz compressed tarball filename.

    **NOTE:** this **MUST** match the actual tarball's **filename** in order for
    this to be valid. If there is a mismatch you stand a great risk of having
    your submission rejected for violating [Rule 17](next/rules.html#rule17)!
    Moreover, it is possible that `txzchk` will report a problem through
    `fnamchk(1)` which also puts you at great risk of violating [Rule
    17](next/rules.html#rule17). If `txzchk` does not detect this, though, it
    does not mean it's a bug but rather that the directory in the tarball
    matches the filename.

- `rule_2a_size` (number)
    * The size calculated of [Rule 2a](next/rules.html#rule2a).

    **NOTE:** if this violates [Rule 2a](next/rules.html#rule2a) you stand a great
    chance of having your submission rejected for violating the
    [Rules](next/rules.html)!

- `rule_2b_size` (number)
    * The size calculated of [Rule 2b](next/rules.html#rule2b).

    **NOTE:** if this violates [Rule 2b](next/rules.html#rule2b) you stand a great
    chance of having your submission rejected for violating the
    [Rules](next/rules.html)!

- `empty_override` (boolean)
    * `true` if user override warning of an empty source file, else `false`.

- `rule_2a_override` (boolean)
    * `true` if user overrides warning of [Rule 2a](next/rules.html#rule2a)
    violation, else `false`.

    **NOTE:** if the [Rule 2a](next/rules.html#rule2a) calculated size is **NOT**
    violated but this is `true` then you stand a good chance of having your
    submission rejected for violating [Rule 17](next/rules.html#rule17)!

- `rule_2a_mismatch` (boolean)
    * `true` if [Rule 2a](next/rules.html#rule2a) calculated size is not the
    same as the file size.

- `rule_2b_override` (boolean)
    * `true` if user overrides warning of [Rule 2b](next/rules.html#rule2b)
    violation, else `false`.

    **NOTE:** if the [Rule 2b](next/rules.html#rule2b) calculated size is **NOT**
    violated but this is `true` then you stand a good chance of having your
    submission rejected for violating [Rule 17](next/rules.html#rule17)!

- `highbit_warning` (boolean)
    * `true` if `iocccsize` detects a high bit (unescaped octets with the high
    bit set - octet value >= 128); see [Rule 13](next/rules.html#rule13), else
    `false`.

- `nul_warning` (boolean)
    * `true` if `iocccsize` detects a NUL character in the `prog.c`, else
    `false`.

- `trigraph_warning` (boolean)
    * `true` if `iocccsize` detects an unknown or invalid trigraph in
    `prog.c`, else `false`.

- `wordbuf_warning` (boolean)
    * `true` if `prog.c` triggered a word buffer overflow (see `iocccsize`),
    else `false`.

    **NOTE:** this does **NOT** mean that your code has been checked for buffer
    overflows in general.

- `ungetc_warning` (boolean)
    * `true` if `prog.c` triggered an `ungetc(3)` error, else `false`.

- `Makefile_override` (boolean)
    * `true` if the user overrides any warnings about an incomplete/incorrect
    `Makefile` file, else `false`.

    **NOTE:** if the `Makefile` file has no problems and this is `true` then
    you stand a good chance of having your submission rejected for violating
    [Rule 17](next/rules.html#rule17)!

    See the
    FAQ on "[Makefile](#makefile)"
    for more information.

- `first_rule_is_all` (boolean)
    * `true` if the first rule in the `Makefile` file is `all`, else `false`.

    **NOTE:** if the `Makefile` file does **NOT** have an `all` rule or it is not
    first and this boolean is `true` then you stand a good chance of having your
    submission rejected for violating [Rule 17](next/rules.html#rule17)!

    See the
    FAQ on "[Makefile](#makefile)"
    for more information.

- `found_all_rule` (boolean)
    * `true` if the `Makefile` file has an `all` rule, else `false`.

    **NOTE:** if the `Makefile` file does **NOT** have an `all` rule and this
    boolean is `true`, or if it does **NOT** have an `all` rule but
    `first_rule_is_all` is `true` then you stand a good chance of having your
    submission rejected for violating [Rule 17](next/rules.html#rule17)!

    See the
    FAQ on "[Makefile](#makefile)"
    for more information.

- `found_clean_rule` (boolean)
    * `true` if the `Makefile` file has a `clean` rule, else `false`.

    **NOTE:** if the `Makefile` file does **NOT** have a `clean` rule and this
    boolean is `true` then you stand a good chance of having your submission
    rejected for violating [Rule 17](next/rules.html#rule17)!

    See the
    FAQ on "[Makefile](#makefile)"
    for more information.

- `found_clobber_rule` (boolean)
    * `true` if the `Makefile` file has a `clobber` rule, else `false`.

    **NOTE:** if the `Makefile` file does **NOT** have an `clobber` rule and this
    boolean is `true` then you stand a good chance of having your submission
    rejected for violating [Rule 17](next/rules.html#rule17)!

    See the
    FAQ on "[Makefile](#makefile)"
    for more information.

- `found_try_rule` (boolean)
    * `true` if the `Makefile` file has a `try` rule, else `false`.

    **NOTE:** if the `Makefile` file does **NOT** have an `try` rule and this
    boolean is `true` then you stand a good chance of having your submission
    rejected for violating [Rule 17](next/rules.html#rule17)!

    See the
    FAQ on "[Makefile](#makefile)"
    for more information.

- `test_mode` (boolean)
    * `true` if the `test` ID was used to form the tarball, else `false`.

    **NOTE:** if this is `true` then this may **NOT** be submitted to the
    contest! Please do **NOT** email the [Judges](judges.html) your submission!

Next comes the `manifest` **array** which **MUST** have AT LEAST the following.
The `mkiocccentry(1)` tool will write it in this order:

- `info_JSON` (double quoted string)
    * This `MUST` be `".info.json"`, defined as `INFO_JSON_FILENAME` in
    [soup/entry_util.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/entry_util.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/), and
    it is the `.info.json` file that `mkiocccentry` forms.
    See the
    FAQ on "[.info.json](#info_json)"
    for more information.

    **NOTE:** if this is **NOT** the case you stand a great chance of having your
    submission rejected for violating [Rule 17](next/rules.html#rule17)!

- `auth_JSON` (double quoted string)
    * This `MUST` be `".auth.json"`, defined as `AUTH_JSON_FILENAME` in
    [soup/entry_util.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/entry_util.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/), and
    it is the `.auth.json` file that `mkiocccentry` forms.
    See the
    FAQ on "[.auth.json](#auth_json)"
    for more information.

    **NOTE:** if this is **NOT** the case you stand a great chance of having your
    submission rejected for violating [Rule 17](next/rules.html#rule17)!

- `c_src` (double quoted string)
    * This `MUST` be `"prog.c"`, defined as `PROG_C_FILENAME` in
    [soup/entry_util.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/entry_util.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/), and
    is your submission source code.

    **NOTE:** if this is **NOT** the case you stand a great chance of having your
    submission rejected for violating [Rule 17](next/rules.html#rule17)!

    **NOTE:** if you provide to `mkiocccentry` a different filename it will be
    copied to `prog.c`.

- `Makefile` (double quoted string)
    * This `MUST` be `"Makefile"`, defined as `MAKEFILE_FILENAME` in
    [soup/entry_util.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/entry_util.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/), and
    is your `Makefile` file.
    See the
    FAQ on "[Makefile](#makefile)"
    for more information.

    **NOTE:** if this is **NOT** the case you stand a great chance of having your
    submission rejected for violating [Rule 17](next/rules.html#rule17)!

    **NOTE:** if you provide to `mkiocccentry` a different filename it will be
    copied to `Makefile`.

- `remarks` (double quoted string)
    * This `MUST` be `"remarks.md"`, defined as `REMARKS_FILENAME` in
    [soup/entry_util.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/entry_util.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/), and
    is your `remarks.md]` file.
    See the
    FAQ on "[remarks.md](#remarks_md)"
    for more information.

    **NOTE:** if this is **NOT** the case you stand a great chance of having your
    submission rejected for violating [Rule 17](next/rules.html#rule17)!

    **NOTE:** if you provide to `mkiocccentry` a different filename it will be
    copied to `remarks.md`.

The `manifest` **array** also **OPTIONALLY** has one or more of the field:

- `extra_file` (double quoted string)

    * Any additional file that you need or want to include with your submission.

    **NOTE:** this MUST **NOT** match a mandatory filename (see above list) and
    `chkentry` will verify this for you; it is **ALSO** an **error** if the
    filenames are not unique. In these cases you stand a great risk of having
    your submission rejected for violating [Rule 17](next/rules.html#rule17)! On
    the other hand, **ONLY** `mkiocccentry` will verify that the files exist and
    can be read; `txzchk(1)` will **NOT** do this for you as it only **LISTS**
    the tarball: it does **NOT** extract it. Even so, the [Judges](judges.html)
    **WILL** extract the tarball and if a file listed in the manifest does not
    exist your submission will very likely be rejected for not being as
    documented!

Finally, after the `manifest` **array**, the following fields **MUST** exist:

- `formed_timestamp` (number)
    * Seconds since epoch when JSON (`.auth.json` or `.info.json`) file was formed (see `gettimeofday(2)`).

    **NOTE:** this **MUST** be greater than or equal to `MIN_TIMESTAMP` (see
    [soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/)). If
    this is not the case your submission **WILL BE** rejected.

- `formed_timestamp_usec` (number)
    * Microseconds since the tstamp (seconds since epoch when `.auth.json` was
    formed - see `gettimeofday(2)`) second.

    **NOTE:** this **MUST** be within the range `MIN_FORMED_TIMESTAMP_USEC`
    **THROUGH** `MAX_FORMED_TIMESTAMP_USEC` and is validated by
    `test_formed_timestamp_usec()` in
    [soup/entry_util.c](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/entry_util.c)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case `chkentry(1)` will report an **error** and your
    submission **WILL BE** rejected!

- `timestamp_epoch` (double quoted string)
    * `"Thu Jan 01 00:00:00 1970 UTC"`  (`gettimeofday(2)` epoch).

    **NOTE:** this **MUST** be `"Thu Jan 01 00:00:00 1970 UTC"` which is `#define`d
    as `TIMESTAMP_EPOCH` in
    [soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

- `min_timestamp` (number)
    * Minimum number of second since epoch for **this** IOCCC.

    **NOTE:** this **MUST** be >= `MIN_TIMESTAMP` defined in
    [soup/limit_ioccc.h](https://github.com/ioccc-src/mkiocccentry/blob/master/soup/limit_ioccc.h)
    in the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry/). If
    this is not the case your submission **WILL BE** rejected!

This file will be verified with the `chkentry(1)` tool and if there are any
problems **it is an error** and the tarball will **NOT** be formed by
`mkiocccentry`; otherwise the `txzchk(1)` tool will be executed on the tarball.

The [Judges](judges.html) **WILL** use `chkentry(1)` on this file during the
judging process and if it does not pass your submission **WILL BE** rejected.

An obvious example where `chkentry` would fail to validate `.info.json` is if
there is a mismatch of type in the JSON file with what is expected, for
instance, if in `.info.json` the `no_comment` that we chose to not comment on is
not a string. Another obvious example is when things are out of range (see above
for list). Two more examples would be if a field is missing or if an unknown
filed is in the file. In these cases (and any others that must be established as
valid by `chkentry`) your submission would be rejected for violating [Rule
17](next/rules.html#rule17) and in particular because `chkentry` would not
validate the `.info.json` file.

If you wish to **verify** that your `.info.json` file is valid **JSON** then see the
FAQ on "[validating JSON documents](#validating_json)".

Jump to: [top](#)


<!-- we cannot use id="author_handle" because of a header in FAQ 6.6 -->
<div id="author_handle_faq">
### Q: What is an `author_handle`?
</div>

An `author_handle` is string that refers to a given author and is unique to the
IOCCC.  Each author has exactly one `author_handle`.

For each `author_handle`, there will be a JSON file of the form:

```
    author/author_handle.json
```

See the
FAQ on "[fixing author information](#fix_author)"
for information about how to update
and/or correct IOCCC author information.

See the
FAQ on "[.auth.json](#auth_json)"
for information about the contents of these JSON files and
how they are used.

See the
FAQ on "[finding author handle](#find_author_handle)"
for how to find your own _author_handle_.

Because the `author_handle` is used to form a JSON filename, the string must be
POSIX safe string plus the use of `+` (for technical reasons beyond this
answer).  In particular, the `author_handle` must be an ASCII string or
32 characters or less that matches this regexp:

``` <!---re-->
    ^[0-9A-Za-z][0-9A-Za-z._+-]*$"
```

Default `author_handle`'s do not have multiple consecutive `_` (underscore)
characters.  Nevertheless, multiple consecutive `_` (underscore) characters are
allowed. Contest submitters who wish to override their default `author_handle`
may do so, long as the ASCII string matches the regexp above AND
so long as the length does not exceed the 32 ASCII characters (not including
the terminating NUL byte).

The `author_handle` is derived from the name of the author.  While there is a
algorithm that maps the name of the author (which can contain any UTF-8
characters) into a default `author_handle` string, those who submit an entry to
the IOCCC are free to choose a different `author_handle` string if they so
desire.

An `author` who has won a previous IOCCC is encouraged to reuse their
`author_handle` so that new winning entries can be associated with the same
author.

For an anonymous `author`, their handle is one of these forms:

```
    Anonymous_year
```

or:

```
    Anonymous_year.digits
```


The latter form is in case there are more than one anonymous author in a given
year.

**NOTE**: even if the directory name is not `anonymous` the above rules apply as in
in the case of [2005/anon](%%REPO_URL%%/2005/anon/anon.c).

Anonymous `author_handle`'s match this regexp:

``` <!---re-->
    Anonymous_[0-9][0-9][0-9][0-9][.0-9]*$
```

Jump to: [top](#)


<div id="author_json">
<div id="author_handle_json">
### Q: What is an `author_handle.json` file and how are they used?
</div>
</div>

**TL:DR**: The contents of these JSON files contain the best known
information about authors of IOCCC entries and is used to help form
HTML files as well to contact an author.

**NOTE**: tools to validate the `author_handle.json` files, which are only for
winning authors, are in the works (which will be documented after they are
developed). See the
FAQ on "[author handles](#author_handle_faq)"
for more information on author handles.

The content of these JSON files are used by tools from the [bin directory](bin/index.html)
to help build HTML content for the [official IOCCC website](https://www.ioccc.org).

For example, the `index.html` file for each IOCCC entry contains selected
information about the authors.  Tools from the [bin directory](bin/index.html)
use the content of these JSON files to generate the `index.html` files for each
IOCCC winning entry.

Moreover, should the [IOCCC judges](judges.html) need to
contact an authors of an IOCCC entry, they will consult the contents
of the author's JSON file for ways to contact them.

Each author of an IOCCC winning entry has their own `author_handle.json` file
of the form:

```
    author/author_handle.json
```

where _author_handle_ is an author handle.  See
FAQ on "[author handle](#author_handle_faq)"
for more information about an author handles.

#### `author_handle.json` JSON file contents

The syntax of a `author_handle.json` follows the _So-called JSON spec_.
See <https://www.json.org/json-en.html> for information on the _So-called JSON
spec_.

A good way to understand the JSON file contents of a `author_handle.json` file
is to look at an example, the `author_handle.json` file for Yusuke Endoh:

```
    author/Yusuke_Endoh.json
```

As of _Thu Nov 30 23:51:12 UTC 2023_, the contents was as follows:

``` <!---json-->
    {
        "no_comment" : "mandatory comment: because comments were removed from the original JSON spec",
        "author_JSON_format_version" : "1.0 2023-06-10",
        "author_handle" : "Yusuke_Endoh",
        "full_name" : "Yusuke Endoh",
        "sort_word" : "endoh",
        "location_code" : "JP",
        "email" : "mame@ruby-lang.org",
        "url" : "https://mametter.hatenablog.com",
        "alt_url" : null,
        "deprecated_twitter_handle" : null,
        "mastodon" : "@mame@ruby.social",
        "mastodon_url" : "https://ruby.social/@mame",
        "github" : "@mame",
        "affiliation" : null,
        "winning_entry_set" : [
            { "entry_id" : "2012_endoh1" },
            { "entry_id" : "2012_endoh2" },
            { "entry_id" : "2013_endoh1" },
            { "entry_id" : "2013_endoh2" },
            { "entry_id" : "2013_endoh3" },
            { "entry_id" : "2013_endoh4" },
            { "entry_id" : "2014_endoh1" },
            { "entry_id" : "2014_endoh2" },
            { "entry_id" : "2015_endoh1" },
            { "entry_id" : "2015_endoh2" },
            { "entry_id" : "2015_endoh3" },
            { "entry_id" : "2015_endoh4" },
            { "entry_id" : "2018_endoh1" },
            { "entry_id" : "2018_endoh2" },
            { "entry_id" : "2019_endoh" },
            { "entry_id" : "2020_endoh1" },
            { "entry_id" : "2020_endoh2" },
            { "entry_id" : "2020_endoh3" }
        ]
    }
```

**NOTE**: if you need to just check the validity of a JSON document then see the
FAQ on "[validating JSON documents](#validating_json)". Taking that FAQ in mind,
if you wish to validate every JSON file in `author/` then you could do so like:

``` <!--sh-->
        for auth in *.json; do jparse -q "$auth" || echo "$auth is invalid JSON" ; done
```

If you see any output then it will say which file or files are invalid JSON
(this should not actually happen, however).

See the
FAQ on "[jparse](#jparse)",
for now to location and/or install the `jparse(1)` command.


<div id="walk_through_author_json">
##### Walk through of an `author_handle.json` file
</div>

We now will walk thru the above JSON document looking at various JSON members:


##### no_comment

``` <!--- json-->
    "no_comment" : "mandatory comment: because comments were removed from the original JSON spec",
```

Because the authors of the so-called JSON spec removed the ability to use comments in JSON
(for reason(s) that seem to be less than credible), the IOCCC mandates this _JSON member_
be present in all IOCCC related JSON files.

There **MUST** be one and only one `no_comment` _JSON member_ and the _JSON value_ **MUST**
be the exact _JSON string_ as shown above.


##### author_JSON_format_version

``` <!---json-->
    "author_JSON_format_version" : "1.0 2023-06-10",
```

This _JSON member_ holds the format version of the `author_handle.json` JSON file.

There **MUST** be one and only one `author_JSON_format_version`
_JSON member_ and the _JSON value_ **MUST** be a _JSON string_.

This is **NOT** the version of the contents!  When updating an
`author_handle.json` JSON file, **DO NOT MODIFY author_JSON_format_version**!
As of _Thu Nov 30 23:51:12 UTC 2023_, the _JSON value_ **MUST** be _"1.0 2023-06-10"_.

The _author_JSON_format_version_ would only changed when the overall format
of the these files is modified: and then only those who maintain the
[official IOCCC website](https://www.ioccc.org) would be the one to do this
in conjunction with changes to [bin directory tools](bin/index.html).


##### author_handle

``` <!---json-->
    "author_handle" : "Yusuke_Endoh",
```

This _JSON member_ holds the author handle of the author.

There **MUST** be one and only one `author_handle` _JSON member_
and the _JSON value_ **MUST** be a _JSON string_ that is also a value author handle.

See
FAQ on "[author handle](#author_handle_faq)"
for more information about an author handles.

Normally the _author_handle_ _JSON value_ should **NOT** be changed
**unless there is a strong reason to do so**.  If the  _JSON value_
changes, then all of the `.entry.json` files for all of this authors
winning IOCCC entries should also be changed.  The _author_handle_
_JSON value_ must match the basename (without the leading path and
without the trailing `.json`) of the `author_handle.json` file.  So
a change of _author_handle_ _JSON value_ would also require the
`author_handle.json` file to also be renamed.


##### full_name

``` <!---json-->
    "full_name" : "Yusuke Endoh",
```

This _JSON member_ holds the full name of the author.

There **MUST** be one and only one `full_name` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_.

The full name of an author may use non-ASCII characters so long as the
full name is properly encoded as a _JSON string_.


##### sort_word

``` <!---json-->
    "sort_word" : "endoh",
```

This _JSON member_ holds the string that will be used to sort the author.

There **MUST** be one and only one `sort_word` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_.  Moreover the string **MUST** be a lower case ASCII
alphanumeric string that starts with a lower case ASCII letter.

The _JSON value_ is used, for example, to place a reference to the author
in the `/authors.html` file.

Normally the `sort_word` _JSON member_ _JSON value_ is the last
name of the author, translated into lower case ASCII alphanumeric
string that starts with a lower case ASCII letter.  If the author
wishes to be found in the `/authors.html` file under a different
string, such as if they wish to be listed under their first name
or their username, then they may change this accordingly.


##### location_code

``` <!---json-->
    "location_code" : "JP",
```

This _JSON member_ holds the string that is the
[ISO 3166-1 alpha-2 code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Decoding_table)
of the author's location or country.

There **MUST** be one and only one `location_code` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_.  Moreover the string **MUST** be 2 character UPPER case ASCII
alphabetic string that is **NOT** an Unassigned
[ISO 3166-1 alpha-2 code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Decoding_table) value
(not a 2 character symbol with a gray background on that Wikipedia table)

The `soup/location` tool from the [mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry),
when run without arguments, will print the ISO 3166-1 alpha-2 codes that permitted, along with
the location name.

We use the term "location" (and not "country") because some of the
ISO 3166-1 alpha-2 codes belong to locations that are not technically
a country, such as "Antarctica" or a User-assigned code.

If the author wishes to not specify a location, they should select **XX**.


##### email

``` <!---json-->
    "email" : "mame@ruby-lang.org",
```

This _JSON member_ holds the email address of the author, or is the value null.

There **MUST** be one and only one `email` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_ or it **MUST** be a _JSON null_.

If the author wishes to not specify an email address, or if the email address is
unknown, it should be the _JSON null_ as the _JSON value_ of this _JSON member_.
For example:

``` <!---json-->
    "email" : null,
```

**NOTE**: The _JSON null_ is **NOT** enclosed in quotes!


##### url

``` <!---json-->
    "url" : "https://mametter.hatenablog.com",
```

This _JSON member_ holds the URL of the author's home page.

There **MUST** be one and only one `url` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_ or it **MUST** be a _JSON null_.

If the author wishes to not specify a URL or if the URL is
unknown, it should be the _JSON null_ as the _JSON value_ of this _JSON
member_.  For example:

``` <!---json-->
    "url" : null,
```

**NOTE**: The _JSON null_ is **NOT** enclosed in quotes!


##### alt_url

``` <!---json-->
    "alt_url" : null,
```

This _JSON member_ holds an alternate or 2nd URL a home page for the author.

There **MUST** be one and only one `alt_url` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_ or it **MUST** be a _JSON null_.

In some cases the author may wish to record a special URL for their IOCCC entry,
or a 2nd URL such as a work or school or personal home page.  For example,
Cody as of  _Thu Nov 30 23:51:12 UTC 2023_ used:

``` <!---json-->
    "alt_url" : "https://ioccc.xexyl.net",
```

If the author wishes to not specify an alternate URL, or if the alternate URL is
unknown, it should be the _JSON null_ as the _JSON value_ of this _JSON
member_.  For example:

``` <!---json-->
    "alt_url" : null,
```

**NOTE**: The _JSON null_ is **NOT** enclosed in quotes!


##### deprecated_twitter_handle

This _JSON member_ used to hold the twitter handle of the author.

There **MUST** be one and only one `deprecated_twitter_handle` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_ or it **MUST** be a _JSON null_.

The IOCCC no longer is associated with twitter (or whatever someone chooses to call it),
and so the `deprecated_twitter_handle` is **no longer used**.  A _JSON value_ that is
not a _JSON null_ is kept for only historic reasons.  For example, Anthony C. Howe
once used:

``` <!---json-->
    "deprecated_twitter_handle" : "@SirWumpus",
```

If the author wishes to not specify a twitter handle, or if the twitter handle is
unknown, it should be the _JSON null_ as the _JSON value_ of this _JSON member_.
For example:

``` <!---json-->
    "deprecated_twitter_handle" : null,
```

Of course in the future we will not be asking for twitter handles so this means
that unless the winner is a previous winner (before we moved to mastodon) this
will always be `null` anyway.

**NOTE**: The _JSON null_ is **NOT** enclosed in quotes!


##### mastodon

``` <!---json-->
    "mastodon" : "@mame@ruby.social",
```

This _JSON member_ holds the
[Mastodon social network](https://en.wikipedia.org/wiki/Mastodon_&lpar;social_network&rpar;)
handle of the author.

There **MUST** be one and only one `mastodon` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_ or it **MUST** be a _JSON null_.  The _JSON string_ just be a valid
Mastodon handle.  In particular is must start with an at sign (_@_), followed by the
Mastodon username, followed by a 2nd sign (_@_), followed by the Mastodon server instance
used by the author.

For more information in Mastodon, see the [Mastodon help](https://mastodon.help) guide.
See the "Mastodon Address" section of that page in particular.

The IOCCC Mastodon handle is:

``` <!---json-->
    @ioccc@fosstodon.org
```

The IOCCC uses the Mastodon social network for announcements such
as the opening and closing of a new IOCCC, changes to the IOCCC web
site, updates during the judging process, and when new IOCCC entries
are selected.  We recommend you follow us on Mastodon.

If the author wishes to not specify an Mastodon handle, or if the Mastodon handle is
unknown, it should be the _JSON null_ as the _JSON value_ of this _JSON member_.
For example:

``` <!---json-->
    "mastodon" : null,
```

**NOTE**: The _JSON null_ is **NOT** enclosed in quotes!


##### mastodon_url

``` <!---json-->
    "mastodon_url" : "https://ruby.social/@mame",
```

This _JSON member_ holds the URL of the author's Mastodon page.

There **MUST** be one and only one `mastodon_url` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_ or it **MUST** be a _JSON null_.  The _JSON string_ just be a valid URL.
If the `mastodon` handle is a _JSON null_, them the `mastodon_url` **MUST** be a _JSON null_.
If the `mastodon` handle is a _JSON string_, then the `mastodon_url` **MUST** be a _JSON string_.

The `mastodon_url` is just a translation of the above mentioned Mastodon handle.
For example, if the Mastodon handle is:

```
    @user@server.domain
```

Then the `mastodon_url` would be:

```
    https://server.domain/@user
```

If the author wishes to not specify an Mastodon URL, or if the Mastodon URL is
unknown, it should be the _JSON null_ as the _JSON value_ of this _JSON member_.
For example:

``` <!---json-->
    "mastodon_url" : null,
```

**NOTE**: The _JSON null_ is **NOT** enclosed in quotes!

See
FAQ on "[Mastodon](#try_mastodon)"
for more information on Mastodon.


##### github

``` <!---json-->
    "github" : "@mame",
```

This _JSON member_ holds the [GitHub](https://github.com) handle of the author.

There **MUST** be one and only one `github` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_ or it **MUST** be a _JSON null_.  The `github` _JSON string_ **MUST**
start with an at sign (_@_) and **MUST** be a valid GitHub username.

The IOCCC uses GitHub to hold the [official winner repo of the IOCCC](https://github.com/ioccc-src/winner),
and hosts [official IOCCC website](https://www.ioccc.org) on GitHub pages.

The IOCCC GitHub handle is:

```
    @ioccc-src
```

If the author wishes to not specify an GitHub handle, or if the GitHub handle is
unknown, it should be the _JSON null_ as the _JSON value_ of this _JSON member_.
For example:

``` <!---json-->
    "github" : null,
```

**NOTE**: The _JSON null_ is **NOT** enclosed in quotes!


##### affiliation

``` <!---json-->
    "affiliation" : null,
```

This _JSON member_ holds the affiliation of the author.

There **MUST** be one and only one `affiliation` _JSON member_ and the _JSON value_ **MUST**
be a _JSON string_ or it **MUST** be a _JSON null_.

An affiliation might be the name of a school, university, company, or organization.
It is recommended that the affiliation _JSON string_ be the formal affiliation name.
For example, the affiliation for the IOCCC would be:

```
    The International Obfuscared C Code Contest
```

If the author wishes to not specify an affiliation, or if the affiliation is
unknown, it should be the _JSON null_ as the _JSON value_ of this _JSON member_.
For example:

``` <!---json-->
    "affiliation" : null,
```

**NOTE**: The _JSON null_ is **NOT** enclosed in quotes!


##### winning_entry_set
##### entry_id

``` <!---json-->
    "winning_entry_set" : [
        { "entry_id" : "2012_endoh1" },
        { "entry_id" : "2012_endoh2" },
        { "entry_id" : "2013_endoh1" },
    ...
        { "entry_id" : "2020_endoh1" },
        { "entry_id" : "2020_endoh2" },
        { "entry_id" : "2020_endoh3" }
    ]
```

The `winning_entry_set` _JSON member_ holds _JSON array_ containing one or more `entry_id` _JSON member_s.

There **MUST** be one and only one `winning_entry_set` and the  _JSON value_ **MUST**
be a non-empty _JSON array_.  Each value in that _JSON array_ **MUST** must contain
a _JSON member_ whose _JSON name_ **MUST** be "_entry_id_" and those _JSON value_
is a valid entry ID.

Due to the nature of the  _So-called JSON spec_, the last value of the `winning_entry_set`
_JSON array_ cannot end in a comma (_,_).

See
FAQ on "[author_handle.json](#author_json)"
for information about entry ids.

See
FAQ on "[fixing author information](#fix_author)"
for information about how to update
and/or correct IOCCC author information.

Jump to: [top](#)


<div id="find_author_handle">
### Q: How can I find my author handle?
</div>

If you are an _author_ of a winning _entry_, you may find your own _author_handle_
by going to your entry in the [authors.html](authors.html) web page and viewing the string
that follows the _author_handle_: line.

If you are not someone who has won a previous IOCCC, you will be able to select
a potential _author_handle_ when you form your _submission_ tarball (see
FAQ on "[how to submit](#submit)"
).

**Helpful Hint**: If an _author_ clicks on their _author_handle:_
line link, you will be taken to that author's `author_handle.json` file.

For example, [Brian Westley](authors.html#Brian_Westley) can view his
author entry and see that his _author_handle_ is **Brian_Westley**.
Clicking on the _author_handle_ shows the contents of
the [Brian_Westley.json](%%REPO_URL%%/author/Brian_Westley.json) file.

**IMPORTANT NOTE**: An `author` who has won a previous IOCCC is encouraged to reuse their
`author_handle` so that new winning entries can be associated with the same author.

See
FAQ on "[fixing author information](#fix_author)"
for information about how to update
and/or correct IOCCC author information.

See
FAQ on "[author handle](#author_handle_faq)"
for more information about author handles.

See
FAQ on "[author_handle.json](#author_json)"
for information about the contents of these JSON file and
how they are used.

See
FAQ on "[Author, Entry, Submission](#terms)"
for more information on terms such as _author_, _entry_, and _submission_.

Jump to: [top](#)


<!-- we cannot use id="entry_id" because of a header in FAQ 6.6 -->
<div id="entry_id_faq">
### Q: What is an `entry_id`?
</div>

An `entry_id` is a string that identifies a winning entry of the IOCCC.

An `entry_id` is a 4-digit year, followed by an underscore, followed by a directory name.

For example, the `entry_id` associated with Cody Boone Ferguson's 2nd winning IOCCC entry
of 2020 is found under the following directory:

```
    2020/ferguson2
```

The `entry_id` for that winning entry is:

```
    2020_ferguson2
```

Jump to: [top](#)


<div id="entry_json">
### Q: What is a `.entry.json` file and how is it used?
</div>

**TL:DR**: The contents of this JSON file contain information about each winning
entry in JSON format.

Each winning entry has a `.entry.json` file that includes data in JSON format
about the entry. We describe the fields below in order to help you understand
its contents.

This file is created by the [cvt-submission.sh](bin/index.html#cvt-submission)
tool as part of the final steps to announce a new set of winning IOCCC entries.

Each winning entry has its own `.entry.json` filename of the form:

```
    YYYY/winner/.entry.json
```

where _winner_ is the entry directory name, usually the name of the author.

**IMPORTANT NOTE**: this file should **NOT** be manually modified! It is created
by the [csv2entry](bin/index.html#csv2entry) tool when updating the manifest.

#### `.entry.json` JSON file contents

The syntax of a `.entry.json` follows the _So-called JSON spec_.
See <https://www.json.org/json-en.html> for information on the _So-called JSON
spec_.

A good way to understand the JSON file contents of a `.entry.json` file
is to look at an example, for instance the
[1984/laman/.entry.json](%%REPO_URL%%/1984/laman/.entry.json) file, as
it is shorter than some of the others.

As of _Fri 26 Jul 2024 17:29:15 UTC_, it contains:

``` <!---json-->
    {
        "no_comment" : "mandatory comment: because comments were removed from the original JSON spec",
        "entry_JSON_format_version" : "1.2 2024-09-25",
        "award" : "Third Place",
        "year" : 1984,
        "dir" : "laman",
        "entry_id" : "1984_laman",
        "title" : "1984.laman",
        "abstract" : "prints spiralling numbers laid out in columns",
        "author_set" : [
            { "author_handle" : "Mike_Laman" }
        ],
        "manifest" : [
            {
                "file_path" : "laman.c",
                "inventory_order" : 20,
                "OK_to_edit" : true,
                "display_as" : "c",
                "display_via_github" : true,
                "entry_text" : "entry source code"
            },
            {
                "file_path" : "Makefile",
                "inventory_order" : 30,
                "OK_to_edit" : true,
                "display_as" : "makefile",
                "display_via_github" : true,
                "entry_text" : "entry Makefile"
            },
            {
                "file_path" : "laman.orig.c",
                "inventory_order" : 50,
                "OK_to_edit" : false,
                "display_as" : "c",
                "display_via_github" : true,
                "entry_text" : "original source code"
            },
            {
                "file_path" : "try.sh",
                "inventory_order" : 100,
                "OK_to_edit" : true,
                "display_as" : "shellscript",
                "display_via_github" : true,
                "entry_text" : "script to try entry"
            },
            {
                "file_path" : "1984_laman.tar.bz2",
                "inventory_order" : 1415926535,
                "OK_to_edit" : false,
                "display_as" : "tbz2",
                "display_via_github" : false,
                "entry_text" : "download entry tarball"
            },
            {
                "file_path" : ".entry.json",
                "inventory_order" : 4000000000,
                "OK_to_edit" : true,
                "display_as" : "json",
                "display_via_github" : true,
                "entry_text" : "entry summary and manifest in JSON"
            },
            {
                "file_path" : ".gitignore",
                "inventory_order" : 4000000000,
                "OK_to_edit" : true,
                "display_as" : "gitignore",
                "display_via_github" : true,
                "entry_text" : "list of files that should not be committed under git"
            },
            {
                "file_path" : ".path",
                "inventory_order" : 4000000000,
                "OK_to_edit" : false,
                "display_as" : "path",
                "display_via_github" : true,
                "entry_text" : "directory path from top level directory"
            },
            {
                "file_path" : "README.md",
                "inventory_order" : 4000000000,
                "OK_to_edit" : true,
                "display_as" : "markdown",
                "display_via_github" : true,
                "entry_text" : "markdown source for this web page"
            },
            {
                "file_path" : "index.html",
                "inventory_order" : 4294967295,
                "OK_to_edit" : false,
                "display_as" : "html",
                "display_via_github" : false,
                "entry_text" : "this web page"
            }
        ]
    }

```

<div id="walk_through_entry_json">
##### Walk through of a `.entry.json` file
</div>

We now will walk through the above JSON document looking at all the JSON
members:

##### `no_comment`

``` <!--- json-->
    "no_comment" : "mandatory comment: because comments were removed from the original JSON spec",
```

Because the authors of the so-called JSON spec removed the ability to use comments in JSON
(for reason(s) that seem to be less than credible), the IOCCC mandates this _JSON member_
be present in all IOCCC related JSON files.

There **MUST** be one and only one `no_comment` _JSON member_ and the _JSON value_ **MUST**
be the exact _JSON string_ as shown above.

##### `entry_JSON_format_version`

``` <!---json-->
        "entry_JSON_format_version" : "1.2 2024-09-25",
```

This _JSON member_ holds the format version of the `.entry.json` JSON file.

There **MUST** be one and only one `entry_JSON_format_version`
_JSON member_ and the _JSON value_ **MUST** be a _JSON string_.

This is **NOT** the version of the contents!

The `entry_JSON_format_version` would only changed when the overall format
of the these files is modified: and then only those who maintain the
[official IOCCC website](https://www.ioccc.org) would be the one to do this
in conjunction with changes to [bin directory tools](bin/index.html).

##### `award`

``` <!---json-->
    "award" : "Third Place",
```

This JSON string is the award title of the entry which the [Judges](judges.html)
decide/decided when it becomes/became a winning entry.

##### `year`

``` <!---json-->
    "year" : 1984,
```

This JSON number is the year the contest ran, ended or was announced in.

##### `dir`

``` <!---json-->
    "dir" : "laman",
```

This JSON string is the subdirectory of the entry, **under** the year directory,
in this case [1984](1984/index.html). With the above member, `year`, and this
one, one can determine the directory of the entry, here being
[1984/laman](1984/laman/index.html).

##### `entry_id`

``` <!---json-->
    "entry_id" : "1984_laman",
```

This is the ID of the entry in question and corresponds to the `entry_id` in the
`author/author_handle.json` file.

See
FAQ on "[author handle](#author_handle_faq)"
for more information about author handles.

See
FAQ on "[author_handle.json](#author_json)"
for information about the contents of these JSON file and
how they are used.


##### `title`

The `title` for an entry's `.entry.json` file defaults to
"`YYYY/dirname`".  The `title` is not used at this time.

For IOCCC winning entries after 2020, the `title` is obtained from the
`.info.json` file with the entry was a submission.

See the
FAQ on "[.info.json](#info_json)"
for more information on `.info.json` files.


##### `abstract`

The `abstract` is a summary of the entry.  The `abstract` is used as a
head line in an entry's `index.html` file.

For IOCCC winning entries after 2020, the `abstract` is obtained from the
`.info.json` file with the entry was a submission.

See the
FAQ on "[.info.json](#info_json)"
for more information on `.info.json` files.


##### `author_set`


``` <!---json-->
    "author_set" : [
        { "author_handle" : "Mike_Laman" }
    ],
```

This JSON **array** has a list of `author_handle`s that indicate who won this
entry.

That _JSON member_ holds the author handle of the author.

In most cases there is only one `author_handle` in a `.entry.json` file but in
some there is more than one.

See
FAQ on "[author handle](#author_handle_faq)"
for more information about an author handles.

Normally the `author_handle` _JSON value_ should **NOT** be changed
**unless there is a strong reason to do so**.  If the  _JSON value_
changes, then all of the `.entry.json` files for all of this author's
winning IOCCC entries should also be changed.  The `author_handle`
_JSON value_ must match the basename (without the leading path and
without the trailing `.json`) of the `author_handle.json` file.  So
a change of `author_handle` _JSON value_ would also require the
`author_handle.json` file to also be renamed.

The full name of an author may use non-ASCII characters so long as the
full name is properly encoded as a _JSON string_.

##### `manifest`

Finally there is the manifest JSON **array** that lists the files of the winning
entry. Because each array member (a file) has the same fields we will only list
one of the files in the manifest, providing comments about each field. After
that we will list some files that are mandatory files, also with comments.

There **MUST** be one and only one `manifest` _JSON member_ and the _JSON value_
**MUST** be a _JSON_ array.

A shortened manifest for our example entry is:

``` <!---json-->
    "manifest" : [
        {
            "file_path" : "laman.c",
            "inventory_order" : 20,
            "OK_to_edit" : true,
            "display_as" : "c",
            "display_via_github" : true,
            "entry_text" : "entry source code"
        }
    ]
```


Now we will describe each field of each file in the manifest:

- `file_path` (string)
    * This _JSON_ **string** is the name of the file in question.

- `inventory_order` (number)
    * This _JSON_ **number** decides which file list in the `index.html` file this
    file is listed and its order in that list. The details are beyond the scope
    of this document and it is only necessary to understand this if you are
    adding a file to the manifest. However as the [Judges](judges.html) are the
    ones who will be doing this this need not concern you.

- `OK_to_edit` (boolean)
    * This _JSON_ **boolean** indicates whether this file should be modified,
    edited, replaced, or even removed directly.

    If `true` then a modification (i.e., edit) of the file, replacement of the file,
    or even removal os the file would be welcome via a pull request.

    See the
    FAQ on "[GitHub pull request](#pull_request)"
    for more information about pull requests.

    If `false`, then the file almost certainlty should **NOT** be modified
    (i.e., edited), replaced or removed.  Submitting a pull request that impacts
    such a `false` `OK_to_edit` file is likely to cause the pull request
    to be modifed or rejected.

    **IMPORTANT NOTE**: In most all cases, `OK_to_edit` should be set to `true`.
    There are only a few cases when `OK_to_edit` needs to be `false` that are documented below:

    * **Reason for `OK_to_edit == false` # 0**:

    The file is original source code file.

    Modifications of the **original source code** is only permitted it can
    be shown at the file is not the true **original source code**.

    See the
    FAQ on "[original source code](#original_source_file)"
    for more information including how to open an [IOCCC issue](https://github.com/ioccc-src/winner/issues)
    if you believe the **original source code** is not a true original.

    * **Reason for `OK_to_edit == false` # 1**:

    The HTML file is generated by a [set of tools and scripts](bin/index.html)(including a related `Makefile` rule).

    Modifing HTML files that contain comments such as "_DO NOT MODIFY THIS FILE ..._"
    or "_Do not modify this web page ..._" will not have the desired effect
    because any modications will be overridden when the [set of tools and scripts](bin/index.html)
    (includeing a related `Makefile` rule).

    In order to properly change a generated HTML file, files such as a markdown file
    (often `README.md`) and/or sometimes JSON files (such as `.entry.json` or
    the `author/author_handle.json` JSON files)

    See the
    FAQ on "[fix web site](#fix_web_site)"
    for information on submitting fixes to the IOCCC website.

    See the
    FAQ on "[update IOCCC author information](#fix_author)"
    for information how to modify `author/author_handle.json` JSON files.

    * **Reason for `OK_to_edit == false` # 2**:

    The file is a compressed tarball for an entry or set of entries for a given IOCCC year.

    Compressed tarball files are provided as a conveience for those who wish th download
    an IOCCC entry or all IOCCC entries for a given IOCCC year.  These files are generate
    by [set of tools and scripts](bin/index.html)(including a related `Makefile` rules).

    Instead of trying to modify a compressed tarball, individual files that make
    up the compressed tarball should be modified instead.  When you pull request to modify
    such individual files, the [IOCCC judges](judges.html) will run the appropriate
    [set of tools and scripts](bin/index.html) to update the compressed tarballs as needed.

    * **Reason for `OK_to_edit == false` # 3**:

    The file is a `.path` file.

    As the `.path` file is related to the path of the entry under an IOCCC year,
    this file should be consider as **read-only**.

    If you believe a `.path` file is in error, then please open up an
    [IOCCC issue](https://github.com/ioccc-src/winner/issues).

    See the
    FAQ on "[.path files](#dot_path)"
    for more information on `.path` files.

    See also the
    FAQ on "[fixing an entry](#fix_an_entry)"
    for information on opening up an IOCCC issue.

    * **Reason for `OK_to_edit == false` # 4**:

    There is some rare case or reason we forgot to document.

    The reasons previously listed for why the `OK_to_edit` set to `false` may be incomplete,
    or there is some special rare case.  More likely, however, if some other file has
    `OK_to_edit` set to `false`, is a mistake.

    If you believe if `OK_to_edit` has the wrong value, please open a GitHub pull request.

    See the
    FAQ on "[GitHub pull request](#pull_request)"
    for more information about pull requests.

- `display_as` (string)
    * This _JSON_ **string** describes what kind of file it is and in particular
    how to **display** it. An entry source code file would be (all strings are
    lower case) `c`, a shell script would be `shellscript` and a `Makefile`
    would be `makefile`, for three examples of others. As updating the manifest
    is mostly a task for the [Judges](judges.html) you need not concern yourself
    with all the different names.

- `display_via_github` (boolean)
    * This _JSON_ **boolean** indicates whether the file should be viewed at
    (that is linked to) GitHub or not. A good reason it might be viewed at
    GitHub is for syntax highlighting or if it should not be downloaded but
    would likely be downloaded by the browser otherwise.

- `entry_text` (string)
    * This _JSON_ **string** is a short string that gives a summary of what the
    file is, for purposes of the file lists in the `index.html` inventory.

Now that we have discussed the _JSON members_ of each file in the `manifest` we
will give a list of **MANDATORY** files (for winning entry source code the names
will depend on the year).

- the entry source code
    * This file is typically called `winner.c`, where `winner` is as described
    above, or `prog.c` (for later years). The `entry_text` is always `"entry
    source code"`.

- the entry Makefile
    * This is the submission's Makefile **modified** by the [Judges](judges.html),
    should the submission win. The `entry_text` is always `"entry Makefile"` and
    the `file_path` is **ALWAYS** `"Makefile"`.

- the original source code file
    * This is the entry source code file that was submitted and that won. This
    will be named either `winner.orig.c` or `prog.orig.c`, depending on the
    year. This file may **NOT** be modified. The `entry_text` for this file is
    always `"original source code"`.

    See the
    FAQ on "[original source code](#original_source_code)"
    for more information.

- the [entry tarball](#tarball)
    * This is the tarball of just the top level Makefile (and those included by
    it) and the entry itself, for convenience. It is named in the form of
    `YYYY_winner.tar.bz2`. For instance, for [1984/laman](1984/laman/index.html)
    it is called `1984_laman.tar.bz2`. This file is **NOT** displayed via
    GitHub. The `entry_text` is always `download entry tarball` as it is a file
    that is to be downloaded, should one wish to.

- [.entry.json](#entry_json) file
    * This is the file we're currently discussing, the `.entry.json` file. The
    `entry_text` is always `"entry summary and manifest in JSON"` and the
    `file_path` is **ALWAYS** `".entry.json"`.

- `.gitignore`
    * The list of files that should not be committed under git. Its `entry_text`
    is always `"list of files that should not be committed under git"` and the
    `file_path` is **ALWAYS** `".gitignore"`.

- `.path`
    * This file contains the path to the entry subdirectory from the top level
    directory. For instance for [1984/laman](1984/laman/index.html) it is
    `"1984/laman"`. This file's `entry_text` is always `"directory path from top
    level directory"` and the `file_path` is **ALWAYS** `".path"`.

- `README.md`
    * This file is the markdown source file for the `index.html` file. Its
    `entry_text` is always `"markdown source for this web page"` (because it is
    listed in `index.html`) and the `file_path` is **ALWAYS** `"README.md"`
    (renamed from the `remarks.md` provided in submissions).

    In most cases, if the entry has other html files then they are also formed
    from markdown files and the `entry_text` will be similar; the `file_path` in
    these cases will be the same as the html file except it will have the
    extension `.md`.

- `index.html`
    * This is the main page of the entry, formed from the `README.md` file. Its
    `entry_text` is always `"this web page"` and its `file_path` is **ALWAYS**
    `"index.html"`.


If the entry has an alternate source code file, often it will be in the form of
`"winner.alt.c"` or `"prog.alt.c"`; this is also what the `file_path` will be.
The `entry_text` will typically (not always but almost always) be `"alternate
source code"`.

Many entries have a script (or scripts) for the `Try` section in their index.html file.
Usually this is called `try.sh` for the entry and `try.alt.sh` for the alternate
source code (if there is an alternate version). Some, however, have another file
name. The `entry_text` for the `try` scripts will be `script to try entry` or
something along those lines.

Jump to: [top](#)


<div id="validating_json">
<div id="jparse">
### Q: How can I validate any JSON document?
</div>
</div>

If you want or need to verify that a JSON document (as a string or file) is
valid, you can use the
[jparse](https://github.com/ioccc-src/mkiocccentry/blob/master/jparse/README.md)
tool. The IOCCC version of the `jparse(1)` tool may be installed from the
[mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry).

The [FAQ.md file in the mkiocccentry
repo](https://github.com/ioccc-src/mkiocccentry/blob/master/FAQ.md#download)
contains information about how to find and compile the mkiocccentry
toolkit, which includes the IOCCC version of the `jparse(1)` tool, located
under the `mkiocccentry` directory as `jparse/jparse`.

Additionally you may install the `jparse(1)` tool from the [jparse
repo](https://github.com/xexyl/jparse):

``` <!--sh-->
    git clone https://github.com/xexyl/jparse.git
    cd jparse
    make clobber all test
    sudo make install
```

The syntax of `jparse(1)` is very simple:


``` <!--sh-->
    jparse foo.json
```

If the tool exits 0 then the document is valid JSON; otherwise it'll
show an error message.

If you want to see more information about the parsing you can increase the
verbosity with the `-v` option. For instance:

``` <!--sh-->
    jparse -v 3 foo.json
```

If the tool is not installed then you will obviously have to specify the path of
the tool.

Jump to: [top](#)

<hr style="width:50%;text-align:left;margin-left:0">
<hr style="width:50%;text-align:left;margin-left:0">


<div id="compiling">
## Section 4: Compiling IOCCC entries
</div>

Jump to: [top](#)


<div id="make_rules">
<div id="makefile_rules">
### Q: What Makefile rules are available to build or clean up IOCCC entries?
</div>
</div>

In general the best way to compile everything in an entry directory is to run:

``` <!---sh-->
    make clobber all
```

If you wish to compile every entry for every year you should go to the top level
directory and run the same command as above, `make clobber all`.

The `all` rule will build everything necessary except for the alternate
versions. Every Makefile has an `alt` rule but it will only do something if an
alternate version exists. To build all the entries along with any alternate code
you can do from the top level directory:

```
    make clobber everything
```

If you wish to only build alternate code you can do:

``` <!---sh-->
    make clobber alt
```

If you wish to not remove the entry binaries and only compile the additional alt
versions:

``` <!---sh-->
    make alt
```

The following Makefile rules should be in all Makefiles:

- all: build the entry programs (main program and any supplementary program)
- alt: build alternate code
- clobber: clean up object files and all binary files (except for those that are
not compiled)
- clean: a simpler version of `clobber` that only removes object files. `make
clobber` depends on `clean` so running `make clobber` will invoke `make clean`.
- everything: equivalent to `make all alt`.

Are there any other rules? You tell us!

The top level and the year (e.g. `1984/Makefile`, `1985/Makefile` etc.)
`Makefile`s recurse into the subdirectories for each entry so you can compile
individual entries, entries of a given year or all entries, based on what you
wish to do.

NOTE about the above rules: the Makefile default assumes `cc` which might be a
gcc-based compiler, or a clang-based compiler, or some other compiler. Only by
forcing `CC=clang` or `CC=gcc` will one invoke a specific compiler to, say,
enable or disable additional warnings or flags. Even so different versions or
compilers might do different things, have different defects or other issues.
Note that the `Makefile`s check the `CC` variable by substrings so that if you
were to do something like `make CC=gcc=mp-12` it would register as `gcc`.

Jump to: [top](#)


<div id="make_compatibility">
<div id="gnu_make">
<div id="gmake">
### Q: What kind of make&lpar;1&rpar; compatibility does the IOCCC support and will it support other kinds?
</div>
</div>
</div>

For the [IOCCC](https://www.ioccc.org) [mkiocccentry submission
toolkit](https://github.com/ioccc-src/mkiocccentry) and the [winning IOCCC
entries](years.html) we support *ONLY* GNU Makefile syntax. This means that if
you only have Cygwin or a BSD `make(1)` (often `bmake(1)`) or some other
`make(1)` utility the Makefiles we use will not be compatible.

We do not intend on supporting anything but the GNU `make(1)` utility so if you
do not currently have it installed you will have to do that in order to compile
entries for the IOCCC. If you are submitting an entry this will also be
necessary.

If you do not have GNU `make(1)` you might look for `gmake` as that is what it
often is packaged as. Then you can use `gmake` instead. For instance if you go
to the top level directory of the winner repo you can do:

``` <!---sh-->
    gmake
```

In the case that the Makefile uses the `MAKE` variable you will have to override
it like:

``` <!---sh-->
    gmake MAKE=gmake
```

though of course for both you may specify a rule or rules to run.

Jump to: [top](#)

<hr style="width:50%;text-align:left;margin-left:0">
<hr style="width:50%;text-align:left;margin-left:0">


<div id="dependencies">
## Section 5: Dependencies for some IOCCC entries
</div>

Jump to: [top](#)


<div id="X11macOS">
<div id="X11">
### Q: How do I compile and run an IOCCC entry that requires X11?
</div>
</div>


<div id="X11_general">
#### Generally, to compile and run an IOCCC entry that requires X11:
</div>

You must have the X11 related include files and X11 libraries in order to
compile the IOCCC entry. In order to do this you will need to install Xorg and
related packages including development related packages. If you have macOS see
further down for different instructions. Otherwise: in particular you must:

* Install the Xorg server.
* Configure the Xorg server for your graphics environment.
* Install a X11 terminal application.
* Start the Xorg server.
* Launch the X11 terminal application.
* Run the IOCCC entry in the X11 terminal application.

By X11 terminal application we suggest one of:

* [Gnome](https://www.gnome.org) terminal application
* [KDE](https://kde.org) terminal application
* `xterm(1)` terminal application

See below for various system related hints that may be of help.


<div id="Xorg_deprecated">
#### X.org server has been deprecated
</div>

The Red Hat RHEL9.0 release notes state that [X.org Server is now
deprecated](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/9.0_release_notes/deprecated_functionality#deprecated-functionality_graphics-infrastructures).

According to this [Linux for Devices tutorial on
XOrg](https://www.linuxfordevices.com/tutorials/linux/install-xorg-on-linux) as
of 2023 Mar 25:


> Recently, RHEL developers categorized [Xorg was put in the ‘deprecated’
software](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/9.0_release_notes/deprecated_functionality),
as its development has mostly halted. Subsequent updates will completely replace
it with Wayland, a more modern windowing system.. Although Wayland is not fully
developed yet, many applications do not support it properly yet and screen
sharing might not work sometime, but it is the future. Fedora, also developed by
RHEL, has switched to a Wayland session as it’s default windowing system (And it
works flawlessly on my Laptop).

See the [Wayland](https://wayland.freedesktop.org) website for more details.

**IMPORTANT NOTE**: We do **NOT** know if IOCCC entries will run under
**Wayland**.  Some IOCCC entries that use X11 might be OK while other IOCCC
entries that use X11 in an unusual way might fail under **Wayland**.


See the [Wayland FAQ](https://wayland.freedesktop.org/faq.html) for more
information.

If your system uses **Wayland** and not X11, you might give the IOCCC entries
that use X11 a try.  They might work but again we do not know.

**IMPORTANT NOTE**: The [IOCCC judges](judges.html) **do not support IOCCC entries**.
See the
FAQ on "[no entry support](#no_support)".
So if an IOCCC entry that uses X11 fails under **Wayland**, and you wish to
provide a fix to the IOCCC entry so that it will run under **Wayland**,
then consider submitting a fix so that it will run under **Wayland**.
See the
FAQ on "[fixing an entry](#fix_an_entry)"
for more information.

Basically: if you discover an entry does not work in Wayland you are welcome to
provide **alternate code** that works for Wayland. We will happily credit you in
the [thanks-for-help.html](thanks-for-help.html) file.


#### Red Hat based Linux

First, see the
FAQ on "[general X11](#X11_general)".

Install Xorg and related packages:

``` <!---sh-->
    sudo dnf install --skip-broken --best --exclude xorgxrdp \
    --exclude xorgxrdp-glamor '*xorg*' 'libx*' 'libX*' 'fontconfig*'
```

See also:

* [How to Configure X11 in Linux](https://www.wikihow.com/Configure-X11-in-Linux)

**IMPORTANT NOTE**: The X.org server has been deprecated.
See the
FAQ on "[X.org deprecated](#Xorg_deprecated)"
for more information.


#### macOS

First, see the
FAQ on "[general X11](#X11_general)".
However, for macOS, instead of installing the Xorg server, you need to install and launch
the [most recent XQuartz](https://www.xquartz.org) application
and then run the IOCCC entry from the [Xterm window
shell](https://en.wikipedia.org/wiki/Xterm).

As an example we will use [1993/jonth](1993/jonth/index.html) which works
with macOS 14.2.1 (macOS Sonoma).

First of all you will need to install the [most recent
XQuartz](https://www.xquartz.org), preferably on an [Apple supported version of
macOS, preferably the most recent version](https://support.apple.com/macOS).
After it is installed, open the "XQuartz" application (usually located in
`/Applications/Utilities/XQuartz.app`) by typing at the command line:

``` <!---sh-->
    open /Applications/Utilities/XQuartz.app
```

With the "XQuartz" application open you will get an [X Window System
Manager](https://www.x.org/wiki/) launched with an [Xterm window
shell](https://en.wikipedia.org/wiki/Xterm) started:

<img alt="xterm-launch in macOS" src="png/xquartz-shell.png">

At this point you need to cd to the winning directory and compile it. For example:

<img alt="compiling an entry in xterm in macOS" src="png/xquartz-entry-compile.png">

And then run the program as directed by the `index.html` file. For example with
`1993/jonth`:

<img alt="running 1993/jonth in macOS" src="png/xquartz-1993-jonth.png">

Note that you can compile the code in your regular terminal prior to opening
XQuartz, should you wish to. You can even run it from that terminal and it
should open XQuartz.

**IMPORTANT NOTE**: The X.org server has been deprecated.
See the
FAQ on "[X.org deprecated](#Xorg_deprecated)"
for more information.


#### Debian based Linux

First, see the
FAQ on "[general X11](#X11_general)".

According to the [Debian Xorg wiki](https://wiki.debian.org/Xorg), installing
X11 requires:

``` <!---sh-->
    sudo apt install xorg
```

**IMPORTANT NOTE**: The X.org server has been deprecated.
See the
FAQ on "[X.org deprecated](#Xorg_deprecated)"
for more information.


#### Other Linux distributions

First, see the
FAQ on "[general X11](#X11_general)".

For general documentation on installing  X11, this [ServerGUI for
Ubuntu](https://help.ubuntu.com/community/ServerGUI), and in particular, these
may be helpful:

* [X11 Client Installation](https://help.ubuntu.com/community/ServerGUI#X11_Client_Installation)
* [X11 Server Installation](https://help.ubuntu.com/community/ServerGUI#X11_Server_Installation)
* [Full Desktop Environments](https://help.ubuntu.com/community/ServerGUI#Full_Desktop_Environments)

See also:

* [How to Configure X11 in Linux](https://www.wikihow.com/Configure-X11-in-Linux)

For systems that have the `dnf(1)` command:

``` <!---sh-->
    sudo dnf install --skip-broken --best --exclude xorgxrdp \
    --exclude xorgxrdp-glamor '*xorg*' 'libx*' 'libX*' 'fontconfig*'
```

For systems that have the `yum(1)` command:

``` <!---sh-->
    sudo yum install --skip-broken --best --exclude xorgxrdp\
    --exclude xorgxrdp-glamor '*xorg*' 'libx*' 'libX*' 'fontconfig*'
```

**IMPORTANT NOTE**: The X.org server has been deprecated.
See the
FAQ on "[X.org deprecated](#Xorg_deprecated)"
for more information.


#### Package website

First, see the
FAQ on "[general X11](#X11_general)".

See the [X.org](https://x.org/wiki/) foundation website.

**IMPORTANT NOTE**: The X.org server has been deprecated.
See the
FAQ on "[X.org deprecated](#Xorg_deprecated)"
for more information.

Jump to: [top](#)


<div id="SDL">
### Q: How do I compile and install SDL1 or SDL2 for entries that require it?
</div>

This depends on your operating system but below are instructions for Linux and
macOS with alternative methods for macOS and different package managers with Linux.


#### Red Hat based Linux

Execute the following as root or via sudo:

``` <!---sh-->
    dnf install SDL2 SDL2-devel sdl12-compat sdl12-compat-devel
```

Older RHEL distributions might have to use "yum" instead of "dnf"
in the above command.

In the past it was said that one might need to run `make` like:

``` <!---sh-->
    make ... SDL2_INCLUDE_ROOT=/usr
```

or set the following environment variable:

``` <!---sh-->
    export SDL2_INCLUDE_ROOT=/usr
```

but this might not be necessary in more modern days especially as we use
`sdl-config` and `sdl2-config` which should find the proper paths.


<div id="X11macos">
#### macOS
</div>

If you're using macOS there are at least three ways to obtain it. You can
use Homebrew or MacPorts.  If you do not wish to use either of those
package managers, you can always try to install via the package website.
For macOS we do recommend using Homebrew or MacPorts instead of using
the package website.


##### macOS via Homebrew

If you have not already done so, install [Homebrew](https://brew.sh).

Then to install SDL and SDL2, execute the following command:

``` <!---sh-->
    brew install sdl2 sdl12-compat
    eval "$(opt/homebrew/bin/brew shellenv)"
```


##### macOS via MacPorts

If you haven't already, install
[MacPorts](https://www.macports.org/install.php). Then run:


``` <!---sh-->
    sudo port install libsdl libsdl2
```


#### Debian based Linux

Execute the following as root or via sudo:

``` <!---sh-->
    apt install libsdl1.2debian libsdl1.2-dev libsdl2-dev
```

and then try `make all` again.

In the past it was said that one might need to run `make` like:

``` <!---sh-->
    make ... SDL2_INCLUDE_ROOT=/usr
```

or set the following environment variable:

``` <!---sh-->
    export SDL2_INCLUDE_ROOT=/usr
```

but this might not be necessary in more modern days especially as we use
`sdl-config` and `sdl2-config` which should find the proper paths.


#### Other Linux distributions

Use your package manager to install the appropriate packages. Try the search
feature of the package manager to determine which packages you need to install.
Note that you might have to install both the library and the developmental
packages: one for compiling and one for linking / running.


#### Package website

Go to the [SDL website](https://www.libsdl.org) and follow their instructions
for downloading, installing and using SDL.

We recommend trying a method suitable for your environment first, if possible.


#### NOTE: there might be extra SDL packages required

In the case that some entries do not work even with SDL1/SDL2 installed it might
be that you need additional SDL libraries. See the entry's index.html for
details. If something is not noted you're welcome to report it as an issue or
fix it and make a pull request.

See the
FAQ on "[GitHub pull request](#pull_request)"
for more information about pull requests.

Jump to: [top](#)


<div id="curses">
### Q: How do I compile and install &lpar;n&rpar;curses for entries that require it?
</div>

This depends on your operating system but below are instructions for Linux and
macOS with alternative methods for macOS and different package managers with Linux.


#### Red Hat based Linux

Execute the following as root or via sudo:

``` <!---sh-->
    dnf install ncurses ncurses-devel
```


#### macOS

With macOS it should already be installed. If it is not you might have to do:

``` <!---sh-->
    xcode-select --install
```

and agree to the terms and conditions and proceed with the install.


##### macOS via Homebrew

Not applicable, see above.


##### macOS via MacPorts

Not applicable, see above.


#### Debian based Linux

Execute the following as root or via sudo:

``` <!---sh-->
    apt install libncurses6
```

and then try `make all` again.


#### Other Linux distributions

Use your package manager to install the appropriate packages. Try the search
feature of the package manager to determine which packages you need to install.
Note that you might have to install both the library and the developmental
packages: one for compiling and one for linking / running.


#### Package website

Go to the [ncurses website](https://invisible-island.net/ncurses/) and follow their instructions
for downloading, installing and using ncurses.

We recommend trying a method suitable for your environment first, if possible.

Jump to: [top](#)


<div id="sox">
<div id="sound">
### Q: How do I compile and run an IOCCC entry that requires sound?
</div>
</div>

This might depend on the entry but most likely the Swiss Army Knife of sound
processing programs, [SoX](https://sox.sourceforge.net), will work. How to
install depends on your OS. See below.

After it is installed, you should be able to compile and use the program as
described in the index.html file.

#### Red Hat based Linux

As root or via sudo:

``` <!---sh-->
    dnf install -y sox sox-devel
```

#### macOS

For macOS there are two well known options.

##### macOS via Homebrew

If you have not already done so, install [Homebrew](https://brew.sh).

Then to install SoX, execute the following command:

``` <!---sh-->
    brew install sox
    eval "$(opt/homebrew/bin/brew shellenv)"
```


##### macOS via MacPorts

If you haven't already, install
[MacPorts](https://www.macports.org/install.php). Then run:


``` <!---sh-->
    sudo port install sox
```


#### Debian based Linux

Usually the index.html file will explain how to use it under Debian so we do not
include this here, at least for now.


#### Package website

Not applicable, see above.


#### Other Linux distributions

Usually the index.html file will explain how to use it under Linux so we do not
include this here, at least for now.

Jump to: [top](#)


<div id="tcpserver">
### Q: - How do I compile and install tcpserver for entries that require it?
</div>

If your OS package manager does not have the package `tcpserver` you can
download, making sure you're in a temporary directory, and compile the source
like:

``` <!---sh-->
    wget http://cr.yp.to/ucspi-tcp/ucspi-tcp-0.88.tar.gz
    tar ucspi-tcp-0.88.tar.gz
    cd ucspi-tcp-0.88
    make
```

Then as root or via `sudo(1)` enter:

``` <!---sh-->
    make setup check
```

That will install it to `/usr/local/bin`. Now you should be able to use the
entry in question.

Jump to: [top](#)


<div id="netpbm">
### Q: How do I compile and install netpbm for entries that require it?
</div>

This depends on your operating system for which we describe a couple below.


#### Red Hat based Linux

Execute the following as root or via sudo:

``` <!---sh-->
    dnf install netpbm-progs netpbm
```

Older RHEL distributions might have to use "yum" instead of "dnf"
in the above command.


#### macOS


If you're using macOS there are at least three ways to obtain it. You can
use Homebrew or MacPorts.  If you do not wish to use either of those
package managers, you can always try to install via the package website.
For macOS we do recommend using Homebrew or MacPorts instead of using
the package website.


##### macOS via Homebrew

If you have not already done so, install [Homebrew](https://brew.sh).

Then to install netpbm, execute the following command:

``` <!---sh-->
    brew install netpbm
```


##### macOS via MacPorts

If you haven't already, install
[MacPorts](https://www.macports.org/install.php). Then run:


``` <!---sh-->
    sudo port install libnetpbm netpbm
```


#### Debian based Linux

Execute the following as root or via sudo:

``` <!---sh-->
    apt install netpbm
```

and then try `make all` again.


#### Other Linux distributions

Use your package manager to install the appropriate packages. Try the search
feature of the package manager to determine which packages you need to install.
Note that you might have to install both the library and the developmental
packages: one for compiling and one for linking / running.


#### Package website

Go to the [netpbm website](https://netpbm.sourceforge.net) and follow their instructions
for downloading, installing and using netpbm.

We recommend trying a method suitable for your environment first, if possible.

Jump to: [top](#)


<div id="libjpeg">
### Q: How do I compile and install libjpeg-turbo for entries that require it?
</div>

This depends on your operating system for which we describe a couple below.


#### Red Hat based Linux

Execute the following as root or via sudo:

``` <!---sh-->
    dnf install libjpeg-turbo-utils libjpeg-turbo-devel libjpeg-turbo
```

Older RHEL distributions might have to use "yum" instead of "dnf"
in the above command.


#### macOS

If you're using macOS there are at least three ways to obtain it. You can
use Homebrew or MacPorts.  If you do not wish to use either of those
package managers, you can always try to install via the package website.
For macOS we do recommend using Homebrew or MacPorts instead of using
the package website.


##### macOS via Homebrew

If you have not already done so, install [Homebrew](https://brew.sh).

Then to install libjpeg-turbo, execute the following command:

``` <!---sh-->
    brew install libjpeg-turbo
```


##### macOS via MacPorts

If you haven't already, install
[MacPorts](https://www.macports.org/install.php). Then run:


``` <!---sh-->
    sudo port install libjpeg-turbo libjpeg-turbo-devel
```


#### Debian based Linux

Execute the following as root or via sudo:

``` <!---sh-->
    apt install libturbojpeg0 libturbojpeg0-dev
```

and then try `make all` again.


#### Other Linux distributions

Use your package manager to install the appropriate packages. Try the search
feature of the package manager to determine which packages you need to install.
Note that you might have to install both the library and the developmental
packages: one for compiling and one for linking / running.


#### Package website

Go to the [libjpeg-turbo website](https://www.libjpeg-turbo.org) and follow their instructions
for downloading, installing and using libjpeg-turbo.

We recommend trying a method suitable for your environment first, if possible.

Jump to: [top](#)


<div id="imagemagick">
### Q: How do I compile and install ImageMagick for entries that require it?
</div>

This depends on your operating system for which we describe a couple below.


#### Red Hat based Linux

Execute the following as root or via sudo:

``` <!---sh-->
    dnf install ImageMagick
```

Older RHEL distributions might have to use "yum" instead of "dnf"
in the above command.


#### macOS

If you're using macOS there are at least three ways to obtain it. You can
use Homebrew or MacPorts.  If you do not wish to use either of those
package managers, you can always try to install via the package website.
For macOS we do recommend using Homebrew or MacPorts instead of using
the package website.


##### macOS via Homebrew

If you have not already done so, install [Homebrew](https://brew.sh).

Then to install ImageMagick, execute the following command:

``` <!---sh-->
    brew install ImageMagick
```


##### macOS via MacPorts

If you haven't already, install
[MacPorts](https://www.macports.org/install.php). Then run:


``` <!---sh-->
    sudo port install ImageMagick
```


#### Debian based Linux

Execute the following as root or via sudo:

``` <!---sh-->
    apt install imagemagick
```

and then try `make all` again.


#### Other Linux distributions

Use your package manager to install the appropriate packages. Try the search
feature of the package manager to determine which packages you need to install.
Note that you might have to install both the library and the developmental
packages: one for compiling and one for linking / running.


#### Package website

Go to the [ImageMagick website](https://imagemagick.org) and follow their instructions
for downloading, installing and using ImageMagick.

We recommend trying a method suitable for your environment first, if possible.

Jump to: [top](#)


<div id="OpenGL">
### Q: How do I compile and install OpenGL for entries that require it?
</div>

This depends on your operating system for which we describe a couple below.

In general OpenGL needs X11 to be installed and the X Window Server to be running.  See the
FAQ on "[X11](#X11)"
for general information about X11.

Once X11 is install and the X Window Server is running, one needs to compile
and link with the two libraries, _GL_ and _GLU_:

``` <!---sh-->
    cc ... -lGL -lGLU -L _location-where-X11-libs-are-installed_ -lX11
```

**NOTE**: The OpenGL development effort is being managed by [vulkan.org](https://vulkan.org).
We suggest you check out their resource for further information on OpenGL.


#### Red Hat based Linux

Execute the following as root or via sudo:

``` <!---sh-->
    sudo dnf install glew-devel SDL2-devel SDL2_image-devel glm-devel freetype-devel
```

See [OpenGL Programming/Installation/Linux](https://en.wikibooks.org/wiki/OpenGL_Programming/Installation/Linux) for details.

Older RHEL distributions might have to use "yum" instead of "dnf"
in the above command.


#### macOS

In the past, macOS has come with OpenGL pre-installed.  However as of macOS 10.14,
[OpenGL has been deprecated on macOS](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/OpenGL-MacProgGuide/opengl_intro/opengl_intro.html) (in favor of Metal).

As long as Apple continues to ship OpenGL pre-installed and it works, you
should be able to go.  However in Apple drops support for OpenGL later on,
you might look to install OpenGL via Homebrew or MacPorts.


#### Debian based Linux

Execute the following as root or via sudo:

``` <!---sh-->
    sudo apt-get install libglew-dev libsdl2-dev libsdl2-image-dev libglm-dev libfreetype6-dev
```

and then try `make all` again.

See [OpenGL Programming/Installation/Linux](https://en.wikibooks.org/wiki/OpenGL_Programming/Installation/Linux) for details.


#### Other Linux distributions

Use your package manager to install the appropriate packages. Try the search
feature of the package manager to determine which packages you need to install.
Note that you might have to install both the library and the developmental
packages: one for compiling and one for linking / running.


#### Package website

Go to the [Vulkan website](https://vulkan.org) and follow their instructions
for downloading, installing and using OpenGL.

We recommend trying a method suitable for your environment first, if possible.

Jump to: [top](#)


<div id="entry_downloads">
<div id="download">
### Q: How do I download individual winning entries or all winning entries of a given year?
</div>
</div>

Although one can clone the entire [winner
repo](https://github.com/ioccc-src/winner) to get the entire website and all
entries, we also provide, as a convenience, a way to download individual entries
as well as a way to download a year's winning entries.

Please note that some of the links in the html files will not work! This is
because you are not downloading the full website. If you want to view the entry
with links intact you should clone the repo or view it on the [official IOCCC
website](https://www.ioccc.org) instead.


#### Individual winning entry tarballs

The individual entry tarballs are named in the form of
`YYYY/winner/YYYY_winner.tar.bz2` (e.g.
[1984/mullender/1984_mullender.tar.bz2](1984/mullender/1984_mullender.tar.bz2))
and they contain a single entry as well as some additional necessary files. Each
entry tarball is linked to in its `index.html` (e.g.
[1984/mullender/index.html](1984/mullender/index.html)) manifest, listed in the
_Secondary files_ list.

These tarballs will have the following files:

- `ioccc.css`                                   - stylesheet for the html files
- `var.mk`                                              - the top level Makefile included by all the other Makefiles that holds variables used by the Makefiles
- `YYYY/winner/.path`                   - directory path from top level directory
- `YYYY/winner/.entry.json`             - entry summary and manifest in JSON
- `YYYY/winner/.gitignore`              - list of files that should not be committed under git

plus the winning entry files like source code, the Makefile, supplementary data
provided by the author and any other file in the winning entry, found under the
entry's subdirectory.

If you downloaded `1984/mullender/1984_mullender.tar.bz2`, for instance, you might
then do:

```sh
        cd 1984/mullender
        make everything
        ./mullender.alt
```

to compile all versions and then run the alternate version (if you have
a PDP-11 or VAX-11 you would be able to run the original version). For more help
on compiling entries, see also the
FAQ on "[IOCCC Makefile rules](#make_rules)".

If you want to view the `index.html` file you can point your browser to the
`index.html` file of the winning entry (e.g. `1984/mullender/index.html`) with the
caveats noted above.


#### Year based tarballs

The year based tarballs, which are under each year's directory and are named in
the form of `YYYY/YYYY.tar.bz2` (e.g. [1984/1984.tar.bz2](1984/1984.tar.bz2)),
include all the winning entries of a given year.
Each year's tarball can be found under that year in the [years.html](years.html)
page and in the year's `index.html` as well (e.g.
[1984/index.html](1984/index.html)).

These tarballs have, along with each entry's directory and their respective
files (as if you downloaded each entry tarball of the year individually as
described above), the following files:

- `.filelist`           - list of files in the year that are not part of a winning entry of the year, including the `YYYY.tar.bz2` tarball
- `index.html`          - the `YYYY/index.html` file rendered from the `YYYY/README.md` file
- `Makefile`            - Makefile for the year to compile etc. all entries of the year
- `README.md`           - the source of the `YYYY/index.html` file
- `rules.txt`           - rules of the year's contest
- `.year`                       - text file that has a list of the winning entries' directories of the year


Additionally, some will have extra files like:

- `.gitignore`                  - list of files that should not be committed under git
- `guidelines.txt`              - the guidelines of the year
- `iocccsize.c`                 - `iocccsize` tool of the year
- `iocccsize.mk`                - Makefile to compile the `iocccsize` tool of the year
- `iocccsize-test.sh`   - test suite for the `iocccsize` tool

.. and perhaps some others we have neglected to mention as well.

If you extract a year's tarball you can `cd YYYY` (e.g. `cd 1984`) and then run
`make everything` to compile the entries and alternate code of every entry, as
if you switched to each entry's directory and ran `make everything` in each one.

If you download the 1984 tarball, i.e. `1984/1984.tar.bz2`, then you might
extract it and then switch to the directory and compile everything of each
entry:

```sh
        cd 1984
        make everything
```

For more help on compiling entries, see also the
FAQ on "[IOCCC Makefile rules](#make_rules)".

Of course in this case you can also switch to individual entries and look at the
`index.html` file (or any other file in the entry) and try out the entries that
interest you, as if you downloaded that entry's individual tarball.

If you want to view the `index.html` files of that tarball, for instance the
year's `index.html` file and then `1984/mullender/index.html` you could point your
browser to `1984/index.html`, scroll down to `Winning Entries of 1984 - The 1st
IOCCC` and click on the link `1984/mullender` which will take you to the
`index.html` file. Of course the caveats listed above still will apply.

Jump to: [top](#)


<div id="zlib">
### Q: How do I compile and install zlib for IOCCC entries that require it?
</div>

This depends on your operating system but below are instructions for Linux and
macOS with alternative methods for macOS and different package managers with Linux.


#### Red Hat based Linux

Execute the following as root or via sudo:

``` <!---sh-->
    dnf install zlib
```


#### macOS

With macOS it should already be installed. If it is not you might have to do:

``` <!---sh-->
    xcode-select --install
```

and agree to the terms and conditions and proceed with the install.


##### macOS via Homebrew

Not applicable, see above.


##### macOS via MacPorts

Not applicable, see above.


#### Debian based Linux

Execute the following as root or via sudo:

``` <!---sh-->
    apt install zlib1g zlib1g-dev
```

and then try `make all` again.


#### Other Linux distributions

Use your package manager to install the appropriate packages. Try the search
feature of the package manager to determine which packages you need to install.
Note that you might have to install both the library and the developmental
packages: one for compiling and one for linking / running.


#### Package website

Go to the [zlib website](https://www.zlib.net) and follow their instructions
for downloading, installing and using zlib.

We recommend trying a method suitable for your environment first, if possible.

Jump to: [top](#)


<div id="ruby">
### Q: How do I install Ruby for entries that require it?
</div>

Please see the [official Ruby installation
guide](https://www.ruby-lang.org/en/documentation/installation/).

Jump to: [top](#)


<div id="rake">
### Q: How do I install rake for entries that require it?
</div>

First, if `gem` is not installed, see the [gem GitHub repo
](https://github.com/rubygems/rubygems).

Assuming you have `git(1)` installed, you can do:

``` <!---sh-->
    git clone https://github.com/rubygems/rubygems
    cd rubygems && exe/gem install rake
```

Otherwise, you can download the zip file, extract it, cd to the directory and
then run:

``` <!---sh-->
    exe/gem install rake
```

Once this is done, try as root or via `sudo`:

``` <!---sh-->
    gem install rake
```

Jump to: [top](#)

<hr style="width:50%;text-align:left;margin-left:0">
<hr style="width:50%;text-align:left;margin-left:0">


<div id="compile_problems">
## Section 6: Problems compiling IOCCC entries
</div>

Jump to: [top](#)


<div id="compile">
<div id="compile_errors">
### Q: Why don't certain IOCCC entries compile?
</div>
</div>

Some entries that won the IOCCC, particularly entries from long ago, no longer compile on more
modern systems because the C language has evolved (i.e. the modern C compilers
are much more strict in what they accept as a valid program), or the entry
depended on operation system and library features that where common back then
but are different/missing today.

Please see the other FAQs in this section as they might offer helpful
hints, especially in cases were something else needs to be installed.

Please see the [bugs.html](bugs.html) file for details about known problems with IOCCC entries.  In some cases you may be dealing with a problematic entry.  In a few fun cases, the IOCCC does not compile by design!

If you have a fix that makes a minimal impact to the entry, then
please consider submitting that change in the form of a pull request.
Please see
FAQ on "[fixing an entry](#fix_an_entry)".
See also the
FAQ on "[GitHub pull request](#pull_request)"
for more information about pull requests.

In some cases alternative code has been added that does compile on some or most
systems.  Check the write up for the entry for "alt" code and possible ways to
compile and run that code.  In some cases we replaced the original code (but not
the `.orig.c` file!) with code that works for modern systems but one can view
the original code in the `.orig.c` files (sometimes the original code is also in
the directory as a `dirname.alt.c` or `prog.alt.c`).

See the
FAQ on "[original source code](#original_source_code)"
for more information.

It might also be worth noting that almost all entries, have been
fixed so that they can compile in modern systems though just because an entry
compiles does not mean it will run on your specific system.

Jump to: [top](#)


<div id="gcc">
<div id="clang">
### Q: Why does clang or gcc fail to compile some IOCCC entries?
</div>
</div>

Although we have fixed numerous entries to work with clang (sometimes in an alt
version but usually in the program itself) there are some that simply cannot be
fixed or if they are fixable they have not yet been fixed (and might or might
not ever be fixed).

This is because clang has some defects where the args of `main()` are required to
be a specific type and some versions of clang allow only 1, 2 or 3 args, not 4,
to `main()`. In the case of types of args many were changed to the right type and
then what was `main()` became another function of the original `main()` type.

At the same time some entries are not designed to work with clang. There might
be alternate code added at some point but at this point it is highly unlikely.

`gcc` is far more forgiving. Nonetheless some entries no longer work or worked
with `gcc`. Some of these have been fixed (or in some cases partly fixed, much
like with `clang`) but there might be some that do not work with `gcc` or
`clang` or for that matter some other compiler.

See if the problem is mentioned in [bugs.html](bugs.html).  If you have a change
that fixes the problem (even if it just a change to the `Makefile`) that doesn't
negatively impact the entry too much, consider submitting that change in the
form of a pull request.  Please see the
FAQ on "[fixing an entry](#fix_an_entry)".
See also the
FAQ on "[GitHub pull request](#pull_request)"
for more information about pull requests.

Jump to: [top](#)


<div id="macos_errors">
<div id="macos_compile">
### Q: Why do some IOCCC entries fail to compile under macOS?
</div>
</div>

If the entry requires gcc and you did not explicitly install gcc in macOS you
will not be able to run or use these entries. This is because macOS gcc is
actually clang, even `/usr/bin/gcc`.

That being said many (if not most) of these entries have been fixed and some
others will be looked at, when found.

In some cases the [bugs.html](bugs.html) file may note a known macOS problem
with an entry.  Should you manage to port the entry, and assuming your changes
also attempt to preserve the original intent of the IOCCC entry, we would
encourage you to submit a pull request with your ported code.
Please see the
FAQ on "[fixing an entry](#fix_an_entry)"
for details.

Jump to: [top](#)


<div id="weverything">
### Q: Why do Makefiles use -Weverything with clang?
</div>

While we know that use of `-Weverything` is generally not recommended
by `clang` C compiler developers, we do use the `-Weverything`
option in a certain case in IOCCC entry `Makefile`s.

The use of `-Weverything` is limited to when one forces `CC=clang` or more
generally if the string 'clang' is in `$(CC)`. If `$(CC)` contains 'gcc' the
'gcc' specific options are run instead.

Users with clang compilers are not required to set `CC=clang` or equivalent but
when they do, `-Weverything` is enabled with all of its challenges, pedantic
warnings, and sometimes warnings about things that do not matter, some of which
are frankly frivolous and often downright dubious.

To enable this feature:

``` <!---sh-->
    make clobber all CC=clang
```

IOCCC authors who have access to `clang` might wish to try their
hand at compiling with `-Weverything` while using a minimum of `-Wno-foo`
statements.  Sometimes there is a technical or pedantic issue that
`-Weverything` warns about that would merit a change to your C code; often,
however, it is not even possible to fix let alone is it worth it. Of course
if you're running out of bytes due to rule 2[ab] one might not have much choice.
This is something that obfuscation authors simply sometimes have to deal with!

If you try to minimize the number of `-Wno-foo` options needed with
`-Weverything`, please mention this in your remarks about the entry, as the
judges note you attempt to honor it (see also below). In some cases your
obfuscated code will issue warnings with `-Weverything` no matter what: the
`-Wno-poison-system-directories` is a common example of this but there are
others as well, sometimes depending on the version of `clang`.

If you do try for a compile with `clang -Weverything`, keep on mind that while _your_
compile environment might be warning free, a different clang version or a
different build environment might still have warnings. For instance the warning
set is different in macOS (which by default is `clang`: even when run as `gcc`!)
than Linux (due to versions and possibly other things)!

Given that your entry **MUST** work as documented, you may be safer to
say that your entry keeps the number of warnings and `-Wno-foo` options while
compiling with `clang -Weverything` at a minimum. You might want to say the
version number and platform too as an extra safety net. Because if you claim zero
warnings, and we find a warning situation, this may diminish the value of your
entry as it is not as documented. Thus it might be wise to point this out and
if you can test it in multiple platforms (or versions of `clang`, see
below note) this would be advisable.

**NOTE**: different versions of `clang` have other differences as well. For instance
a defect of `clang` that required numerous entries to be fixed for clang is that it
requires that `main()`'s arguments to be of a specific type. However some
versions of `clang` are more strict in the number of args allowed. These reasons
are part of why numerous entries had to be modified so that `main()` calls
another function instead of doing it all in `main()` (another reason was that
some entries that recursively called `main()` caused a crash or otherwise broke
the entry in modern systems). Some entries do not work in `clang` (or at least do
not work completely) due to these defects, for instance
[1989/westley](1989/westley/index.html); [Cody Boone
Ferguson](authors.html#Cody_Boone_Ferguson) was able to
get much of it to work and looking at that entry might be of value to your
submissions, at least if you can figure the code out :-). To see the
differences, try from `1989/westley`:

``` <!---sh-->
    make diff_orig_prog
```

If you have `colordiff` try:

``` <!---sh-->
    make DIFF=colordiff diff_orig_prog
```

Alternatively you can try:

``` <!---sh-->
    git diff d2a42f42e8f477f29e9d5ed09ce2bb349eaf7397..eb9e69fde657acc8c85a618a8a99af4c2f93b21d westley.c
```

As you can see, using `clang` has some additional problems to work out but if
you can get your entry to work well in `clang` it might very well be considered
better than other entries.

Jump to: [top](#)

<hr style="width:50%;text-align:left;margin-left:0">
<hr style="width:50%;text-align:left;margin-left:0">


<div id="running_entries">
## Section 7: Running IOCCC entries
</div>

Jump to: [top](#)


<div id="try">
### Q: What are `try.sh` and `try.alt.sh` scripts and why should I use them?
</div>

A lot of the entries, old and otherwise, have complicated uses or, if not
complicated uses, it has numerous uses (sometimes both), and having a script
that automates these for viewers improves the usability of these entries so one
can enjoy them better.

The `try.sh` script is for the original entry and the `try.alt.sh` script is for
alternate versions. These scripts are usually for the `Try:` and `Alternate
try:` sections in the `index.html` files.

Some entries provide additional scripts that are meant to run the entry as well
but might not fit in the `try` model though some are used by a `try.sh` /
`try.alt.sh` script.

Although you're certainly welcome to copy and paste or type the commands in
manually, sometimes the scripts will do additional things that you might miss
and there are some other benefits as well which you would miss if you did not
use them. Nevertheless, if you prefer to do it manually, whether to help you
process or appreciate the entry more, then please do so.

Jump to: [top](#)


<div id="terminal">
<div id="sanity">
<div id="reset">
<div id="stty">
### Q: An IOCCC entry messed up my terminal application, how do I fix this?
</div>
</div>
</div>
</div>

The simplest way to do this is to type `reset`. If echo was disabled you can get
usually away with `stty echo`. Sometimes you can also get away with `stty sane`.
`reset` does the most but note that it will clear the screen; it is not the
clearing of the screen, however, that solves the problem, so `clear` will not
help.

Jump to: [top](#)


<div id="no_support">
<div id="unsupported">
### Q: Why does an IOCCC entry fail to compile and/or fail to run?
</div>
</div>

What may have worked years ago may not work well or work at all today.
Please note that the IOCCC judges do **NOT** support IOCCC entries.
Nevertheless, there may be a number of reasons why an IOCCC entry
may fail to compile or run well or fail to run on your system.

In some cases the American National Standards Institute's ANSI C committee has
damaged the C standard to the point where perfectly valid C programs no longer
compile with modern compilers.  As such some old IOCCC entries can no longer be
compiled with modern compilers (though a great deal of these were fixed in
2023).

In some cases programs that may have worked on an old computer system
longer work on modern computers.  Some IOCCC entries do not work well,
or no longer work on modern computers or modern operating systems, though again
a great deal of these were fixed for modern systems.

Some IOCCC entries fail to compile under clang, or gcc.
Some IOCCC entries require operating system services that
may not be present on your system.

In some cases the IOCCC entry simply has bugs or (Mis)features.

If you are having problems compiling or running an IOCCC entry,
we recommend that you look in [bugs.html](bugs.html) to see if
there is a known bugs or (Mis)feature.  In some cases what you
may think is a bug is actually an feature that was intentionally
written by the authors.  In some cases the problem is well
known and we are looking for someone to attempt to fix it.

In some cases there is an alternate version of the IOCCC entry
that you may wish to try.

It also possible that you may have discovered a bug in a winning IOCCC
entry.  If so, you are invited to try and fix the IOCCC entry and
submit that fix by way of a [GitHub pull
request](https://github.com/ioccc-src/winner/pulls).
Please see the
FAQ on "[fixing an entry](#fix_an_entry)"
for how to submit a fix to an IOCCC entry.

Jump to: [top](#)


<div id="eof">
<div id="intr">
<div id="interrupt">
### Q: How do I find out how to send interrupt/EOF etc. for entries that require it?
</div>
</div>
</div>

For some entries one needs to send interrupt or EOF or some other signal/other
special characters. There are typical defaults like (where `^` = ctrl):

- `^D` for EOF (`eof`)
- `^C` for interrupt (`intr`)
- `^U` for kill (`kill`)

and various others. But if you don't know this you can find out through the
`stty(1)` command with the `-a` option. For instance with macOS you might see:

``` <!---sh-->
    $ stty -a
    speed 9600 baud; rows 40; columns 155;
    intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; [..snip..]
```

If you know the name you can use `grep` to find the correct line and if your
implementation of `grep(1)` has the `-o` option you can filter it. For instance
to find what the `intr` is set to:

``` <!---sh-->
    $ stty -a |grep -o 'intr = ^[[:alpha:]]'
    intr = ^C
```

... assuming of course that it's a ctrl combination :-) If for some strange
reason it's not you might have to do something else including just piping it to
just `grep intr` or whatever.

Jump to: [top](#)


<div id="64bit">
<div id="64-bit">
### Q: Why does an IOCCC entry fail to run on my 64-bit system?
</div>
</div>

Unfortunately some older entries are non-portable and require 32-bit support or
32-bit binaries. A problem system here is macOS Catalina (10.15) as as of that
version macOS no longer supports 32-bit binaries. If the entry acts on a certain
type of binary, say ELF, then that will also be a problem depending on the
entry. For example [2001/anonymous](2001/anonymous/index.html) requires 32-bit
ELF binaries.

There are a few example entries that require 32-bit binaries. We have tried
to note these in both the respective Makefiles and index.html files but it is
possible that some were missed. These entries are very likely in the
[bugs.html](bugs.html) file and we welcome any help in making an alternate version
for 64-bit systems. Many were fixed to work with modern systems but some are
supposed to only work with 32-bit systems so any updated version of these
entries should be an alternate version.

Other entries like [2001/herrmann2](thanks-for-help.html#2001_herrmann2)
now work with 32-bit AND 64-bit systems.

Please see the [bugs.html](bugs.html) file for the problematic entry
in question to see if the problem is known, and if a fix is wanted,
consider trying to port the code to a 64-bit system and submitting
a pull request with that change.  Pull requests that fix such code
while trying to minimize the impact of any changes and preserving
the spirit of the original code are very welcome!  Please see the
FAQ on "[fixing an entry](#fix_an_entry)"
for details.  See also the
FAQ on "[GitHub pull request](#pull_request)"
for more information about pull requests.

Jump to: [top](#)

<hr style="width:50%;text-align:left;margin-left:0">
<hr style="width:50%;text-align:left;margin-left:0">


<div id="changes">
/An IOCCC entry messed
## Section 8: Changes made to IOCCC entries
</div>

Jump to: [top](#)


<div id="what_changed">
<div id="diff">
### Q: How can I find out what was changed in an IOCCC entry source code?
</div>
</div>

We have set up make rules to easily do see what was changed in the winning IOCCC
entry source.  Using the `Makefile` in the entry directory, use
one of the following `make(1)` rules:

The following `make` rules exist to make a difference:

* `make diff_orig_prog`:
    - This rule will show the diff of the _original_ source to the
    current source (that is `entry.orig.c` to `entry.c`).
* `make make diff_alt_orig`:
    - This rule will show the diff of the alternate code to the original
    code (that is `entry.alt.c` to `entry.orig.c`). If no alternate code exists
    nothing will be shown.
* `make diff_alt_prog`:
    - This rule will show the diff of the alternate code to the entry as it
    stands (that is `entry.alt.c` to `entry.c`).
* `make diff_orig_alt`:
    - This rule will show the diff of the original code to the alternate code
    (that is `entry.orig.c` to `entry.alt.c`).
* `make diff_prog_alt`:
    - This rule will show the diff of the entry to the alternate code (that is
    `entry.c` to `entry.alt.c`).
* `make diff_prog_orig`:
    - This rule will show the diff of the entry to the original code (that is
    `entry.c` to `entry.orig.c`).

For instance one of Landon's all time favourite entries is
[1984/mullender](1984/mullender/index.html) so the file names would be:
`mullender.orig.c`, `mullender.alt.c` and `mullender.c`. For later years, it
would be instead `prog.orig.c`, `prog.alt.c` and `prog.c`.

Note that you might see something like:

```
    make: [Makefile:170: diff_orig_prog] Error 1 (ignored)
```

at the end of the output but this is completely normal if there are differences.

If the alternate code is the same as the original, say with
[1984/anonymous](1984/anonymous/index.html), then naturally there is no point in
running the rule and the same applies for all the other rules but this system
allows for easily seeing the diffs.

As some examples we'll first look at one that has really long lines which
will make it harder to see what is different,
[2001/anonymous](2001/anonymous/index.html). What you would do is `cd
2001/anonymous` and then do:

``` <!---sh-->
    make diff_orig_prog
```

and then be really confused! :-)

But for an entry like [1991/dds](1991/dds/index.html), you can see the
differences much more easily. `1991/dds` is a good example where it's very
simple to see what is different as it's just a couple lines.

You might be quite surprised how little some entries had to be changed and at
the same time how much other entries had to be changed, often with quite complex
differences! In some cases if the line is rather long, like the above mentioned
one, it will be harder to see what changed but in other cases like
[1984/decot](1984/decot/index.html) or [1986/wall](1986/wall/index.html) it's a
lot easier.

Well, at least it's easier see the differences on a line-by-line basis but maybe
not what actually changed, especially since it's easier to know what was fixed
when you have compiler errors :-) (though there are, as noted, some examples
where it's quite easy to see the differences).

[1991/dds](1991/dds/index.html) is also a good example to see the alt difference
very easily. To do that `cd 1991/dds` and then do:

``` <!---sh-->
    make diff_alt_prog
```

and you'll see a single line changed and very simply.

**NOTE**: The above mentioned `make` rules are located in the [1337.mk](%%REPO_URL%%/1337.mk)
include Makefile via the optional include directive line:

``` <!---Makefile-->
    -include 1337.mk ../1337.mk ../../1337.mk
```

The [1337.mk](%%REPO_URL%%/1337.mk) file must exist in the current
directory, or under the directory above, or under the directory 2 levels
above in order for these rules to work.


#### Tip: if you have `colordiff` installed it's a lot easier to see the differences

To use these rules but provide a different `diff`, for instance `colordiff`,
just do:

``` <!---sh-->
    make DIFF=colordiff diff_orig_prog          # for orig to prog diff
    make DIFF=colordiff diff_alt_prog           # for alt to prog diff
```

Obviously if you want to view the alternate code or the orig code you can just open
the files as described above.

See the
FAQ on "[original source code](#original_source_code)"
for more information.

Jump to: [top](#)


<div id="gets">
<div id="fgets">
### Q: Why were some calls to the libc function gets&lpar;3&rpar; changed to use fgets&lpar;3&rpar;?
</div>
</div>

Some may wonder: "Doesn't this tamper with the entry too much?"

A fine line indeed has to be drawn here but it was decided that it is worth it
because of alarming warnings that can be displayed, in some systems at runtime
interspersed with the output of the program.

For instance in macOS the entry [1990/tbr](1990/tbr/index.html) would output the
warning in such a way that caused confusing output for the entry, looking like:

``` <!---sh-->
    $ ./tbr
    $ warning: this program uses gets(), which is unsafe.
    # nothing here, what to do?
```


In some cases it is not possible to fix or at least it is highly unlikely and so
those have mainly not been touched except one that has had the buffer size
increased (which could be done for others that are not possible to change to
`fgets()` though this has not been done).

Some entries can be made to look almost identical to the original entry. For
instance the fix to [1988/reddy](1988/reddy/index.html) required only a single
`#define` be added.

In the cases it has not been done it is likely the entry can be found in the
[bugs.html](bugs.html) file.

In the future we, the judges, would prefer that entries use `fgets()` to prevent
these problems.

An annoying fact is that for '"compatibility" reasons' `fgets()` retains the
newline and `gets()` does not.  As the Unix version 7 man page used to say:

> **BUGS**
>
> The _fgets(3)_ function retains the newline while _gets(3)_ does not, all
in the name of backward compatibility.

We're not sure how this is compatibility but either way it can cause a
problem and it is this that has complicated most of the fixes though again some
can look almost identical.

Jump to: [top](#)


<div id="remarks_consistency">
<div id="consistency">
###  Q: Why do author remarks sometimes not match the source and/or inconsistent with the entry?
</div>
</div>

Because some entries had to be fixed for modern systems and often the fixes
required a change in code, sometimes significant changes. Thus the remarks can
be inconsistent in some cases.

This is why we recommend that when you read the remarks, sometimes the judges'
remarks and always the author's or authors' remarks, you look at the original
code. When the entry source code is called `prog.c` the original code is in
`prog.orig.c`; otherwise it is `dirname.orig.c`. For instance one of Landon's all
time favourite entries is [1984/mullender](1984/mullender/index.html) and the
original code is in [mullender.orig.c](%%REPO_URL%%/1984/mullender/mullender.orig.c). In
some cases, such as `1984/mullender`, the original code is the same as the code
as no changes were made (there is an alt version for systems that are not
VAX-11/PDP-11, however).

See the
FAQ on "[original source code](#original_source_code)"
and the
FAQ on "[entry source code changes](#what_changed)"
for more information.

Jump to: [top](#)


<div id="orig_c">
### Q: What is the meaning of the file ending in .orig.c in IOCCC entries?
</div>

Due to the fact that the original code has sometimes had to change these files
are the original winning entry or as close to as possible to the original that
we can find (in some cases a change was made by the Judges, for example, or an
author might have made a modification without saving the original).

Jump to: [top](#)


<div id="alt">
<div id="alt_code">
### Q: What are alternate versions and why were they added to some entries?
</div>
</div>

The alternate versions are exactly what they sound like, versions of their
respective entries that were not the winning source code but have additional
features added (often by the author) or fixes, updates at the request of the
judges (upon winning the contest), unobfuscated versions and a variety of other
things for instance letting it work on more than one platform (where it would
not be possible to do in the original submission).

In some cases the alternate code added come directly from the author (some of
which already were in the website) but there were other cases where alternate
code was added that might or might not be necessary; this was a judgement call
and the reasons vary.

In many cases it was simply to make the entry more presentable to more people
but without modifying the entry itself, which would be tampering with the entry
(a problem that we tried to avoid as much as possible although we certainly did
not manage to do this perfectly), and in some cases it would be changing it so
much that it would no longer be what was submitted.

In one case an alternate version was created to help locate and fix a bug that
prevented the entry from working properly and it seemed like it should be added
as well, for fun (it is a game).

In some cases it might be better to not have them but as noted this was a
judgement call.

See also the
FAQ on "[original source code](#original_source_code)"
for more information.

Jump to: [top](#)


<div id="arg_count">
<div id="main_args">
### Q: Why was arg count and/or type changed in main&lpar;&rpar; in some older entries?
</div>
</div>

There are a number of reasons this was done but they usually come down to a
mis-feature or defect in the `clang` compiler.

In all versions of `clang` the first arg must be an `int` and the rest must be a
`char **` but in some versions it also objects to the number of args in
`main()`. In the versions observed that complain about the number of args it
says that there must be 0, 2 or 3 args. This only was triggered with 4 args, not
1, but to future proof the entry entries that had only one arg to `main()` were
changed to two.

The above also meant that some entries that were recursive calls to `main()`
could no longer be so: `main()` instead had to call another function that has
the body of the old `main()` and that function would call itself again. In some
cases, however, this had to be done even without `clang` objections.

Jump to: [top](#)


<div id="files_added">
<div id="files_removed">
<div id="files_changes">
<div id="files">
### Q: Why were files added to, removed from or changed in some entries?
</div>
</div>
</div>
</div>

Like with files being renamed, there are multiple reasons files were added,
removed or changed. The addition of the `try.sh` and `try.alt.sh` scripts is the most
significant example of files being added. These scripts,
help demonstrate entries by automating commands, sometimes many
commands and not always simple commands, that one would previously have to run
manually (there are other benefits as well).

See the
FAQ on "[try.sh and try.alt.sh](#try)"
for more details.

Alternate code, sometimes provided by the author, sometimes provided by the
judges and sometimes other people, was added to some entries as well.

In the case that a link might end up with a 404 the files, if possible, were
downloaded and put into the entry's directory. Sometimes the links were already
dead but with the help of the Internet Wayback Machine we could get the files
back.

In a few cases files were removed and there are multiple reasons for this too.

The end result is to help improve the presentation of the entries in some way or
ways.

Jump to: [top](#)


<div id="original_source_code">
<div id="prog_orig_c">
### Q: What is the original source file?
</div>
</div>

Every entry has what is called the "**original source file**".  This is
a copy of the original source code (usually `prog.c`) that the
[IOCCC judges](judges.html) used when declaring that submission is a
winning IOCCC entry.

There are a number of reasons why the source code (usually `prog.c`) needs
to be modified.  Reasons include things such as:

* modification as requested by the [IOCCC judges](judges.html)
* modification as requested by the author(s)
* modification as requested by a pull request from [someone else](thanks-for-help.html)
* bug fix
* portability improvement
* etc.

We seek to preserve the "**original source file**", for historical purposes,
by preserving the original source code (usually as `prog.orig.c`).

**IMPORTANT NOTE**: The "**original source file**", because it is a historic
record, should **NOT** be modified.

Unless one can demonstrate that a mistake has been made regarding
the "**original source file**" and that, for some reason, the file
is **NOT** the original source code, please do **NOT** attempt to modify it.

**IMPORTANT NOTE**: If you believe that the "**original source file**" is
**NOT** the original source code, then plesse open an
[IOCCC issue](https://github.com/ioccc-src/winner/issues) and describe the
problem to the [IOCCC judges](judges.html), including what you believe
is the correct "**original source file**".

**FYI**: To determine the difference between the "**original source file**" and
the source code as it is now now, try:

``` <!---sh-->
    make diff_orig_prog
```

See the
FAQ on "[what changed](#what_changed)"
for more information and make rules relating to "**original source file**" differences.

Jump to: [top](#)


<div id="renaming_files">
### Q: Why were some filenames changed?
</div>

The reasons this was done varies. One of the earliest changes was making the old
`.hint` or `.text` files `README.md` files. The first time this was done was for
`2019/README.text` and `2020/README.text` with [commit
87c41a787fa334f6696ec8f23284eacea63e3e89](https://github.com/ioccc-src/temp-test-ioccc/commit/87c41a787fa334f6696ec8f23284eacea63e3e89).
With [commit
77fb0f11a2ddc8584a1ebe8d68fb0cccf3b959a6](https://github.com/ioccc-src/temp-test-ioccc/commit/77fb0f11a2ddc8584a1ebe8d68fb0cccf3b959a6)`index.html`
and `hint.html` files were removed in favour of `README.md` files;
[commit
851e191519953c743cdd363dc19099e89210319c](https://github.com/ioccc-src/temp-test-ioccc/commit/851e191519953c743cdd363dc19099e89210319c)
renamed `hint.txt` and `hint.text` to `README.md`. There were most likely other
commits that fixed some issues with this.

Other files were also renamed, though, sometimes being converted to markdown as
well. Shell scripts were often renamed to end with `.sh` to indicate it is a
shell script and to help browsers know how to deal with it (this was before the
method of how to display files was devised).

Another example is for more consistency, sometimes to do with alternate code and
other times something else.

There were certainly other reasons as well.

Jump to: [top](#)

<hr style="width:50%;text-align:left;margin-left:0">
<hr style="width:50%;text-align:left;margin-left:0">


<div id="help">
## Section 9: Helping the IOCCC
</div>

Jump to: [top](#)


<div id="how_to_help">
<div id="helping">
### Q: How can I help the IOCCC?
</div>
</div>

#### We welcome your help in fixing IOCCC entries

The [known bugs](bugs.html) file, order by IOCCC years, contains a
list of known bugs & (mis)features.  If you are looking for an IOCCC entry
to try and fix, this file is a good place to start.

See the
FAQ on "[fixing an entry](#fix_an_entry)"
for information on how to submit a fix to
an IOCCC entry.  Before you consider trying to fix an IOCCC winning entry,
please check the [known bugs](bugs.html) file for the IOCCC entry
in question.  Note that in several cases what you may have discovered,
while a (mis)feature is not considered a bug and should **not be fixed**.
In cases where the bug is known, the entry's [known bugs](bugs.html) file
section may offer you important fixing clues.

#### We welcome your help on fixing the IOCCC website

Jump to: [top](#)


<div id="bugs">
<div id="misfeatures">
<div id="mis-features">
### Q: Is there a list of known bugs and &lpar;mis&rpar;features of IOCCC entries?
</div>
</div>
</div>

Yes! Please see [bugs.html](bugs.html) for a list of known bugs and/or issues of a
variety of kinds.

Note that just because an entry is not in the bugs file does not mean there is
not an issue and note that some issues are simply missing files, dead URL(s) or
something like that.

Jump to: [top](#)


<div id="fix_an_entry">
<div id="fixing_entries">
### Q: How can I submit a fix to an IOCCC entry?
</div>
</div>

If you see a problem with an IOCCC entry, first check the [known bugs](bugs.html)
file.  In some cases what you might think of as a bug is instead a known
feature.  In some cases the bug is known, but no fix has ever been submitted.
In other cases you may have found a new problem.

If you do have a fix, and the [known bugs](bugs.html) file **does not recommend
against fixing it**, then please consider opening a [GitHub pull
request](https://github.com/ioccc-src/winner/pulls) against the master
[branch](https://github.com/ioccc-src/winner/branches) of the [ioccc-src/winner
repo](https://github.com/ioccc-src/winner).

BTW: A **problem** is not limited to the code itself.  Fixing typos in files
such as "_index.html_" files, fixing issues in a "_Makefile_", or otherwise
correcting an IOCCC entry is **VERY MUCH WELCOME**!  Please use the same
[GitHub pull request](https://github.com/ioccc-src/winner/pulls) process against
the [master branch](https://github.com/ioccc-src/winner/branches) of the
[ioccc-src/winner repo](https://github.com/ioccc-src/winner).

**NOTE**: some of the issues in the [bugs.html](bugs.html) file includes just missing
files and we welcome these too!

**Please also help us fix typos and / or otherwise improve the write-up** of how
IOCCC winning entries are presented!

In any event we will happily add you to the
[thanks](thanks-for-help.html) file for your help!

And of course, an IOCCC author may update their own entries
(metadata as well as source code and any extra files) by opening a
[GitHub pull request](https://github.com/ioccc-src/winner/pulls)
against the [master branch](https://github.com/ioccc-src/winner/branches)
of the [ioccc-src/winner repo](https://github.com/ioccc-src/winner).

Please see the
FAQ on "[fixing an entry](#fix_an_entry)".
See also the
FAQ on "[GitHub pull request](#pull_request)"
for more information about pull requests.

Note that we're much more inclined to accept an author's fixes but the judges
have the final say in the matter.

Jump to: [top](#)


<div id="pull_request">
<div id="commit">
### Q: How do I make a pull request to the GitHub repo?
</div>
</div>

First, if you do not already have a GitHub account or you have not installed an
ssh key to your account you must do so. For this we will assume you do not have
a GitHub account. For the steps following creating a GitHub account you will
have to be logged into your account.

To help you out here is a navigation menu in this FAQ entry:

- [Creating a GitHub account](#creating-a-github-account)
- [Installing an ssh key to GitHub](#installing-an-ssh-key)
- [Forking the IOCCC winner repo](#forking-the-ioccc-winner-repo)
- [Cloning the IOCCC winner repo](#cloning-the-ioccc-winner-repo)
- [Making changes, fixes etc.](#making-changes-fixes-etc)
- [Committing your changes](#committing-your-changes)
- [Opening a pull request](#opening-a-pull-request)
- [What to do after a merge](#what-to-do-after-a-merge)


#### Creating a GitHub account

Go to [GitHub](https://github.com/) and click on 'Sign up'. Follow the
instructions. Once you've completed this task make sure you log in to GitHub.

#### Installing an ssh key to GitHub

Assuming you do not have an ssh key you should go to the command prompt and
type (if you already have one and are okay using it for GitHub you can use that
one):

``` <!---sh-->
    ssh-keygen -t rsa -b 4096 -C "luser@example.com"
```

where `luser@example.com` is the email you want associated with your key.
Follow the instructions. It will tell you the key files.

Once you have an ssh key you need to go to your [account
settings](https://github.com/settings/profile). Once there, in the menu
on the left you should see the item _SSH and GPG keys_. Click that and then
click (on the right side) the button that says _New SSH key_. You will see that
you have to specify a title, the key type and the PUBLIC key. Put whatever title
you want and keep the key type as _Authentication Key_. Now you need to put the
PUBLIC key in.

If you used an rsa key the default file will likely be found in:
`~/.ssh/id_rsa.pub`. If you used a different algorithm the file name will be
different. For instance if you used `ed25519` the default PUBLIC key file would
be `~/.ssh/id_ed25519`. If, like some people do, you have a separate key for
GitHub, it could be anything you wish, as long as it's in `~/.ssh`. For instance
it might be `~/.ssh/github.pub`.

Whatever the key file is, copy the contents and paste it into the GitHub field
labelled _Key_. Once you have done so click on _Add SSH key_.

#### Forking the IOCCC winner repo

Open in your browser the link:
<https://github.com/ioccc-src/winner/fork>. You now should follow the
instructions in forking the repo.


#### Cloning the IOCCC winner repo

Once you have forked the repo you are ready to clone it to your system. For
instance Cody Boone Ferguson has the GitHub handle _xexyl_ so he would type in:

``` <!---sh-->
    git clone https://github.com/xexyl/winner [target_dir]
```

Once that is completed you will need to change to that directory. The default
directory would be the name of the repo but if you specified a target directory
it will be that. For instance using the above example you might do:

``` <!---sh-->
    cd winner
```

You're ready to make your changes now!


#### Making changes, fixes etc.

Here you must use your wits, knowledge, creativity and whatever else you have.
Let's say that Cody wants to update his file
[2020/ferguson1/play.sh](%%REPO_URL%%/2020/ferguson1/play.sh) script. He would open it in
his editor of choice (in his case vim) and make the changes. He would then make
sure (as there is a last updated date) to update the last updated date. For
instance he might add the following:

> BTW: did you know that some people believe in snake human hybrids? It's true! See
> http://www.macroevolution.net/snake-human-hybrids.html and have a laugh, shock
> or an exercise in sibilance!

Then, assuming that the date is 1 March 2024, he would update the line that
starts with `# Last updated: ` to refer to `01 March 2024` rather than what it
is now (at the time of writing this), `15 April 2023`.

But what if he wanted to add a file? He'd create the file and then type:

``` <!---sh-->
    git add foo
```

where _foo_ is the file to add.

When he's ready to make a commit he would need to create a new branch for the
pull request.

#### Committing your changes

First, as an aside, if this is your first pull request (which we assume is if you're
reading this :-) ) you need to make sure that you can push changes to GitHub
with your ssh key. To do this you need to do:

``` <!---sh-->
    ssh -T git@github.com
```

Cody would see:

> Hi xexyl! You've successfully authenticated, but GitHub does not provide shell access.

Now, assuming that the forked repo is
<https://github.com/xexyl/winner>, you'd type:


``` <!---sh-->
    git remote set-url origin git@github.com:xexyl/winner.git
```

Now you'd be ready to make your commits.

Before doing anything else, however, a new branch needs to be created.
Continuing the example above for
[2020/ferguson1/play.sh](%%REPO_URL%%/2020/ferguson1/play.sh), it might be that:


``` <!---sh-->
    git checkout -B human-snakes
```

This would change the branch to the newly created branch `human-snakes` branch.
Now Cody could commit the changes:

``` <!---sh-->
    git commit play.sh # if specifying specific files
    git commit -a # if committing everything
```

He could also have done:

``` <!---sh-->
    git add play.sh
    git commit
```

In any case this would open an editor (in his case vim) to write a commit log.
It is recommended that the first line is <=51 chars and the next line is blank.
Then if necessary add a description for the log. For instance the above might
warrant the log:

```
    Add fun link to 2020/ferguson1/play.sh

    Did you know some people believe in snake human hybrids? I added a link to the
    script that discusses this and gives supposed examples.
```

Now a pull request has to be opened.


#### Opening a pull request

To do this depends on the branch name. Assuming the branch from above,
`human-snakes`, you would type:

``` <!---sh-->
    git push --set-upstream origin human-snakes
```

This might show:

```
    Enumerating objects: 9, done.
    Counting objects: 100% (9/9), done.
    Delta compression using up to 10 threads
    Compressing objects: 100% (5/5), done.
    Writing objects: 100% (5/5), 739 bytes | 147.00 KiB/s, done.
    Total 5 (delta 4), reused 0 (delta 0), pack-reused 0
    remote: Resolving deltas: 100% (4/4), completed with 4 local objects.
    remote:
    remote: Create a pull request for 'human-snakes' on GitHub by visiting:
    remote:      https://github.com/xexyl/winner/pull/new/human-snakes
    remote:
    To github.com:xexyl/winner.git
     * [new branch]     human-snakes -> human-snakes
    branch 'human-snakes' set up to track 'origin/human-snakes'.
```

The link referred to above would then be opened to open a pull request. Just
follow the instructions at this point. If however it does not show a link it is
likely because the branch already exists in your GitHub account (for the repo).
In this case you can open the link:
<https://github.com/ioccc-src/winner/pulls> which might show something
like:

```
    xexyl:human-snakes had recent pushes 1 minute ago
```

and to the right of it you would see a button that says _Compare & pull request_
which you could click on. Do that and follow the instructions.

An important note is if you have more than one pull request opened it'll only
show the branch name as the summary. You should in that case copy paste the log
you put in into the website. For instance the line (on the website) _Add a
title_ could have:

> Add fun link to 2020/ferguson1/play.sh

and then the text field that is labelled _Add a description_ would have:

> Did you know some people believe in snake human hybrids? I added a link to the
> script that discusses this and gives supposed examples.

Once you've done this you should click on _Create pull request_.

IMPORTANT NOTE: although the [Judges](https://www.ioccc.org/judges.html) will
give more deference to the authors of edited entries the
[Judges](https://www.ioccc.org/judges.html) also retain the final editorial say
in the matter.


#### What to do after a merge

When the judges have merged the pull request you now need to make sure your fork
has the merge. To do this from the command line, assuming the fork in the above
example, you would type:

``` <!---sh-->
    git checkout master && git pull https://github.com/ioccc-src/winner.git master && git push origin master
```

This will merge your pull request to your fork.

Jump to: [top](#)


<div id="report_website_problem">
<div id="website_problems">
### Q: How can I report an IOCCC website problem?
</div>
</div>

If you discover a problem with the IOCCC website that is related
to a particular IOCCC entry, please see the
FAQ on "[report entry bug](#report_bug)"
for information about reporting a bug in an IOCCC entry, and see the
FAQ on "[fixing an entry](#fix_an_entry)"
for information on how to submit a fix to an IOCCC entry.

If you discover a problem with the IOCCC website (such as a broken link, which
may or may not be specific to a particular IOCCC entry) that is **not related
to a particular IOCCC entry**, the best way you can help is to submit a fix to
the IOCCC website.  See the
FAQ on "[fixing the website](#fix_web_site)"
for information on submitting fixes
to the IOCCC website.

If you do not have an IOCCC website fix, and just wish to report a general IOCCC
website problem, we ask that you first look at the [IOCCC
issues](https://github.com/ioccc-src/winner/issues) to see if the problem has
already been reported.  If it has been reported, feel free to add a comment to
the issue. Otherwise, if you do not see the same issue reported, then feel free
to [open a new IOCCC website issue](https://github.com/ioccc-src/temp-test-ioccc/issues/new?assignees=&labels=website&projects=&template=website_issue.yml&title=%5BWebsite%5D+%3Ctitle%3E).

Jump to: [top](#)


<div id="fix_website">
### Q: How can I submit a fix to the IOCCC website?
</div>

For IOCCC website problems that relate to a particular IOCCC entry, please
see the
FAQ on "[fixing an entry](#fix_an_entry)"
for information on how submit a fix to an IOCCC entry.

You may open a [GitHub pull request](https://github.com/ioccc-src/winner/pulls)
against the [master branch](https://github.com/ioccc-src/winner/branches)
of the [ioccc-src/winner repo](https://github.com/ioccc-src/winner)
to submit a fix.

Please see the
FAQ on "[fixing an entry](#fix_an_entry)".
See also the
FAQ on "[GitHub pull request](#pull_request)"
for more information about pull requests.

#### Some HTML files should NOT be directly modified

Nearly all HTML files on the [IOCCC website](https://www.ioccc.org)
are built from [markdown](https://daringfireball.net/projects/markdown/) files.
If you see lines containing:

``` <!---html-->
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <!-- !!! DO NOT MODIFY THIS FILE - This file is generated by a tool !!! -->
    <!-- !!! DO NOT MODIFY THIS FILE - This file is generated by a tool !!! -->
    <!-- !!! DO NOT MODIFY THIS FILE - This file is generated by a tool !!! -->
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
```

This means that the file is generated by a tool from a [bin directory tool](bin/index.html).
You should **NOT** attempt to modify the file.

You may also find lines slightly below the above set that suggest another file to edit.
For example, in [contact.html](contact.html), one may read:

``` <!---html-->
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <!-- !!! Do not modify this web page, instead modify the file: contact.md -->
    <!-- !!! Do not modify this web page, instead modify the file: contact.md -->
    <!-- !!! Do not modify this web page, instead modify the file: contact.md -->
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
```

This means that you could consider editing the referenced markdown file
AND then run `make www` from the top level directory in your IOCCC pull
request. There are quicker ways but to be sure you get
everything built you should do this. If you modified a markdown and you do not
see the same file as a html file then you did not complete the fix.

Please see the
FAQ on "[fixing an entry](#fix_an_entry)".

See also the
FAQ on "[GitHub pull request](#pull_request)"
for more information about pull requests.

In some cases, the HTML file is **NOT** based on markdown content, but instead
came from JSON and other data files.  So instead of the above reference to a
markdown file, you will read:

``` <!---html-->
    <!-- The main section of this web page came from JSON and other data files -->
    <!-- -->
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <!-- The main section of this web page was generated via the tool: bin/gen-years.sh -->
    <!-- The main section of this web page was generated via the tool: bin/gen-years.sh -->
    <!-- The main section of this web page was generated via the tool: bin/gen-years.sh -->
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
```

This means there is **NOT even a markdown file to edit**.  Instead one must
modify JSON files and/or change a [bin directory tool](bin/index.html).

If this happens, consider opening up an [IOCCC issue](https://github.com/ioccc-src/winner/issues)
and ask for help.  See
FAQ on "[fixing an entry](#fix_an_entry)"
for information on opening up an IOCCC issue.

Jump to: [top](#)


<div id="fix_author">
### Q: How can I correct or update an IOCCC author's information?
</div>

You may correct or update IOCCC author information by submitting a
GitHub pull request that modifies an author's `author_handle.json` file.

For example, if a given `author_handle.json` file contained:

``` <!---json-->
    "url" : "https://www.example.com/employee/username",
```

and you knew that the author has long ago left the `www.example.com` company,
and that they have a new faculty web page at `www.example.edu`, then you should
submit a GitHub pull request to change the above line to:

``` <!---json-->
    "url" : "https://www.example.edu/faculty/deartment/user.name",
```

Authors of IOCCC winning entries are kept in JSON files of the form:

```
    author/author_handle.json
```

where `author_handle` is an author handle.

See the
FAQ on "[author handle](#author_handle_faq)"
for more information about author handles.

See the
FAQ on "[author_handle.json](#author_json)"
for information about the contents of these JSON files and how they are used.

See the
FAQ on "[finding author handles](#find_author_handle)"
for how to find an _author_handle_.

You may update IOCCC author information in a `author_handle.json` file
by [submitting  a pull request](#pull_request)
against the [master branch](https://github.com/ioccc-src/winner/branches)
of the [ioccc-src/winner repo](https://github.com/ioccc-src/winner).

See the
FAQ on "[GitHub pull request](#pull_request)"
for more information.

**IMPORTANT NOTE**: As these files are JSON you should verify that
they are validly formed (e.g., you didn't make a typo).

Before you form your GitHub pull request that modifies a
`author_handle.json` file, please run the `make www` command.  This
unfortunately takes quite a while but it is the safest way to do
it.  So you may wish to test your edits by running the somewhat
quicker `make quick_www` as this can speed up your testing.

The `make quick_www` rule will update the `authors.html` and
`location.html` pages and it will also check the timestamps of the `index.html`
files versus the `README.md` files. Since they were touched and thus the
timestamp was updated, the
[bin/quick-readme2index.sh](%%REPO_URL%%/bin/quick-readme2index.sh) tool would
only worry about those two files. This greatly speeds things along while testing.
Nevertheless, doing a final `make www` is still recommended best practice
before you form your pull request.

Please see
FAQ on "[fixing an entry](#fix_an_entry)".

See also the
FAQ on "[GitHub pull request](#pull_request)"
for more information about pull requests.


#### Important note about **XX - Anonymous location**:

Unless you are the author who originally selected the **XX - Anonymous
location**, please do not attempt to change an **XX - Anonymous
location** without the permission of the original author, as sometimes they
want to have the location known but not their name and/or other details.


<div id="zz_help">
#### PLEASE HELP us identify proper locations for IOCCC authors
</div>

If you know the location of an author listed under:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**[ZZ - Unknown location](location.html#ZZ)**

or if you find IOCCC author location that is incorrect,
then **please submit a pull request**,
or at least [inform the IOCCC judges](contact.html).

**FYI**: The [ZZ - Unknown location](location.html#ZZ) is used for
historic winning authors whose location or country is not known,
whereas the [XX - Anonymous location](location.html#XX) is used when the
winning author does **not wish to disclose their location**.

The contents of these JSON files contain the best known information
about authors of IOCCC entries.  See
FAQ on "[author_handle.json](#author_json)"
for information about the contents of these JSON files and how they are used.

For example, if a given `author_handle.json` file contained:

``` <!---json-->
    "location_code" : "ZZ",
```

and you knew that the author was located in [Australia](location.html#AU)
(location code **AU**), we encourage you to submit a **GitHub pull
request** to change that line to:

``` <!---json-->
    "location_code" : "AU",
```

See the
FAQ on "[fixing author information](#fix_author)"
for information about how to change author location codes.

Jump to: [top](#)


<div id="fix_link">
### Q: What should I do if I find a broken or wrong web link?
</div>

We would appreciate if you try to fix the broken (the link goes nowhere) or wrong
(the link goes to something that clearly is not the original intent) web link.
If wish to fix such links, you may open a GitHub pull request as described in
FAQ on "[fixing the website](#fix_web_site)".
In the case of dead links or invalid links it doesn't matter
if it's a specific winner or not; the procedure is the same: open a pull request
to fix the problem.  See also the
FAQ on "[GitHub pull request](#pull_request)"
for more information about pull requests.

As far as how to find the updated link you can try using the [Internet Wayback
Machine](https://web.archive.org) and see if you can find the last non 4xx non
3xx page. Note, however, that just because it redirects, does not mean it's not
valuable.  Other times you might find it with a web search.

Some links were changed to more recent URLs by doing this exact
same thing.  Some links, while they were a valid web page, no longer
reach the intended web page (for example when the domain is sold
and the new domain owner's content no longer provides the content
that was originally intended .. and while the content of the web
page may be humorous to some, the original content may have literally
gone "up in smoke").

In cases where the original content is lost, try searching for it on
the [Internet Wayback Machine](https://web.archive.org).  When searching
look back for dates that are around the year of given IOCCC contest.
If you do find the original content in Internet archive history,
please consider submitting a change to replace the link accordingly.

If there is no alternative that you can find you might want to remove the link
instead by replacing the link with just phrase of text.  For example,
if the text in some `index.html` file was:

```
    See the [author's description of the program](https://example.com) for more information.
```

Assuming that the author's description cannot be found in the
[Internet Wayback Machine](https://web.archive.org) archive, then
replace that text with:

```
    See the **author's description of the program** (sorry the content is no longer available) for more information.
```

If you just wish to report the bad link issue, see
FAQ on "[report website problem](#report_web_problem)".

Jump to: [top](#)


<div id="support">
<div id="supporting_ioccc">
### Q: How can I support the IOCCC?
</div>
</div>

The [IOCCC judges](judges.html) run the IOCCC entirely out of
their own funds.  This includes paying for IOCCC related hardware,
services, registration, software and related technical items.

There is **NO** requirement for anyone to support the [IOCCC](index.html).
Nevertheless, it has been shown that receiving  **anonymous** gifts
provides the [IOCCC judges](judges.html) with a nice
[dopamine](https://en.wikipedia.org/wiki/Dopamine)
boost, and happy [IOCCC judges](judges.html) help make the IOCCC
better for everyone. :-)

If you wish to express your support and/or appreciation for our
efforts, we suggest making an **Anonymous** gift via the
[IOCCC Amazon wishlist](https://www.amazon.com/hz/wishlist/ls/3HSNTEL8RQ1M0?ref_=wl_share).

Jump to: [top](#)


<div id="deobfuscated">
<div id="deobfuscation">
<div id="unobfuscated">
<div id="unobfuscation">
### Q: I deobfuscated some entry code, may I contribute the source?
</div>
</div>
</div>
</div>

**PLEASE NOTE**: **many [winning authors](authors.html)** have unobfuscated code
of their **own entries** and you should look for this first, often on GitHub or on
their website; see the FAQ on [how to find more information about a winning
author of an entry](#author-information) for how you might find this
information. We ask you to, if you can find them, please ask them what they
think as they can often provide invaluable information; this is less of an issue
for fixes of bugs - not features - found in the [bugs.html](bugs.html) file.

The [IOCCC judges](judges.html) welcome those who wish to contribute a
**deobfuscated** version of a winning IOCCC entry: from either the [author or
authors](authors.html) (**which is much, much preferred**) or from people such
as yourself (assuming you are not the author :-) ) who are willing to contribute
**deobfuscated** code.  We also welcome contributions to improve existing
**deobfuscated** code. You might wish to look at their URL or alt URL (see below
for more details) **first** as quite a few [authors](authors.html) have provided
unobfuscated code of their entries and this is far more fair to the [winning
authors](authors.html) (and it is much more likely to be identical functionality
as well, though many [authors](authors.html) are experienced and skilled enough
to add features **after or during obfuscation!** and many in fact do).

**HISTORICAL NOTE**: The IOCCC website has shifted to a more
educational theme: preferring to explain entries rather than hiding
things under the guise of such information being a "_spoiler_".  We
now use the term **deobfuscated** instead of "_spoiler_" for this reason, at
least in most cases; other terms might be used, including on a rare occasion
_spoiler_, this depending on context.

We ask that the **deobfuscated** code be **identical in functionality**
to the winning IOCCC entry code.

**_PLEASE_ NOTE**: Be aware that IOCCC entry code may contain **extremely subtle and
obscure side effects** (i.e., features).  Those wishing to contribute a
**deobfuscated** version of code should **strive to mimic** the original (or
existing) IOCCC entry code as much as possible. Some authors can be contacted
(see above for more details on this) and you could ask them for details and if
possible it would be good to include them in the discussion as well (see below)
as it is **very likely** there are things that will be missed when trying to
deobfuscate the code, some of which might be important to the author.

To contribute your **deobfuscated** code, please open up a
[Show and tell new discussion](https://github.com/ioccc-src/temp-test-ioccc/discussions/new?category=show-and-tell)
with a title of the form:

> Enhancement: deobfuscated code for YYYY/dirname

where "`YYYY/dirname`" refers to the winning IOCCC entry for which you are deobfuscating.

In the **body** of your new discussion, **PLEASE** provide us with a **URL** of
your **deobfuscated** code, along with whatever notes and/or comments you
think might be helpful. If the author has a GitHub handle **please** mention
them in the discussion (see above part for how you might find out if they have a
GitHub account)!

If you are providing an improved version of some existing **deobfuscated** code, please
mention that in the **body** of your new discussion as well.

If there are **limitations** to how well the your **deobfuscated** code mimics
the original (or existing) IOCCC entry code, **PLEASE** mention those **limitations**
in the **body** of your new discussion as well.

Any questions that may arise will be added as comments to the discussion.

**SUGGESTION**: **PLEASE** try to make your **deobfuscated** code readable.  **PLEASE**
add comments as needed to help the reader of your **deobfuscated** code understand it.

**SUGGESTION**: Where useful, consider providing, as **C comments**,
code fragments of from the original (or existing) IOCCC
entry code.  While it is **NOT** necessary to include the entire
original code as **C comments**, including key parts from the
original (or existing) IOCCC entry code may be helpful
to others who wish to read your **deobfuscated** code.

If your **deobfuscated** is accepted (in some form), the [IOCCC judges](judges.html)
will be happy to **thank you** for your contribution in the
[thanking people for their help file](thanks-for-help.html).

The [IOCCC judges](judges.html) will do the rest of the work in integrate your
**deobfuscated** code as an "_alt_" code for the entry **AND** will reference
your **deobfuscated** code in the entry's `index.html` file.  We will be
happy to include any whatever notes and/or comments from your new discussion
that be prove helpful.

**THANK YOU** in advance for your willingness to assist!

Jump to: [top](#)


<div id="report_bug">
<div id="reporting_bugs">
### Q: How do I report a bug in an IOCCC entry?
</div>
</div>

We do not 'maintain' the contest entries as such. The code is made available on an 'AS
IS' basis. If you have a FIX for an entry, we suggest that you submit your fixes in a [GitHub pull
request](https://github.com/ioccc-src/winner/pulls) as we welcome pull requests that have a
minimal impact on the entry while improving the portability, functionality, and/or addressing known problems.

If you do submit a pull request, we ask that each pull request address just one IOCCC entry at a time.

Note that just because you have a fix does not mean it'll be accepted. This
might be because the author objects or it doesn't fit in some way or another. Of
course if the entry does not work we'll certainly be more inclined to accept the
fix. If it is accepted we'll be happy to credit you in the
[thanks](thanks-for-help.html) file. If you're a previous author of a winning IOCCC entry we will happily
link to your entries; if you're not we can link to your website if you wish.

Please see the
FAQ on "[fixing an entry](#fix_an_entry)"
for information on how to submit a fix to an
IOCCC entry.  See also the
FAQ on "[GitHub pull request](#pull_request)"
for more information about pull requests.

Jump to: [top](#)

<hr style="width:50%;text-align:left;margin-left:0">
<hr style="width:50%;text-align:left;margin-left:0">


<div id="misc">
## Section 10: Miscellaneous IOCCC
</div>

Jump to: [top](#)


<div id="mirrors">
<div id="website_mirrors">
<div id="website_mirroring">
### Q: May I mirror the IOCCC website?
</div>
</div>
</div>

There are a few steps in mirroring the website:

0. First of all, open the website on your device, preferably one you can hold
and aim somewhere.
1. Then, turn your device towards a mirror. This should mirror it. :-)
2. If you can, take a picture of the mirror image. It might help if you can put
your device down facing the mirror, so that it is easier to get a picture.

Okay, backing up, on a more serious note: we are not accepting mirror requests at
this time, sorry.  However you are free to fork the [IOCCC winner
repo](https://github.com/ioccc-src/winner).

Yes we are aware that some people have previously made their own repo of the
winning entries but these **ARE UNOFFICIAL** and **VERY LIKELY** out of date or
incorrect. What's more, this repo is the source of the [**Official** IOCCC
website](https://www.ioccc.org) so whenever a push is made to this repo the
**Official IOCCC website** is updated. When new winners are announced, this will
happen.

To put it simply, please do **NOT** fork those repos, as they are **UNOFFICIAL**
and certainly **OUT OF DATE**.

If you do make a new fork of **THIS** repo, we do ask that your fork keep up to
date with the latest changes when possible. Thank you.

Jump to: [top](#)


<div id="permission">
<div id="ioccc_copyright">
### Q: May I use parts of the IOCCC in an article, book, newsletter, or instructional material?
</div>
</div>

While IOCCC judges look favorably on most requests to use IOCCC material,
we request that you ask the [IOCCC judges](judges.html) first. Of course, if
you're the winner of the entry you can make use of it as you want (make a shirt,
put it on your website etc.).

Please send your request using the instructions on the [contacting
the IOCCC Judges](contact.html) page.

Please note that the content of the IOCCC
**Copyrighted and is under the CC BY-SA 4.0 License**.
See the [Copyright](#copyright) at the bottom of IOCCC web pages for more details.

See
FAQ on "[using IOCCC content](#license)".
For additional information on the [Copyright and CC BY-SA 4.0 License](license.html).

Jump to: [top](#)


<div id="first_person">
<div id="person">
<div id="pronoun">
### Q: Why do you sometimes use the first person plural?
</div>
</div>
</div>

As a precedent for [first person
plural](https://en.wikipedia.org/wiki/Nosism), we may cite [Two-,
Three-, and Four-Atom Exchange Effects in bcc in
3He](https://journals.aps.org/prl/abstract/10.1103/PhysRevLett.35.1442) and
the co-authorship of [F. D. C.
Willard](https://en.wikipedia.org/wiki/F._D._C._Willard) as well
as the [APS New Open Access
Initiative](https://journals.aps.org/2014/04/01/aps-announces-a-new-open-access-initiative).

The number of [IOCCC judges](https://www.ioccc.org/judges.html) has
always been "> 1" such that IOCCC judges often refer to themselves
in the plural, sometimes [in the common
plural](https://en.wikipedia.org/wiki/Plural), sometimes in the
[first person plural](https://en.wikipedia.org/wiki/Nosism), there
may be some who reject such a practice.  Therefore please consider
that when you believe that just one of the [IOCCC
judges](judges.html) is in action, you may
consider that [F. D. C.
Willard](https://en.wikipedia.org/wiki/F._D._C._Willard) has been
consulted, agreed, and has authorized the statement thus allowing
the [in the common plural](https://en.wikipedia.org/wiki/Plural)
to be used without offense.

And while some might claim that [F. D. C.
Willard](https://en.wikipedia.org/wiki/F._D._C._Willard) died in
1982, we suggest that the [Schrödinger's
cat](https://en.wikipedia.org/wiki/Schrödinger%27s_cat) superposition
may still be in effect and the 1982 [report of death was an
exaggeration](https://books.google.com/books?id=ms3tce7BgJsC&lpg=PA134&vq=%22the%20report%20of%20my%20death%20was%20an%20exaggeration%22&pg=PA134#v=onepage&q=%22the%20report%20of%20my%20death%20was%20an%20exaggeration%22&f=false).

p.s. Here is an image of F. D. C. Willard:

<img src="png/F.D.C.Willard.png"
 alt="image of F.D.C.Willard.png"
 width=600 height=401>

Jump to: [top](#)


<div id="dot_path">
<div id="dot_year">
<div id="dot_allyear">
<div id="dot_top">
<div id="dot_files">
### Q: What is the purpose of the `.top`, `.allyear`, `.year` and `.path` files?
</div>
</div>
</div>
</div>
</div>

The [.top](%%REPO_URL%%/.top) file resides at the top directory.  This file contains the complete list
of IOCCC years.

Under each IOCCC year, one will find a `.year` file.  These files contain directory paths from the top directory,
of the IOCCC entry directories for a given year.  For example, see the [1984/.year](%%REPO_URL%%/1984/.year) file.

The [.allyear](%%REPO_URL%%/.allyear) file contains the contents of all `.year` files for all IOCCC years.

Under each IOCCC entry directory, you will find a `.path` file.
These files contain the directory path from the top directory.
For example see [1984/anonymous/.path](%%REPO_URL%%/1984/anonymous/.path).

The .top, .allyear, .year and .path files are generated from the top level Makefile, by:

``` <!---sh-->
    make genpath
```

Jump to: [top](#)


<div id="terms">
### Q: What is the current meaning of the IOCCC terms Author, Entry, and Submission?
</div>

The IOCCC is now attempting to use the following terms:

- Author

An _author_ is someone who has submitted an entry that has won the IOCCC.

An entry can have more than one authors.  A number of authors have submitted
entries that have won the IOCCC, sometimes in the same IOCCC contest year.

**An apology for being inconsistent**: In the past, the IOCCC used the term _winner_ to
refer to what is now an _author_.  In a number of historical cases,
such as old rules and old guidelines, terms such as _winner_ may still be
found.  Moreover, out of habit, the IOCCC judges sometimes use old
names such as _winner_ when they should use _author_.  Sorry (tm Canada)! :-)

- Entry

An _entry_ is a _submission_ that won the IOCCC.

An _entry_ has one or more _authors_.

An _entry_ includes all of the files needed to compile it,
plus sample input files, a `Makefile`, an `.entry.json` file
describing the entry, a compressed tarball containing all of
files in the entry, etc.  Under the IOCCC tree, an _entry_
that win the IOCCC in year _YYYY_ is located under the
directory `YYYY/entry`.

**An apology for being inconsistent**: In the past, the IOCCC used the term _winner_ to
refer to what is now an _entry_.  In a number of historical cases,
such as old rules and old guidelines, terms such as _winner_ may still be
found.  Moreover, out of habit, the IOCCC judges sometimes use old
names such as _winner_ when they should use _entry_.  Sorry (tm Canada)! :-)

- Submission

A _submission_ is something given to the IOCCC judges
for consideration when the IOCCC is open.

When the IOCCC is open for submissions, those who register
to enter the IOCCC may use the [mkiocccentry tool](https://github.com/ioccc-src/mkiocccentry)
to package their code into a compressed tarball that may be
uploaded to the [IOCCC submit server](https://submit.ioccc.org).
This compressed tarball is formatted in such a way that
the IOCCC judges do not see who wrote the code.

A _submission_ that the IOCCC judges deem to have won the IOCCC
becomes an _entry_.  Only then do the IOCCC judges look into
the special JSON file to discover who the _author_(s) are.

**An apology for being inconsistent**: In the past, the IOCCC used the term _entry_ to
refer to what is now a _submission_.  In a number of historical cases,
such as old rules and old guidelines, terms such as _entry_ may still be
found.  Moreover, out of habit, the IOCCC judges sometimes use old
names such as _entry_ when they should use _submission_.  Sorry (tm Canada)! :-)

Jump to: [top](#)


<div id="license">
<div id="licence">
### Q: Am I allowed to use IOCCC content?
</div>
</div>

**Disclaimer**: This FAQ is **not a license**, has **no legal
value**, and only highlights some of the key features and terms of
the actual [CC BY-SA 4.0
license](https://creativecommons.org/licenses/by-sa/4.0/legalcode.en).

The content of the IOCCC is [Copyrighted and is under the CC BY-SA 4.0 License](#copyright).

As long as you abide by the terms of the [CC BY-SA 4.0
License](https://creativecommons.org/licenses/by-sa/4.0/?ref=chooser-v1)
you may copy and redistribute the material in any medium or format
for any purpose, even commercially.

As long as you abide by the terms of the [CC BY-SA 4.0
License](https://creativecommons.org/licenses/by-sa/4.0/?ref=chooser-v1)
you may remix, transform, and build upon the material for any
purpose, even commercially.

This FAQ is an incomplete summary of how you may use IOCCC content.
You should review the [highlights of some of the key features and terms](license.html)
and this may help clarify some aspects of the
[CC BY-SA 4.0 License](https://creativecommons.org/licenses/by-sa/4.0/?ref=chooser-v1).

The [Copyright and CC BY-SA 4.0 License](#copyright) applies to all
IOCCC content.  We use this to help ensure that we can all
enjoy hat those working on the IOCCC have proper Attribution
including, of course, the IOCCC winners themselves!  It is designed
to help ensure that everyone may enjoy the IOCCC.

Jump to: [top](#)


<div id="try_mastodon">
### Q: What is Mastodon and why does IOCCC use it?
</div>

The [IOCCC uses Mastodon](https://fosstodon.org/@ioccc) for news updates,
announcements, and for various other social media purposes.

**Please follow the [IOCCC on Mastodon](https://fosstodon.org/@ioccc)**.

> The IOCCC no longer uses twitter, or whatever that someone who appears to have
poor impulse control (allegedly) calls their platform these days.

The IOCCC prefers to reside in the [fediverse](https://fediverse.info).

**For help with Mastodon**:

There is [help with Mastodon](https://mastodon.help) available for
those who might wish to [get started with Mastodon](https://fosstodon.org/deck/getting-started).

While there are many fine Mastodon server instances out there, the [IOCCC judges](judges.html)
use [fosstodon.org](https://fosstodon.org/about) where lots of fun folk hang out,
and topics like science, technology, [free and open source](https://en.wikipedia.org/wiki/Free_and_open-source_software)
have a good home.  The [fosstodon.org](https://fosstodon.org/@fosstodon) folk made the IOCCC feel welcome.

While using Mastodon is free, the [IOCCC judges](judges.html) are pleased to
[support the Fosstodon Hub](https://hub.fosstodon.org/support/).

If you have a phone or tablet there is also an official app that you can get
from the App Store or whatever equivalent your device has. Please note that the
app does not at this time seem to give push notifications when someone you
follow posts something so you will have to check the IOCCC feed manually.

**HINT to mastodon users**: You may wish to refresh the [@IOCCC
mastodon feed](https://fosstodon.org/@ioccc) page and/or mastodon
app from time to time to view IOCCC mastodon updates.

Jump to: [top](#)


<div id="tabstops">
### Q: How do I set certain tabstops for viewing source code in vi(m)?
</div>

Sometimes an author will state that for best viewing purposes you should have
your tabstop set at say 4 or 8. If you use vim or vi or vim in no compatible
mode you can do this easily: make sure you're in command mode (in most cases you
can hit ESC to do this) and then type the command:


```
    :set tabstop=4
```

where `4` is the value you wish to set the tabstop to.

Jump to: [top](#)


<div id="menus">
### Q: How do the menus on the website work and what can I do if they don't work?
</div>

<div id="desktop_menu">
#### Menu on desktops or laptop computers
</div>

The way the menu works on desktops or laptops is that you should simply see the
menu directly without the need of JavaScript or any intervention on your part.
It should look something like:

<img src="png/ioccc-menu-desktop.png"
 alt="screenshot of IOCCC menu on desktops"
 width=912 height=160>

Simply move your mouse cursor over the category you want and then click on the
item you wish to view that drops down from the category.

This is likely how it will appear with a [tablet device in landscape
mode](#tablet_menu), too, unless [JavaScript is
disabled](#no_javascript_menu).


<div id="mobile_menus">
#### Mobile menus
</div>

If, however, you're on a mobile device, it can vary, depending on the dimensions
and whether or not you have JavaScript enabled.

<div id="mobile_phone_menu">
##### Menus on mobile phones
</div>

For instance, on an iPhone 14
Pro Max or similar device (in dimensions), you should see at the top right of
every page, something that looks like:


<img src="png/ioccc-menu-mobile-phone.png"
 alt="screenshot of IOCCC menu on iPhone 14 Pro Max"
 width=1290 height=527>

In this case click on the icon at the top right corner that looks like:

<img src="png/hamburger-icon-open.png"
 alt="menu open icon"
 width=24 height=24>

to activate the menu.

<div id="no_javascript_menu">
##### Menu on mobile devices if JavaScript is disabled
</div>

If JavaScript is disabled on any mobile device, tablet or phone, you should see
the words:

```
        Please Enable JavaScript
```

at the top right corner; clicking on this will take you to the [no JavaScript
menu](nojs-menu.html) which is a plaintext menu. You of course can use this if
you like, even if you do not have JavaScript enabled, by pointing your browser
to <https://ioccc-src.github.io/temp-test-ioccc/nojs-menu.html>.

<div id="tablet_menu">
##### Menus on tablet devices (e.g. iPads)
</div>

With tablets, it likely depends on the orientation you have your device in. If it's
in portrait mode you likely will see the [menu that one will get on a mobile
phone](#mobile_phone_menu).

If, on the other hand, you are using landscape mode, say on an iPad Pro 11 inch
4th generation, then you will likely see the [menu as you would on a desktop or
laptop](#desktop_menu).


<div id="1024px_menu">
##### Menus on mobile devices wider than 1024 pixels
</div>

Finally, if you're on a mobile device that is wider than 1024 pixels, you will
very possibly have to **press and hold** the menu icon:

<img src="png/hamburger-icon-open.png"
 alt="menu open icon"
 width=24 height=24>

to activate it. You can then use it [as you would on a mobile
phone](#mobile_phone_menu).


<div id="browser_bug_menu">
##### Browsing the website on mobile devices with a browser bug
</div>

It was noticed that in iOS 16 Safari (both on an iPhone 8 Plus and in simulation
mode in macOS) the menu does not work at all. That is to say one might see:

<img src="png/ioccc-menu-browser-bug.png"
 alt="browser bug where menu icon does not show up"
 width=1242 height=531>

Notice how the menu icon is not even there! This happens in both portrait mode
and landscape mode.

In this case one will have to use the [no JavaScript
menu](#no_javascript_menu). If you have a fix for this that **does NOT
affect the usability of desktops, laptops or other mobile devices**, please
consider fixing it and [opening a pull request](#pull_request) or at
least [report it as an
issue](https://github.com/ioccc-src/temp-test-ioccc/issues/new/choose) (choose
the category _Website issue_).

Jump to: [top](#)


<div id="author-information">
### Q: How do I find more information about a winning author of an entry?
</div>

At the top of the index.html file of a winning entry with the author you want
information on, you should see a section called `Author`. All you have to do is
click on the author's name (it's a link) and it will take you to their
information in the [authors.html](authors.html) page.

There you will find various information including a link to their
[authors.html](authors.html) information which includes various things like
their GitHub account (if known), a URL or alternate UL, mastodon handle,
location (if known and not anonymous location) and a link to their JSON author file.

**NOTE**: you might wish to search google (or some other search engine) by their
name as sometimes you can find out their GitHub account even if it's not in our
JSON files.

Of course if you know the author's name you can go directly to
[authors.html](authors.html) and click on their surname's/last name's/second
name's initial and then scroll down (if necessary) to the author in question.

Jump to: [top](#)


<div id="cb">
### Q: What is this cb tool that is mentioned in the IOCCC?
</div>

This was a C beautifier for Unix, both AT&T and Berkeley, but it seems to no
longer be available, code wise, except for Plan 9, but Plan 9 was never used for
judging the IOCCC. A Unix man page for `cb`
[still exists](https://www.ibm.com/docs/en/aix/7.3?topic=c-cb-command).

Jump to: [top](#)

<hr style="width:50%;text-align:left;margin-left:0">
<hr style="width:50%;text-align:left;margin-left:0">


<div id="history">
<div id="ioccc_history">
## Section 11: History of the IOCCC
</div>
</div>

Jump to: [top](#)


<div id="ioccc_start">
<div id="stormy_night">
<div id="beginning">
### Q: How did the IOCCC get started?
</div>
</div>
</div>

**It was a dark and stormy night...**

OK, let's go back to 1984, not 1830: one day (1984 March 23 to be exact), Larry Bassel
and I (Landon Curt Noll) were working for National Semiconductor's Genix porting
group, and we were both in our offices trying to fix some very broken code.

Larry had been trying to fix a bug in the classic Bourne shell (C code `#define`d
to death to sort of look like Algol) and I had been working on the `finger(1)`
program from early BSD (a bug ridden `finger` implementation to be sure).

We happened to both wander (at the same time) out to the hallway
in Building 7C to clear our heads.

We began to compare notes: '_You won't believe the code I am trying to fix_'.

And: '_Well you cannot imagine the brain damage level of the code I'm trying to
fix'_.

As well as: '_It's more than bad code, the author really had to try to make it
this bad!_

After a few minutes we wandered back into my office where I posted a
[flame to
net.lang.c](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=789%40nsc.UUCP&rnum=3&filter=0")
inviting people to try and out obfuscate the UN\*X source code we had just been working on.

BTW: I (Landon Curt Noll) had to post this [typo
correction](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=795%40nsc.UUCP&rnum=10&filter=0).
Thus began the tradition of putting typos in the contest rules and guidelines
... to make them more obfuscated of course! :-)

BTW: This posting was made back in the days when AT&amp;T was the evil giant.
Now, Microsoft makes AT&amp;T look mild and kind in comparison. :-( (IMHO) ).

BTW: See the story about the '[Bill Gates](1993/cmills/index.html)' award. :-)

OK, back to the story.

We (Larry and I) received a number of entries by email.
When we began to receive messages from outside of the US, Larry and I
decided to include International in the name.

The
[1st IOCCC entries](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=837%40nsc.UUCP&rnum=2&filter=0)
were posted on 17 April 1984.

There were 4 entries that won in 1984:

1. [&lpar;dis&rpar;honorable mention](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=842%40nsc.UUCP&rnum=8&filter=0)
2.  [3rd place](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=843%40nsc.UUCP&rnum=7&filter=0)
3. [2nd place](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=844%40nsc.UUCP&rnum=6&filter=0)
4. [1st place](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=845%40nsc.UUCP&rnum=5&filter=0)

BTW: The (dis)honorable mention wished to remain anonymous.
While many have asked who it was, we have continued to follow the
author's wish to remain anonymous.

A few years ago, we asked the author if they still wanted to remain anonymous.
They said: '_Yes, I want to keep my anonymity.  But you can tell them that I am well known for my connection to the
C language_'. It was not until 2001 that another [anonymous
entry](2001/anonymous/index.html) received an award.

BTW: The [1984/mullender](1984/mullender/index.html) remains one of my (Landon Curt Noll) all time favorites.

The name used in the posting of the [1st winning IOCCC
entry](http://groups.google.com/groups?q=Obfuscated&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=1&as_minm=1&as_miny=1983&as_maxd=18&as_maxm=4&as_maxy=1984&selm=837%40nsc.UUCP&rnum=2&filter=0)
posting was **I**nternational **O**bfuscated **C** **C**ode **C**ontest or
**IOCCC** for short.

The posting said '_1st annual_', so in 1985 we held the [2nd IOCCC contest](years.html#1985)
and the tradition continues as the longest running contest on the Internet.

P.S. Part of the inspiration for making the IOCCC a contest goes to the
[Bulwer-Lytton fiction contest](http://www.bulwer-lytton.com/).

Jump to: [top](#)


<div id="missing_years">
### Q: Why are some years missing IOCCC entries?
</div>

Some years, such as 1997, 1999, 2002-2003, 2007-2010, 2016-2017, 2021-2023, no IOCCC was held.

While we try to hold the IOCCC every year, sometime the other demands on the IOCCC judges
do not permit us to hold a new IOCCC.

The pause during the 2021-2023 period was due to the IOCCC judges developing tools to
make it much more likely for the IOCCC to be held on a yearly basis later on.

Jump to: [top](#)


<div id="website">
<div id="website_history">
### Q: What is the history of the IOCCC website?
</div>
</div>

#### In the beginning of www.ioccc.org

The long history of the [official IOCCC website](https://www.ioccc.org) can be
viewed at the [Internet Wayback Machine Wayback Machine](https://web.archive.org).

One can [view several thousand snapshots showing how the IOCCC website has
evolved](https://web.archive.org/web/20230000000000*/www.ioccc.org) going back
as far as [1998 Dec 12
www.ioccc.org](https://web.archive.org/web/19981212030016/https://www.ioccc.org/).

On 2020 Dec 31, the IOCCC source tree was moved to the [IOCCC winner
repo](https://web.archive.org/web/20210101211346/https://www.ioccc.org/) on
[GitHub](https://github.com).  From this point on, the [official IOCCC web
site](https://www.ioccc.org) became a [GitHub Pages](https://pages.github.com)
website.

#### 2020 Dec 28 bzip2 compressed tarball archive

Furthermore, a bzip2 compressed tarball containing the released
IOCCC entry source code may be found under the
[archive/historic](archive/historic/index.html) directory.  The file
[archive-all.tar.bz2](archive/historic/archive-all.tar.bz2) contains
all years and the individual years are in the form
`archive/historic/archive-YYYY.tar.bz2`.

These files were obtained from the [Internet Wayback
Machine](https://web.archive.org) from the [snapshot of the website
on 2020 Dec
28](https://web.archive.org/web/20201228005211/https://www.ioccc.org/).
See [archive/historic/index.html](archive/historic/index.html) for
details about these bzip2 compressed tarballs.


#### 2022 Dec 29 Official IOCCC winner repo

The [Official IOCCC winner repo](https://github.com/ioccc-src/winner)
was [created on 2020 Dec
29](https://github.com/ioccc-src/winner/commit/28efc67f5dd692a3544708bf7fa26286adb82dfb).


#### 2020 Dec 30 IOCCC content uploaded to GitHub

An [IOCCC judge](https://www.ioccc.org/judges.html) formed a local
directory [git](https://git-scm.com) repo on **Tue Dec 29 23:48:30
2020 -0800** via [commit
28efc67f5dd692a3544708bf7fa26286adb82dfb](https://github.com/ioccc-src/winner/commit/28efc67f5dd692a3544708bf7fa26286adb82dfb)
and then on **Wed Dec 30 16:57:03 2020 -0800** added a preview of
1984-2019 via [commit
c0663537cb88d39b74285a930ff1a668c6d5968b](https://github.com/ioccc-src/winner/commit/c0663537cb88d39b74285a930ff1a668c6d5968b).

On 2020 Dec 30, with [commit
c0663537cb88d39b74285a930ff1a668c6d5968b](https://github.com/ioccc-src/winner/commit/c0663537cb88d39b74285a930ff1a668c6d5968b),
the [official IOCCC website of 2022 Dec
29](https://web.archive.org/web/20221231001721/https://www.ioccc.org/) was
uploaded into the [Official IOCCC winner
repo](https://github.com/ioccc-src/winner).


#### 2020 IOCCC winning entries released using git via GitHub

The [winning
entries](https://github.com/ioccc-src/winner/commit/9d61fc0fb4a3245afb1435458cfb597fad0e8e6a)
of the [IOCCC 2020](years.html#2020),
after a far too long of a delay
(due in part to a [former IOCCC judge whose resignation was noted on
2021 Jan 04](https://github.com/ioccc-src/winner/commit/c94fc84c35dc83e3eb9900720b95917a15c27afe) commit)
from their initial [2020 Jul 25
announcement](https://web.archive.org/web/20200726232505/http://www.ioccc.org:80/index.html),
were added by an [IOCCC judge](https://www.ioccc.org/judges.html)
to their local [git](https://git-scm.com) repository and then were
merged into the [Official IOCCC winner repo on 2020 Dec
31](https://github.com/ioccc-src/winner/commit/b1638ff0012964d79ab1c44aa815d3f824f35b6c).

These [2020 IOCCC winning entries](years.html#2020),
as shown in the [Internet Wayback Machine](https://web.archive.org)
[snapshot of 2021 Jan 02](https://web.archive.org/web/20210102042216/www.ioccc.org/years.html)
were the first IOCCC entries to have been released via
[git](https://git-scm.com) and [GitHub](https://github.com).


#### 2020 Dec 30 thru 202y MMM DD - Work on the temp-test-ioccc GitHub repo

Starting on [2020 Dec
30](https://github.com/ioccc-src/winner/commit/2f20ae8451ada03f4601ac727d10e1d8630861a8)
edits to the [Official IOCCC winner
repo](https://github.com/ioccc-src/winner) began.

The local [git](https://git-scm.com) repository of an [IOCCC
judge](https://www.ioccc.org/judges.html) was [edited starting Wed
Dec 30 16:57:03 2020
-0800](https://github.com/ioccc-src/winner/commit/c0663537cb88d39b74285a930ff1a668c6d5968b)
and was occasionally committed to the [Official IOCCC winner
repo](https://github.com/ioccc-src/winner).

The [first accepted pull request](https://github.com/ioccc-src/winner/pull/2) to
the [Official IOCCC winner repo](https://github.com/ioccc-src/winner) was made
by [Yusuke Endoh](https://www.ioccc.org/winners.html#Yusuke_Endoh)  on [2021 Jan
5](https://github.com/ioccc-src/winner/commit/84c62c4cbf56ac1351ea91e5019f51103615fda2).


Between [Wed Dec 30 16:57:03 2020
-0800](https://github.com/ioccc-src/winner/commit/c0663537cb88d39b74285a930ff1a668c6d5968b)
and [Sat Jan 29 21:56:53 2022
-0800](https://github.com/ioccc-src/winner/commit/098a3e7e04d43e480ecc4b5482c83274e1434002),
an [IOCCC judge](https://www.ioccc.org/judges.html) made edits to
their local repository with occasional pushes to the [Official IOCCC winner
repo](https://github.com/ioccc-src/winner) and the [Official
www.ioccc.org website](https://www.ioccc.org/index.html).  After
that time and until the **Great Fork Merge**, very few changes
were made to the [Official IOCCC winner
repo](https://github.com/ioccc-src/winner) and the [Official
www.ioccc.org website](https://www.ioccc.org/index.html) most of
which were news updates.

While the [temp-test-ioccc
repo](https://github.com/ioccc-src/temp-test-ioccc) has history
going back to [2020 Dec
29](https://github.com/ioccc-src/temp-test-ioccc/commit/28efc67f5dd692a3544708bf7fa26286adb82dfb),
the repo was forked on **Sun Sep 18 17:30:00 2022 -0700**.  The
first [push into the temp-test-ioccc
repo](https://github.com/ioccc-src/temp-test-ioccc/commit/edbc3089e1b755d85a020af7975bbc7df3737a5f)
occurred on Sun Sep 18 11:15:49 2022 -0700.

At this same time, the [temp-test-ioccc website](https://ioccc-src.github.io/temp-test-ioccc/) went live.

Edits were made by an [IOCCC judge](https://www.ioccc.org/judges.html)
to their local [git](https://git-scm.com) repository and [were pushed into the temp-test-ioccc
repo](https://github.com/ioccc-src/temp-test-ioccc/commit/2f20ae8451ada03f4601ac727d10e1d8630861a8)
and to the [temp-test-ioccc website](https://ioccc-src.github.io/temp-test-ioccc/).

The [first accepted pull request](https://github.com/ioccc-src/temp-test-ioccc/pull/15)
made directly to the [temp-test-ioccc
repo](https://github.com/ioccc-src/temp-test-ioccc) on
[Wed Feb 22 05:44:55 2023 -0800 with commit
11bb36ac8ce790f32a9a3e5d2131ee12820fb8ec](https://github.com/ioccc-src/temp-test-ioccc/commit/11bb36ac8ce790f32a9a3e5d2131ee12820fb8ec)
by [Cody Boone
Ferguson](https://www.ioccc.org/winners.html#Cody_Boone_Ferguson).

A [decision was made by the
IOCCC](https://github.com/ioccc-src/temp-test-ioccc/discussions/1918) to
mostly use frequent commits to individual components of the IOCCC,
rather than to use occasional site wide massive updates in order
to improve the tractability of changes made to components of the
IOCCC such as IOCCC entries although occasionally site wide updates
were performed in order to address an issue common to many IOCCC
entries.  And while some people prefer infrequent updates to a repo
the [IOCCC judges](https://www.ioccc.org/judges.html) believe
the ability to trace changes with commit messages is important.

Changes to the IOCCC content included things such as:

* Moving IOCCC entries into their own separate directories.
* Establishing a detailed manifest for an IOCCC winning entries.
* Fixing lots and lots of typos.
* Fixing Makefiles and code to allow for nearly all winning entries to be
compiled with/in modern systems.
* Fixing Makefiles and code to allow for nearly all winning entries to run
with/in modern systems.
* Reworking the Makefiles to use a consistent set of rules.
* Reworking the Makefiles specific to the gcc and clang C compilers.
* Replacing the various hint files with a index.html markdown (from README.md
files) that is more consistent across IOCCC years.
* Generating HTML content from markdown files and JSON data files via a [set of
tools and scripts](bin/index.html).
* Setting up a system whereby authors of IOCCC entries may update their own
contact information via a [GitHub pull
request](https://github.com/ioccc-src/winner/pulls).
* Setting up to generate the top level [years.html](years.html) file via the
[gen-years.sh](%%REPO_URL%%/bin/gen-years.sh) tool.
* Setting up to generate the top level [authors.html file](authors.html), renamed
from `winners.html`, via the [gen-authors.sh](%%REPO_URL%%/bin/gen-authors.sh) tool.
* Making use of a new and improved [IOCCC CSS](%%REPO_URL%%/ioccc.css) for website consistency
* Etc.


<div id="great_fork_merge_date">
#### 202y mm dd The Great Fork Merge <!-- XXX - Fill in the date when Great Fork Merge happens -->
</div>

As of 2024 Sep 1 [temp-test-ioccc
repo](https://github.com/ioccc-src/temp-test-ioccc)
there were [5858 commits ahead](https://github.com/ioccc-src/winner/compare/master...ioccc-src:temp-test-ioccc:master)
of the [IOCCC winner repo](https://github.com/ioccc-src/winner).

On 202y mm dd, the temporary repo was merged back into the [IOCCC winner
repo](https://github.com/ioccc-src/winner) resulting in many, many substantial improvements
to the [official IOCCC website](https://www.ioccc.org).

Jump to: [top](#)


<div id="size_rule_history">
<div id="size_restriction">
### Q: How has the IOCCC size limit rule changed over the years?
</div>
</div>

The IOCCC size rule has changed over the years.

In later years, Rule 2 was split into two parts.  These two parts of Rule 2 are:

* Rule 2a: Overall size limit of "prog.c"
* Rule 2b: Size of "prog.c", w/o counting certain types of characters

<div id="size_rule1984-1985">
#### IOCCC 1984-1985
</div>

**NOTE**: The size rule was actually rule 1.

* Rule 2a: 512
* Rule 2b: n/a

<div id="size_rule1986-1987">
#### IOCCC 1986-1987
</div>

**NOTE**: The size rule was actually rule 1.

* Rule 2a: 1024
* Rule 2b: n/a

<div id="size_rule1988-1991">
#### IOCCC 1988-1991
</div>

**NOTE**: The size rule was actually rule 1.

* Rule 2a: 1536
* Rule 2b: n/a

<div id="size_rule1992-2000">
#### IOCCC 1992-2000
</div>

* Rule 2a: 3217
* Rule 2b: 1536

<div id="size_rule2001-2012">
#### IOCCC: 2001-2012
</div>

* Rule 2a: 4096
* Rule 2b: 2048

<div id="size_rule2013-2020">
#### IOCCC 2013-2020
</div>

* Rule 2a: 4096
* Rule 2b: 2053

<div id="size_rule2024-xxxx">
#### IOCCC 2024-date
</div>

* Rule 2a: 4993
* Rule 2b: 2503

Jump to: [top](#)


<div id="great_fork_merge">
### Q: What is the **Great Fork Merge**?
</div>

The **Great Fork Merge** was when thousands of changes that had been applied to the
[temp-test-ioccc repo](https://github.com/ioccc-src/temp-test-ioccc) was applied
to the [Official IOCCC winner repo](https://github.com/ioccc-src/winner) causing the
[Official IOCCC website](index.html) to be updated into its present form.

See the
FAQ on "[Great Fork Merge Date](#great_fork_merge_date)"
for more information.

Jump to: [top](#)


<div id="ioccc_bof">
<div id="bof">
### Q: What is an IOCCC BOF?
</div>
</div>

The term **IOCCC BOF** stood for **International Obfuscated C Code
Contest Birds Of a Feather**.  It was a special session held at the
general [USENIX conference](https://www.usenix.org/conferences), usually
immediately after the BSD BOF, where the winners of a new IOCCC were
announced in the early years of the IOCCC.

Jump to: [top](#)


<div id="explain_IOCCC">
### Q: I do not understand the IOCCC, can you explain it to me?
</div>

The IOCCC stands for the International Obfuscated C Code Contest.
The IOCCC is a C programming contest.

The goals of the IOCCC are:

* To write the most Obscure/Obfuscated C program within the rules.
* To show the importance of programming style, in an ironic way.
* To stress C compilers with unusual code.
* To illustrate some of the subtleties of the C language.
* To provide a safe forum for poor C code. :-)
* To have fun with C!

See the
FAQ on "[start of the IOCCC](#ioccc_start)"
and the
FAQ on "[history of the IOCCC](#website_history)"
for more information the background of the IOCCC.

See the
FAQ on "[entering the IOCCC](#submit)"
for information on how to enter and submit to the IOCCC.

If you are still confused, consider the nature of
the [IOCCC rules](next/rules.html) and of the [IOCCC
guidelines](next/guidelines.html).  You will see a dose of the technical,
mixed with "nerd humor" (or humour if you prefer 🤓).

If after all that you are still confused, sorry (tm Canada 😉).
Consider this: While the IOCCC often attempts to be presentable,
it is under no obligation to be wholly understandable.  One might
say that to truly understand the IOCCC is problematic. And if
someone did manage to fully understand the IOCCC, then perhaps
this **modified** quote from the [The Hitchhiker's Guide to the
Galaxy](https://en.wikipedia.org/wiki/The_Hitchhiker's_Guide_to_the_Galaxy)
may apply:

> "There is a theory which states that if ever anyone discovers
exactly what the IOCCC is for and why it is here, it will
instantly disappear and be replaced by something even more bizarre
and inexplicable.
>
> There is another theory which states that this has
[already happened](#great_fork_merge)." 😜

Share and enjoy! ☺️

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
