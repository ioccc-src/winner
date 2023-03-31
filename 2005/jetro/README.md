# Most sonorous output

    Jetro Lauha
    Talonpojantie 5A9,
    00790 Helsinki
    <http://jet.ro>

## To build:

This entry requires SDL to be installed.

```sh
make
```

### To install SDL and SDL2:

#### macOS users

If you have not aleady do so, install Homebrew.  See the following for information:

    https://brew.sh

Then to install SDL and SDL2, execute the following command:

```sh
brew install sdl2 sdl12-compat
eval "$(/opt/homebrew/bin/brew shellenv)"
```

#### Linux users:

To install SDL and SDL2, execute the following command as root:

```sh
dnf install SDL2 SDL2-devel sdl12-compat sdl12-compat-devel
```

Use make as follows:

```sh
make ... SDL2_INCLUDE_ROOT=/usr
```

or set the following environment variable:

```sh
export SDL2_INCLUDE_ROOT=/usr
```

#### Debian users

To install SDL and SDL2, execute the following command as root:

```sh
apt install libsdl1.2debian libsdl1.2-dev libsdl2-dev
```

Use make as follows:

```sh
make ... SDL2_INCLUDE_ROOT=/usr
```

or set the following environment variable:

```sh
export SDL2_INCLUDE_ROOT=/usr
```

## To run:

```sh
./jetro
```

## Try:

```sh
echo "Do or do not. There is no try."
```

## Judges' comments:

We have seen entries with SDL graphics in the past, now it's time for SDL
sound. This entry can even be run on a computer without a sound card with an
appropriate setting of an environment variable - for that you'll have to dig
into the SDL documentation.

Can you figure out how the notes are encoded and program a different melody?

## Author's comments:

To compile the entry you need SDL library, which is used only for audio
output. To run the entry make sure you have audio output available. The entry
plays 22KHz 16 bit mono music with a small softsynth. When the music plays,
you can stop the application by pressing enter, as the code will just wait
with one call to getchar() before it quits.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
