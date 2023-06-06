# Best Output

Thor AAge Eldby  
European Technology Partner  
Roedtvetvn 20                (Home address)  
0955 Oslo  
Norway  


## To build:

```sh
make all
```


## To run:

```sh
./eldby 
```

WARNING: on modern systems this is very fast and could be a problem for those
susceptible to photosensitivity. Please try this one with caution if this
applies to you! The same goes for people who can be overstimulated. See below
for alternate version if you want to see it go slower or if seeing things move
by too fast is a problem for you.

NOTE: to reset the sanity of your terminal after this program ends try `reset`.


### Alternate code:

The default sleep duration is `35000` but you can change it at compilation like:

```sh
make CFLAGS+="-DZ=20000" clobber alt
```

Use `eldby.alt` as you would `eldby`.


## Judges' remarks:

We were impressed by the author's ability to render spheres in 3D 
in a very small chunk of code.


## Author's remarks:

This program shows flying spheres. The program eats CPU on lesser
equipped systems. The program will run until termination. Terminal 
must be vt100 or better with 80 columns and 24 rows or more.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
