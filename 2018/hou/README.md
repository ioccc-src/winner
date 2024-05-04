## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [2018/hou in bugs.html](../../bugs.html#2018_hou).


## To use:

``` <!---sh-->
    ./prog < input.json > output.html
```

View `output.html` in a browser.


## Try:

``` <!---sh-->
    ./try.sh
```

The script will generate a JSON file called `ioccc.json`, showing it via
`tee(1)` and then run the program on that. Can you find any problem with the
JSON file? What happens if you try and fix it?

As the script says, open `ioccc.html` in a browser.

Is anything wrong with the output? How can you fix it if so?


## Judges' remarks:

This entry exhibits a way of obfuscation we haven't seen before, we think.
The `rulez` of programming in an imperative language are violated, aren't they?

Try figuring out how to increase the number of different colors, if you can.


## Author's remarks:

Nowadays almost every programmer needs to do some Web chore. With all the open
source stuff readily available, often we just need to call a bunch of libraries
to generate an HTML page from a JSON feed.

This entry takes such decadence to an extreme. It just calls a bunch of
libraries to generate an HTML page from a JSON feed, literally. There is no
variable (function parameters included), no operator, no flow control statements
except a few decorative `return`s. In compliance to production coding standards,
the code is littered with fashionable jargon, doxygen comment, and license text.

As one would expect from such an approach, this program is much more resource
intensive than it should be. And one needs a C99-compatible libc (with the
common UNIX stuff) to build this and an HTML5-compatible browser to open the
result. And it terminates with an assertion failure, but who cares if the web
page is already generated?

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
