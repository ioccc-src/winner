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

```re
^[a-z][0-9a-z]*
```

## files

### [author-names.txt](author-names.txt)

A text file of full names of each `author`: one full name per line.

In the case of anonymous authors the form is:

```
Anonymous YYYY
```

### [author-wins.csv](author-wins.csv)

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

### [example.author.json](example.author.json)

This is a JSON file containing an example `author/author_handle.json` for a
fictitious `author`.

An `author/author_handle.json` file will be derived from the contents of the 
[author.csv](author.csv) file and the [author-wins.csv](author-wins.csv) file.

### [example.dot_winner.json](example.dot_winner.json)

This is a JSON file containing an example `year/dir/.winner.json` for a
fictitious `winner`.

A `year/dir/.winner.json` file will be derived from the contents the `year/dir/.id` file,
the [author-wins.csv](author-wins.csv) file, the `year/dir/.year` file,  and the
contents of the `year/dir` directory.

### [sql/winners.sql](sql/winners.sql)

This is a SQL file, extracted from another SQL file that was used in the past
to generate data for the old winners directory tree.

### [winner_id.txt](winner_id.txt)

A text file containing `winner_id` strings: one `winner_id` per line.

### [year-prize.csv](year-prize.csv)

A CSV file: one line per `winner`.

The first field is a `winner_id`.

The second field is the name of the award for given `winner`.

### [gen_author_json.sh](gen_author_json.sh)

Temporary tool used to generate the `author/author_handle.json` files.

The following command, executed in this directory, created the `author/` directory:

```sh
rm -rf ../author ; ./gen_author_json.sh  author_handle.txt author.csv author-wins.csv ../author
```
