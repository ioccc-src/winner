# Best of Show

Adrian Mariano  
University of Washington  
2729 72nd Ave SE  
Mercer Island, WA 98040  
US  


## To build:

```sh
make all
```


## To run:

```sh
./theorem expression x1 x2 h y1
```

where:

```
expression - function f(x,y)  (see below)
x1 - start of interval
x2 - end of interval
h - step size
y1 - initial value  (y(x1) == y1)
```

## Try:

```sh
./theorem y 0 1 0.1 1
```

### INABIAF - it's not a bug it's a feature! :-)

If the two args passed to `fibonacci` and `theorem_bkp` equals 0 it will
print 0 over and over again in an infinite loop. In this case it should not be
fixed (another condition where this occurred was fixed as it affected usability
of the program).

BTW: why can't the fix:

```c
if (a[1]==NULL||a[2]==NULL||a[3]==NULL||a[4]==NULL||a[5]==NULL) return 1;
```

be changed to just test the value of `A` when `a` is argv and `A` is argc?


## Judges' remarks:

The program's source implements four functions, all from the
same source file!

When you compile theorem.c as is and run with 5 args, it numerically solves the
equation `y'=f(x,y)`, with a step size of `h` (see above usage), over the
interval `x=[x1,x2]`, with the initial condition of `y(x1)=y1`.

The 'expression' `f(x,y)` is any function of `x` and `y` with the
operators:

```
+	-	*	/	^
```

The symbol `^` is the power operator.  Note that it only supports
integer powers.  Also note that all expressions are evaluated strictly 
left to right.  (i.e., parenthesis aren't supported).

Try running the program with the following args:

```sh
./theorem y 0 1 0.1 1
./theorem 1/x 1 2 0.1 0
./theorem 'x^2/y+x' 0 1 0.1 6
```

But wait, there is more!  You also get, free of charge, a 
reversing filter!  Try:

```sh
./theorem -r 0 0 0 0 < theorem.c > sorter.c
```

Still not impressed?  The author throws in for free, a 
sort program! Try:

```sh
make sorter
ls | ./sorter
```

This program is safe for home use as well.  The author has
included a safety feature in case you misplace the original
program source:

```sh
./sorter -r 0 0 0 0 < sorter.c > theorem_bkp.c
```

And finally, as a special offer to users of this entry,
the author provides a Fibonacci sequence generator!  Try:

```sh
./sorter 0 0 0 0 < theorem.c > fibonacci.c
make fibonacci
./fibonacci 1 1
./fibonacci 2 1
```

Program available on 9 track and cartridge cassette.  Neither [Ginsu
knife](https://ginsu.com) nor [Swiss army
knife](https://en.wikipedia.org/wiki/Swiss_Army_knife) included! :-)

When this program was first shown at the 1990 Summer Usenix conference, it
received a standing ovation; a first for a contest entry.


## Author's remarks:

Differential equations are solved via the Runge-Kutta method, which guarantees
local error proportional to `h^5`, and total error across a finite interval is at
most a constant times `h^4`.

Sorting is accomplished with a standard shell sort.

Note that the sorting and reversing is limited to files with fewer than 500
lines, each less than 99 characters long.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
