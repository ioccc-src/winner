# Most Useful Obfuscation

Larry Wall\
US

## To build:

```sh
make all
```


## To run:

```sh
./wall
# enter some numbers

./wall | some_command
# enter some strings or numbers, depending on command
```


## Try:

```sh
./wall | bc | ./wall
```

and input the following:

```
x*x
c^2
m*m

# can you figure out what this does?
500

```

### Also try:

```sh
./wall | bc

./wall | cat
```

and enter some input like:

```
x*x
2^x
quit # for the cat version
```


## Judges' remarks:


What we found amazing was how the flow of control was transferred between
subroutines.  Careful inspection will show that the array of pointers to
functions named `vi` refers to functions which seem to not be directly called.
Even so, these pointers to functions are being used as an argument to
`signal(3)` (used both with and without an arg - but how?).  Can you determine
why this is being done and how it is being exploited?

Some compilers complained about this file, so we changed: `=++I` to `= ++I`.


## Author's remarks:

No remarks were provided by the author.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
