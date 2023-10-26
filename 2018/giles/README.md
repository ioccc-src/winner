# Most unstable

    Edward Giles

## To build:

This entry requires SDL2 to be installed.

```sh
make
```

### To install SDL and SDL2:

#### macOS users (Homebrew)

If you have not already done so, install [Homebrew](https://brew.sh).

Then to install SDL and SDL2, execute the following command:

```sh
brew install sdl2 sdl12-compat
eval "$(/opt/homebrew/bin/brew shellenv)"
```

#### macOS users (MacPorts)

Install [MacPorts](https://www.macports.org/install.php).

Then to install SDL and SDL2:

```sh
sudo port install libsdl libsdl2
```

#### Red Hat Linux users:

To install SDL and SDL2, execute the following command as root:

```sh
dnf install SDL2 SDL2-devel sdl12-compat sdl12-compat-devel
```

It was once possibly necessary to use `make` like:

```sh
make ... SDL2_INCLUDE_ROOT=/usr
```

or set the following environment variable:

```sh
export SDL2_INCLUDE_ROOT=/usr
```

but this is most likely unneeded as we use `sdl-config` and `sdl2-config` in the
Makefiles.

#### Debian users

To install SDL and SDL2, execute the following command as root:

```sh
apt install libsdl1.2debian libsdl1.2-dev libsdl2-dev
```

It was once possibly necessary to use `make` like:

```sh
make ... SDL2_INCLUDE_ROOT=/usr
```

or set the following environment variable:

```sh
export SDL2_INCLUDE_ROOT=/usr
```

but this is most likely unneeded as we use `sdl-config` and `sdl2-config` in the
Makefiles.

See also the judges' remarks below.


## To use:

```sh
./prog
```

## Try:

```sh
./prog ioccc.txt
./prog prog.c
./prog sand.txt
./prog sand.alt.txt
```

## Judges' remarks:

Can you explain the behavior of the program when ioccc.txt is given to it as input?

How would the description of the state machine look like when translated from
Polynomish to English?

You may have to install libsdl2-dev on your system to compile and use this code:

```sh
sudo dnf install SDL2 SDL2-devel # Linux
sudo apt install libsdl2-dev 	 # Debian
brew install sdl2		 # macOS via Homebrew
sudo port install libsdl2	 # macOS via MacPorts
```

## Author's remarks:

### Remarks

This entry graphically displays a simulation of sand falling.
It uses SDL to draw the interface.

The code makes the following assumptions about the underlying system:

* SDL2 is installed from [https://libsdl.org](https://libsdl.org).
* `double` is an IEEE 754 floating-point type and `sizeof(double)==8`.
* The compiler supports the C99 standard.

In order to simulate the motion of the sand, a cellular automaton is used. The
state transition table is not stored directly. Instead, the program stores the
coefficients of a polynomial that map each state to the correct one. These
coefficients are stored as raw hexadecimal in the `V[]` array, and they are
reinterpreted as doubles when used. This allows more numeric precision in fewer
characters (base 16 > base 10), and makes the purpose of the array less clear.

The code is laid out graphically as a bucket pouring sand, and it is far easier
to observe this high-level layout than the code's actual function.

The preprocessor is used to both obfuscate the code as a whole and abbreviate
the calls to SDL. Additionally, throughout the code, the variables were named
so that they are short and easily confused with each other.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
