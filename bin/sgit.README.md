# sgit - run sed on files under git control

This was originally a quick and dirty hack to modify files under git control
via `sed`. It started out with some limitations like the inability to deal
with spaces in `sed` commands, only allowing one glob and it had terrible
efficiency because it ran git ls-files for each `sed` command.

Now it is a bit more thorough and is more efficient (though not perfect). It
allows you to specify a path to `sed`, `sed` options and multiple `sed` commands
(though this always existed). The default behaviour is to use in place editing
**WITHOUT A BACKUP EXTENSION** but you may override the saving to disk with the
`-I` option.

## Usage

```sh
usage: sgit [-h] [-V] [-v level] [-x] [-I] [-o sed_options] [-s sed] [-e command] <glob...>

    -h			    print help and exit
    -V			    print version and exit
    -v level		    set verbosity level
    -x			    turn on tracing (set -x)
    -I			    disable in place editing
    -o			    sed options (don't pass '-')
				WARNING: use of '-o n' without '-I', can depending on command, empty files
    -s sed		    set path to sed
    -e command		    append sed command to execute on globs

sgit version: 0.0.7-1 12-04-2023

```

You **MUST** specify at least one `sed` command and one glob: the sed command by
way of the `-e` option (just like with `sed`); anything after the last option is
a glob. You may specify more than one of each. Specify `-e` for each command.

# Examples

## Change in this file (in memory only) `\<sed\>` to be `used` but only show lines changed:

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

## Change references of `\<sed\>` to be `used` in this file and save it:

```sh
./sgit -e 's/\<sed\>/used/p' -v3 -x README.md

```

## Change `\<sed\>` to `used` but only if it's on the third line

```sh
./sgit -e '3s/\<sed\>/used/g' README.md
```

Alternatively you could do one of:


```sh
./sgit -e '3s/\<sed\>/u&/g' README.md
./sgit -e '3s/\(\<sed\>\)/u\1/g' README.md
```

# WARNING: invalid use of -o -n can empty files!

Because `sed -n` does not print output if you do not use `-I` and you use
substitute you can empty the entire file. For instance **DO NOT** do this:


```sh
./sgit -o n -e 's/.//g' sgit
```

because it would empty `sgit`!


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

