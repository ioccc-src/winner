# tmp

The purpose of the `tmp` directory is to hold temporary files.
The files in the `tmp` directory will go away leaving behind
an empty `tmp` directory.

This documentation is here to help define terms, files under `tmp/`
and the format of those files.

*NOTE*: The `terms` section may be moved to another file
later on, after the contents


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

``` <!---re-->
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

``` <!---re-->
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

``` <!---re-->
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

``` <!---re-->
    ^[a-z][0-9a-z.-]*$
```

Each `winner` is under its own individual directory.  This directory
is directly under a `year` directory.


### `winner_id`

A string that identifies the winning entry.  The string is of the form:

```
    year_dir
```


### `.id`

Each `winner` directory will have a file directory under it named:

```
    .id
```

The contents of `_.id_` file is the `winner_id` string for that `winner`.

* `sort_word`

A string that is used to determine the position within the `winners.html` file;
an `author` and the `winners` they submitted are to be listed.

A `sort_word` match this regexp:

``` <!---re-->
    ^[a-z][0-9a-z]*
```


## files


### [README.md](README.md)

This file.


### [author_names.txt](author_names.txt)

A text file of full names of each `author`: one full name per line.

In the case of anonymous authors the form is:

```
    Anonymous YYYY
```


### [author_wins.csv](author_wins.csv)

A CSV (Comma Separated Values) file: one line per `author`.

The first field is an `author_handle`.

The other fields are the `winner_id`'s of all `winner`s won by the `author`.


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

4. open a terminal window

5. cd to the `tmp` directory

6. tr -d '\015' < author.csv > tmp.csv

7. echo >> tmp.csv

8. mv -f tmp.csv author.csv


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


### [author_handle.txt](author_handle.txt)

A text file containing `author_handle`s for each `author`: one `author_handle`
per line.


### [awards_check.sh](awards_check.sh)

Script to verify that the award name for each entry as found as a level 1
markdown header in each entry's `README.md` file.

Run the script from the top level directory.  The output should end in ":1".

For example, this command should not produce any output.

``` <!---sh-->
    tmp/awards_check.sh | grep -v ':1$'
```

Any output is an indication that either an award name is incorrect, or the
award is not formed at a level 1 markdown header, or that more than one
award line as at a level 1 markdown header we found, or the `README.md`
file is missing, etc.


### [check_file_list.sh](check_file_list.sh)

Look for problems with file_list.required.txt, file_list.full_manifest.txt,
and file_list.found.txt files.   In particular, the files found in
winning directories are compared with the list of required files
as well as the complete manifest list of files.

If all is OK, [check_file_list.sh](check_file_list.sh) exits 0 and prints
nothing.  If there are missing required files, or extra files found
then [check_file_list.sh](check_file_list.sh) will exit non-zero and
print information about problems.


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
contents of the `year/dir` directory.

The 11 field names in [manifest.numbers](manifest.numbers),
[missing_manifest.numbers](missing_manifest.numbers), and
[full_manifest.numbers](full_manifest.numbers) match the JSON member
names found in [example.dot_winner.json](example.dot_winner.json).


### [file_list.full_manifest.txt](file_list.full_manifest.txt)

This is the list of file paths, both primary and constructed
files from winners.

This is the sorted combined [file_list.built.txt](file_list.built.txt)
and [file_list.required.txt](file_list.required.txt) files.

This file is formed by the [fix_numbers_csv.sh](fix_numbers_csv.sh) tool.


### [file_list.built.txt](file_list.built.txt)

A list of file paths (from the top directory) of winner directories,
that are built from other primary content files.

These paths are formed from [full_manifest.numbers](full_manifest.numbers)
entries where the "created_by" (5th) field is null.  See
[manifest.numbers](manifest.numbers) for details on the fields.

This file is formed by the [fix_numbers_csv.sh](fix_numbers_csv.sh) tool.


### [file_list.required.txt](file_list.required.txt)

A list of file paths (from the top directory) of winner directories,
that are required to exist.

These paths are formed from [full_manifest.numbers](full_manifest.numbers)
entries where the "created_by" (5th) field is non-null.  See
[manifest.numbers](manifest.numbers) for details on the fields.

This file is formed by the [fix_numbers_csv.sh](fix_numbers_csv.sh) tool.


### [file_list.found.txt](file_list.found.txt)

A list of files that exist, or should exist once the tools to generate certain files,
such as the `index.html`, or the `.winner.json` files for each entry, are created.

This file is created by [gen_file_list.found.sh](gen_file_list.found.sh).


### [fix_numbers_csv.sh](fix_numbers_csv.sh)

This tool will fix the [manifest.csv](manifest.csv) and [missing_manifest.csv](missing_manifest.csv)
files, removing carriage returns and appending a newline if it was missing.

This tool also creates / updates [full_manifest.csv](full_manifest.csv).


### [full_manifest.csv](full_manifest.csv)

Combined and sorted [manifest.csv](manifest.csv) and [missing_manifest.csv](missing_manifest.csv).

This file is formed by the [fix_numbers_csv.sh](fix_numbers_csv.sh) tool.

See [manifest.numbers](manifest.numbers) for information on this file format
as it has the exact same format.

In case of conflict, the data in [full_manifest.csv](full_manifest.csv) file is
considered authoritative over the [full_manifest.numbers](full_manifest.numbers) file.


### [full_manifest.numbers](full_manifest.numbers)

This file is formed by opening [manifest.csv](manifest.csv) in numbers
and saving the result as a numbers file.

In case of conflict, the data in [full_manifest.csv](full_manifest.csv) file is
considered authoritative over the [full_manifest.numbers](full_manifest.numbers) file.

**NOTE**: Due to the way that the macOS numbers program imports CSV
files, some values of false may be turned into FALSE, some values
of true may be turned into TRUE, and some values of null may be
turned into NULL.  JSON does not allow UPPER case FALSE, nor TRUE,
nor NULL, so the UPPER case values of fields should be used in JSON
in their lower case form.

The 11 field names in [manifest.numbers](manifest.numbers),
[missing_manifest.numbers](missing_manifest.numbers), and
[full_manifest.numbers](full_manifest.numbers) match the JSON member
names found in [example.dot_winner.json](example.dot_winner.json).


### [gen_author_json.sh](gen_author_json.sh)

Temporary tool used to generate the `author/author_handle.json` files.

The following command, executed in this directory, created the `author/` directory:

``` <!---sh-->
    rm -rf ../author ; ./gen_author_json.sh  author_handle.txt author.csv author_wins.csv ../author
