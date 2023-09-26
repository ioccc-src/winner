# Best layout

Eric Marshall   

## To build:

```sh
make all
```

There is an alternate version. See the Alternate code section for the commentary
on why this is: there was a funny problem in modern systems where depending on
the compiler and flags it would work with one compiler with the optimiser but it
would not work with the other; and if the optimiser state is changed the
previous problematic compiler might work but the other one would not! We
describe this in more detail below and we encourage you to read it.


## Try:

```sh
./marshall
```

### Alternate code:

As some changes had to be made due to the problem of conflicting compiler
options briefly noted above we provide the code that demonstrates the problem so
you can see if your compiler has the problem as described below.

In some versions of gcc and clang (this was first discovered in fedora linux 38)
depending on whether or not the optimiser was enabled would cause one compiler
to generate code that segfaults but not another - but when changing the state
of the optimiser the opposite would happen: the compiler that did not cause a
segfault suddenly did and the one that did now worked! Another problem was an
infinite loop also depending on the optimiser.

The alternate code has the original fix for clang which works with some
compilers depending on the optimiser. When we refer to the code below we refer
to the alternate code.

### The conflicting compiler problems:

Below we describe the conflicting options that resulted in the need to modify
the original code.

#### Linux

With the optimiser disabled GCC compiled the code to enter an infinite loop.
Enabling the optimiser and it worked fine. But if the optimiser is enabled clang
generates code that first prints the text twice (it should print it once) and
then immediately dumps core!

But then what happens if we remove the infinite loop?

Once the loop is fixed if we compile with clang and the optimiser is disabled
all is okay. If however we compile with gcc and the optimiser is disabled the
string is printed once and the program then dumps core! Why is this? It is
because of the call to `_exit()` (see below). Clang works fine with the loop
removed and the optimiser disabled. If however we enable the optimiser clang
generates code that prints the string twice and dumps core just like before!
What about the call to `_exit()`?

The call was:


```c
_exit(argv[(int)*argc-2/cc[1*(int)*argc]|-1<<4]);
```

Changing it to not refer to these variables and just exit 1 and the problems
disappear!

#### macOS

But as noted just because it works one way in linux does not mean it works the
same way in macOS!

If the infinite loop is not removed/commented out and the optimiser is enabled
it works fine but if it's disabled it prints out the string and then enters an
infinite loop.

After we fix the infinite loop if we change the `_exit()` call in macOS and
disable the optimiser we might get something like:

```sh
$ ./marshall
      choo choo
Segmentation fault: 11
```

Observe how it doesn't print it twice.

If the optimiser is enabled, however, we will see that it works fine before the
change to `_exit()`.


#### To use:

Due to the different conflicting problems we instead offer the problematic code
as an alternate version whereas [marshall.c](marshall.c) has both the infinite
loop and the complicated arg to `_exit()` commented out, replaced by just `1`.

To try out the alternate version:

```sh
make alt
```

Use `marshall.alt` as you would `marshall` above.


## Judges' remarks:

This program prints the name of the picture.  The layout is somewhat
pretty though it is not the usual sort of output one would expect
from printing a program!

This program was selected for the 1987 t-shirt collection.



## Author's remarks:

No remarks were provided by the author.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
