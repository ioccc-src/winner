# sgit - run sed on files under git control

This was originally a quick and dirty hack to modify files under git control
via `sed`. It started out with some limitations like the inability to deal
with spaces in `sed` commands, only allowing one glob and it had terrible
efficiency because it ran git ls-files for each `sed` command.

Now it is a bit more thorough and is more efficient (though not perfect). It
allows you to specify a path to `sed`, `sed` options and multiple `sed` commands
(though this always existed). The _default_ behaviour is to use in place editing
(**WITHOUT A BACKUP EXTENSION**; use `-i` to provide a backup extension) but you
can override the saving to disk with the `-I` option.

## Usage

```sh
usage: sgit [-h] [-V] [-v level] [-x] [-I] [-i extension] [-o sed_options] [-s sed] [-e command] <glob...>

    -h			    print help and exit
    -V			    print version and exit
    -v level		    set verbosity level
    -x			    turn on tracing (set -x)
    -I			    disable in place editing
    -i extension	    set backup extension (default none)
				WARNING: sed -i overwrites existing files
				WARNING: this will create another file for each file changed
    -o			    sed options (NOTE: don't pass '-'!)
				WARNING: use of '-o n' without '-I', can depending on command, empty files
    -s sed		    set path to sed
    -e command		    append sed command to list of commands to execute on globs

sgit version: 0.0.8-1 19-04-2023
```

You **MUST** specify at least one `sed` command and one glob: the sed command by
way of the `-e` option (just like with `sed`); anything after the last option is
a glob. You may specify more than one of each. Specify `-e` for each command.

# A note about the `-i` option and backup extensions

It works like `sed -i` except that the default behaviour of the script is to use
`-i` just with an empty backup extension (this is required for some versions of
`sed` which force that a backup extension actually be provided with the `-i`
option .. I'm looking at you, BSD/macOS `sed`).


# `-i` WARNING: each file edited will result in another file in the working directory

Of course if you have 50 files that are affected then 50 new files will be
created.

# `-i` WARNING: `sed -i` **WILL OVERWRITE EXISTING FILES**!

Please be aware that if a backup file already exists it **WILL** be overwritten!
I won't even try and detect this because it's not how `sed` works and it would
overly complicate the script.


# `-o n` WARNING: invalid use of -o n can empty files!

Because `sed -n` does not print output if you do not use `-I` and you use
substitute you can empty the entire file. For instance **DO NOT** do this:


```sh
./sgit -o n -e 's/.//g' sgit
```

because it would empty `sgit`!


# Examples

## Change in this file (_IN MEMORY ONLY_) `\<sed\>` to `used` but only show lines changed:

```sh
./sgit -I -o n -e 's/\<sed\>/used/p' README.md 
./sgit -I -n -e 's/\<sed\>/used/p' README.md 
```

## Print out matches of `\<sed\>` in all files under git control

This is a simpler way of running `git --no-pager grep -h -E '\<sed\>'|sed
's/^[0-9]*://g'` which itself might or might not be more complicated than it
needs to be:

```sh
./sgit -I -o n -e '/\<sed\>/p' .
```

## With tracing enabled, change references of `\<sed\>` to `used` in this file and save it:

```sh
./sgit -e 's/\<sed\>/used/g' -x README.md

```


## With tracing enabled, change references of `\<sed\>` to `used`, duplicating the lines, in this file and save it:

```sh
./sgit -e 's/\<sed\>/used/p' -x README.md

```

## Verbosely (level 1) change references of `\<sed\>` to `used` in this file and save it:

```sh
./sgit -e 's/\<sed\>/used/g' -v1 README.md

```

## Verbosely (level 3) change references of `\<sed\>` to `used` in this file with a backup as `README.md.bak`

```sh
./sgit -i.bak -e 's/\<sed\>/used/g' -v3 README.md

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


## Change `\<sed\>` to `used` but only if it's on the first line

```sh
./sgit -e '1s/\<sed\>/used/g' README.md
```

Alternatively you could do one of:


```sh
./sgit -e '1s/\<sed\>/u&/g' README.md
./sgit -e '1s/\(\<sed\>\)/u\1/g' README.md
```

## Change `\<hack\>` to `crack` but only if it's on the third line

```sh
./sgit -e '3s/\<hack\>/crack/g' README.md
```



## Installation

If you wish to install it you may either copy it to a place in your path or if
you have make installed you can just run `make install` either as root or via
`sudo` like:

```sh
sudo make install
```

## Documentation?

Right now this is it but the Makefile is set up so that if a man page is added
it can easily install it as well.

## Limitations

One that comes to mind is you cannot specify `git ls-files` options but this
could be problematic anyway especially if one were to specify the `-z` option.

There are probably other limitations but it works well for what I needed.

## Bugs

None known but it does not try and determine which files have match the
patterns. This would likely greatly complicate the script and is I feel
unneeded.

If you specify invalid `sed` commands obviously there will be problems. If you
specify invalid `sed` options there will possibly be problems as well.

Again this was originally a hack.


## History

It has been a persistent problem for me that I need to edit files under git
control and `sed` is the obvious way to go about it.

Working on the [IOCCC mkiocccentry](https://github.com/ioccc-src/mkiocccentry)
and the [IOCCC temporary website](https://github.com/ioccc-src/temp-test-ioccc)
and the [IOCCC temporary website](https://github.com/ioccc-src/temp-test-ioccc)
repos (and in particular the latter) is what inspired me to do something about
it.

## Other thoughts

Pull requests are welcome but I think it's mostly in a good enough state where
this will probably generally not be needed.

