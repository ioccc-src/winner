## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./garry <input_file >output_file
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

While it may not have been the intention of the author, the
judges noted that the C pre-processed version (with the `#include`s
left intact) looked very much like a rat "dropping core".  See
[garry.alt.c](%%REPO_URL%%/1995/garry/garry.alt.c) and judge for yourself!


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./garry.alt <input_file >output_file
```


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

The author was kind enough to provide a less obfuscated version of
the source called [garry.fmt.c](%%REPO_URL%%/1995/garry/garry.fmt.c).


## Author's remarks:

This program is a file filter, designed to do environment-expansion and
incorporating the ability to create binary from escaped data in the
environment variables.

The calling syntax is pretty simple, just use it with `stdio`-redirection
or inside pipelines, e.g.:

``` <!---sh-->
    ./garry <file_to_convert >converted_file
```

or

``` <!---sh-->
    cat all_my_files/* | ./garry | lp
```

The syntax of the conversion of the input file is as follows: To include the
value of an environment variable in the output file, place the name of the
variable between `$`-signs in the input, e.g.:

```
    My Home-Directory is: $HOME$
    I'm using the path: $PATH$
```

Unknown Env-variables or malformed expressions are ignored and kept intact.

Additionally, the filter replaces escaped octal values in the environment
variables by their binary representation, e.g.:

``` <!---sh-->
    $ TEST="\110\145\154\154\157"
    $ export TEST
    $ echo '$TEST$' | ./garry
    Hello
```


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
