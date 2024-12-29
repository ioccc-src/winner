In order to successfully compile this you will need a C compiler that supports
C99+ and ncurses; note that for some platforms (e.g. Red Hat based Linux) you
will need two different packages: the library itself but also the dev package
that has the header files etc. If you use the Makefile obviously you need `make`
too.

In [gameplay.html](gameplay.html)
I show how to easily customise the colours, set up
different gameplay modes and various other things. The troubleshooting.md
and terminals.md as well as bugs.md include a variety of information
should you run into trouble.

--

# Portability

I have tested this under macOS Catalina, macOS Ventura (and probably between the
two), Fedora (29 and also 31 - no that's not a typo, I upgraded from 29 to 31 as
I had delayed upgrading to 30 due to a number of issues and being busy) and
CentOS 7.7.1908. It should work under any modern linux system and maybe other
Unices as well as macOS (as noted).

It obviously requires ncurses but other than that nothing extra should be
needed. Note that the testing of Fedora 29 was earlier in the development
however (but then 29 is also EOL).

Furthermore I do not believe - but I cannot confirm either - that endianness
matters; I only have Intel CPUs and arm64 (MacBook Pro M1).

I imagine that it works for 32-bit systems but I do not know for sure.


# Portability: macOS

You should be able to get the compiler with:

``` <!---sh-->
    sudo xcode-select --install
```

You don't need Xcode itself and it appears that the command line tools (as above
should install) already has ncurses so there shouldn't be anything else that
needs to be done. But I'm not actually sure of this - I'm seeing conflicting
information and it's been too long; anyway there's always [MacPorts][] and also
Homebrew which should be sufficient; I do *NOT* recommend Homebrew however:
it takes ownership of /usr/local: as in the user you run it as is the new owner
so that you don't need sudo because ... Well never mind.


# Portability: Fedora

You'll need the packages `gcc`, `ncurses` and `ncurses-devel` (plus `make` if
you want to use the Makefile) to compile and link this entry. With Fedora more
recent versions there's the `dnf` package manager but I cannot help with any of
the GUI installers since I don't use them. Something like:

``` <!---sh-->
    sudo dnf install ncurses-devel ncurses make gcc
```

or

``` <!---sh-->
    # dnf install ncurses-devel ncurses make gcc
```

# Portability: CentOS

Just like Fedora you will need `gcc`, `ncurses`, `ncurses-devel` (and if you
want to use the Makefile `make`). CentOS uses `yum` and CentOS 8 uses `dnf`.
So:

``` <!---sh-->
    sudo yum install ncurses-devel ncurses make gcc
```

or

``` <!---sh-->
    # yum install ncurses-devel ncurses make gcc
```

or

``` <!---sh-->
    sudo dnf install ncurses-devel ncurses make gcc
```

or

``` <!---sh-->
    # dnf install ncurses-devel ncurses make gcc
```

You can also use clang to compile (which is what gcc actually is under macOS).


# Compilation notes

As long as you have the dependencies above the only thing that comes to mind is
integer width problems.

If `size_t` does not equate to unsigned long: In this case if say it's an
unsigned long long then theoretically you should be able to change the
`strtoul()` to be `strtoull()` (after updating the typedef for unsigned long to
be unsigned long long maybe?). It appears to work from a quick test at least.

If it's an unsigned int I believe you will have to opt for an unsigned long (so
`strtoul()` cast to an unsigned int).

Anything else I do not know other than just changing the typedef and updating to
the proper function (and/or cast to the right type).


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
