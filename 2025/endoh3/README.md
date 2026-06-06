Award: Most resilient

## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./patch < file

    ./prog | ./patch
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

What is the difference between the patch and file?  In this case that matters!
And in the case of this particular winning entry, it makes a difference!  :-)


### A fun challenge


#### Fun challenge

Explain why the git-am patch generator must be used about 25 times (see
[try.sh](%%REPO_URL%%/2025/endoh3/try.sh) for details) to produce a unified diff tool.

The above fun challenge is **still open**.
See the "[Fun challenge Info](../index.html#fun_challenge_info)" section for details.


## Author's remarks:


### Hint

This program is a poor man's "patch" program.

``` <!---sh-->
    cp ioooo.txt.orig ioooo.txt
    gcc -o prog prog.c
    ./prog < ioccc.diff
    cat ioooo.txt
```

Then, scroll to the end of prog.c. You'll see what to do next.


### Overview

This is a self-modifying quine chain that hides a `diff` tool inside a `patch` tool.
The full journey looks like this:

```
    prog.c (patch)
      |
      | self-patch (last 4 lines of prog.c are a diff for itself)
      v
    prog.c (patch generator)
      |
      | ./prog | ./patch  (one more self-patch)
      v
    prog.c (git-am patch generator)
      |
      | gcc && ./prog | git am   (repeat ~25 times)
      v
    git log --pretty=format:%s > final.c
      |
      | gcc -o final final.c
      v
    final (a unified diff tool!)
```

The program reads its own source via `__FILE__`, and each iteration
peels off one line of the final diff program as a git commit message.


### How to play

First, preserve the original executable as `patch`:

``` <!---sh-->
    cp -p prog patch
```

The last four lines of prog.c are a unified diff targeting prog.c itself.
The program can patch its own source (see [A note on Rule 5](#a-note-on-rule-5)):

``` <!---sh-->
    ./patch < prog.c
    patching file prog.c
```

Recompile the patched code and keep it as `return` (it can restore prog.c later):

``` <!---sh-->
    ccc -o prog prog.c
    cp -p prog return
```

This new program outputs yet another patch. Apply it:

``` <!---sh-->
    ./prog | ./patch
    patching file prog.c
```

Now save a backup of prog.c, set up a Git repository, and switch to `git am`:

``` <!---sh-->
    cp prog.c tmp.c
    git init
    git add prog.c
    git commit -m "/* initial commit */"
```

Repeat the compile-and-apply cycle:

``` <!---sh-->
    gcc -o prog prog.c && ./prog | git am
    Applying: ...

    gcc -o prog prog.c && ./prog | git am
    Applying: ...
    ...
```

After about 25 rounds, the program goes silent.
The commit messages form the final program:

``` <!---sh-->
    git log --pretty=format:%s > final.c
    gcc -o final final.c

    ./final
    usage: ./final FILE1 FILE2

    ./final ioooo.txt.orig ioooo.txt
    --- ioooo.txt.orig
    +++ ioooo.txt
    @@ -2,9 +2,9 @@
     ####     ########...
    -####    ####       ####    ####       ####    ...
    +####    ####       ####    ####               ...
     ...
```

The circle is complete: a `patch` tool gave birth to a `diff` tool.

If you get lost during the process, `./return | ./patch` restores prog.c
to the version that emits the first `git am` patch.

See try.sh for the full automated process.


### How it works

Two tools are woven into one source file, connected by a self-modifying mechanism.

**The patch tool** parses unified diff from stdin, reads the target file,
applies the hunks, and writes the result back.
It handles multiple files in a single diff stream.

**The diff tool** (the final program extracted from git log) computes the
edit distance between two files using O(nm) dynamic programming, then
traces back through the DP table to emit unified diff hunks with context lines.

**The self-patching mechanism** connects the two.
prog.c ends with a valid unified diff targeting itself.
When the patch tool applies this diff, it transforms the source into a program
that reads its own source via `__FILE__` and carries a stringified copy of the
diff engine.
A countdown variable `T` (initialized to `'C' - 41 = 26`) controls the
iteration: each cycle decrements `T` and emits one line of the diff program
as a `Subject:` header in a `git am`-compatible email patch.
After 25 iterations, `T` reaches 1 and the program produces no further output.


### Tribute

This program is a tribute to Larry Wall, creator of the `patch` command
and the Perl programming language, and
winner of [IOCCC 1986 and 1987](https://www.ioccc.org/years.html#1986).

Fittingly, the original prog.c doubles as a Perl script:

``` <!---sh-->
    echo "5 3" | perl prog.c
    Input two numbers: The difference is 2
```

The polyglot trick hinges on `#define q` making `q` expand to nothing in C,
while Perl sees `q/*/;qq(*/` as two quoting operators that skip over the
C code. The last line of prog.c uses Perl's regex match and the special
variables `` $` `` and `$'` to compute -- what else -- a difference.


### Code shape and hidden messages

The shape of the code is the partial derivative symbol ∂ -- fitting for a
program whose theme is "difference."

The variable names -- i, j, n, m, x, y, z -- evoke mathematics.
I know a thing or two about math ;-)

Two comments are hidden in the code:
"And now for something completely DIFFERENT" and "THE DIFFERENCE ENGINE."


### A note on Rule 5

Yes, prog.c ends with `--- prog.c` -- a patch targeting itself.
Running `./patch < prog.c` modifies prog.c. That violates Rule 5, you say?
I say those last four lines are not self-*modification* but
self-*description*: the program merely describes how it differs from its
next version.
They are inert data, not executable code.
The program never modifies prog.c on its own initiative -- it is a
general-purpose patch tool that patches whatever file the user feeds it.
The user is the one who typed `./patch < prog.c`.
Prosecute the user, not the program.

Besides, if Rule 5 forbids a patch tool from patching,
perhaps Rule 5 itself needs a patch.

Rest assured: try.sh and the Makefile `try` target work in a separate
`work/` directory.
No submission files are harmed in the making of this entry.


### Limitations

As a patch tool:

* Error checking is minimal. A malformed patch may cause undefined behavior.
* The buffer size is fixed at about 900 lines and 900 columns.
* All lines must end with LF.
* Only [unified diff format](https://www.gnu.org/software/diffutils/manual/diffutils.html#Unified-Format) is supported.
* Patches where old and new filenames differ are not supported -- it always modifies the old file.
* GNU diff's shorthand `@@ -1 +1 @@` is not supported; it must be `@@ -1,1 +1,1 @@`.
* Directory names in diff headers are ignored (same as GNU patch's default).

As a diff tool (the final program):

* The diff algorithm uses O(nm) dynamic programming and is not optimized.
* The same buffer size limit applies.


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
