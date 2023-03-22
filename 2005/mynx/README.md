# Best use of the www

    Anthony Howe
    Snert
    42 av. Isola Bella
    06400 Cannes,
    France
    achowe@snert.com

# To build:

```sh
make
```

### To run:

```sh
./prog
```

### Try:

```sh
./mynx http://www.ioccc.org/
```

## Judges' comments

This little mynx will give any Fiery Fox a run for its money. A nice complement
to last years winning hibachi. The judges double dare any eager
Obfuscationalists to submit the missing pieces to get a functioning LAMP stack.

## Author's comments:

I was rather impressed by last year's mini web server. So much so that
it inspired me to try my hand at writing the client side complement.

A typical build would be command would be:

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
./configure
make
```

After which, the rest of the documentation can be read by saying:

```sh
./mynx manual.html
```

Manifest:

        mynx.c
        makefile                pre-built generic Un*x
        README.TXT
        manual.html
        makefile.in             makefile template
        entities.txt            ISO 8859-1 entites
        configure.in            configure script description
        configure               pre-built configure script
