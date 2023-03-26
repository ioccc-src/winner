# Most likely to top the charts

    Qiming HOU  

# To build:

```sh
make
```

### To run:

```sh
./prog < input.json > output.html
```

View `output.html` in a browser.

### Try:

```sh
grep -e '[-?+*/^&|.<>=]' prog.c

(cd ..; ls -lS */prog.c) | \
awk 'BEGIN { print "["; } { print "{\"winner\":\"",$9,"\", \"size\":",$5,"},"} END { print "]"}' \
> ioccc.json
./prog < ioccc.json > ioccc.html
```

View `output.html` in a browser.

What's not right with the output?  How can one fix it?

## Judges' comments:

This entry exhibits a way of obfuscation we haven't seen before, we think.
The rulez of programming in an imperative language are violated, aren't they?

Try figuring out how to increase the number of different colors, if you can.

## Author's comments:

Nowadays almost every programmer needs to do some Web chore. With all the open source stuff readily available, often we just need to call a bunch of libraries to generate an HTML page from a JSON feed.

This entry takes such decadence to an extreme. It just calls a bunch of libraries to generate an HTML page from a JSON feed, literally. There is no variable (function parameters included), no operator, no flow control statements except a few decorative returns. In compliance to production coding standards, the code is littered with fashionable jargon, doxygen comment, and license text.

As one would expect from such an approach, this program is much more resource intensive than it should be. And one needs a C99-compatible libc (with the common UNIX stuff) to build this and an HTML5-compatible browser to open the result. And it terminates with an assertion failure, but who cares if the web page is already generated?

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
