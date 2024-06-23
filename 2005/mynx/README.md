## To build:

``` <!---sh-->
    make
```

There is an alternate version that scans for (_ONLY_ scans) the string `https`
as a starting point in case anyone wishes to add support or come up with a
pipeline to let it work, as many websites no longer work with `http`.
See [alternate code](#alternate-code) below.


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [2005/mynx in bugs.html](../../bugs.html#2005_mynx).


## To use:

``` <!---sh-->
    ./mynx http://<domain>
```

You can specify a port by appending to the domain `:port`. See notes below on
the issue of https.


## Try:

``` <!---sh-->
    ./mynx http://www.textfiles.com

    ./mynx manual.html
```


## Alternate code:

Obviously this will not work with `https` as it only scans for `http` in the URL
(if not specified it tries to open it as a local file). But even if it scanned
for `https` one would need to do more work as it would have to set up a secure
connection before http commands could be sent.  Fortunately or unfortunately
many more websites use https so this entry will not work as well as it  used to.
If one were to try and connect to <https://ioccc.org> with this entry they'll
just get a 301 error.

The alternate code is a starting point that scans for `https` too (note you have
to specify the port in this case) but that is all it does. It will not work with
https websites as it does not set up a secure connection. But should anyone wish
to either come up with a pipeline (or some other command line) that allows it to
work with https or to update the code to support https they may. Otherwise you
must just appreciate the entry for what it once was.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `mynx.alt` as you would `mynx`. You'd have to specify a port at the end of
the URL like:

``` <!---sh-->
    ./mynx.alt https://www.ioccc.org:443
```

but again unless you have a clever workaround or hack to the problem, this sadly
won't work.


## Judges' remarks:

This little `mynx` will give any [Fiery
Fox](https://en.wikipedia.org/wiki/Firefox) a run for its money. A nice
complement to last years winning [2004/hibachi](../../2004/hibachi/index.html). The
judges double dare any eager Obfuscationalists to submit the missing pieces to
get a functioning LAMP stack.


## Author's remarks:

I was rather impressed by last year's mini webserver. So much so that
it inspired me to try my hand at writing the client side complement.

A typical build command would be:

``` <!---sh-->
    cc -o mynx mynx.c
```

While some others like to be a little different:

``` <!---sh-->
    cc -o mynx mynx.c -lnsl -lsocket
```

I even managed to figure out a basic configure script, given last year's
example, which is kinda of useful when you consider how many OSes put
all the network functions in a variety of places. So a simpler build
command sequence would be:

``` <!---sh-->
    cd source ; ./configure ; make
```

After which, the rest of the documentation can be read by saying:

``` <!---sh-->
    ./mynx ../manual.html
```


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
