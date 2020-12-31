# Most tweetable entry

Sandro Maffiodo  
<smaffer@gmail.com>  
<http://www.assezeta.com/sandromaffiodo>  


## Judges' comments:
### To build:

    make

### To run:

    ./prog arg

### Try:

    cat image.rgb | ./prog '  .,:;!$#@'

### Selected Judges Remarks:

On the face of it :-) given what this program one might wonder what makes this winner special.
But when you realize the source is small enough to tweet on twitter you understand.

Who will be the first to tweet this source?  How many re-tweets will such tweet get?
And how many people will really understand the tweet?

## Author's comments:
### Remarks

This program convert an image to an ASCII ART. The program reads a raw RGB image from **stdin** and print the ASCII ART to **stdout**.

The build process will raise some warnings about:

- declaration specifier missing, defaulting to 'int'
- implicitly declaring library function

The program crash if run without parameters.

### Screen size

If you have a terminal geometry than if different from the common 80x25 you can modify the *output width* by changing the value of the first variable:

	d=80

### Something to try

Type this:

	cat image.rgb | ./prog "  .:;Y0"

You can use your own image. Convert the image to a raw RGB image, using imagemagick it's very simple:

	convert -geometry 80x source.jpg image.rgb

This program require one parameter, or crash. The parameter of the program is the *convertion ramp*. You can use different ramps or create your own (for ex. using some letters of your name).
These are some ramps you can try:

	./prog " :1"
	./prog "  .:;Y0"
	./prog " .:-=+*#%@"
	./prog "   .,:!-iots&8%#@$"
	./prog "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/\|()1{}[]?-_+~<>i!lI;:,"^`'. "

### 121 byte version

An alternative version of this program is only 121bytes long:

	d=80,e,j;g(){j+=getchar();}main(){for(;;){j=0;g();if(j<0)break;g(g());putchar(" .:#@"[j/3*5>>8]);if(!(++e%d))puts("");}}

This alternative version have a **fixed ramp**. It's smaller but it's not so fun to use...

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
