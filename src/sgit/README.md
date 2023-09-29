# sgit - run sed on files under git control

`sgit` runs `sed(1)` on files that are under git control, based on one or more
globs (either a pattern or an exact file name). Running this from a directory
that is not a git repository is an error and any files not under git control in
the directory will not be touched. Depending on the globs specified it might or
might not recurse into subdirectories. That is the shell at work, of course.
Running it in a directory that is not a git repository is an error.

`sgit` is extremely useful because one need not run extra commands to determine
the list of files (which might be very long) and then pass them directly to
`sed(1)`.

At least one `sed` command is required with the `-e` option (analogous to `sed
-e`) and at least one glob is required. It is an error if at least one of each
is not specified.

You can specify the path to `sed` in case you wish to use a different one. For
instance in macOS if you have GNU sed installed you might want to use that
instead. You can do that with the `-s sed` option.

If you wish to provide options to `sed` itself you can so with the `sgit -o`.
Note that you **MUST** pass the `-` to the option and for long options like
`--posix` you must pass `--`! In other words use the options like you would with
`sed` but prefixing it with `-o` first. This was a stylistic choice but it
allows one to quote the option arg to pass more than one option instead of
having to use `sgit -o` more than once though you can certainly use the option
more than once. Note that not all options to `sed` have been tested. If the
option requires a space (say for an arg) or you want to pass more than one
option separated by a space and you only use one `-o` you must quote it.

By default it does **in-place editing and it does NOT backup files**. If you
wish to not edit the file in place (see examples later in this file) you can use
the `sgit -I` option. Note that the `-n` option (`sgit -o -n`) without `sgit -I`
can, depending on the sed commands, empty files! This is analogous to using both
`-n` and `-i` to `sed` which would do in-place editing without automatic
printing of the pattern space. An example is provided later.

If you wish to provide a backup extension for editing files use `sgit -i`. See
example below. Note that using `-i` overwrites existing backup files and it will
also create or update a file for each file edited. This means that if it ends up
editing 50 files without a backup file (with the extension provided) there will
be 50 new files created. Using this option might be of limited use, of course,
since files under git control can be restored, compared etc. but it's there in
case one wants it.

See the usage below or run `sgit` by itself (or with the `-h` option) to see the
rest of the options.

