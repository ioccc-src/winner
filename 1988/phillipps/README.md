## Least likely to compile successfully

Ian Phillipps  
Cambridge Consultants Ltd  
Science Park  
Milton Road  
Cambridge CB4 4DW  
England  


## To build:

```sh
make all
```


[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this for modern
systems. It did not compile with clang because it requires the second and third
args to main() to be `char **` but even before that with gcc it printed random
characters. After fixing it for clang by changing main() to call the new
function pain() (chosen because it's a paint that clang requires these args to
be `char **` :-) ) with the correct args it now works. Thank you Cody for your
assistance!


## Judges' remarks:

Compile and run without parameters.

The program is smaller than even the 'compressed' form of its output,
and thus represents a new departure in text compression standards.

The judges thought that this program looked like what you would get
by pounding on the keys of an old typewriter at random.

## Author's remarks:

No remarks were provided by the author.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
