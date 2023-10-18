# Most tweetable entry

    Sandro Maffiodo  
    <smaffer@gmail.com>  
    <http://www.assezeta.com/sandromaffiodo>

## To build:

```sh
make
```

## To run:

```sh
./prog arg
```

## Try:

```sh
cat image.rgb | ./prog '  .,:;!$#@'
```

## Judges' remarks:

On the face of it :-) given what this program does one might wonder what makes
this winner special.  But when you realize the source is small enough for posting
to social media that has a small size limit.

Who will be the first to tweet this source?  How many re-tweets will such tweet
get?  And how many people will really understand the tweet?

## Author's remarks:

### Remarks

This program convert an image to an ASCII ART. The program reads a raw RGB image
from **stdin** and print the ASCII ART to **stdout**.

The build process will raise some warnings about:

- declaration specifier missing, defaulting to 'int'
- implicitly declaring library function

The program crash if run without parameters.

### Screen size

If you have a terminal geometry than is different from the common 80x25 you can
modify the *output width* by changing the value of the first variable:

```c
d=80,
```

### Something to try

Type this:

```sh
cat image.rgb | ./prog "  .:;Y0"
```

You can use your own image. Convert the image to a raw RGB image, using imagemagick it's very simple:

```sh
convert -geometry 80x source.jpg image.rgb
```

This program require one parameter, or crash. The parameter of the program is the *convertion ramp*. You can use different ramps or create your own (for ex. using some letters of your name).
These are some ramps you can try:

```sh
./prog " :1"
./prog "  .:;Y0"
./prog " .:-=+*#%@"
./prog "   .,:!-iots&8%#@$"
./prog "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/\|()1{}[]?-_+~<>i!lI;:,"^`'. "
```

### 121 byte version

An alternative version of this program is only 121bytes long:

```c
d=80,e,j;g(){j+=getchar();}main(){for(;;){j=0;g();if(j<0)break;g(g());putchar(" .:#@"[j/3*5>>8]);if(!(++e%d))puts("");}}
```

This alternative version have a **fixed ramp**. It's smaller but it's not so fun to use...

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
