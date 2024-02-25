# bin

The directory holds [bin](README.md) directory
holds tools that build files, such as HTML content, for the
[official IOCCC web site](https://www.ioccc.org).

For HTML content, the [bin](README.md) directory tools
makes use of HTML fragments from the [inc](../inc/README.md) directory
as well as various JSON files and other content from the
[IOCCC GitHub repo](https://github.com/ioccc-src/temp-test-ioccc).


## bin tools


### [all-run.sh](all-run.sh)

Run a command on all winning entries.

For example:

```sh
bin/all-run.sh -v 3 bin/quick-readme2index.sh -v 1
```

Or for example:

```sh
bin/all-run.sh -v 3 bin/readme2index.sh -v 1
```


### [all-years.sh](all-years.sh)

Run a command on all IOCCC years.

For example:

```sh
all-years.sh -v 1 bin/gen-year-index.sh -v 1
```

Or for example:

```sh
all-years.sh -v 1 bin/chk-entry.sh
```


### [chk-entry.sh](chk-entry.sh)

Check of files required by an entry matches the entry's manifest as found in `.entry.json`.

For example:

```sh
bin/chk-entry.sh 2020/ferguson1
```


### [filelist.entry.json.awk](filelist.entry.json.awk)

Generate the list of files in the entry's manifest `.entry.json`.

For example:

```sh
awk -f bin/filelist.entry.json.awk 2020/ferguson1/.entry.json
```


### [gen-authors.sh](gen-authors.sh)

Generate the top level `/authors.html` page.

Usage:

```sh
bin/gen-authors.sh -v 1
```


### [gen-location.sh](gen-location.sh)

Generate the top level `/location.html` page.

Usage:

```sh
bin/gen-location.sh -v 1
```


### [gen-top-md2html.sh](gen-top-md2html.sh)

Generate a number of top level HTML pages for the IOCCC web sites.

Usage:

```sh
bin/gen-top-md2html.sh -v 1
```

Examples of top level HTML pages built by this tool include:

- [CODE_OF_CONDUCT.html](CODE_OF_CONDUCT.html)
- [README.html](README.html)
- [bugs.html](bugs.html)
- [contact.html](contact.html)
- [faq.html](faq.html)
- [thanks-for-help.html](thanks-for-help.html)


### [gen-year-index.sh](gen-year-index.sh)

Generate an `index.html` page for an given IOCCC year.

Usage:

```sh
bin/gen-year-index.sh -v 1 2020
```


### [gen-years.sh](gen-years.sh)

Generate the top level `/years.html` page.

Usage:

```sh
bin/gen-years.sh -v 1
```


### [ioccc-status.sh](ioccc-status)

Updates the [status.json](/status.json) file.


### [manifest.entry.json.awk](manifest.entry.json.awk)

Output manifest table from a entry .entry.json file.


### [md2html.sh](md2html.sh)

This is the primary tool that forms IOCCC generated HTML content from
markdown files (permanent markdown files or temporarily generated
markdown files) and HTML fragments from the [inc](/inc) directory.

The [../inc/md2html.cfg](../inc/md2html.cfg) configuration file is
used by [md2html.sh](md2html.sh) to drive the generation process.


### [output-index-author.sh](output-index-author.sh)

Output author(s) Related HTML for for an entry's index.html page.


### [output-index-inventory.sh](output-index-inventory.sh)

Output the inventory in HTML form for an entry's index.html page.


### [output-year-index.sh](output-year-index.sh)

Output markdown of winner links for a given year.


### [pandoc-wrapper.sh](pandoc-wrapper.sh)

Wrapper tool to run pandoc.


### [quick-readme2index.sh](quick-readme2index.sh)

Runs [readme2index.sh](readme2index.sh) if the entry directory
does not have a non-empty `index.hmtl` file, or if either
`.entry.json` or `README.md` is newer than the `index.hmtl` file.

This is useful when only a few entries have been
modified (resulting in an updated `.entry.json` file)
or if the `README.md` of a few entries have been changed.

While the [readme2index.sh](readme2index.sh) take a few
seconds to run, when applied to 300+ entries,
the extra time can add up.

If only a few `index.hmtl` files need updating, then
this command will only briefly pause while the
slightly longer [readme2index.sh](readme2index.sh) is run:

```sh
bin/all-run.sh -v 3 bin/quick-readme2index.sh -v 1
```

**NOTE**: This command assumes that the relative
modification times for `index.hmtl`, .entry.json`,
and `README.md` are correct.  If in doubt, use:

```sh
bin/all-run.sh -v 3 bin/readme2index.sh -v 1
```


### [readme2index.sh](readme2index.sh)

Convert a entry README.md into entry directory index.html.


### [sgi.sh](sgi.sh)

Sort .gitignore content from stdin to stdout.

We sort with lines starting with # first.
We sort with lines starting with * second.
We sort with lines that do not start with [#!*] third.
We sort with lines starting with ! fourth.

This tool is used by [sort.gitignore.sh](sort.gitignore.sh).


### [sort.gitignore.sh](sort.gitignore.sh)

Sort a .gitignore in a entry directory.

Usage:

```sh
bin/sort.gitignore.sh -v 1 YYYY/dir
```

Suggested usage:

```sh
bin/all-run.sh bin/sort.gitignore.sh -v 1
```


### [subst.default.sh](subst.default.sh)

Print default substitutions.


### [subst.entry-index.sh](subst.entry-index.sh)

Print substitutions for a entry index.html.


### [subst.entry-navbar.awk](subst.entry-navbar.awk)

Output substitutions for navbar on behalf of a entry.


### [subst.year-index.sh](subst.year-index.sh)

Print substitutions for a year level index.html.


### [subst.year-navbar.awk](subst.year-navbar.awk)

Output substitutions for navbar on behalf of a year level index.html.


## [tar-entry.sh](tar-entry.sh)

Form a compress tarball for an entry.

Usage:

```sh
bin/tar-entry.sh -v 1 YYYY/dir
```

Suggested usage:

```sh
bin/all-run.sh -v 3 bin/tar-entry.sh -v 1 -W
```


## [tar-all.sh](tar-all.sh)

Form the compressed tarball for all IOCCC years and all IOCCC entries.

Usage:

```sh
bin/tar-all.sh -v 1
```


## [tar-year.sh](tar-year.sh)

Form a compress tarball for an IOCCC year.

Usage:

```sh
bin/tar-year.sh -v 1 YYYY
```

Suggested usage:

```sh
bin/all-years.sh -v 3 bin/tar-year.sh -v 1 -W
```


# <a name="how"></a>How IOCCC HTML content is built

The [md2html.sh](md2html.sh) tool is the primary tool that
is used to form all IOCCC related HTML pages for the [official IOCCC web
site](https://www.ioccc.org).

Nearly all IOCCC related HTML pages are built from markdown files,
from either permanent markdown files or temporary generated markdown files,
as well as HTML fragments from the [inc](../inc/README.md) directory.

Most HTML content is built from permanant markdown files, such as a `README.md`
markdown file found in each entry directory.  Some HTML content are generated
from temporary markdown files.  These temporary markdown files are produced by
tools in the [bin](README.md) directory and exist only while the tool is running.

In addition to converting markdown to HTML, the canonical way that HTML content is
built uses, by default, files from the [inc](../inc/README.md) directory, of the form:

```
*.default.html
```

By using command line options of the form

```sh
-H phase=name
```

where `phase` is the name of an HTML phase,
a non-default file may be used.  For example:

```sh
-H topnav=up2index
```

will cause [inc/topnav.up2index.html](../inc/topnav.up2index.html)
instead of [inc/topnav.default.html](../inc/topnav.default.html) to be
used during the _topnav_ HTML phase.

If _name_ is dot (i.e., "."), then the given HTML phase is skipped.
For example:

```sh
-H footer=.
```

will cause no HTML content to be produced during the _footer_ HTML phase.



## <a name="html"></a>HTML phases

The following HTML phase files are used to build HTML content:

0. inc/top.default.html
1. inc/head.default.html
2. inc/body.default.html
3. inc/header.default.html
4. inc/topnav.default.html
5. inc/begin-row.default.html
6. inc/begin-leftcolumn.default.html
7. inc/sidenav.default.html
8. inc/end-leftcolumn.default.html
9. inc/begin-rightcolumn.default.html
10. inc/before-content.default.html

Phases 11-19 are reserved for future use.

20. ((insert 'before tool' output))
21. ((insert 'pandoc wrapper tool' output))
22. ((insert 'after tool' output))

Phases 23-29 are reserved for future use.

30. inc/after-content.default.html
31. inc/end-rightcolumn.default.html
32. inc/end-row.default.html
33. inc/footer.default.html
34. inc/bottom.default.html

Phases 35-39 are reserved for future use.

In the above HTML phase numbers, except during HTML phase numbers 20-29, symbols of the form %%TOKEN%% are substituted.
Any %%TOKEN%% printed by the 'before tool' (-b tool), the 'pandoc wrapper tool' (-p tool), and the 'after tool' (-a tool)
are ignored (i.e., not substituted).

See the tool [readme2index.sh](readme2index.sh) for an example of
how HTML phases are implemented.


## <a name="getopt"></a>Getopt phase processing of the command line

The command options are evaluated in the following getopt phases:


### Getopt phase 0

In getopt phase 0 we parse command line options and save all arguments for the end of the final command line.

Depending on the program, the argument at the end is directory under topdir, or it is a file under topdir.

In getopt phase 0 is the only getopt phase where "-d topdir" and "-c md2html.cfg" may be used.


### Getopt phase 1

In getopt phase 1 we execute each -o "output tool" from getopt phase 0, parsing the output as a command line.

The -o "output tool" may be given optstr from "-O tool=optstr", followed by the phase 0 argument.

The -o "output tool" is not allowed to output another "-o tool", nor a "-O tool=optstr".
Instead an -o "output tool" may execute another -o "output tool" merge the output into its own.


### Getopt phase 2

In getopt phase 2 we parse the "cfg_options" from the first "md2html.cfg" line matched by saved argument.

The match is made with the (possibly modified) phase 0 argument.


### Getopt phase 3

In getopt phase 3 we execute each -o "output tool" from getopt phase 2, parsing the output as a command line.

The -o "output tool" may be given optstr from "-O tool=optstr", followed by the phase 0 argument.

The -o "output tool" is not allowed to output another "-o tool", nor a "-O tool=optstr".
Instead an -o "output tool" may execute another -o "output tool" merge the output into its own.


### Command line option order

Most command line options override earlier copies of the same option.  However in the case of
'-H phase=name', later '-H phase=name' only overrides an earlier use of '-H' for the same 'phase' only.
Also in the case of '-s token=value', later '-s token=value' only overrides an earlier use of '-s'
for the same 'token' only.


### Output tools

An "output tool" may be used to add certain additional command line options to be processed.

IMPORTANT: An "output tool" will print each command line option / argument on a separate line.
So for example, if an "output tool" wishes to convey:

```
-s TITLE='IOCCC entry locations' -H topnav=top-of-site
```

The  "output tool" would output the following 4 lines:

```
-s
TITLE='IOCCC entry locations'
-H
topnav=top-of-site
```

The command line opions printed by an "output tool" are processed
after all command line options, and all options from a matching
line from the md2html.cfg file, and before any filename arguments
on the command line.

For exmaple:

```
command [command_options ..] [cfg_options ..] [output_tool_options ..] [--] [filename_arg ..]
```

Here the 'command' first processes any command line options, then
it processes 'cfg_options' obtained from this file from a 1st match of a given file_glob, then
it processes 'output tool' (i.e., -o tool) options found in 'command_options', and 'cfg_options', then
an optional -- (end of all options), then zero of more 'filename_arg' filename arguments.

The '-o tool' must NOT output any '-o tool' options as '-o tool' is NOT RECURSIVE.  A '-o tool' is free, however,
to execute other '-o tool' output tools and merge the output from those tools into its own.


### Special -E exitcode option

When '-E exitcode' is evaluated, the application will exit with the 'exitcode' value.  If one wishes to also
output a message to stderr, the '-e string' must come BEFORE any '-E exitcode' in the command line.


### Substitution tokens

All tokens (i.e., strings of the form '%%token%%') MUST be substituted (by some -s token=value)
in all HTML output, except during phase numbers 20-29 (i.e., except 'before tool' output, pandoc wrapper output,
and except 'after tool' output), or command will exit non-zero, unless -S is given.  If -S is given,
only a warning about un-substituted tokens will be written to stderr.


The command line of tools in the [bin](README.md) directory,
and perhaps modified via [md2html config file](../inc/md2html.cfg) file may change
to using a different filename for a given phase.

For example when forming the HTML from `2020/ferguson2/chocolate-cake.md`,
a different "topnav" navigation bar is needed.  So instead of the
usual top navigation bar that normally directs people to the previous
entry for the year, or go up to the year page, or to the next entry
for the year, a top navigation bar to just go up to the entry's
main page is needed.   A line in the [md2html config file](../inc/md2html.cfg) file
that refers to `2020/ferguson1/chocolate-cake.md` may specify use
of `topnav.up2index.html` instead of using the `topnav.default.html` default.

The HTML phase may be skipped resulting in no HTML output during a given phase.
Furthermore, forming HTML content from a given markdown file altogether.

See comments in the [md2html config file](../inc/md2html.cfg) file for details.
See also, the tool [readme2index.sh](readme2index.sh) for an example of
how such command lines are used.


# Use CAUTION when modifying inc files

Some of the files under this directory are used to form **MOST** of the HTML content
on the [official IOCCC web site](https://www.ioccc.org).

These files are used to form **MOST** of the HTML content
on the [experimental web site](https://ioccc-src.github.io/temp-test-ioccc/).

... and in particular files under [inc](../inc/README.md) that are of the form (called default HTML files) ...:

```
*.default.html
```

... contain default content used to form IOCCC HTML / IOCCC web pages.

Instead of editing the default HTML files in order to fix a special web page,
consider making a copy of the default file and modifying the [md2html config file](md2html.cfg) to refer to the copy instead.  That way your special case situation will
not impact **MOST** of the HTML content.


# Why do we do not use certain well-known HTML technologies

You may wonder why we need these files in the first place.
You may wonder why we even need the tools in the [bin](README.md) directory
when there other solutions available to form web pages.


## <a name="static-only"></a>Static web pages only

Here are some reasons why we are using these files and
special tools to create HTML content / IOCCC web pages:

We host [official IOCCC web site](https://www.ioccc.org) via [GitHub pages](https://pages.github.com).
As of the time this file written, **only static web pages are supported**.


## We cannot use server side include

We use [static web pages](#static-only), so use of "server side include" is not available to the IOCCC.

For example, Apache SSI "#include" does not work on [GitHub pages](https://pages.github.com).


## We cannot use a back-end database

We use [static web pages](#static-only), so use of "back-end database" is not available to the IOCCC.


## <a name="why-github"></a>We cannot use non-GitHub web servers

The [GitHub pages](https://pages.github.com) have the distributed server capacity needed to handle
the **huge download volume** or [Slashdot effect](https://en.wikipedia.org/wiki/Slashdot_effect)
that happens when a IOCCC entries are published.

Most so-called low cost web hosting sites have a somewhat hidden excessive bandwidth charge
and/or cap bandwidth when the volume gets too high, and/or do not have the infrastructure
that can handle the [Slashdot effect](https://en.wikipedia.org/wiki/Slashdot_effect).

The IOCCC had experience with people offering web mirrors and even free hosting
only to find that the generous benefactor moves on, or their service is purchased
by someone else who is not so generous.  While it is possible that GitHub might someday
suffer a similar fate, for the time being we are betting that GitHub will remain
willing to host the IOCCC.

The [official IOCCC web site](https://www.ioccc.org) is, after all, primarily C source code
with some supporting documentation.  As such it is a natural fit for GitHub and
[GitHub pages](https://pages.github.com).


## We cannot use the HTML object tag

The _<_ object _>_ HTML tag does not work for our needs.

The browser context relationship between the HTML content holds the
HTML tag does not extend into the content that the tag includes.
For example, menu bars will not operate as specified by the [ioccc CSS](../ioccc.css).


## We cannot use the HTML embed tag

The _<_ embed _>_ HTML tag does not work for our needs.

This tag wants one to specify the _width_ and _height_ in pixels.
Use of a percentage is not officially supported even if some browsers
might do so.  Our Responsive Web Design on the [ioccc CSS](../ioccc.css)
needs to be responsive to small-sized cell phone-like screens,
mid-sized table-like screens, as well as large-sized desktop-like screens.
Specifying a _width_ and _height_ in pixels will not work well in
all of those screen size contexts.


## We cannot use the HTML iframe tag

The _<_ iframe _>_ HTML tag does not work for our needs.

This tag wants one to specify the _width_ and _height_ in pixels.
Use of a percentage is not officially supported even if some browsers
might do so.  Our Responsive Web Design on the [ioccc CSS](../ioccc.css)
needs to be responsive to small-sized cell phone-like screens,
mid-sized table-like screens, as well as large-sized desktop-like screens.
Specifying a _width_ and _height_ in pixels will not work well in
all of those screen size contexts.


## We cannot use JavaScript to include content

We do not use JavaScript to include HTML content.

While the IOCCC may use JavaScript in the future to directly render things like C source code,
we will do so in such a way that someone will be able to view [official IOCCC web site](https://www.ioccc.org)
content with JavaScript disabled.

The IOCCC will **NOT MANDATE USE OF JavaScript** to view [official IOCCC web site](https://www.ioccc.org).

For this reason, we cannot use JavaScript include HTML content.


# <a name="terms"></a>IOCCC terms

The following IOCCC terms apply to tools, JSON files, and the directory structure of this repo.


## `author`

An individual who was an `author` of at least one winning IOCCC entry.

Some authors have submitted more than one IOCCC entry that won.  Some winning
IOCCC entries have more than one author.


## `author_handle`

An `author_handle` is string that refers to a given author and is unique to the
IOCCC.  Each author has exactly one `author_handle`.

For each `author_handle`, there will be a JSON file of the form:

```
author/author_handle.json
```

Because the `author_handle` is used to form a JSON filename, the string must be
lower case POSIX safe string.  Furthermore, the `author_handle` must be an ASCII
string that matches this regexp:

```re
^[0-9a-z][0-9a-z_]*$
```

Default `author_handle`'s do not have multiple consecutive `_` (underscore)
characters.  Nevertheless, multiple consecutive `_` (underscore) characters are
allowed. Contest submitters who wish to override the `author_handle` may do so.

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

NOTE: even if the directory name is not `anonymous` the above rules apply as in
in the case of [2005/anon](/2005/anon/anon.c).

Anonymous `author_handle`'s match this regexp:

```re
Anonymous_[0-9][0-9][0-9][0-9][.0-9]*$
```


## `entry`

An IOCCC entry that won an award for given IOCCC.

A `entry` has one more more `author`s.

Each `entry` is contained under its own directory.  The parent of the entry directory
is the year's directory.

While in most cases a `entry` consists of files under a entry's directory,
there are a few cases where a `entry` directory contains subdirectories.

Use of subdirectories under a `entry` directory is discouraged and
may be limited to previous `entry`s that used them.

NOTE: In the past, the term _winner_ was used in instead of today's term of _entry_.


## `year`

A `year` is a 4 character string.  Most years are 4-digit strings that
represent the year.  Some special `year` strings are possible, such as _`mock`_.
Non-numeric `year` strings are lower case.

A `year` string matches this regexp:

```re
[0-9a-z][0-9a-z][0-9a-z][0-9a-z]
```

The `year` directories reside directly below the top level directory.


## `.year`

Each `year` will have a file directory under it named:

```
.year
```

The contents of the `.year` file is the year string of the directory. For
instance, [2020/.year](/2020/.year) has the string: `2020`.


## `dir`

A `dir` is a POSIX safe string that holds an entry.

A `dir` is a string that matches this regexp:

```re
^[a-z][0-9a-z.-]*$
```

Each `_entry_ is under its own individual directory.  This directory
is directly under a `year` directory.


### `entry_id`

A string that identifies the winning entry.  The string is of the form:

```
year_dir
```
