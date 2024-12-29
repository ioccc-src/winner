# Conflicting compilers and optimisers that broke this entry in 2023

As briefly noted in the [index.html](index.html) `gcc` versus `clang` caused
different problems with this entry, depending on the optimiser being enabled or
disabled, where if the optimiser was enabled it would work with one compiler but
not the other; on the other hand, if you disabled the optimiser the opposite
problem would occur: the working compiler would no longer work and the other one
would! And then there's the problem of linux versus macOS causing problems.

Using the [alternate source code](%%REPO_URL%%/1986/marshall/marshall.alt.c)
demonstrates the problem so you can see if your compiler has the problem
described below.

In some versions of `gcc` and `clang` (this was first discovered in fedora linux 38)
if the optimiser was enabled one compiler would generate code that segfaulted but
the other one did not. However, when disabling the optimiser, the compiler
that had no problem suddenly _did_ and the one that did suddenly _did not_. But
segfaulting was not by any means the only problem.

Another problem was that depending on the optimiser an infinite loop would be
entered. But then removing it would cause other problems as well, including a
segfault!

It was not only one compiler that dumped core. Both dumped core with other
behaviour, depending on what changes in code were made, and the optimiser being
on or off. `clang` in macOS also dumped core!

The [marshall.c](%%REPO_URL%%/1986/marshall/marshall.c) has the original fix
for `clang`, which works with some compilers, depending on the optimiser. Below
we refer to the [alternate code
marshall.alt.c](%%REPO_URL%%/1986/marshall/marshall.alt.c).


## The conflicting compiler problems:

Below we describe the conflicting options that resulted in the need to modify
the original code.

### Linux

With the optimiser disabled `gcc` compiled the code to enter an infinite loop.
If the optimiser was enabled it worked fine, but if the optimiser is enabled
`clang` generates code that first prints the text twice (when it should print it
only once) and then immediately dumps core!

But then there's that infinite loop. What happens if we fix it?

Once the loop is removed, if we compile with `clang` and the optimiser is disabled
all is okay. If however we compile with `gcc` and the optimiser is disabled the
string is printed once and then the program dumps core! Why is this? It is
because of the call to the `_exit(2)` syscall (see below).

`clang` works fine with the loop removed if the optimiser is disabled. Once we
enable it, though, it will generate code that prints the string twice and
dumps core, just like before!


<div id="exit">
### What about the call to the `_exit(2)` syscall?
</div>

The call _was_:


``` <!---c-->
    _exit(argv[(int)*argc-2/cc[1*(int)*argc]|-1<<4]);
```

In the fixed code, these variables are simply commented out so the code does
`_exit(1)`.


### macOS

Now as for macOS, _another problem_ existed!

If the code that resulted in an infinite loop is _NOT_ commented out _AND_ the
optimiser is enabled it works fine; but if it [the optimiser] is disabled, it
prints out the string and then enters that infinite loop!

After we fix the infinite loop issue, if we change the call to the `_exit(2)`
syscall in macOS and disable the optimiser we might get something like:

``` <!---sh-->
    $ ./marshall
          choo choo
    Segmentation fault: 11
```

Observe how it doesn't print it twice. But of course it segfaults so it's not
right either.

If the optimiser is enabled, however, we will see that it works fine before the
change to the call to the `_exit(2)` syscall.


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
