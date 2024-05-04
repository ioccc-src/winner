## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [2001/schweikh in bugs.html](../../bugs.html#2001_schweikh).


## To use:

``` <!---sh-->
    ./schweikh string string2
```

This program will very likely crash or do something else if you do not give it
two args.

Note also that the glob pattern must match the whole string. See the author's
comments for details and a workaround.

There's also no way to escape meta characters.

This is supposed to happen.  As is written in the
[The Jargon File](http://catb.org/jargon/html/F/feature.html):

```
    That's not a bug, that's a feature.
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Do you get the pattern here?


## Author's remarks:

This one-liner program is a glob pattern matcher. It understands
the glob characters `*` meaning 'zero or more characters' and
`?` meaning exactly one character, just like your unix shell.

Run it with two args, the string and the glob pattern. The exit status is 0
(shell true) when the pattern matches, 1 otherwise.  The glob pattern must match
the whole string, so you may want to use `*` at the beginning and end of the
pattern if you are looking for something in the middle.

You can use it for your shell scripting needs similar to a silent grep
(and without `stdout` redirected to `/dev/null`):

``` <!---sh-->
    if prog "${VARIABLE}" '<glob>'; then
	echo VARIABLE matches
    else
	echo no match
    fi
```

### Bugs

There is no way to escape the meta characters. Dammit Jim, I'm a
one-liner, not a regexp lib.

All obfuscation is obviously in the recursive `m()` function, an 86
character glob pattern evaluator, returning nonzero for a match:

* Just a single complex return expression.
* Nested ternary operator `?:` to save on `if`/`else` verbosity.
* Short circuiting `&&` and `||` to save even more on `if`/`else` verbosity.
* Subtraction instead of an equality operator in `*t - 42`.
* ASCII codes for `*` and `?`.
* Careful use of blanks even though this year's rules have extended
  that resource limit.
* The source is a complete preprocessed C program. Because it communicates
  with the world out there by means of `argv` and the exit status, there
  is no need for `stdio.h` bloat. An asm guru could surely squeeze this
  program in less than a screenful.
* `indent(1)` is probably not too helpful.

The recursion wonderfully and magically takes care of iteration and
backtracking. I could tell you how it works but then I would have to
<del>kill</del> request a NDA from you :-) Run it under a debugger with several
inputs, it will be quite helpful and instructive. Handling of `?` is
straightforward; for `*` start out with `*foo` and `foo*` against `foo`.
How does it deal with sequences of adjacent `*`? How could this be
improved? If all else fails, recode the `?:` operators with `if`/`else` and
try again. For extra credit implement character classes like `[a-z]`.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