See the section [Script history](#script-history) for more details on the
evolution of the script.

## Usage

```sh
usage: sgit [-h] [-V] [-v level] [-x] [-I] [-i extension] [-o sed_option] [-s sed] [-e command] <glob...>

    -h			    print help and exit
    -V			    print version and exit
    -v level		    set verbosity level
    -x			    turn on tracing (set -x)
    -I			    disable in place editing

    -i extension	    set backup extension (default none)
				WARNING: sed -i overwrites existing backup files
				WARNING: this will create or update a file for each file changed

    -o sed_option	    append sed option or options to options list
				WARNING: use of '-o -n' without '-I', can depending on
				sed commands, empty files as if both sed -i and sed -n were
				used together

				NOTE: you must pass the '-' for short options and '--' for long options!
				NOTE: if you need a space in an option you should quote it!

    -s sed		    set path to sed
    -e command		    append sed command to list of commands to execute on globs

sgit version: 0.0.12-1 29-04-2023
```

You **MUST** specify at least one `sed` command and one glob: the `sed` command
by way of the `-e` option (just like with `sed`); anything after the last option
is a glob. You may specify more than one of each. Specify `-e` for each command.
The `sed` commands is an array just like the `sed` options.


## A note about the `-i` option and backup extensions

It works like `sed -i` except that the default behaviour of the script is to use
`-i` just with an empty backup extension (this is required for some versions of
`sed` which force that a backup extension actually be provided with the `-i`
option .. I'm looking at you, BSD/macOS `sed`).


## `sgit -i` WARNING: each file edited will result in another file in the working directory

Of course if you have 50 files that are edited then 50 new files will be
created (or otherwise updated) just like with `sed` itself.

# `sgit -i` WARNING: this **WILL OVERWRITE EXISTING BACKUP FILES**!

Please be aware that if a backup file already exists it **WILL** be overwritten!
This is because it uses `sed -i`.

I won't even try and detect this because it's not how `sed` works and it would
overly complicate the script.


# `sgit -o -n` WARNING: invalid use of `sgit -o -n` can empty files!

As already noted: because `sed -n` does not print output if you do not use `-I`
and you use substitute or do not print everything you can empty the entire file
or remove much of the file for two examples. For instance **DO NOT** do this:


```sh
sgit -o -n -e 's/.//g' sgit
```

because it would empty `sgit`!

## More about options and the tool itself

A man page exists for this tool with more about the tool and the options. Since
this file has a number of examples there are no additional examples in it. To
render it:

```sh
man sgit
```

if installed. Otherwise if it's not installed you can do:

```sh
man ./sgit.1
```


## Examples

### Change references (_**IN MEMORY ONLY**_ i.e. WITHOUT in-place editing) of the exact word `sed` (as in `\<sed\>`) in this file but only show changed lines

```sh
sgit -I -o -n -e 's/\<sed\>/used/p' README.md
```

### Print out matches of the EXACT word `sed` (as in `\<sed\>`) in all files under git control from the current working directory

This is a simpler way of running `git --no-pager grep -h -E '\<sed\>'|sed
's/^[0-9]*://g'` which itself might or might not be more complicated than it
needs to be:

```sh
sgit -I -o -n -e '/\<sed\>/p' .
```

### With tracing enabled, change references of `\<sed\>` to `used` in this file and save it:

```sh
sgit -e 's/\<sed\>/used/g' -x README.md

```


### With tracing enabled, change references of `\<sed\>` to `used`, duplicating the lines, in this file and save it:

```sh
sgit -e 's/\<sed\>/used/p' -x README.md

```

## Verbosely (level 1) change references of `\<sed\>` to `used` in this file and save it:

```sh
sgit -e 's/\<sed\>/used/g' -v1 README.md
sgit -e 's/\<sed\>/used/g' -v 1 README.md

```

## Verbosely (level 3) change references of `\<sed\>` to `used` in this file with a backup as `README.md.bak`

```sh
sgit -i.bak -e 's/\<sed\>/used/g' -v3 README.md
sgit -i.bak -e 's/\<sed\>/used/g' -v 3 README.md

```

With that you would see something like:

```sh
debug[2]: sed commands:  -e	s/\<sed\>/used/g
debug[2]: looping through all globs
debug[1]: using backup extension: .bak
debug[2]: found glob: 0
debug[1]: about to run: git ls-files README.md | xargs /opt/local/bin/sed -i".bak" -e	s/\<sed\>/used/g
debug[2]: 0 remaining globs
```

Level 2 would not show how many globs remain after each operation.


### Verbosely (level 3) change references of `\<used\>` back to `sed` in this file with a backup as `README.md.bak`

```sh
sgit -i.bak -e 's/\<used\>/sed/g' -v3 README.md
sgit -i.bak -e 's/\<used\>/sed/g' -v 3 README.md

```

With that you would see something like:

```sh
sgit -i.bak -e 's/\<used\>/sed/g' -v3 README.md
debug[2]: sed commands:  -e	s/\<used\>/sed/g
debug[2]: looping through all globs
debug[1]: using backup extension: .bak
debug[2]: found glob: 0
debug[1]: about to run: git ls-files README.md | xargs /opt/local/libexec/gnubin/sed -i".bak" -e	s/\<used\>/sed/g
debug[2]: 0 remaining globs
```

and the example title would look like:

```markdown
### Verbosely (level 3) change references of `\<sed\>` back to `sed` in this file with a backup as `README.md.bak`
```

## Change `\<sed\>` to `used` but only if it's on the first line

```sh
sgit -e '1s/\<sed\>/used/g' README.md
```

Alternatively you could do one of:


```sh
sgit -e '1s/\<sed\>/u&/g' README.md
sgit -e '1s/\(\<sed\>\)/u\1/g' README.md
```

### Change `\<sgit\>` to `gits` but only if it's on the third line

```sh
sgit -e '3s/\<sgit\>/gits/g' README.md
```



## Installation

If you wish to install it you may either copy it to a place in your path or if
you have make installed you can just run `make install` either as root or via
`sudo` like:

```sh
sudo make install
```

## Limitations

One that comes to mind is you cannot specify `git ls-files` options but this
could be problematic anyway especially if one were to specify the `-z` option.

There are probably other limitations but it works well for what I needed.

## Bugs

None known but it does not try and determine which files match the patterns.
This would likely greatly complicate the script and is I feel unneeded.

If you specify invalid `sed` commands obviously there will be problems. If you
specify invalid `sed` options there will possibly be problems as well.

As below this was originally a hack.


## History

It has been a persistent problem for me that I need to edit files under git
control and `sed` is the obvious way to go about it.

Working on the [IOCCC mkiocccentry](https://github.com/ioccc-src/mkiocccentry)
and the [IOCCC temporary website](https://github.com/ioccc-src/temp-test-ioccc)
and the [IOCCC temporary website](https://github.com/ioccc-src/temp-test-ioccc)
repos (and in particular the latter) is what inspired me to finally do something
about it. The latter repo will eventually be merged into the [IOCCC winner
repo](https://github.com/ioccc-src/winner) which is the actual [IOCCC
website](https://www.ioccc.org).

### Script history

This was originally a quick and dirty hack to modify files under git control
via `sed`. It started out with some limitations like the inability to deal
with spaces in `sed` commands, only allowing one glob and it had terrible
efficiency because it ran git ls-files for each `sed` command.

Now it is much more thorough and is more efficient (though not perfect). It
allows you to specify a path to `sed`, `sed` options and multiple `sed` commands
(though the latter always existed), it can disable in-place editing, you can
backup files if you wish and much more.

`sgit` version `0.0.9-1 24-04-2023` added support to use the `-o` option more
than once. Not allowing this was an oversight.


## Other thoughts

Pull requests are welcome but I think it's mostly in a good enough state where
this will probably generally not be needed.

