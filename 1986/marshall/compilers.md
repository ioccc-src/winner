# Conflicting compilers and optimisers that broke this entry in 2023

As briefly noted in the [index.html](index.html) `gcc` and `clang` caused different
problems with this entry depending on the optimiser being enabled or not, where
if the optimiser was enabled it would work with one compiler and not the other.
But if you then disabled the optimiser the opposite problem would occur: the
working compiler would no longer work and the non-functional one would start to
work! And then there's the problem of linux versus macOS causing problems.

The [alternate code](%%REPO_URL%%/1986/marshall/marshall.alt.c) (source code) demonstrates the problem so
you can see if your compiler has the problem as described below.

In some versions of `gcc` and `clang` (this was first discovered in fedora linux 38)
if the compiler was enabled one compiler would generate code that segfaulted but
the other one would not. However, when then disabling the optimiser the compiler
that had no problem suddenly did and the one that did suddenly did not. But
segfaulting was not by any means the only problem.

Another problem was that depending on the optimiser an infinite loop would be
entered. But then removing it would cause other problems as well, including a
segfault.

It was not only one compiler that dumped core. Both dumped core with other
behaviour, depending on what changes in code were made and the optimiser being
on or off. `Clang` in macOS also dumped core!

The [marshall.c](%%REPO_URL%%/1986/marshall/marshall.c) has the original fix
for `clang` which works with some compilers depending on the optimiser. When we
refer to the code below we refer to the alternate code,
[marshall.alt.c](%%REPO_URL%%/1986/marshall/marshall.alt.c).

## The conflicting compiler problems:

Below we describe the conflicting options that resulted in the need to modify
the original code.

### Linux

With the optimiser disabled `GCC` compiled the code to enter an infinite loop.
If the optimiser was enabled it worked fine. But if the optimiser is enabled
`clang` generates code that first prints the text twice (it should print it once) and
then immediately dumps core!

But then there's that infinite loop. What happens if we remove it?

Once the loop is removed if we compile with `clang` and the optimiser is disabled
all is okay. If however we compile with `gcc` and the optimiser is disabled the
string is printed once and then the program dumps core! Why is this? It is
because of the call to `_exit()` (see below).

`Clang` works fine with the loop removed and the optimiser disabled. If however we
enable the optimiser `clang` will generate code that prints the string twice and
dumps core just like before!  What about the call to `_exit()`?

The call was:


``` <!---c-->
    _exit(argv[(int)*argc-2/cc[1*(int)*argc]|-1<<4]);
```

Changing it to not refer to these variables and just exit 1 and the problems
disappear!

### macOS

But then there was macOS which had another problem!

If the infinite loop is not removed/commented out and the optimiser is enabled
it works fine but if it's disabled it prints out the string and then enters an
infinite loop!

After we fix the infinite loop if we change the `_exit()` call in macOS and
disable the optimiser we might get something like:

``` <!---sh-->
    $ ./marshall
	  choo choo
    Segmentation fault: 11
```

Observe how it doesn't print it twice. But of course it segfaults so it's not
right either.

If the optimiser is enabled, however, we will see that it works fine before the
change to `_exit()`.

## Summary

And that is the tale of a little <del>engine</del> train that
could...eventually! Or perhaps it's the compilers, optimisers and OSes that
eventually could?

Whichever you wish it to be, it now works with both `clang` and `cc`. Choo choo!


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
