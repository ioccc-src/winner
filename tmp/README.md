# tmp

The tools under this directory are an alpha release.
The [bin directory](bin/index.html)
holds the formal release of tools that will
maintain the [official IOCCC web site](https://www.ioccc.org).

Currently these tools maintain the [experimental web site](https://ioccc-src.github.io/temp-test-ioccc/)
by default, via the  [temp-test-ioccc GitHub repo](https://github.com/ioccc-src/temp-test-ioccc).
These tools will default to using the temp-test-ioccc repo and the experimental web site
until the [official IOCCC web site](https://www.ioccc.org), via the
[IOCCC winner repo](https://github.com/ioccc-src/winner) is ready for the mass pull request/merge.

**IMPORTANT**: The purpose of the `tmp` directory is to hold temporary files.
The files in the `tmp` directory will go away leaving behind an empty `tmp` directory.


## purpose

This documentation is here to help define terms, files under `tmp/`
and the format of those files.

*NOTE*: The `terms` section may be moved to another file
later on, after the contents of this directory are removed.


## files


### [OLD_manifest](OLD_manifest)

The files in the [OLD_manifest](OLD_manifest) were in the top of
the tmp directory as of 2023 Oct 26.  They represent the first
complete manifest that matched the _YYYY/dir_ entry directories.

These files in this directory are kept as a temporary snapshot.

Some obsolete files and tools were moved under [OLD_manifest](OLD_manifest).


### [README.md](README.md)

This file.


### [author_handle.txt](author_handle.txt)

A text file containing `author_handle`s for each `author`: one `author_handle`
per line.


### [author_names.txt](author_names.txt)

A text file of full names of each `author`: one full name per line.

In the case of anonymous authors the form is:

```
    Anonymous YYYY
```


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


### [author_wins.numbers](author_wins.numbers)

A [macOS](https://www.apple.com/macos) [Numbers](https://www.apple.com/numbers/)
spreadsheet: one line per `author`.

The first field is an `author_handle`.

The other fields are the `entry_id`'s of all _YYYY/dir_ entry's won by the `author`.


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


### [entry_dir.txt](entry_dir.txt)

A list of paths to _YYYY/dir_ entry directories that reside
under year directories.


### [entry_id.txt](entry_id.txt)

A text file containing `entry_id` strings: one `entry_id` per line.


### [example.author.json](example.author.json)

This is a JSON file containing an example `author/author_handle.json` for a
fictitious `author`.


### [example.dot_entry.json](example.dot_entry.json)

This is a JSON file containing an example `year/dir/.entry.json` for a
fictitious winning _YYYY/dir_ entry.

A `year/dir/.entry.json` file will be derived from the contents the `year/dir/.id` file,
the [author_wins.csv](author_wins.csv) file, the `year/dir/.year` file,  and the
the [manifest.csv](manifest.csv) file.

The 11 field names in [manifest.numbers](manifest.numbers) match
the JSON member names found in
[example.dot_entry.json](example.dot_entry.json).


### [fix_csv.sh](fix_csv.sh)

This tool will fix CSV files exported by
[macOS](https://www.apple.com/macos)
[Numbers](https://www.apple.com/numbers/) by removing carriage
returns and appending a newline if it was missing.

Fixing involves these actions:

``` <!---sh-->
    tr -d '\015' < input.csv > tmp.csv
    echo >> tmp.csv
    mv -f tmp.csv input.csv
```

This tool also forms [path_list.built.txt](path_list.built.txt),
[path_list.manifest.txt](path_list.manifest.txt), and
[path_list.required.txt](path_list.required.txt) from
[manifest.csv](manifest.csv).


### [format-headers.sh](format-headers.sh)

This tool helped format the `README.md` files for _YYYY/dir_ winning entries.


### [gen_entry_json.sh](gen_entry_json.sh)

Generate a `.entry.json` for a given winning _YYYY/dir_ entry.


### [gen_path_list.found.sh](gen_path_list.found.sh)

The list of paths of files in all winning entries.

After doing a `make clobber` this tool updates, if needed,
form [path_list.found.txt](path_list.found.txt).


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


### [manifest.numbers](manifest.numbers)


A [macOS](https://www.apple.com/macos) [Numbers](https://www.apple.com/numbers/)
spreadsheet contains information about files in _YYYY/dir_ entry directories under year directories.
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

   This number is the rank showing the order
   that this file is to be listed for the given entry's in
   the winning entry's `index.html` file.

   If the number is 9 digits or less, then the given file
   is considered a primary file when listed in the inventory
   of files for a given winning _YYYY/dir_ entry.

   If the number is 10 digits or more, then the given file
   is considered a secondary file when listed in the inventory
   of files for a given winning _YYYY/dir_ entry  We recommend using the
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

8. entry_text:

    Any text that should be displayed at the end of line in `index.html`
    (with a preceding " - "), or null is no such text is to be displayed.


The 8 field names in [manifest.numbers](manifest.numbers), must
match the JSON member names found in
[example.dot_entry.json](example.dot_entry.json).

NOTE: Cells containing true or false are JSON booleans.
NOTE: All other cells are JSON strings that need to be double quoted, including the year.
NOTE: Do not put commas, nor quotes, nor newlines in fields as these are bound to cause problems.

In case of conflict, the data in [manifest.numbers](manifest.numbers) file is
considered authoritative over the [manifest.csv](manifest.csv) file.


### [path_list.built.txt](path_list.built.txt)

A list of file paths (from the top directory) of _YYYY/dir_ entry directories,
that are built from other primary content files.

These paths are formed from [manifest.numbers](manifest.numbers)
entries where the "created_by" (5th) field is null.  See
[manifest.numbers](manifest.numbers) for details on the fields.

This file is formed by the [fix_csv.sh](fix_csv.sh) tool.


### [path_list.found.txt](path_list.found.txt)

A list of files that exist, or should exist once the tools to generate certain files,
such as the `index.html`, or the `.entry.json` files for each entry, are created.

This file is created by [gen_path_list.found.sh](gen_path_list.found.sh).


### [path_list.manifest.txt](path_list.manifest.txt)

This is the list of file paths, both primary and constructed
files from _YYYY/dir_ entry directories.

This file is formed by the [fix_csv.sh](fix_csv.sh) tool.


### [path_list.required.txt](path_list.required.txt)

A list of file paths (from the top directory) of _YYYY/dir_ entry directories,
that are required to exist.

These paths are formed from [manifest.numbers](manifest.numbers)
entries where the "created_by" (5th) field is non-null.  See
[manifest.numbers](manifest.numbers) for details on the fields.

This file is formed by the [fix_csv.sh](fix_csv.sh) tool.


### [run_all.sh](run_all.sh)

A tool to run another tool over all _YYYY/dir_ entry directories.

Examples:

``` <!---sh-->
    ./run_all.sh -v 3 ./fake.gen_index.sh
    ./run_all.sh -v 1 ./gen_entry_json.sh
```


## [md-chk-paths.sh](%%DOCROOT_SLASH%%tmp/md-chk-paths.sh)

Print full directories of local (non-remote URL) markdown paths.

Usage:

``` <!---sh-->
    tmp/md-chk-paths.sh
```


## [md-links.sh](%%DOCROOT_SLASH%%tmp/md-links.sh)

For all markdown files, print markdown links.

Usage:

``` <!---sh-->
    tmp/md-links.sh
```

Lines printed are of the form:

```
    markdown_path.md [pseudo title](path)
```


## [md-local-links.sh](%%DOCROOT_SLASH%%tmp/md-local-links.sh)

For all markdown files, print markdown links that are local.
We ignore URLs that start with "http:" or "https:" or "mailto:".
We ignore links that are internal to the file (i.e., "#name").

Usage:

``` <!---sh-->
    tmp/md-local-links.sh
```

Lines printed are of the form:

```
    markdown_path.md [pseudo title](path)
```


## [md-token-links.sh](%%DOCROOT_SLASH%%tmp/md-token-links.sh)

For all markdown files, print markdown links that start with a **%%TOKEN%%**.

Usage:

``` <!---sh-->
    tmp/md-token-links.sh
```

Lines printed are of the form:

```
    markdown_path.md [pseudo title](%%TOKEN%%path)
```


## [md-link-paths.sh](%%DOCROOT_SLASH%%tmp/md-link-paths.sh(

Print local file paths referenced in markdown links.

We ignore URLs that start with "http:" or "https:" or "mailto:".
We remove "%%REPO_URL%%/" and "%%DOCROOT_SLASH%%" from paths.
We delete lines with "%%TOKEN%%" as this is just a test/example token.

Usage:

``` <!---sh-->
    tmp/md-link-paths.sh
```

Lines printed are of the form:

```
    path
```


### [src](src)

This is a temporary location for potential tools that are used to
build and maintain the www.ioccc.org web site.


### [things-todo.md](things-todo.md)

A todo list of known things to check and/or do.


### [update-manifest.sh](update-manifest.sh)

Interactive script to update the IOCCC manifest step by step post manifest.csv export.


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


### [year_prize.numbers](year_prize.numbers)

A [macOS](https://www.apple.com/macos) [Numbers](https://www.apple.com/numbers/)
spreadsheet: one line per _YYYY/dir_ entry directory.

The first field is a `entry_id`.

The second field is the name of the award for given _YYYY/dir_ entry.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
