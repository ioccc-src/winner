## To build:

```sh
make all
```


### Bugs and (Mis)features:

The current status of this entry is:

```
STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [1994 ldb in bugs.md](/bugs.md#1994-ldb).


## To use:

```sh
./ldb < file

some_command | ./ldb
```


### Try:

```sh
./ldb < /etc/passwd

printf "The International Obfuscated C Code Contest\n
	Best One-liner\n
	by Laurion Burchall" | ./ldb
```


## Judges' remarks:

Trigraphs are natural obfuscators.  Most C-beautifiers become C-uglifiers
because they don't handle them correctly.

Can you figure out how it prints a given random line (or if the line is longer
than 231 characters, part of that line) from stdin?


## Author's remarks:

All input lines must be under 232 characters long.  The compiling
platform should be ASCII based.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