```


### [gen_file_list.found.sh](gen_file_list.found.sh)

The list of paths of files in winners.

After doing a `make clobber` this tool updates, if needed,
form [file_list.found.txt](file_list.found.txt).


### [manifest.numbers](manifest.numbers)


A [macOS](https://www.apple.com/macos) [Numbers](https://www.apple.com/numbers/)
spreadsheet contains information about files, that must already exist, with the
following fields:

1. year:

   IOCCC year as a 4-character string.  Normally this would be a 4 digit year string,
   however it may also be a string such as "mock".

   NOTE: If year begins with "#", then dir is a comment, and the
   rest of the row is to be ignored.  Rows of this form do NOT
   contain manifest information for a file.

2. dir:

   Directory name number the IOCCC year.

3. winners_rank:

   If a number, then this is the winners rank showing the order
   that this file is to be listed for the given entry's in
   [winners.html](winners.html), or null if the file is not to be listed.

4. path:

   Path under the IOCCC/directory.  In a few cases this is a path,
   not just a simple filename under the IOCCC/directory.

5. created_by:

   The name of the program that creates this file, or null is the
   file an original file.

   NOTE: A null created_by value indicates that the file is part
   of the primary content.  A non-null created_by value indicates
   that the contents of the file is created by given program from
   primary content files.

   NOTE: The created_by values for [manifest.numbers](manifest.numbers)
   MUST always be null.  This is because every file with primary
   content (i.e., content not created by some tool) MUST be listed
   in the [manifest.numbers](manifest.numbers) file and MUST NOT
   listed in the [missing_manifest.numbers](missing_manifest.numbers) file.

   NOTE: The created_by values for [missing_manifest.numbers](missing_manifest.numbers) '
   MUST always be non-null.  This is because every file that is NOT a primary
   content file (i.e., content that is created by some tool) MUST
   be listed in the [missing_manifest.numbers](missing_manifest.numbers)
   file and MUST NOT listed in the  [manifest.numbers](manifest.numbers) file.

6. prog:

   This field indicates if the file main program.  This filed is one of:

   main		The main source code to display.
   alt		The alternative source code.
   orig		The original version of the source code (may be the same as main).
   null		Not a primary, nor alternative, nor original source code file.

7. filetype:

   The type of file.

8. ext:

    This ending filename extension, or null if no extension.
    This field is temporary and may go away.

9. winners_show:

   A JSON boolean indicating of the file is listed on `winners.html` or not.

   The winners_show value must be either true or false.

   NOTE: When winners_show is false, display_via MUST be null.

10. display_via:

   A string indicating how the file is to be displayed from `winners.html`.
   Possible files include:

   browser	The file is to be displayed directly from the browser.
   github	The file should be linked to the GitHub repo so that
		it may be rendered directly by GitHub.  In the future
		this may changed to allow a suitable browser to
		directly display this file instead of via GitHub.
   download	The file is intended to be downloaded from the browser
		instead of being displayed.
   null		This file not listed in `winners.html`.

   NOTE: When display_via is null, winners_show MUST be false.

11. winners_text:

    Any text that should be displayed at the end of line in `winners.html`
    (with a preceding " - "), or null is no such text is to be displayed.

The 11 field names in [manifest.numbers](manifest.numbers),
[missing_manifest.numbers](missing_manifest.numbers), and
[full_manifest.numbers](full_manifest.numbers) match the JSON member
names found in [example.dot_winner.json](example.dot_winner.json).

NOTE: Cells containing null are a JSON NULLs.
NOTE: Cells containing true or false are JSON booleans.
NOTE: Empty cells are TBD and need to be filled in.
NOTE: The winners_rank cells are either JSON null or JSON numbers.
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

0. open [manifest.csv](manifest.csv) in numbers: modify if/as needed

1. File -> Export To -> CSV...
    * 1a. `[ ]` Include table names (unset)
    * 1b. Text Encoding: Unicode (UTF-8)
    * 1c. Click ((Save..))

2. Save As: manifest.csv
    * 2a. Select the `tmp` directory

3. Click ((Export))
    * 3a. If needed click ((Replace))

4. execute ./[fix_numbers_csv.sh](fix_numbers_csv.sh)


### [missing_manifest.numbers](missing_manifest.numbers)

A [macOS](https://www.apple.com/macos) [Numbers](https://www.apple.com/numbers/)
spreadsheet contains information about files, that may not yet exist because
a tool needs to create it, with the following fields:

In case of conflict, the data in [missing_manifest.numbers](missing_manifest.numbers) file is
considered authoritative over the [missing_manifest.csv](missing_manifest.csv) file.

See [manifest.numbers](manifest.numbers) for information on this file format
as it has the exact same format.

The 11 field names in [manifest.numbers](manifest.numbers),
[missing_manifest.numbers](missing_manifest.numbers), and
[full_manifest.numbers](full_manifest.numbers) match the JSON member
names found in [example.dot_winner.json](example.dot_winner.json).


### [missing_manifest.csv](missing_manifest.csv)

The [missing_manifest.csv](missing_manifest.csv) is a CSV file that was exported from the
[missing_manifest.numbers](missing_manifest.numbers) file.

In case of conflict, the data in [missing_manifest.numbers](missing_manifest.numbers) file is
considered authoritative over the [missing_manifest.csv](missing_manifest.csv) file.

The [missing_manifest.csv](missing_manifest.csv) is generated from the [missing_manifest.numbers](missing_manifest.numbers) file,
via the [macOS](https://www.apple.com/macos/)
[Numbers](https://www.apple.com/numbers/) spreadsheet app, as follows:

0. open [missing_manifest.csv](missing_manifest.csv) in numbers: modify if/as needed

1. File -> Export To -> CSV...
    * 1a. `[ ]` Include table names (unset)
    * 1b. Text Encoding: Unicode (UTF-8)
    * 1c. Click ((Save..))

2. Save As: missing_manifest.csv
    * 2a. Select the `tmp` directory

3. Click ((Export))
    * 3a. If needed click ((Replace))

4. execute ./[fix_numbers_csv.sh](fix_numbers_csv.sh)


### [sql/winners.sql](sql/winners.sql)

This is a SQL file, extracted from another SQL file that was used in the past
to generate data for the old winners directory tree.


### [winner_id.txt](winner_id.txt)

A text file containing `winner_id` strings: one `winner_id` per line.


### [year_prize.csv](year_prize.csv)

A CSV file: one line per `winner`.

The first field is a `winner_id`.

The second field is the name of the award for given `winner`.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
