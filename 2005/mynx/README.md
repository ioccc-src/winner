## To build:

```sh
make
```


### Bugs and (Mis)features:

The current status of this entry is:

```
STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [2005 mynx in bugs.md](/bugs.md#2005-mynx).


## To use:

```sh
./mynx http://<domain>
```

You can specify a port by appending to the domain `:port`. See notes below on
the issue of https.


### Try:

```sh
./mynx http://www.textfiles.com
```


Some have pointed out that this will not work for https initially
for two reasons. For a starting point see the alternate code section below.


## Alternate code:

As noted this will not work for https. This is because it does not scan for
https but also a secure connection needs to be set up before http commands can
be sent. One would also have to specify a port in the URL. Fortunately or
unfortunately many more websites use https nowadays so this entry will not work
as well as it used to.  If one were to try and connect to `https://www.ioccc.org`
with this entry they'll just get a 301 error.

In case someone can come up with a clever pipeline or some other hack or
workaround (perhaps [stunnel](https://www.stunnel.org)),

To compile:


```sh
make alt
```

Use `mynx.alt` as you would `mynx`. You'd have to specify a port at the end of
the URL like:

```sh
./mynx.alt https://www.ioccc.org:443
```

but again unless you have a clever workaround or hack to the problem, this sadly
won't work.


## Judges' remarks:

This little `mynx` will give any [Fiery
Fox](https://en.wikipedia.org/wiki/Firefox) a run for its money. A nice
complement to last years winning [hibachi](/2004/hibachi/src/hibachi.c). The
judges double dare any eager Obfuscationalists to submit the missing pieces to
get a functioning LAMP stack.


## Author's remarks:

I was rather impressed by last year's mini webserver. So much so that
it inspired me to try my hand at writing the client side complement.

A typical build command would be:

```sh
cc -omynx mynx.c
```

While some others like to be a little different:

```sh
cc -omynx mynx.c -lnsl -lsocket
```

I even managed to figure out a basic configure script, given last year's
example, which is kinda of useful when you consider how many OSes put
all the network functions in a variety of places. So a simpler build
command sequence would be:

```sh
cd source ; ./configure ; make
```

After which, the rest of the documentation can be read by saying:

```sh
./mynx ../manual.html
```

Manifest:

```
    mynx.c
    makefile                pre-built generic Unix
    README.TXT
    manual.html
    makefile.in             makefile template
    entities.txt            ISO 8859-1 entites
    configure.in            configure script description
    configure               pre-built configure script
```


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
