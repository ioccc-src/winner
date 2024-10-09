## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./jar.2
    [enter some lisp]

    ./jar.2 < some_lisp_file
```

**NOTE**: this entry will likely segfault on invalid input.


## Try:

``` <!---sh-->
    ./try.sh

    ./try.sh chocolate_cake.lisp

    ./try.sh try.lisp
```


## Judges' remarks:

This is the most useful program submitted this year. It is a
rather large subset of
[lisp](https://en.wikipedia.org/wiki/Lisp_&lpar;programming_language&rpar;).
It has no error recovery, and performs rather poorly in a number of cases.  Even
so, placing all this functionality in such a small, densely packed program, is
impressive enough to win the `Best of Show` award.


## Author's remarks:

This program implements a Lisp interpreter in 1465 bytes of source.
Some sophisticated features supported, e.g. functionals and recursion.
The special-forms/functions/variables implemented are:

- \+
- \-
- \*
- \<
- ()
- car
- cdr
- cons
- defun
- equal
- function
- if
- lambda
- quote
- t

Below are sample lisp expressions you might choose to try as input.
The program implements a conventional lisp listener, i.e. you type in
lisp expressions (followed by CR), the program evaluates them and
prints out the return values. End execution by typing an end-of-file
character.

``` <!---lisp-->
    (+ 2.5 3.1)
    (defun fib (n)
       (if (< n 2)
           1
           (+ (fib (- n 2)) (fib (- n 1)))))
    (fib 10)
    (defun ! (x) (if (equal x 0) 1 (* x (! (- x 1)))))
    (! 7)
    (defun fn1 (fn) (+ (fn 1 2) (fn 3 4)))
    (defun fn2 (a b) (+ a b))
    (fn1 (function +))
    (fn1 (function fn2))
    (fn1 (function (lambda (z1 z2) (+ z1 z2))))
    (quote a)
    (cons (quote (a b)) (quote (c d e)))
    (cons (quote (f)) ())
    (car (quote (a b c)))
    (cdr (cdr (quote (g h i))))
```


Please do not leave any whitespace before the first parenthesis when
you type your input, or any other unnecessary whitespace. Please try to
avoid any undefined variables or functions, wrong number of arguments
etc. All these errors are likely to dump core (i.e. there are no error
checks in the program).

Traditional Lisp implementations use cons cells as the main data
structure. Lists are organized of pointer chains of these cells.
In this program, an alternate representation was chosen: `char*'`s.
All list operations, including the ones in the interpreter, are
made using string representations of the lists. These operations
must count parentheses and skip whitespace. This leads to extremely
poor performance!


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
