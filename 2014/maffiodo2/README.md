## To build:

``` <!---sh-->
    make
```

There is a 121 byte version provided by the author. See [Alternate
code](#alternate-code) below.


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [2014/maffiodo2 in bugs.html](../../bugs.html#2014_maffiodo2).


## To use:

``` <!---sh-->
    ./prog arg
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

This shorter version is provided by the author. It has a fixed ramp and so not
as fun but it's 121 bytes instead of 140.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    cat image.rgb | ./prog.alt
```


## Judges' remarks:

On the face of it :-) given what this program does one might wonder what makes
this winning entry special.  But when you realize the source is small enough for posting
to social media that has a small size limit.

Who will be the first to tweet this source?  How many re-tweets will such tweet
get?  And how many people will really understand the tweet?

Judges' 2023 update: Last year we would have referred to a
[toot](https://en.wikipedia.org/wiki/Mastodon_&lpar;social_network&rpar;#Comparison_to_Twitter),
as in a [Mastodon](https://fosstodon.org/@ioccc) *toot*.
This year we might have mentioned the term
[publish](https://www.itechpost.com/articles/115087/20221116/mastodon-officially-replaced-toot-publish.htm)
although we remain fond of the
[historic Mastodon term, toot](https://gizmodo.com/mastodon-toot-retired-twitter-tweet-equivalent-1849786221).


## Author's remarks:

### Remarks

This program convert an image to an ASCII ART. The program reads a raw RGB image
from `stdin` and print the ASCII ART to `stdout`.

The build process will raise some warnings about:

- declaration specifier missing, defaulting to 'int'
- implicitly declaring library function

The program will crash if run without parameters.


### Screen size

If you have a terminal geometry than is different from the common 80x25 you can
modify the *output width* by changing the value of the first variable:

``` <!---c-->
    d=80,
```

### Something to try

Type this:

``` <!---sh-->
    cat image.rgb | ./prog "  .:;Y0"
```

You can use your own image. Convert the image to a raw RGB image. Using
ImageMagick it's very simple:

``` <!---sh-->
    convert -geometry 80x source.jpg image.rgb
```

This program require one parameter or it will crash. The parameter of the
program is the *conversion ramp*. You can use different ramps or create your own
(for example using some letters of your name).

These are some ramps you can try:

``` <!---sh-->
    ./prog " :1"
    ./prog "  .:;Y0"
    ./prog " .:-=+*#%@"
    ./prog "   .,:!-iots&8%#@$"
```

### 121 byte version

An alternative version of this program is only 121bytes long:

``` <!---c-->
    d=80,e,j;g(){j+=getchar();}main(){for(;;){j=0;g();if(j<0)break;g(g());putchar(" .:#@"[j/3*5>>8]);if(!(++e%d))puts("");}}
```

This alternative version has a **fixed ramp**. It's smaller but it's not so fun to use...


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
