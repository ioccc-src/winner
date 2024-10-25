# bin

> "After 50+ years, the UNIX command line remains very powerful." -- Landon Noll
>
> An answer to (Monty)? Pythonesque question of why these tools
> weren't written in a certain language.  :-)

The [bin directory](index.html) holds tools that build files, such as HTML
content, for the [official IOCCC website](https://www.ioccc.org).

For HTML content, the [bin directory](index.html) tools make use of HTML
fragments from the [inc directory](../inc/index.html) as well as various JSON
files and other content from the [IOCCC GitHub
repo](https://github.com/ioccc-src/temp-test-ioccc).


## [bin/](index.html) tools

All tools in this directory support a number of options that can be used to get
help, diagnose problems, see progress etc. These options are as follows:

### Get help / usage string of a tool

If you need to remember the syntax of the tool or get certain notes about
different options, you can use the `-h` option.

For instance if you want help on the [all-run.sh](index.html#all-run) tool
from the root directory (of the repo/website), you would do:


``` <!---sh-->
    bin/all-run.sh -h
```


### Set verbosity level of a tool

If you want verbosity, say for debugging purposes or to see what is
going on more, you should use the `-v level` option. For instance if you wish to
see what is going on with the
[quick-readme2index.sh](index.html#quick-readme2index) tool, you might do:


``` <!---sh-->
    bin/quick-readme2index.sh -v 3
```

to set the verbosity level to `3`. The default for verbosity is `0`, no
verbosity, though using the [top level Makefile](%%REPO_URL%%/Makefile) will,
for some tools, set a verbosity level.


### Get version string of a tool

If you just want to know what version the tool is, you can use the `-V` option.
For instance to see what version the [chk-entry.sh](index.html#chk-entry) tool
is, you would do:

``` <!---sh-->
    bin/chk-entry.sh -V
```


### Other notes about some of the common options

These options, and especially `-h` and `-v level`, can be very useful to get
basic usage information and to see what is going on when the tool is running.
For more details on each tool, including the ones mentioned above, see below. As
you go through each tool, if you need to understand more of it, we recommend
that you use the `-h` option on it first.

There are some scripts that are invoked by the
[bin/md2html.cfg](%%REPO_URL%%/bin/md2html.cfg) file but some of these tools can
be directly invoked as well, should you wish to see their output or if you have
some odd need to do so.


<div id="all-jfmt">
### [all-jfmt.sh](%%REPO_URL%%/bin/all-jfmt.sh)
</div>

Canonically format all entry and author JSON files

Usage:

``` <!---sh-->
    bin/all-jfmt.sh -v 3
```

Alternate usage:

``` <!---sh-->
    make all_jfmt
```


<div id="all-years">
### [all-years.sh](%%REPO_URL%%/bin/all-years.sh)
</div>

Run a command on all IOCCC years.

Usage:

``` <!---sh-->
    bin/all-years.sh -v 1 bin/gen-year-index.sh -v 1
```

If you wish to run instead, for example, [chk-entry.sh](#chk-entry), then do:

``` <!---sh-->
    bin/all-years.sh -v 1 bin/chk-entry.sh
```


<div id="all-run">
### [all-run.sh](%%REPO_URL%%/bin/all-run.sh)
</div>

Run a command on all winning entries.

Usage:

``` <!---sh-->
    bin/all-run.sh -v 3 bin/quick-readme2index.sh -v 1
```

If you wish to run instead, for example, [readme2index.sh](#readme2index), then
do:


``` <!---sh-->
    bin/all-run.sh -v 3 bin/readme2index.sh -v 1
```


<div id="all-years">
### [all-years.sh](%%REPO_URL%%/bin/all-years.sh)
</div>

Run a command on all IOCCC years.

Usage:

``` <!---sh-->
    bin/all-years.sh -v 1 bin/gen-year-index.sh -v 1
```

If you wish to run instead, for example, [chk-entry.sh](#chk-entry), then
do:

``` <!---sh-->
    bin/all-years.sh -v 1 bin/chk-entry.sh
```


<div id="chk-entry">
### [chk-entry.sh](%%REPO_URL%%/bin/chk-entry.sh)
</div>

Check an entry directory to verify that all the files in its manifest
(`.entry.json`) exist in the git repo.

Usage:

``` <!---sh-->
    bin/chk-entry.sh 2020/ferguson1
```

If you wish to run it on all entries, we recommend that this tool be invoked via
the top level `Makefile`:

``` <!---sh-->
    make verify_entry_files
```

**NOTE**: see the
FAQ on "[.entry.json files](../faq.html#entry_json)"
for more details on `.entry.json` files.


<div id="combine-author-handle">
### [combine_author_handle.sh](%%REPO_URL%%/bin/combine_author_handle.sh)
</div>

Combine all author/author_handle.json files as single JSON file.

The purpose of this tool is to make looking for information across all
authors faster by temporarily forming them into a single JSON file.

Because `jsp(1)` open remembers the last copy of a given JSON member name.
As such, we change the JSON member name "winning_entry_set" into
a unique "winning_entry_set.FILENO" where FILENO is the file number.
This the JSON member value will be preserved across all files.

We also convert where FILENO is the file number and FILENAME is the filename:

``` <!---json-->
   "sort_word" : "data",
```

into:

``` <!---json-->
   "sort_word.FILENO" : [
       {
           "sort_word" : "data FILENAME"
       }
   ],
```

This will allow `jsp(1)` to print sort_word values.

We also make sure that the last item from a given file ends in a comma (",)",
due to the bogosity of the so-called JSON spec.

Usage:

``` <!---sh-->
    bin/combine_author_handle.sh > combined_author_handle.json
```

**NOTE**: This tool assume that all JSON files have been formatted with the
`bin/jprint-wrapper.sh` tool.  In particular the first line is just "{:,
and the last line is just "}" and each JSON element is on its own line.

**NOTE**: see the
FAQ on "[author_handle.json](../faq.html#author_handle_json)"
for more details on `author_handle.json` files.


<div id="csv2entry">
### [csv2entry.sh](%%REPO_URL%%/bin/csv2entry.sh)
</div>

Convert CSV files into `.entry.json` for all winning IOCCC entries.

This tool takes as input, the following CSV files:

- [author_wins.csv](#author_wins_csv) - `author_handle` followed by all their
`entry_id`s
- [manifest.csv](#manifest_csv) - information about files under an entry
- [year_prize.csv](#year_prize_csv) - `entry_id` followed by the entry's award
title

This tool updates `.entry.json` files entries whose content is modified.

Usage:

``` <!---sh-->
    bin/csv2entry.sh -v 1
```

There is no requirement to sort the CSV files (say through the spreadsheet
application prior to exporting), convert them to UNIX format, or append a final
newline to the file.

This tool will canonicalize the CSV files before using them
as input.  Thus, if one wishes to import the CSV file into
some spreadsheet such as the [macOS](https://www.apple.com/macos)
[Numbers](https://www.apple.com/numbers/) spreadsheet application,
modify the content and finally export back to the CSV file,
this tool will modify the CSV file (if needed) in order
to restore the CSV order and other canonicalizing processes.

This tool will flag as an error, any empty fields, fields that are
an unquoted `NULL` or `null`, fields that start with whitespace,
fields that end with whitespace, or fields that contain consecutive
whitespace characters.

**NOTE**: see the
FAQ on "[.entry.json files](../faq.html#entry_json)"
for more details on `.entry.json` files.


#### Internal details of `bin/csv2entry.sh`

We first canonicalize the CSV files by replacing any "carriage
return line feeds" with "newlines".  We also make sure that the CSV
files end in a newline.  We do this because some spreadsheet
applications, when exporting to a CSV file, do not do this.

We also sort the CSV files in the same way that [entry2csv](#entry2csv) sorts
its CSV output files.  We do this in case the CSV files were imported into a
spreadsheet where their order was changed before exporting.  This means one is
free to order the CSV file content as you wish as this tool will reset these CSV
files.

Next this tool processes the non-CSV comment lines in
[manifest.csv](#manifest_csv).  The 1st and 2nd fields of
[manifest.csv](#manifest_csv) refer to entry YYYY and entry subdirectory (i.e.,
the `YYYY/dir` directory under the root of the git repository).  From that list of
`YYYY/dir` IOCCC entry directories, we will create the `.entry.json` files.  We
only modify those `.entry.json` files when their content changes.

**IMPORTANT NOTE**: while this tool uses `jparse(1)` to verify that the modified
`.entry.json` contains valid JSON content, **this tool does NOT perform ANY
semantic checks**.  For example, this tool does **NOT** verify that the manifest in
the `.entry.json` file matches the files in the `YYYY/dir directory`, or even
that the `.entry.json` contains a manifest (or any of the other required JSON
content). Another tool will be modified to do this, at a later date.

**NOTE**: you can obtain `jparse(1)` from the which can be obtained from the
[mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry)'s copy of the
[jparse repo](https://github.com/xexyl/jparse/).


<div id="cvt-submission">
### [cvt-submission.sh](%%REPO_URL%%/bin/cvt-submission.sh)
</div>

This tool is used by the [Judges](../judges.html) as part of the final
steps to announce a new set of winning IOCCC entries.

Given a submission (that has won the IOCCC and thus will become an entry), with a `.auth.json`
and `.info.json`, we convert the `.auth.json` and `.info.json` into a new `.entry.json` file.

**NOTE**: the `.auth.json` and `.info.json` files are formed by the
`mkiocccentry(1)` tool from the [mkiocccentry GitHub
repo](https://github.com/ioccc-src/mkiocccentry) as part of packaging
submissions.

We will also form new `author/author_handle.json` (see the
FAQ on "[author_handle.json files](../faq.html#author_json)"
for more information) and update `author/author_handle.json`
for [authors](../authors.html) who previously won. See also the
FAQ on "[author_handle](../faq.html#author_handle_faq)".
See also the
FAQ on "[.entry.json](../faq.html#entry_json)".

Usage:

``` <!---sh-->
    bin/cvt-submission.sh -v 1 YYYY/dir
```

Here, `YYYY/dir` is the path of the submission under the `YYYY` year directory.

This tool will form a compressed tarball of any files under `YYYY/dir`
that could be modified or removed by this tool (unless `-N` is used in which
case this tool does nothing).  The compressed tarball, formed by default
under the `/var/tmp` directory, may contain such as:

- `YYYY/dir/.info.json`
- `YYYY/dir/.auth.json`
- `YYYY/dir/remarks.md`
- `YYYY/dir/README.md`
- `YYYY/dir/index.md`
- `YYYY/dir/YYYY_dir.tar.bz2`
- `author/author_handle.json` (could be more than one file)

Only those files that exist will be put into the compressed tarball.
The compressed tarball formed (by default under the `/var/tmp` directory)
is of the following form:

> YYYY_dir.mods.YYYYMMDD.hhmmss.tar.bz2

Here "`YYYYMMDD.hhmmss`" is a date and timestamp from when the tool was executed.

The purpose of this compressed tarball is to allow the files in the
entry directory (that could be modified or removed by this tool)
to be restored as follows:

``` <!---sh-->
    tar -jxvf /var/tmp/YYYY_dir.mods.YYYYMMDD.hhmmss.tar.bz2 YYYY/dir
```

One may also restore modified `author/author_handle.json` files using:

``` <!---sh-->
    tar -jxvf /var/tmp/YYYY_dir.mods.YYYYMMDD.hhmmss.tar.bz2 author
```

This tool will form `YYYY/dir/README.md` if needed, from `YYYY/dir/remarks.md`,
`template/entry/README.md.head`, and `template/entry/README.md.tail`.

**NOTE**: This interactive tool (unless `-i input_data` is used) does
**NOT** perform all of the steps needed to make a directory for a new winning
IOCCC entry.  For example, files such as `YYYY/dir/README.md` and/or `YYYY/dir/index.html`
might contain "_triple X_" comments (`<!--XXXX-->`), indicating where the [Judges](../judges.html)
need to add content.  Moreover, the `Makefile` and `.gitignore` files
need to be examined for suitability, etc.

**HINT**: Executing this tool on your submission will **NOT** make you an IOCCC winner.  :-)


<div id="entry2csv">
### [entry2csv.sh](%%REPO_URL%%/bin/entry2csv.sh)
</div>

This tool takes as input, all entry `.entry.json` files
and updates 3 CSV files:

- [author_wins.csv](#author_wins_csv) - each `author_handle` followed by their `entry_id`s
- [manifest.csv](#manifest_csv) - information about all files in all entries
- [year_prize.csv](#year_prize_csv) - each `entry_id` followed by the entry's award title

The CSV files are written in a canonical UNIX format form.

Only those CSV files files whose content is modified are written.


#### Internal details of `bin/entry2csv.sh`

We generate CSV files from the `.entry.json` files from winning
IOCCC entries listed under years listed in the `.top` file,
and in subdirectories listed in the `YYYY/.year` file for the
given year.  Only those entries so listed are processed.

All IOCCC entry directories must have a `.path` file that lists
the path of the entry's directory from the `TOPDIR`.

**IMPORTANT NOTE**: when adding new IOCCC winning entries, the `.top` file
**MUST** be updated, and the new IOCCC year `YYYY/.year` files **MUST**
reference the directory of the new IOCCC entries.  Each entry directory **MUST**
also contain a `.path` file that contains the path of the IOCCC entry directory
from the `TOPDIR`.


<div id="filelist-entry-json-awk">
### [filelist.entry.json.awk](%%REPO_URL%%/bin/filelist.entry.json.awk)
</div>

Generate a list of files in an entry's manifest (the `.entry.json` file).

Usage:

``` <!---sh-->
    awk -f bin/filelist.entry.json.awk 2020/ferguson1/.entry.json
```

In this case the command will list all the files of the
[2020/ferguson1](../2020/ferguson1/index.html) winning entry.


<div id="find-missing-links">
### [find-missing-links.sh](%%REPO_URL%%/bin/find-missing-links.sh)
</div>

Find all markdown links to local files that do not exist.

This tool does **NOT** check that a remote URL exists, it checks on
links to local files.

This tool does **NOT** check links in a given place in a file, it
checks that local files linked by markdown actually exist.

This tool does **NOT** check HTML file links, it checks markdown
based links.

Usage:

``` <!---sh-->
    bin/find-missing-links.sh -v 1
```

If no missing links are found, this tool exits 0 with no output
(debug messages notwithstanding), otherwise this tool will exit non-zero.

**NOTE**: If the markdown link is malformed, this tool
might generate an error about a file that does exist.
If this tool claims that a file is missing that does exist,
look for a malformed markdown line and/or use of markdown
that is **NOT** an IOCCC markdown best practice.

See also the [IOCCC markdown best practices](../markdown.html) document for more
details.

We recommend that this tool be invoked via the top level `Makefile`:

``` <!---sh-->
    make find_missing_links
```

<div id="find-invalid-json">
### [find-invalid-json.sh](%%REPO_URL%%/bin/find-invalid-json.sh)
</div>

This script uses the `jparse(1)` tool, which can be obtained from the
[mkiocccentry repo](https://github.com/ioccc-src/mkiocccentry)'s copy of the
[jparse repo](https://github.com/xexyl/jparse/), and searches for any invalid
JSON files in the tree.

This is important because the IOCCC makes extensive use of JSON.

Usage:

``` <!---sh-->
    bin/find-invalid-json.sh -v 1
```

If no invalid JSON files are found, this tool exits 0 with no output
(debug messages notwithstanding), otherwise this tool will exit non-zero.

We recommend that this tool be invoked via the top level `Makefile`:

``` <!---sh-->
    make find_invalid_json
```


<div id="format-headers">
### [format-headers.sh](%%REPO_URL%%/bin/format-headers.sh)
</div>

Format select headers and preceding empty lines in entry README.md files.

Usage:

``` <!---sh-->
    bin/format-headers.sh
```


<div id="gen-authors">
### [gen-authors.sh](%%REPO_URL%%/bin/gen-authors.sh)
</div>

Generate the top level [authors.html](../authors.html) page.

Usage:

``` <!---sh-->
    bin/gen-authors.sh -v 1
```

We recommend that this tool be invoked via the top level `Makefile`:

``` <!---sh-->
    make gen_authors
```


<div id="gen-location">
### [gen-location.sh](%%REPO_URL%%/bin/gen-location.sh)
</div>

Generate the top level [location.html](../location.html) page.

Usage:

``` <!---sh-->
    bin/gen-location.sh -v 1
```

We recommend that this tool be invoked via the top level `Makefile`:

``` <!---sh-->
    make gen_location
```


<div id="gen-other-html">
### [gen-other-html.sh](%%REPO_URL%%/bin/gen-other-html.sh)
</div>

Generate the HTML files (other than the README.md to index.html files) from
markdown files, of all entries.

Usage:

``` <!---sh-->
    bin/gen-other-html.sh -v 1
```

We recommend that this tool be invoked via the top level `Makefile`:

``` <!---sh-->
    make gen_other_html
```


<div id="gen-sitemap">
### [gen-sitemap.sh](%%REPO_URL%%/bin/gen-sitemap.sh)
</div>

Generate an XML sitemap for the IOCCC website.

Usage:

``` <!---sh-->
    bin/gen-sitemap.sh -v 1
```

This would generate the [sitemap.xml](../sitemap.xml) file.

We recommend that this tool be invoked via the top level `Makefile`:

``` <!---sh-->
    make gen_sitemap
```


<div id="gen-status">
### [gen-status.sh](%%REPO_URL%%/bin/gen-status.sh)
</div>

Generate [status.json](../status.json) according to the modification date of
[news.md](%%REPO_URL%%/news.md) and/or whether the `contest_status` is changed
at the command line.

Without an argument, the `contest_status` is unchanged.

Usage:

``` <!---sh-->
    bin/gen-status.sh -v 1
```

To force the `contest_status` to be closed:

``` <!---sh-->
    bin/gen-status.sh -v 1 closed
```

To force the `contest_status` to be open:

``` <!---sh-->
    bin/gen-status.sh -v 1 open
```

To see other valid statuses:

``` <!---sh-->
    bin/gen-status -h
```

We recommend that this tool be invoked via the top level `Makefile`:

``` <!---sh-->
    make gen_status
```

unless the `contest_status` is to be changed, but since only the judges should
do that, that is not a problem.


<div id="gen-top-html">
### [gen-top-html.sh](%%REPO_URL%%/bin/gen-top-html.sh)
</div>

Generate a number of top level HTML pages for the IOCCC websites.

Usage:

``` <!---sh-->
    bin/gen-top-html.sh -v 1
```

Examples of top level HTML pages built by this tool include:

- [CODE_OF_CONDUCT.html](../CODE_OF_CONDUCT.html)
- [archive/historic/index.html](../archive/historic/index.html)
- [bin/index.html](../bin/index.html)
- [bugs.html](../bugs.html)
- [contact.html](../contact.html)
- [faq.html](../faq.html)
- [inc/index.html](../inc/index.html)
- [index.html](../index.html)
- [judges.html](../judges.html)
- [news.html](../news.html)
- [thanks-for-help.html](../thanks-for-help.html)

We recommend that this tool be invoked via the top level `Makefile`:

``` <!---sh-->
    make gen_top_html
```


<div id="gen-year-index">
### [gen-year-index.sh](%%REPO_URL%%/bin/gen-year-index.sh)
</div>

Generate an `index.html` page for a given IOCCC year.

Usage:

``` <!---sh-->
    bin/gen-year-index.sh -v 1 2020
```

This would create the [2020/index.html](../2020/index.html) file.

We recommend that this tool be invoked via the top level `Makefile`:

``` <!---sh-->
    make gen_year_index
```

which will create the `index.html` for every IOCCC year (`1984/index.html`,
`1985/index.html` etc.).


<div id="gen-years">
### [gen-years.sh](%%REPO_URL%%/bin/gen-years.sh)
</div>

Generate the top level [years.html](../years.html) page.

Usage:

``` <!---sh-->
    bin/gen-years.sh -v 1
```

We recommend that this tool be invoked via the top level `Makefile`:

``` <!---sh-->
    make gen_years
```


<div id="jfmt-wrapper">
### [jfmt-wrapper.sh](%%REPO_URL%%/bin/jfmt-wrapper.sh)
</div>

The [jfmt-wrapper.sh](%%REPO_URL%%/bin/jfmt-wrapper.sh) tool is a wrapper
tool for `jfmt(1)`, a tool that will format a JSON file into a canonical style.

**NOTE**: As of 2024 Oct 08 the `jfmt(1)` tool has not been written,
so [jfmt-wrapper.sh](%%REPO_URL%%/bin/jfmt-wrapper.sh) uses the
`JSONPath.sh(1)` tool from the recently forked and modified
[JSONPath.sh tool](https://github.com/lcn2/JSONPath.sh).

Usage:

``` <!---sh-->
    bin/jfmt-wrapper.sh .entry.json
```


<div id="jprint-wrapper">
### [jprint-wrapper.sh](%%REPO_URL%%/bin/jprint-wrapper.sh)
</div>

The [jprint-wrapper.sh](%%REPO_URL%%/bin/jprint-wrapper.sh) tool is a wrapper
tool for `jprint(1)`, a tool that will format JSON in a canonical style
to stdout.

**NOTE**: `jprint(1)` is a planned tool based on `jfmt(1)`.
As of 2024 Oct 08 that tool has not been written, so
[jprint-wrapper.sh](%%REPO_URL%%/bin/jprint-wrapper.sh) uses
the `JSONPath.sh(1)` tool from the recently forked and modified
[JSONPath.sh tool](https://github.com/lcn2/JSONPath.sh).

Usage:

``` <!---sh-->
    bin/jprint-wrapper.sh .entry.json
```

Or use in a pipe:

``` <!---sh-->
    cat .info.json | bin/jprint-wrapper.sh
```


<div id="jval-wrapper">
### [jval-wrapper.sh](%%REPO_URL%%/bin/jval-wrapper.sh)
</div>

The [jval-wrapper.sh](%%REPO_URL%%/bin/jval-wrapper.sh) tool is a wrapper
tool for `jval(1)`, a tool that will output a JSON value using the
XPath for JSON mechanism.  For information in XPath for JSON see:

- [https://goessner.net/articles/JsonPath/](https://goessner.net/articles/JsonPath/)
- [https://jsonpath.com](https://jsonpath.com)
- [https://github.com/lcn2/JSONPath.sh?tab=readme-ov-file#jsonpath-patterns-and-extensions](https://github.com/lcn2/JSONPath.sh?tab=readme-ov-file#jsonpath-patterns-and-extensions)

**NOTE**: As of 2024 Oct 08 the `jval(1)` tool has not been written,
so [jval-wrapper.sh](%%REPO_URL%%/bin/jval-wrapper.sh) uses the
`jsp(1)` tool from [https://github.com/kjozsa/jsp](https://github.com/kjozsa/jsp)
or if not found, the `JSONPath.sh(1)` tool from the recently forked and modified
[JSONPath.sh tool](https://github.com/lcn2/JSONPath.sh).

Usage:

``` <!---sh-->
    bin/jval-wrapper.sh [-b] [-q] [-T] file.json [pattern]

    -b        print only values (def: print both JSON member and JSON value)
    -q        remove enclosing double quotes (def: keep any enclosing double quotes)
    -T        trim all newlines (def: do not)

    file.json JSON file to process, - ==> read stdin
    pattern   Xpath for JSON query pattern
```

For example:


``` <!---sh-->
    bin/jval-wrapper.sh 1984/mullender/.entry.json '$.award'
    bin/jval-wrapper.sh 1984/mullender/.entry.json '$..author_handle'

    bin/jval-wrapper.sh 1984/mullender/.entry.json '$.manifest[2]'
    bin/jval-wrapper.sh -q 1984/mullender/.entry.json '$.manifest[2]'

    bin/jval-wrapper.sh -b 1984/mullender/.entry.json '$.manifest[2].entry_text'
    bin/jval-wrapper.sh -b -q 1984/mullender/.entry.json '$.manifest[2].inventory_order'

    bin/jval-wrapper.sh author/Anton_Algmyr.json '$.full_name'
    bin/jval-wrapper.sh -q -T author/Anton_Algmyr.json '$.full_name' | jstrdecode -
```

**NOTE**: With `jstrdecode(1)` version 1.2.3 or better, one can use `jstrdecode -N`
and not have to use `-T` with `bin/jval-wrapper.sh`.


<div id="manifest-csv-entry">
### [manifest.csv.entry.awk](%%REPO_URL%%/bin/manifest.csv.entry.awk)
</div>

Output `manifest.csv` from a entry's manifest as found in its `.entry.json` file.

``` <!---sh-->
    awk -f bin/manifest.csv.entry.awk YYYY/dir/.entry.json
```


<div id="manifest-csv-json">
### [bin/manifest.entry.json.awk](%%REPO_URL%%/bin/manifest.entry.json.awk)
</div>

Output manifest table from an entry's `.entry.json` file.

``` <!---sh-->
    awk -v github=REPO_URL -f bin/manifest.entry.json.awk YYYY/dir/.entry.json
```


<div id="md2html-cfg">
### [md2html.cfg](%%REPO_URL%%/bin/md2html.cfg)
</div>

This is a configuration file for the [md2html](index.html#md2html) tool.
Although a configuration file it is also something of a script file.

To not down descend into the depths of `pandoc(1)` and to have to explain how
this file can change all the HTML files, we advise you to let
[Smaug](https://www.glyphweb.com/arda/s/smaug.html) (the dragon of
[Erebor](https://www.glyphweb.com/arda/e/erebor.html) famously visited by a
[Hobbit](https://www.glyphweb.com/arda/h/hobbits.html) called [Bilbo
Baggins](https://www.glyphweb.com/arda/b/bilbobaggins.html) and 13
[Dwarves](https://www.glyphweb.com/arda/d/dwarves.html) in the
[T.A.](https://www.glyphweb.com/arda/t/thirdage.html) 2941 or 1341
in the [Shire-reckoning](https://www.glyphweb.com/arda/s/shirereckoning.html))), slumber as
"`here be dragons`". If you still need convincing, we wish to remind you of [Bilbo
Baggins](https://www.glyphweb.com/arda/b/bilbobaggins.html)' famous words:

> "Never laugh at live dragons,
[Bilbo](https://www.glyphweb.com/arda/b/bilbobaggins.html) you fool!" he said to himself, and it
became a favourite saying of his later, and passed into a proverb.


<div id="md2html">
### [md2html.sh](%%REPO_URL%%/bin/md2html.sh)
</div>

This is the primary tool that forms IOCCC generated HTML content from
markdown files (permanent markdown files or temporarily generated
markdown files) and HTML fragments from the [inc directory](../inc/index.html).

The [md2html.cfg](index.html#md2html_cfg) configuration file is
used by [md2html.sh](%%REPO_URL%%/bin/md2html.sh) to drive the generation process.


<div id="new-dir">
### [new-dir.sh](%%REPO_URL%%/bin/new-dir.sh)
</div>

This tool is used by the [Judges](../judges.html) as one of the
steps needed to announce a new winning IOCCC entry.

Usage:

``` <!---sh-->
    mkdir -p YYYY/dir
    bin/new-dir.sh YYYY/dir
```

Here, `YYYY/dir` must be the path to the winning IOCCC entry.

**NOTE**: This tool does **NOT** perform all of the steps needed
to make a directory a new winning IOCCC entry.  It only starts the
framework for doing so, creating a situation where the
[cvt-submission](#cvt-submission) tool be be run.

This tool can modify the top level `.allyear` file, and `YYYY/Makefile` files.

**NOTE**: This tool assumes that [new-year.sh](#new-year) was executed to create
the prerequisite `YYYY` directory and related files.

**HINT**: Executing this tool on your submission will **NOT** make you an IOCCC winner.  :-)


<div id="new-year">
### [new-year.sh](%%REPO_URL%%/bin/new-year.sh)
</div>

This tool is used by the [Judges](../judges.html) as part of the final
steps to announce a new set of winning IOCCC entries.

This tool may modify the top level `.top` and `Makefile` files.
It will form `YYYY/Makefile` and/or `YYYY/.year` if needed.
It will form `YYYY/README.md` if needed, from `template/README.md.year`.

**NOTE**: This tool does **NOT** perform all of the steps needed to make a new IOCCC year directory.
For example, files such as `YYYY/README.md` and/or `YYYY/index.html`
might contain "_triple X_" comments (`<!-- XXX -->`) indicating where the
[Judges](../judges.html) need to add content.

Usage:

``` <!---sh-->
    bin/new-year.sh -v 1 YYYY
```

Here, `YYYY` must be a new 4-digit (happy :-)) new IOCCC year.


<div id="othermd2html">
### [othermd2html.sh](%%REPO_URL%%/bin/othermd2html.sh)
</div>

Convert a non-README.md file in an entry to HTML.

Usage:

``` <!---sh-->
    bin/othermd2html.sh YYYY/dir/pathto.md
```

For example:

``` <!---sh-->
    bin/othermd2html.sh -v 1 2020/ferguson1/chocolate-cake.md
```

The [othermd2html.sh](#othermd2html) tool is used by
[gen-other-html.sh](#gen-other-html).


<div id="output-index-author">
### [output-index-author.sh](%%REPO_URL%%/bin/output-index-author.sh)
</div>

Output an author's or authors' related HTML details for an entry's index.html
page.

For an example, see the [author details in
1984/anonymous](../1984/anonymous/index.html#author).

This tool is used in the [bin/md2html.cfg](%%REPO_URL%%/bin/md2html.cfg) file as part of
the [md2html tool](index.html#md2html).


<div id="output-index-inventory">
### [output-index-inventory.sh](%%REPO_URL%%/bin/output-index-inventory.sh)
</div>

Output the inventory in HTML form for an entry's index.html page. For an example
inventory, see the [inventory in
1984/anonymous](../1984/anonymous/index.html#inventory).

This tool is used in the [bin/md2html.cfg](%%REPO_URL%%/bin/md2html.cfg) file as part of
the [md2html tool](index.html#md2html).


<div id="output-year-index">
### [output-year-index.sh](%%REPO_URL%%/bin/output-year-index.sh)
</div>

Output the inventory for a given year's winning entries in HTML form. In other
words in [1984](../1984/index.html) it would list, as links, the four winning
entries, which you can see directly at the [1984
inventory](../1984/index.html#inventory).

This tool is used in the [bin/md2html.cfg](%%REPO_URL%%/bin/md2html.cfg) file as part of
the [md2html tool](index.html#md2html).


<div id="pandoc-wrapper">
### [pandoc-wrapper.sh](%%REPO_URL%%/bin/pandoc-wrapper.sh)
</div>

Wrapper tool to run `pandoc(1)`.


<div id="quick-readme2index">
### [quick-readme2index.sh](%%REPO_URL%%/bin/quick-readme2index.sh)
</div>

Build an entry's `index.html` file if the entry directory
does not have a non-empty `index.hmtl` file, or if either
`.entry.json` or `README.md` is newer than the `index.hmtl` file.

This is useful when only a few entries have been
modified (resulting in an updated `.entry.json` file)
or if the `README.md` of a few entries have been changed: while the
[readme2index.sh](index.html#readme2index) script takes a few seconds
to run for a few entries, when applied to 300+ entries, the extra time can add
up.

If only a few `index.hmtl` files need updating, then
this command will only briefly pause while the
[readme2index.sh](index.html#readme2index) can take much longer.

Usage:

``` <!---sh-->
    # For all entries:
    bin/all-run.sh -v 3 bin/quick-readme2index.sh -v 1

    # For an individual entry:
    bin/quick-readme2index.sh -v 1 2020/ferguson2
```

**NOTE**: This command assumes that the relative
modification times for `README.md`, `.entry.json`,
and `index.html` are correct.  If in doubt, use
[readme2index.sh](index.html#readme2index).

We recommend that this tool be invoked via the top level `Makefile`:

``` <!---sh-->
    make quick_readme2index
```


<div id="readme2index">
### [readme2index.sh](%%REPO_URL%%/bin/readme2index.sh)
</div>

Convert an entry's `README.md` into its `index.html` file.

Usage:

``` <!---sh-->
    bin/readme2index.sh -v 3 1984/mullender
```

To build `index.html` files for all entries:

``` <!---sh-->
    bin/all-run.sh -v 3 bin/readme2index.sh -v 1
```

We recommend that this tool be invoked via the top level `Makefile`:

``` <!---sh-->
    make entry_index
```


<div id="sgi">
### [sgi.sh](%%REPO_URL%%/bin/sgi.sh)
</div>

Sort `.gitignore` content from `stdin` to `stdout`.

We sort with lines starting with `#` first.
We sort with lines starting with `*` second.
We sort with lines that do not start with `[#!*]` third.
We sort with lines starting with `!` fourth.

This tool is used by [sort.gitignore.sh](index.html#sort-gitignore).


<div id="sort-gitignore">
### [sort.gitignore.sh](%%REPO_URL%%/bin/sort.gitignore.sh)
</div>

Sort a `.gitignore` in a entry directory.

Usage:

``` <!---sh-->
    bin/sort.gitignore.sh -v 1 YYYY/dir
```

Suggested usage (for all `.gitignore` files):

``` <!---sh-->
    bin/all-run.sh bin/sort.gitignore.sh -v 1
```

We recommend that this tool be invoked via the top level `Makefile`:

``` <!---sh-->
    make sort_gitignore
```


<div id="status2html">
### [status2html.sh](%%REPO_URL%%/bin/status2html.sh)
</div>

Convert [status.json](../status.json) into HTML.

This tool is a  'before tool' (`-b tool`) that is intended
to be used by [gen-status.sh](index.html#gen-status).


<div id="subst-default">
### [subst.default.sh](%%REPO_URL%%/bin/subst.default.sh)
</div>

Print default substitutions.

This tool is used in the [bin/md2html.cfg](%%REPO_URL%%/bin/md2html.cfg) file.


<div id="subst-entry-index">
### [subst.entry-index.sh](%%REPO_URL%%/bin/subst.entry-index.sh)
</div>

Print substitutions for an entry's `index.html`.

This tool is used in the [bin/md2html.cfg](%%REPO_URL%%/bin/md2html.cfg) file.


<div id="subst-entry-navbar-awk">
### [subst.entry-navbar.awk](%%REPO_URL%%/bin/subst.entry-navbar.awk)
</div>

Output substitutions for `navbar` on behalf of an entry.

This tool is used in [subst.entry-index.sh](index.html#subst-entry-index).


<div id="subst-year-index">
### [subst.year-index.sh](%%REPO_URL%%/bin/subst.year-index.sh)
</div>

Print substitutions for a year level `index.html`.

This tool is used in the [bin/md2html.cfg](%%REPO_URL%%/bin/md2html.cfg) file.


<div id="subst-year-navbar-awk">
### [subst.year-navbar.awk](%%REPO_URL%%/bin/subst.year-navbar.awk)
</div>

Output substitutions for `navbar` on behalf of a year level `index.html`.

This tool is used in [subst.year-index.sh](index.html#subst-year-index).


<div id="tar-entry">
## [tar-entry.sh](%%REPO_URL%%/bin/tar-entry.sh)
</div>

Form a compressed tarball for an entry.

Usage:

``` <!---sh-->
    bin/tar-entry.sh -v 1 YYYY/dir
```

Suggested usage:

``` <!---sh-->
    bin/all-run.sh -v 3 bin/tar-entry.sh -v 1 -W
```


<div id="tar-year">
## [tar-year.sh](%%REPO_URL%%/bin/tar-year.sh)
</div>

Form a compressed tarball for an IOCCC year.

Usage:

``` <!---sh-->
    bin/tar-year.sh -v 1 YYYY
```

Suggested usage:

``` <!---sh-->
    bin/all-years.sh -v 3 bin/tar-year.sh -v 1 -W
```

We recommend that this tool be invoked via the top level `Makefile`:

``` <!---sh-->
    make form_year_tarball
```


<div id="untar-entry">
## [untar-entry.sh](%%REPO_URL%%/bin/untar-entry.sh)
</div>

Untar an entry's compressed tarball.

Usage:

``` <!---sh-->
    bin/untar-entry.sh -v 1 YYYY/dir
```

Suggested usage:

``` <!---sh-->
    bin/all-run.sh -v 3 bin/untar-entry.sh -v 1
```

We recommend that this tool be invoked via the top level `Makefile`:

``` <!---sh-->
    make untar_entry_tarball
```


<div id="untar-year">
## [untar-year.sh](%%REPO_URL%%/bin/untar-year.sh)
</div>

Untar an IOCCC year's compressed tarball.

Usage:

``` <!---sh-->
    bin/untar-year.sh -v 1 YYYY
```

Suggested usage:

``` <!---sh-->
    bin/all-years.sh -v 3 bin/untar-year.sh -v 1
```

We recommend that this tool be invoked via the top level `Makefile`:

``` <!---sh-->
    make untar_year_tarball
```


<div id="how">
# How IOCCC HTML content is built
</div>

The [md2html.sh](index.html#md2html) tool is the primary tool that
is used to form all IOCCC related HTML pages for the [official IOCCC web
site](https://www.ioccc.org).

Nearly all IOCCC related HTML pages are built from markdown files,
from either permanent markdown files or temporary generated markdown files,
as well as HTML fragments from the [inc directory](../inc/index.html).

Most HTML content is built from permanent markdown files, such as a `README.md`
markdown file found in each entry directory.  Some HTML content are generated
from temporary markdown files.  These temporary markdown files are produced by
tools in the [bin directory](index.html) and exist only while the tool is running.

In addition to converting markdown to HTML, the canonical way that HTML content is
built uses, by default, files from the [inc directory](../inc/index.html), of
the file name form:

```
    *.default.html
```

By using command line options of the form:

``` <!---sh-->
    -H phase=name
```

where `phase` is the name of an HTML phase,
a non-default file may be used.  For example:

``` <!---sh-->
    -H navbar=up2index
```

will cause [inc/navbar.up2index.html](../inc/navbar.up2index.html)
instead of [inc/navbar.default.html](../inc/navbar.default.html) to be
used during the _navbar_ HTML phase.

If `name` is dot (i.e., `.`), then the given HTML phase is skipped.
For example:

``` <!---sh-->
    -H footer=.
```

will cause no HTML content to be produced during the `footer` HTML phase.


<div id="html">
## HTML phases
</div>

The following HTML phase files are used to build HTML content:

0. [inc/top.default.html](../inc/top.default.html)
1. [inc/head.default.html](../inc/head.default.html)
2. [inc/body.default.html](../inc/body.default.html)
3. [inc/topbar.default.html](../inc/topbar.default.html)
4. [inc/header.default.html](../inc/header.default.html)
5. [inc/navbar.default.html](../inc/navbar.default.html)
6. [inc/before-content.default.html](../inc/before-content.default.html)

Phases 7-19 are reserved for future use.

20. ((insert 'before tool' output))
21. ((insert 'pandoc wrapper tool' output))
22. ((insert 'after tool' output))

Phases 23-29 are reserved for future use.

30. [inc/after-content.default.html](../inc/after-content.default.html)
31. [inc/footer.default.html](../inc/footer.default.html)
32. [inc/bottom.default.html](../inc/bottom.default.html)

Phases 33-39 are reserved for future use.

In all of the above HTML phase numbers, symbols of the form `%%TOKEN%%` are
substituted.

Substitutions of the form `%%TOKEN%%` are performed on included HTML content,
content generated by the 'before tool' (`-b tool`),
content generated by the 'after tool' (`-a tool`),
as well as the markdown content given to the `pandoc wrapper tool` (`-p tool`).

It is an error, unless `-S` is given, for any phase, except phases HTML
20-29, to not substitute all `%%TOKEN%%`s.  For phases HTML 20-29, any
`%%TOKEN%%` that is not substituted are passed thru without substitution.

See the tool [readme2index.sh](index.html#readme2index) for an example of
how HTML phases are implemented.


<div id="getopt">
## getopt phase processing of the command line
</div>

The command options are evaluated in the following `getopt` phases:


<div id="getopt-0">
### `getopt` phase 0
</div>

In `getopt` phase 0 we parse command line options and save all arguments for the
end of the final command line.

Depending on the program, the argument at the end is directory under topdir, or
it is a file under topdir.

`getopt` phase 0 is the only `getopt` phase where `-d topdir` and `-c
md2html.cfg` may be used.


<div id="getopt-1">
### `getopt` phase 1
</div>

In `getopt` phase 1 we execute each `-o "output tool"` from `getopt` phase 0,
parsing the output as a command line.

The `-o "output tool"` may be given `optstr` from `"-O tool=optstr"`, followed
by the phase 0 argument.

The `-o "output tool"` is not allowed to output another `"-o tool"` or a `"-O
tool=optstr"`. Instead a `-o "output tool"` may execute another `-o "output
tool"` and merge the output into its own.


<div id="getopt-2">
### `getopt` phase 2
</div>

In `getopt` phase 2 we parse the `cfg_options` from the first `md2html.cfg` line
matched by a saved argument.

The match is made with the (possibly modified) phase 0 argument.


<div id="getopt-3">
### `getopt` phase 3
</div>

In `getopt` phase 3 we execute each `-o "output tool"` from `getopt` phase 2,
parsing the output as a command line.

The `-o "output tool"` may be given `optstr` from `"-O tool=optstr"`, followed
by the phase 0 argument.

The `-o "output tool"` is not allowed to output another `"-o tool"` or a `"-O
tool=optstr"`.  Instead a `-o "output tool"` may execute another `-o "output
tool"` and merge the output into its own.


<div id="command-line-option-order">
### Command line option order
</div>

Most command line options override earlier copies of the same option.  However
in the case of `-H phase=name`, a later `-H phase=name` only overrides an
earlier use of `-H` for the same `phase` _only_. Also in the case of `-s
token=value`, a later `-s token=value` only overrides an earlier use of `-s` for
the same `token` _only_.


<div id="output-tools">
### Output tools
</div>

An "output tool" may be used to add certain additional command line options to be processed.

**IMPORTANT**: An "output tool" will print each command line option / argument on a separate line.
So for example, if an "output tool" wishes to convey:

```
    -s TITLE='IOCCC entry locations' -H navbar=top-of-site
```

The  "output tool" would output the following 4 lines:

```
    -s
    TITLE='IOCCC entry locations'
    -H
    navbar=top-of-site
```

The command line options printed by an "output tool" are processed
after all command line options, and all options from a matching
line from the [md2html.cfg](%%REPO_URL%%/bin/md2html.cfg) file, and before any filename arguments
on the command line.

For example:

```
    command [command_options ..] [cfg_options ..] [output_tool_options ..] [--] [filename_arg ..]
```

Here the `command` first processes any command line options, then it processes
`cfg_options` obtained from this file from a first match of a given `file_glob`,
then it processes `output tool` (i.e., `-o tool`) options found in
`command_options`, and `cfg_options`, then an optional `--` (end of all
options), then zero of more `filename_arg` filename arguments.

The `-o tool` must **NOT** output any `-o tool` options as `-o tool` is **NOT
RECURSIVE**.  A `-o tool` is free, however, to execute other `-o tool` output
tools and merge the output from those tools into its own.


<div id="special-exit-code">
### Special `-E exitcode` option
</div>

When `-E exitcode` is evaluated, the application will exit with the `exitcode`
value.  If one wishes to also output a message to `stderr`, the `-e string` must
come **BEFORE** any `-E exitcode` in the command line.


<div id="substitution-tokens">
### Substitution tokens
</div>

All tokens (i.e., strings of the form `%%token%%`) **MUST** be substituted (by
some `-s token=value`) in all HTML output, except during phase numbers 20-29
(i.e., except `before tool` output, pandoc wrapper output, and `after tool`
output), or the command will exit non-zero, unless `-S` is given.  If `-S` is
given, only a warning about non-substituted tokens will be written to `stderr`.

The command line of tools in the [bin directory](index.html), and perhaps
modified via the [md2html config file](%%REPO_URL%%/bin/md2html.cfg) may change to using a
different filename for a given phase.

For example when forming the HTML from
[2020/ferguson1/chocolate-cake.md](%%REPO_URL%%/2020/ferguson1/chocolate-cake.md),
a different `navbar` navigation bar is needed.  So instead of the
usual top navigation bar that normally directs people to the previous
entry for the year, or go up to the year page, or to the next entry
for the year, a top navigation bar to just go up to the entry's
main page is needed. A line in the [md2html config file](%%REPO_URL%%/bin/md2html.cfg)
that refers to
[2020/ferguson1/chocolate-cake.md](%%REPO_URL%%/2020/ferguson1/chocolate-cake.md) may
specify use of `navbar.up2index.html` (as `navbar.up2index`)instead of using the
`navbar.default.html` (`navbar.default.html`) default.

The HTML phase may be skipped resulting in no HTML output during a given phase
and furthermore, forming no HTML content from a given markdown file altogether.

See comments in the [md2html config file](%%REPO_URL%%/bin/md2html.cfg) for details.
See also, the tool [readme2index.sh](index.html#readme2index) for an example of
how such command lines are used.


# Use CAUTION when modifying `inc/` files

Some of the files under this directory are used to form **MOST** of the HTML content
on the [official IOCCC website](https://www.ioccc.org).

These files are used to form **MOST** of the HTML content
on the [experimental website](https://ioccc-src.github.io/temp-test-ioccc/).

... and in particular files under [inc](../inc/index.html) that are of the form
(called default HTML files) ...:

```
    *.default.html
```

... contain default content used to form IOCCC HTML / IOCCC web pages.

Instead of editing the default HTML files in order to fix a special web page,
consider making a copy of the default file and modifying the [md2html config
file](%%REPO_URL%%/bin/md2html.cfg) to refer to the copy instead.  That way your special case
situation will not impact **MOST** of the HTML content.


# Why we do not use certain well-known HTML technologies

You may wonder why we need these files in the first place.  You may wonder why
we even need the tools in the [bin](index.html) directory when there other
solutions available to form web pages.


<div id="static-only">
## Static web pages only
</div>

Here are some reasons why we are using these files and
special tools to create HTML content / IOCCC web pages:

We host [official IOCCC website](https://www.ioccc.org) via [GitHub
pages](https://pages.github.com).  As of the time this file written, **only
static web pages are supported**.


## We cannot use server side include

We use [static web pages](#static-only), so use of "server side include" is not
available to the IOCCC.

For example, Apache SSI `#include` does not work on [GitHub
pages](https://pages.github.com).


## We cannot use a back-end database

We use [static web pages](index.html#static-only), so use of a "back-end database" is not
available to the IOCCC.


<div id="why-github">
## We cannot use non-GitHub web servers
</div>

The [GitHub pages](https://pages.github.com) have the distributed server capacity needed to handle
the **huge download volume** or [Slashdot effect](https://en.wikipedia.org/wiki/Slashdot_effect)
that happens when new IOCCC winning entries are published.

Most so-called low cost web hosting sites have a somewhat hidden excessive bandwidth charge
and/or cap bandwidth when the volume gets too high, and/or do not have the infrastructure
that can handle the [Slashdot effect](https://en.wikipedia.org/wiki/Slashdot_effect).

The IOCCC had experience with people offering web mirrors and even free hosting
only to find that the generous benefactor moves on, or their service is purchased
by someone else who is not so generous.  While it is possible that GitHub might someday
suffer a similar fate, for the time being we are betting that GitHub will remain
willing to host the IOCCC.

The [official IOCCC website](https://www.ioccc.org) is, after all, primarily C
source code with some supporting documentation (sometimes :-) ).  As such it is
a natural fit for GitHub and [GitHub pages](https://pages.github.com).


## We cannot use the HTML `<object>` element

The `<object>` HTML element does not work for our needs.

HTML elements do not extend into the content that they include.
For example, menu bars (see the [ioccc.css](%%DOCROOT_SLASH%%ioccc.css)
stylesheet) will not operate under an HTML element.


## We cannot use the HTML `<embed>` element

The `<embed>` HTML element does not work for our needs.

This element wants one to specify the `width` and `height` in pixels.
Use of a percentage is not officially supported even if some browsers
might do so.  Our Responsive Web Design in the
[ioccc.css](%%DOCROOT_SLASH%%ioccc.css) stylesheet
needs to be responsive to small-sized cell phone-like screens,
mid-sized table-like screens, as well as large-sized desktop-like screens.
Specifying a `width` and `height` in pixels will not work well in
all of those screen size contexts.


## We cannot use the HTML `<iframe>` element

The `<iframe>` HTML element does not work for our needs.

This element wants one to specify the `width` and `height` in pixels.  Use of a
percentage is not officially supported even if some browsers might do so.  Our
Responsive Web Design in the [ioccc.css](%%DOCROOT_SLASH%%ioccc.css) stylesheet
needs to be responsive to small-sized cell phone-like screens, mid-sized
table-like screens, as well as large-sized desktop-like screens.  Specifying a
`width` and `height` in pixels will not work well in all of those screen size
contexts.


## We cannot use JavaScript to include content

We do not use JavaScript to include HTML content.

While the IOCCC may use JavaScript in the future to directly render things like
C source code, we will do so in such a way that someone will be able to view
[official IOCCC website](https://www.ioccc.org) content with JavaScript
disabled.

The IOCCC will **NOT MANDATE USE OF JavaScript** to view [official IOCCC web
site](https://www.ioccc.org) (except for some mobile devices for the menu).

For this reason, we cannot use JavaScript to include HTML content.


<div id="terms">
# IOCCC Terms
</div>

The following IOCCC terms apply to tools, JSON files, and the directory
structure of this repo that forms the [Official IOCCC
website](https://www.ioccc.org).


<div id="author">
## `author`
</div>

An **individual** who was won at least one winning IOCCC [entry](#entry).

Some authors have submitted more than one IOCCC entry that won.  Some winning
IOCCC entries have more than one author; in that case we might use the word
`authors`.


<div id="author-handle">
## `author_handle`
</div>

An `author_handle` is string that refers to a given [author](#author) and **is unique to the
IOCCC**.  Each [author](#author) has **EXACTLY ONE** `author_handle`.

For each `author_handle`, there will be a JSON file located at:

```
    author/author_handle.json
```

where `author_handle` is the [author](#author)'s `author_handle`.

Because the `author_handle` is used to form a JSON filename, the string **MUST** be
a POSIX safe string with the addition of `+` (for technical reasons beyond this
document).  In particular, the `author_handle` **MUST** be an ASCII
string that matches this regexp:

``` <!---re-->
    ^[0-9A-Za-z][0-9A-Za-z._+-]*$"
```

Default `author_handle`s do not have multiple consecutive `_` (underscore)
characters.  Nevertheless, multiple consecutive `_` (underscore) characters are
allowed; contest submitters who wish to override the `author_handle` may do so.

The `author_handle` is derived from the name of the [author](#author).  While
there is an algorithm that maps the name of the [author](#author) (which may contain any UTF-8
characters) into a default `author_handle` string, those who submit to the IOCCC
are free to choose a different `author_handle` string if they so desire.

**NOTE**: an [author](#author) who has won a [previous IOCCC](../years.html)
**is encouraged to reuse their `author_handle`** so that new winning
[entries](#entry) can be associated with the same [author](#author).

For an anonymous `author`, their handle is one of these forms:

```
    Anonymous_year
```

or:

```
    Anonymous_year.digits
```


The latter form is in case there is more than one anonymous author in a given
year.

**NOTE**: even if the directory name is not `anonymous` the above rules apply as in
in the case of [2005/anon](../2005/anon/index.html).

Anonymous `author_handle`'s match this regexp:

``` <!---re-->
    Anonymous_[0-9][0-9][0-9][0-9][.0-9]*$
```


<div id="entry">
## `entry`
</div>

An IOCCC [submission](#submission) that won an award for a given IOCCC.

An `entry` has one or more `author`s.

Each `entry` is contained under its own directory.  The parent of the entry
directory is the year's directory.

While in most cases an `entry` consists of files under an entry's directory,
there are a few cases where an `entry` directory contains subdirectories.

Use of subdirectories under an `entry` directory is discouraged and
may be limited to previous entries that used them.

**HISTORICAL NOTE**: in the past, the term `winner` was used in instead of
today's term of `entry`.

<div id="submission">
## `submission`
</div>

In the past, the IOCCC used the term [entry](#entry) for both a hopeful
[submission](#submission) and a [winning entry](#entry). It was decided,
however, in 2024, to remove this ambiguity by introducing the term
[submission](#submission). This does mean that if one wishes to win the IOCCC they
must submit to the [Judges](../judges.html)! :-)

<div id="submitter">
## `submitter`
</div>

A person who submits a [submission](#submission).


<div id="year">
## `year`
</div>

A `year` is a 4 character string.  Most years are 4-digit strings that
represent the year.  Some special `year` strings are possible, such as `mock`.
Non-numeric `year` strings are lower case (hence `mock` and not `MOCK`).

A `year` string matches this regexp:

``` <!---re-->
    [0-9a-z][0-9a-z][0-9a-z][0-9a-z]
```

The `year` (`1984`, `1985`, ..., `2020`, ...) directories reside directly below
the top level directory.


<div id="dot-year">
## `.year`
</div>

Each [year](#year) directory will have a file under it named `.year`.

The content of each `.year` file is the [year string](#year) of that year's winning
[entries'](#entry) (directory names). For instance, [2020/.year](%%REPO_URL%%/2020/.year)
lists, one directory per line, the directories of the winning entries of
[2020](../2020/index.html). For instance, for [2020](../2020/index.html):

``` <!--sh-->
        $ cat 2020/.year
        2020/burton
        2020/carlini
        2020/endoh1
        2020/endoh2
        2020/endoh3
        2020/ferguson1
        2020/ferguson2
        2020/giles
        2020/kurdyukov1
        2020/kurdyukov2
        2020/kurdyukov3
        2020/kurdyukov4
        2020/otterness
        2020/tsoj
        2020/yang
```


<div id="dir">
## `dir`
</div>

A `dir` is a POSIX safe string (directory name) that holds an entry.

A `dir` is a string that matches this regexp:

``` <!---re-->
    ^[a-z][0-9a-z.-]*$
```

Each [entry](#entry) is under its own individual directory.  This directory
is directly under a [year](#year) directory.


<div id="entry-id">
### `entry_id`
</div>

A string that identifies [winning entries](#entry).  The string is of the form:

```
    year_dir
```

where `year` is the [year](#year) and `dir` is the [dir](#dir).

For instance, the `entry_id` for [2020/endoh2](../2020/endoh2/index.html)
is:


```
    2020_endoh2
```


<div id="csv">
# CSV Files
</div>

The `bin/csv2entry.sh` and `bin/entry2csv.sh` tools use the below
three CSV files.  In the case of `bin/entry2csv.sh`, these CSV files
are created / updated; in the case of `bin/csv2entry.sh`, these
CSV files are used as input.


<div id="author_wins_csv">
## `author_wins.csv`
</div>

A CSV file exported from a spreadsheet, one line per [author](#author).

The first field is an [author_handle](#author-handle).

The other fields are the [entry_id](#entry-id)s of all `YYYY/dir`
[entries](#entry) won by the [author](#author).


<div id="manifest_csv">
## `manifest.csv`
</div>

A CSV file exported from a spreadsheet that contains information about files in
`YYYY/dir` entry directories under year directories.  This file has the
following fields:

1. `year`:

   IOCCC year as a 4-character string.  Normally this would be a 4 digit year string,
   however it may also be a string such as "mock".

   NOTE: If year begins with `#`, then `dir` (see below) is a comment, and the
   rest of the row is to be ignored.  Rows of this form do **NOT** contain
   manifest information for a file.

2. `dir`:

   Directory name (number of the IOCCC year).

3. `path`:

   Path under the IOCCC/directory.  In a few cases this is a path,
   not just a simple filename under the IOCCC/directory.

4. `inventory_order`:

   This number is the rank showing the order that this file is to be listed in
   the list of files for the given entry in the `index.html` file.

   If the number is under 10 digits, then the given file
   is considered a primary file when listed in the inventory
   of files for a given winning `YYYY/dir` entry.

   If the number is 10 digits or more, then the given file
   is considered a secondary file when listed in the inventory
   of files for a given winning `YYYY/dir` entry.  We recommend using the
   value `4294967295` (`2^32-1`) for secondary files.

5. `OK_to_edit`:

   If the value is `true`, then the file is one that may be
   edited directly.

   If the value is `false`, then the file should **NOT** be
   edited, because the given file is generated by a tool.
   One should **NOT** modify such a file directly, but
   instead modify source files (i.e., markdown files,
   JSON files, etc.)

6. `display_as`:

   The type of given file (e.g. C, JSON, shellscript etc.)

   **NOTE**: these are lower case words.

7. `display_via_github`:

   If `true`, then the contents of the file should be viewed
   via the GitHub repo.

   If `false`, then the contents of the file should be viewed
   in the web browser directly.  In some cases this may
   result in the file being downloaded instead of being displayed.

8. `entry_text`:

    Any text that should be displayed at the end of line in `index.html`
    (with a preceding " - "), or `null` if no such text is to be displayed.


**NOTE**: Cells containing `true` or `false` are JSON booleans.

**NOTE**: All other cells are JSON strings that need to be double quoted (in the
JSON files), including the year.

**NOTE**: Do not put commas, or quotes, or newlines in fields as these are bound
to cause problems.


<div id="year_prize_csv">
## `year_prize.csv`
</div>

A CSV spreadsheet, one line per `YYYY/dir` entry directory.

The first field is an [entry_id](#entry-id).

The second field is the name of the award for a given `YYYY/dir` entry.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
