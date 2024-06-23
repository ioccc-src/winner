# author directory

The `author/` directory contains a JSON file for each author of at
least one winning IOCCC entry.  For each author, there is a JSON
file with the following name format:

```
    author/author_handle.json
```

where `author_handle` is defined below.

## author_handle

Each author of a winning IOCCC entry has an assigned `author_handle`,
an IOCCC unique string that matches this regex:

``` <!---re-->
    ^[0-9a-z][0-9a-z_]*$
```

The `author_handle`, by default, is derived from the name of the author.
While there is a algorithm that maps the name of the author
(which can contain any UTF-8 characters) into a default
`author_handle` string, those who submit an entry to the IOCCC
are free to choose a different `author_handle` string.

An `author` who has won a previous IOCCC is encouraged to reuse their
author_handle so that new winning entries will be associated with the same
author or authors.

### anonymous author_handle's

For an anonymous `author`, their handle is one of these forms:

```
    Anonymous_year
```

or:

```
    Anonymous_year.digits
```

The latter form is in case there are more than one
anonymous author in a given year.

Anonymous author_handle's match this regexp:

``` <!---re-->
    Anonymous_[0-9][0-9][0-9][0-9][.0-9]*$
```

## author_handle.json JSON syntax

The `author_handle.json` must have the following JSON members:

``` <!---json-->
    "no_comment" : "mandatory comment: because comments were removed from the original JSON spec",
    "author_JSON_format_version" : "0.1 2023-05-22",
```

There must be the following JSON members:

``` <!---json-->
    "full_name" : "Your Full Name",
    "sort_word" : "lowercaselast",
    "location_code" : "XX",
    "location_name" : "Formal location name",
```

- `"full_name"` value is the author's formal full name.
- `"sort_word"` value is the author's last name, mapped into lower case ASCII, as a JSON encoded string
- `"location_code"` value is a 2 UPPER CASE ISO 3166 code selected by the author
- `"location_name"` value is the formal name corresponding to the `"location_code"`, in JSON encoded string form

A `"sort_word"` that is used to determine the position within the `authors.html` file,
an `author` and the entry they submitted are to be listed.

A `sort_word` matches this regexp:

``` <!---re-->
    ^[a-z][0-9a-z]*
```

And there must be the following JSON members:

``` <!---json-->
    "email" : "user0@example.com",
    "url" : "https://a.host0.example.com/index.html",
    "alt_url" : "https://b.host0.example.com/index.html",
    "deprecated_twitter_handle" : "@something",
    "mastodon" : "@mastodon0@example.com",
    "mastodon_url" : "https://example.org/@mastodon0",
    "github" : "@github0",
    "affiliation" : "an affiliation group",
```

- `"email"` value is the author's email address as a JSON encoded string, or `null` if not given
- `"url"` value is the author's home page URL as a JSON encoded string, or `null` if not given
- `"alt_url"` value is the author's alternate or second URL as a JSON encoded string, or `null` if not given
- `"deprecated_twitter_handle"` value is the author's twitter handle as a JSON encoded string, starting with "_@_", or `null` if not given
- `"mastodon"` value is the author's Mastodon handle in "_@user@server_" form as a JSON encoded string, or `null` if not given
- `"mastodon_url"` value is the URL as a JSON encoded string of the author's Mastodon page, or `null` if not given
- `"github"` value is the author's GitHub username as a JSON encoded string, starting with "_@_", or `null` if not given
- `"affiliation"` is the author's affiliation as a JSON encoded string, or `null` if not given

If an author does not have one of the previous set of values, or wishes to not disclose it / keep it anonymous,
then the JSON value can be `null`. For example:

``` <!---json-->
    "email" : null,
    "url" : null,
    "alt_url" : null,
    "deprecated_twitter_handle" : null,
    "mastodon" : null,
    "mastodon_url" : null,
    "github" : null,
    "affiliation" : null,
```

NOTE: The JSON value of `null` is NOT enclosed in double quotes.

The `"winning_entry_set"` is an array of JSON members that indicate
each of the IOCCC winning entries that the author is the author of.  :-)

``` <!---json-->
    { "entry_id" : "YYYY_dirname" }
```

The `"YYYY_dirname"` is a entry ID in JSON encoded string form.
Here "YYYY" is the IOCCC year, and "dirname" is the directory name
of the winning entry under the given year directory.

NOTE: Due to mis-features in the JSON spec, the final JSON member must NOT be followed by a comma.
For example:

``` <!---json-->
    "winning_entry_set" : [
	{ "entry_id" : "1987_somedir" },
	{ "entry_id" : "2020_entrydir" },
	{ "entry_id" : "2024_dirname" }
    ]
```

### author_handle.json example

Here is a fictitious author_handle.json example:

``` <!---json-->
    {
	"no_comment" : "mandatory comment: because comments were removed from the original JSON spec",
	"author_JSON_format_version" : "1.0 2023-06-10",
	"author_handle" : "first0_last0",
	"full_name" : "First Middle Last",
	"sort_word" : "lowercaselast",
	"location_code" : "AU",
	"location_name" : "Australia",
	"email" : "user0@example.com",
	"url" : "https://a.host0.example.com/index.html",
	"alt_url" : "https://b.host0.example.com/index.html",
	"deprecated_twitter_handle" : "@something",
	"mastodon" : "@mastodon0@example.com",
	"mastodon_url" : "https://example.org/@mastodon0",
	"github" : "@github0",
	"affiliation" : "an affiliation group",
	"winning_entry_set" : [
	    { "entry_id" : "1987_somedir" },
	    { "entry_id" : "2020_entrydir" },
	    { "entry_id" : "2024_dirname" }
	]
    }
```

Here is fictitious author_handle.json example where all entries that may be
withheld are null:

``` <!---json-->
    {
	"no_comment" : "mandatory comment: because comments were removed from the original JSON spec",
	"author_JSON_format_version" : "1.0 2023-06-10",
	"author_handle" : "first0_last0",
	"full_name" : "First Middle Last",
	"sort_word" : "lowercaselast",
	"location_code" : "AU",
	"location_name" : "Australia",
	"email" : null,
	"url" : null,
	"alt_url" : null,
	"deprecated_twitter_handle" : null,
	"mastodon" : null,
	"mastodon_url" : null,
	"github" : null,
	"affiliation" : null,
	"winning_entry_set" : [
	    { "entry_id" : "1987_somedir" },
	    { "entry_id" : "2020_entrydir" },
	    { "entry_id" : "2024_dirname" }
	]
    }
```

## NOTE to authors

If you wish to update / modify information about yourself, you need to
modify your `author_handle.json` file via a [GitHub pull
request](https://github.com/ioccc-src/winner/pulls).


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
