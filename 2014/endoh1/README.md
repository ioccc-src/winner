## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./prog > foo.c
```


## Try:

``` <!---sh-->
    ./try.sh
```

The script will ask you if you wish to run `make rake` but this is not necessary
to fully enjoy the entry. `make rake` will run the [rake.sh](%%REPO_URL%%/2014/endoh1/rake.sh) script and
then `prog` if all is built okay. If `rake` is not installed then it will check
that `gem` is installed. If `gem` is not installed it will tell you where to get
it and then tell you how to install `rake`. Otherwise, if `rake` is installed it
will try running `rake ` and if that fails to run it will tell you to run a
`gem` command as either root or via sudo and then to try running `make rake` or
`./rake.sh` again. If `rake` succeeds it will run `./prog` which can be used to
build `main.c`.

What is the difference between running `./prog` and `main`?


## Judges' remarks:

Big terminals with tiny fonts have their uses in certain cases.
One of them is:

``` <!---sh-->
    make treacl
    ./treacl
```

which is shorthand for:

``` <!---sh-->
    ./prog < prog.c > treacle.c
    make treacle
    ./treacle
```


When using a smartphone to read the output, you may need to
step back to see the bigger picture because that picture is worth
more than 1000 words.


## Author's remarks:

### Remarks

You may want to use a large display with a very small terminal font.


### Deobfuscation

See [deobfuscation.html](deobfuscation.html).


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
