# Most Useful Obfuscation

Larry Wall  
Unisys - System Development Group Santa Monica  
9132 Kester Ave  
Panorama City, CA  91402  USA  

## To build:

```sh
make all
```


## To run:

```sh
./wall
# enter some strings

./wall | some_command
# enter some strings
```

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) made this safer by
using `fgets()` instead of `gets()`. This prevents a potentially alarming
warning at linking or runtime.


## Try:

	./wall | bc | ./wall

and input the following:

	x*x
	c^2
	m*m

	# can you figure out what this does?
	500

### Also try:

	./wall | bc

	./wall | cat


and enter some input like:

	x*x
	2^x
	quit # for the cat version


## Judges' comments:


What we found amazing was how the flow of control was transferred
between subroutines.  Careful inspection will show that the array of
pointers to functions named 'vi' refers to functions which seem to not
be directly called.  Even so, these pointers to functions are being
used as an argument to signal.  Can you determine why this is being
done and how it is being exploited?

Some compilers complained about this file, so we changed: '=++I' to '= ++I'.


## Author's comments:

No comments were provided by the author.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
