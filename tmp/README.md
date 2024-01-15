# tmp

The tools under this directory are an alpha release.
The [build-ioccc repo](https://github.com/ioccc-src/build-ioccc/tree/master)
will hold the beta and formal release of tools that will
maintain the [official IOCCC web site](https://www.ioccc.org).

Currently these tools maintain the [experimental web site](https://ioccc-src.github.io/temp-test-ioccc/)
by default, via the  [temp-test-ioccc GitHub repo](https://github.com/ioccc-src/temp-test-ioccc).
These tools will redefault to using the temp-test-ioccc repo and the experimental web site
until the [official IOCCC web site](https://www.ioccc.org), via the
[IOCCC winner repo](https://github.com/ioccc-src/winner) is ready for the mass pull request/merge.

**IMPORTANT**: The purpose of the `tmp` directory is to hold temporary files.
The files in the `tmp` directory will go away leaving behind an empty `tmp` directory.


## purpose

This documentation is here to help define terms, files under `tmp/`
and the format of those files.

*NOTE*: The `terms` section may be moved to another file
later on, after the contents of this directory are removed.


## terms


### `author`

An individual who was an `author` of at least one winning IOCCC entry.

Some authors have submitted more than one IOCCC entry that won.  Some winning
IOCCC entries have more than one author.


### `author_handle`

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


### `winner`

An IOCCC entry that won an award for given IOCCC.

A `winner` has one more more `author`s.

Each `winner` is contained under its own directory.  The parent of the winner directory
is the year's directory.

While in most cases a `winner` consists of files under a `winner` directory,
there are a few cases where a `winner` directory contains subdirectories.

Use of subdirectories under a `winner` directory is discouraged and
may be limited to previous `winner`s that used them.


### `year`

A `year` is a 4 character string.  Most years are 4-digit strings that
represent the year.  Some special `year` strings are possible, such as _`mock`_.
Non-numeric `year` strings are lower case.

A `year` string matches this regexp:

```re
[0-9a-z][0-9a-z][0-9a-z][0-9a-z]
```

The `year` directories reside directly below the top level directory.


### `.year`

Each `year` will have a file directory under it named:

```
.year
```

The contents of the `.year` file is the year string of the directory. For
instance, [2020/.year](/2020/.year) has the string: `2020`.


### `dir`

A `dir` is a POSIX safe string that holds an winner.

A `dir` is a string that matches this regexp:

```re
^[a-z][0-9a-z.-]*$
```

Each `winner` is under its own individual directory.  This directory
is directly under a `year` directory.


### `winner_id`

A string that identifies the winning entry.  The string is of the form:

```
year_dir
```


## files


### [OLD_manifest](OLD_manifest)

The files in the [OLD_manifest](OLD_manifest) were in the top of
the tmp directory as of 2023 Oct 26.  They represent the first
complete manifest that matched the winner file directories.

These files in this directory are kept as a temporary snapshot for now.


### [README.md](README.md)

This file.


### [author_names.txt](author_names.txt)

A text file of full names of each `author`: one full name per line.

In the case of anonymous authors the form is:

```
Anonymous YYYY
```


### [author_wins.numbers](author_wins.numbers)

A [macOS](https://www.apple.com/macos) [Numbers](https://www.apple.com/numbers/)
spreadsheet: one line per `author`.

The first field is an `author_handle`.

The other fields are the `winner_id`'s of all `winner`s won by the `author`.


### [author_wins.csv](author_wins.csv)

The [author_wins.csv](author_wins.csv) is a CSV file that was exported from the
[author_wins.numbers](author_wins.numbers) file.

In case of conflict, the data in [author_wins.numbers](author_wins.numbers) file is
considered authoritative over the [author_wins.csv](author_wins.csv) file.

The [author_wins.csv.csv](author_wins.csv) is generated from the [author_wins.numbers](author_wins.numbers) file,
via the [macOS](https://www.apple.com/macos/)
[Numbers](https://www.apple.com/numbers/) spreadsheet app, as follows:

0. open [author_wins.numbers](author_wins.numbers) in numbers: modify if/as needed

1. File -> Export To -> CSV...
    * 1a. `[ ]` Include table names (unset)
    * 1b. Text Encoding: Unicode (UTF-8)
    * 1c. Click ((Save..))

2. Save As: author_wins.csv
    * 2a. Select the `tmp` directory

3. Click ((Export))
    * 3a. If needed click ((Replace))

4. Execute ./[fix_csv.sh](fix_csv.sh)


### [author.numbers](author.numbers)

A [macOS](https://www.apple.com/macos) [Numbers](https://www.apple.com/numbers/)
spreadsheet contains information about `author`s: one line per `author` with the
following fields:

1. This field is `sort_word` string.

2. This field is the full name of the `author`.

3. This field is the `author_handle` of the `author`.

4. This field is the primary URL of `author` or the string `null` if none was
   given.

5. This field is the email address of `author` or the string `null` if none was
   given.

6. This field is the location ISO 3166 code of `author` or the string `null` is unknown.
   An `author` who does not wish to specify a location ISO 3166 code is encouraged to
   use the code `XX`.  The location ISO 3166 code consists of two UPPER CASE ASCII letters.

7. This field is the twitter handle of the `author` or the string `null` if none
   was given.  This field is kept for purely historic record purposes and is
   otherwise not used.

8. This field is the mastodon handle  of the `author` or the string `null` if
   none was given.

9. This field is the alternate URL of `author` or the string `null` if none
   was given.


### [author.csv](author.csv)

The [author.csv](author.csv) is a CSV file that was exported from the
[author.numbers](author.numbers) file.

In case of conflict, the data in [author.numbers](author.numbers) file is
considered authoritative over the [author.csv](author.csv) file.

The [author.csv](author.csv) is generated from the [author.numbers](author.numbers) file,
via the [macOS](https://www.apple.com/macos/)
[Numbers](https://www.apple.com/numbers/) spreadsheet app, as follows:

0. open [author.csv](author.csv) in numbers: modify if/as needed

1. File -> Export To -> CSV...
    * 1a. `[ ]` Include table names (unset)
    * 1b. Text Encoding: Unicode (UTF-8)
    * 1c. Click ((Save..))

2. Save As: author.csv
    * 2a. Select the `tmp` directory

3. Click ((Export))
    * 3a. If needed click ((Replace))

4. Execute ./[fix_csv.sh](fix_csv.sh)


### [author_handle.txt](author_handle.txt)

A text file containing `author_handle`s for each `author`: one `author_handle`
per line.


### [awards_check.sh](awards_check.sh)

Script to verify that the award name for each entry as found as a level 1
markdown header in each entry's `README.md` file.

Run the script from the top level directory.  The output should end in ":1".

For example, this command should not produce any output.

```sh
tmp/awards_check.sh | grep -v ':1$'
```

Any output is an indication that either an award name is incorrect, or the
award is not formed at a level 1 markdown header, or that more than one
award line as at a level 1 markdown header we found, or the `README.md`
file is missing, etc.


### [check_path_list.sh](check_path_list.sh)

Look for problems with path_list.required.txt, path_list.manifest.txt,
and path_list.found.txt files.   In particular, the files found in
winning directories are compared with the list of required files
as well as the complete manifest list of files.

If all is OK, [check_path_list.sh](check_path_list.sh) exits 0 and prints
nothing.  If there are missing required files, or extra files found
then [check_path_list.sh](check_path_list.sh) will exit non-zero and
print information about problems.


### [echo.sh](echo.sh)

Tool that simply echos it arguments: used to test [run_all.sh](run_all.sh).


### [example.author.json](example.author.json)

This is a JSON file containing an example `author/author_handle.json` for a
fictitious `author`.

An `author/author_handle.json` file will be derived from the contents of the
[author.csv](author.csv) file and the [author_wins.csv](author_wins.csv) file.


### [example.dot_winner.json](example.dot_winner.json)

This is a JSON file containing an example `year/dir/.winner.json` for a
fictitious `winner`.

A `year/dir/.winner.json` file will be derived from the contents the `year/dir/.id` file,
the [author_wins.csv](author_wins.csv) file, the `year/dir/.year` file,  and the
the [manifest.csv](manifest.csv) file.

The 11 field names in [manifest.numbers](manifest.numbers) match
the JSON member names found in
[example.dot_winner.json](example.dot_winner.json).


### [fake.gen_index.sh](fake.gen_index.sh)

Generate a fake index.html for a given winner.


### [fix_csv.sh](fix_csv.sh)

This tool will fix CSV files exported by
[macOS](https://www.apple.com/macos)
[Numbers](https://www.apple.com/numbers/) by removing carriage
returns and appending a newline if it was missing.

Fixing involves these actions:

```sh
tr -d '\015' < input.csv > tmp.csv
echo >> tmp.csv
mv -f tmp.csv input.csv
```

This tool also forms [path_list.built.txt](path_list.built.txt),
[path_list.manifest.txt](path_list.manifest.txt), and
[path_list.required.txt](path_list.required.txt) from
[manifest.csv](manifest.csv).


### [gen_author_json.sh](gen_author_json.sh)

Temporary tool used to generate the `author/author_handle.json` files.

The following command, executed in this directory, created the `author/` directory:

```sh
rm -rf ../author ; ./gen_author_json.sh  author_handle.txt author.csv author_wins.csv ../author
```


### [gen_winner_json.sh](gen_winner_json.sh)

Generate a `.winner.json` for a given winner.


### [gen_path_list.found.sh](gen_path_list.found.sh)

The list of paths of files in winners.

After doing a `make clobber` this tool updates, if needed,
form [path_list.found.txt](path_list.found.txt).


## [old-ioccc.css](old-ioccc.css)

The previous version of `/ioccc.css`, now `tmp/old-ioccc.css` to make
room for the new IOCCC css being developed.


### [manifest.numbers](manifest.numbers)


A [macOS](https://www.apple.com/macos) [Numbers](https://www.apple.com/numbers/)
spreadsheet contains information about files in winner directories under year directories.
This file as the following fields:

1. year:

   IOCCC year as a 4-character string.  Normally this would be a 4 digit year string,
   however it may also be a string such as "mock".

   NOTE: If year begins with "#", then dir is a comment, and the
   rest of the row is to be ignored.  Rows of this form do NOT
   contain manifest information for a file.

2. dir:

   Directory name number the IOCCC year.

3. path:

   Path under the IOCCC/directory.  In a few cases this is a path,
   not just a simple filename under the IOCCC/directory.

4. inventory_order:

   This number is the winners rank showing the order
   that this file is to be listed for the given entry's in
   [winners.html](winners.html).

   If the number is 9 digits or less, then the given file
   is considered a primary file when listed in the inventory
   of files for a given winner.

   If the number is 10 digits or more, then the given file
   is considered a secondary file when listed in the inventory
   of files for a given winner.  We recommend using the
   value **4294967295** (2^32-1) for secondary files.

5. OK_to_edit:

   If the value is `true`, then the file is one that may be
   edited directly.

   If the value is `false`, then the file should **NOT** be
   edited, because the given file is generated by a tool.
   One should **NOT** modify such a file directly, but
   instead modify source files (i.e., markdown files,
   JSON files, etc.)

6. display_as:

   The type of given file.

7. display_via_github

   If `true`, then the contents of the file should be viewed
   via the GitHub repo.

   If `false`, then the contents of the file should be viewed
   in the web browser directly.  In some cases this may
   result in the file being downloaded instead of being displayed.

8. winners_text:

    Any text that should be displayed at the end of line in `winners.html`
    (with a preceding " - "), or null is no such text is to be displayed.


The 8 field names in [manifest.numbers](manifest.numbers), must
match the JSON member names found in
[example.dot_winner.json](example.dot_winner.json).

NOTE: Cells containing true or false are JSON booleans.
NOTE: All other cells are JSON strings that need to be double quoted, including the year.
NOTE: Do not put commas, nor quotes, nor newlines in fields as these are bound to cause problems.

In case of conflict, the data in [manifest.numbers](manifest.numbers) file is
considered authoritative over the [manifest.csv](manifest.csv) file.


### [manifest.csv](manifest.csv)

The [manifest.csv](manifest.csv) is a CSV file that was exported from the
[manifest.numbers](manifest.numbers) file.

In case of conflict, the data in [manifest.numbers](manifest.numbers) file is
considered authoritative over the [manifest.csv](manifest.csv) file.

The [manifest.csv](manifest.csv) is generated from the [manifest.numbers](manifest.numbers) file,
via the [macOS](https://www.apple.com/macos/)
[Numbers](https://www.apple.com/numbers/) spreadsheet app, as follows:

0. open [manifest.numbers](manifest.numbers) in numbers: modify if/as needed

1. File -> Export To -> CSV...
    * 1a. `[ ]` Include table names (unset)
    * 1b. Text Encoding: Unicode (UTF-8)
    * 1c. Click ((Save..))

2. Save As: manifest.csv
    * 2a. Select the `tmp` directory

3. Click ((Export))
    * 3a. If needed click ((Replace))

4. Execute ./[fix_csv.sh](fix_csv.sh)


### [path_list.built.txt](path_list.built.txt)

A list of file paths (from the top directory) of winner directories,
that are built from other primary content files.

These paths are formed from [manifest.numbers](manifest.numbers)
entries where the "created_by" (5th) field is null.  See
[manifest.numbers](manifest.numbers) for details on the fields.

This file is formed by the [fix_csv.sh](fix_csv.sh) tool.


### [path_list.found.txt](path_list.found.txt)

A list of files that exist, or should exist once the tools to generate certain files,
such as the `index.html`, or the `.winner.json` files for each entry, are created.

This file is created by [gen_path_list.found.sh](gen_path_list.found.sh).


### [path_list.manifest.txt](path_list.manifest.txt)

This is the list of file paths, both primary and constructed
files from winners.

This file is formed by the [fix_csv.sh](fix_csv.sh) tool.


### [path_list.required.txt](path_list.required.txt)

A list of file paths (from the top directory) of winner directories,
that are required to exist.

These paths are formed from [manifest.numbers](manifest.numbers)
entries where the "created_by" (5th) field is non-null.  See
[manifest.numbers](manifest.numbers) for details on the fields.

This file is formed by the [fix_csv.sh](fix_csv.sh) tool.


### [sql/winners.sql](sql/winners.sql)

This is a SQL file, extracted from another SQL file that was used in the past
to generate data for the old winners directory tree.


### [src](src)

This is a temporary location for potential tools that are used to
build and maintain the www.ioccc.org web site.

Eventually a separate [build-ioccc repo](https://github.com/ioccc-src/build-ioccc/tree/master)
will hold these tools.


### [run_all.sh](run_all.sh)

A tool to run another tool over all winner directories.

Examples:

```sh
./run_all.sh -v 3 ./fake.gen_index.sh
./run_all.sh -v 1 ./gen_winner_json.sh
```

### templates
### [template-footer.html](template-footer.html)
### [template-header.html](template-header.html)
### [template-top.html](template-top.html)

An HTML template for what goes into the top of constructed HTML pages.


Constructed HTML pages will be as follows:

0. [template-top.html](template-top.html)
1. file: _path_ HTML comment
2. created by tool: _tool-name_ HTML comment
3. tool version: _tool-version_ HTML comment
4. content source: _path_ HTML comment
... possible multiple content source HTML comments ...
n. [template-header.html])(template-header.html)
n+1. _content generated by a tool such as pandoc_
n+2. [template-footer.html](template-footer.html)


### [test.html](test.html)

A test page for [ioccc.css](../ioccc.css).

This page was modeled after the above mentioned templates
with the "_content generated by a tool such as pandoc_"
replaced with some j-random test text.


### [winner_dir.txt](winner_dir.txt)

A list of paths to winner directories that reside
under year directories.


### [winner_id.txt](winner_id.txt)

A text file containing `winner_id` strings: one `winner_id` per line.


### [year_prize.numbers](year_prize.numbers)

A [macOS](https://www.apple.com/macos) [Numbers](https://www.apple.com/numbers/)
spreadsheet: one line per `winner`.

The first field is a `winner_id`.

The second field is the name of the award for given `winner`.


### [year_prize.csv](year_prize.csv)

The [year_prize.csv](year_prize.csv) is a CSV file that was exported from the
[year_prize.numbers](year_prize.numbers) file.

In case of conflict, the data in [year_prize.numbers](year_prize.numbers) file is
considered authoritative over the [year_prize.csv](year_prize.csv) file.

The [year_prize.csv.csv](year_prize.csv) is generated from the [year_prizes.numbers](year_prize.numbers) file,
via the [macOS](https://www.apple.com/macos/)
[Numbers](https://www.apple.com/numbers/) spreadsheet app, as follows:

0. open [year_prize.numbers](year_prize.numbers) in numbers: modify if/as needed

1. File -> Export To -> CSV...
    * 1a. `[ ]` Include table names (unset)
    * 1b. Text Encoding: Unicode (UTF-8)
    * 1c. Click ((Save..))

2. Save As: year_prize.csv
    * 2a. Select the `tmp` directory

3. Click ((Export))
    * 3a. If needed click ((Replace))

4. Execute ./[fix_csv.sh](fix_csv.sh)
