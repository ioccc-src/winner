## Best abuse of system calls

Paul Dale
University of Queensland
Computer Science Dept
Dept of Computer Science
Uni of Qld, 4067
Australia

## To build:

```sh
make all
```

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this for modern
compilers. There were two problems to address. One was that the entry required
`-traditional-cpp` which it no longer does. It needed this because of two things
it did:

```c
#define a(x)get/***/x/***/id())

p Z=chroot("/");L(!a(u)execv((q(v="/ipu6ljov"),v),C);Z-=kill(l);

...

case_2:L(!--V){O/*/*/c*c+c);wait(A+c*c-c);L(!Z)f(A,"\n",c);return(A*getgid());};C++;
```

does not work to create `getuid()` and `getgid()`. The second is that

    for/*/(;;);/*/k()){O/*/*/c);

cannot form 'fork())' in modern C compilers. What is quite fun is that the cpp
can!

The other problem was that modern compilers do not allow directives like:

```c
#define _ define
+#_ P char
+#_ p int
+#_ O close(
...
```

so Cody changed the lines to be in the form of:

```c
#define foo bar
```

Thank you Cody for your assistance!


## Try:


	./dale hello world
	./dale these files are in this directory: *

NOTE: in linux it might happen that core dumps are created when running this
entry even though it works fine.

## Judges' remarks

This entry has a very twisted flow of control via recursion, iteration 
and multi-processing.  Try to understand what is being done with the
system calls.

NOTE: This program assumes the ASCII character set is being used.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
