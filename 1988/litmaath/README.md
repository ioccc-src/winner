# Best small program

Maarten Litmaath  
The Netherlands  

## To build:

```sh
make
```

## To run:

```sh
./litmaath some text
```

There is an alternate version provided. See the Alternate code section below.

## Try:

```sh
./litmaath eschew obfuscation
```

### Alternate code:

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) added the
[litmaath.alt.c](litmaath.alt.c) which we described in our remarks below. To
use:

```sh
make alt
```

Use `litmaath.alt` as you would `litmaath` above.

Thank you Cody!


## Judges' remarks:

Note the unusual structure:


```c
while (<condition>)
	 ;
```

Did you notice that the body is empty?


The best one can do to understand how the program works is to give it
two small strings as arguments, and follow the program closely.  One
could make the body of the 'while' loop an 'fprintf' with interesting
variables like:


```c
fprintf(stderr,
     "argv=%lo *argv=%lo **argv=%c argv[1]=%lo *argv[1]=%c argc=%d\n",
     (long) argv, (long) *argv, *argv && **argv ? **argv : '@',
     (long) argv[1], argv[1] && *argv[1] ? *argv[1] : '@', argc);
```


Furthermore, it's interesting to note that only two variables are
used to achieve everything.

## Author's remarks:

No remarks were provided by the author.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
