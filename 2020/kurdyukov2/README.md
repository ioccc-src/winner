# Least detailed

Ilya Kurdyukov  
<https://github.com/ilyakurdyukov>  

## To build:

```sh
make
```

## To run:

```sh
./prog
```

## Try:

```sh
# Take a selfie
./prog 1000 selfie.jpg output.jpg
# Admire your portrait in cubist style

(echo P6 1024 1024 255; dd if=/dev/urandom bs=3M count=1) > random.ppm
# Look at random.ppm. Do you see any patterns?
./prog_ppm 1000 random.ppm output.ppm
# See which patterns the program has found

for i in 0001 0002 0004 0008 0016 0032 0064 0128 0256 0512 1024 2048 4096 8192 ; do ./prog $i sample.jpg out$i.jpg; done
# Then flip through the out*.jpg pictures and see when you start recognizing the image.
``

## Judges' remarks:

This entry has reminded us of a winning entry back in the early 90s. Can you guess which one?

For a given image, try graphing the execution time relative to the number of rectangles.
What is the complexity? Is it obvious from the source code?

## Author's remarks:
### Usage

This program divides the image into a specified number of rectangles. This process is content aware, so algorithm tries to match most of the information. However, it doesn't find the best theoretically possible layout.

```sh
./prog 1000 input.jpg output.jpg
```

### Building

You can build three versions, depending on the image format.

Default is JPEG version; if you have the `libjpeg` development package installed
in your system, then `make` without arguments should do the right thing.

If you want to use `libjpeg` compiled from sources, then use `LIBS` define to
specify the path to includes and the library.  For example using
[libjpeg source](https://mac-dev-env.patrickbougie.com/libjpeg/) version 9c:

```sh
make prog LIBJPEG="-Ijpeg-9c jpeg-9c/libjpeg.a"
```

Use this command to build a PNG version (you need `libpng`):

```sh
make prog_png LIBPNG="-lpng"
```

And the PPM version (no additional dependencies, can read raw/ASCII PPM, writes raw PPM):

```
make prog_ppm
```

### Building on macOS with MacPorts:

- Thanks to [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) for this information!

First, make sure you have the compiler tools installed e.g. by:

```sh
sudo xcode-select --install
```

Make sure you install [MacPorts](https://www.macports.org/install.php). Then do:

```sh
sudo port install jpeg libpng ImageMagick
```

The program itself doesn't need ImageMagick, install it only if you plan to make GIFs from the results using `makegif.sh`.

After that’s installed you need to run make with these options:

```sh
make LIBS="-I/opt/local/include -L/opt/local/lib"
```

### Building on macOS with HomeBrew

First, make sure you have the compiler tools installed e.g. by:

```sh
sudo xcode-select --install
```

Make sure you install [HomeBrew](https://brew.sh).

Then:

```sh
brew install libjpeg libpng
eval "$(brew shellenv)"
```

You are now ready to compile this entry:

```sh
make clobber all
```

### Notes

Made this thing while experimenting with the idea of representing an image with
rectangles (lossy compression). It's not very good in that sense, but the
results look funny, like a kind of cubism pixelart.

Do not use values above 50000, it'll be slow.

To understand how this works, just try running with 1,2,3,4... number of
rectangles. At each iteration, the rectangle with the biggest difference from
the picture data is split (halves may have different size) horizontally or
vertically to get the minimum difference.

You can use this command to make a GIF from output images (uses ImageMagick).
For instance after running the command suggested by the judges:

```sh
convert -delay 10 -dither none -loop 0 $(ls out*.jpg | sort -V) $(ls out*.jpg | sort -rV) +map out.gif
```

Also provided `makegif.sh` to aid with GIF creation.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
