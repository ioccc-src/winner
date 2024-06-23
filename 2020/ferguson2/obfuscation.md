# Obfuscation

*   Strings identifying what it is are encrypted by the Enigma itself (with its
default settings). The strings are: `Position`, `Setting`, `Ring`, `Plugboard pair`
`Reflector`. Together these would be a dead giveaway to anyone familiar with the
Enigma machine and some of them by themselves would be a dead giveaway too. I
can't even explain how I did this (although I'm sure at one point I could have)
but I do think it's pretty cool to have the text encrypted by the program and
still be capable of printing it correctly all without giving anything away.

*   Digraphs. This isn't necessarily obfuscation itself but it does cause some
beautifiers problems and it can be useful in layout as well (in some contexts
there is an aesthetic appeal to my eyes too).

*   Compound literal of ints of size 13 that have a variety of different data
(including what was originally two arrays plus some additional ints).

*   Negative pointer offsets. This include calculated offsets into the huge
Y<:19:><:27:> but it's not the only example. Here the compound literal of 13
ints:

``` <!---c-->
	    int *z=(int[13]) { 0 } , *e, *g;
```

    Then in main:

``` <!---c-->
	    e = z + 10;
	    g = e + 1;

	    for (j=-3; j < 0; ++j)
		e<:j:> = j+3;
```

Which I think is more confusing: when one is iterating an array you don't
expect to start out with index < 0 but to then compare that that index < 0
and increment until 0 along with setting the value of the array to j + 3 is
more confusing still. There are at least two other ways that are much easier
to read that could accomplish the same thing. It continues on:

``` <!---c-->
	    /* ... */
	    e<:i-3:> = (j < 1 ? 1 : (j > 5 ? 5 : j))-1;
```

*   Observe these two functions:

``` <!---c-->
	    void w(char *s, int k, int v)
	    {
		    for(e<:2:> = 0; s<:*P:>; ++e<:2:>)
		    {
			    v = s<:e<:2:>:>;
			    if(v > 64 && v < 91)
				s<:e<:2:>:> = (((v - 65 + k) % 26) + 65);
		    }
	    }
	    void Q(void)
	    {
		    for(*g = 0; *g < 3; ++*g)
		    {
			    *Y<:16+e<:1:>:>=S<:e<:e<:1:>-3:>:>;
			    R<:e<:1:>:>=Y<:e<:-3+e<:1:>:>:>;
			    w(R[*g],*(e+e<:1:>-6)=q(Y<:8:>,*Y<:7:>),*g);
		    }
	    }
```

First of all: why do I set `e[2]` to 0 and increment it for each pass in the
loop, but then the condition for the loop is `s[*P]`?

Second notice the many references to e[1] (as e[1] and *g). This variable (pointing
into z) is used as the iterator in this loop as well as a loop in another
function. Now why do I pass *g to the function w()? To mislead. Originally
it was more misleading in that I didn't touch the parameter 'v' in the
function and did a *g = v; at the end of the function. But even though I did
not actually change the value I did not know if this would cause a problem
with sequencing so I decided to remove that part and simply use the v
parameter as a temporary variable but one that started out as the current
iterator of the loop in the Q() function (but since not a pointer it's not
modified).

Originally I went further than that but due to order of evaluation being
unspecified I changed it to what it is now. Anyway:

You can also see that I use the value of e[1]-3 as the index of S[e] (so
S[e[e[1]-3]]) (I think I said that right; I honestly don't know now because
there is such major array and offset abuse. The entire prog.c is riddled
with offset abuses.).


*   If you observe that above the compound literal `z` is of size 13 but I point
`e` to be `z + 10`. Why? Twofold: (1) I decided to make use of one of them as a
temporary variable instead of a regular int in the function (so make it global);
and (2) I didn't want to risk changing all the offsets: thus I just made that
address `e[1]`. Thus I also have:

``` <!---c-->
	    for (*g = 0 ; *g < 10; ++*g)
	    {
		r<:-2:> = Y<:14:><:*(e+1):>; r<:-3:> = Y<:15:><:1<:e:>:>;
		if (r<:-3:> && r<:-2:> == r<:-1:>)
		    return r<:-3:>;
		if (r<:-2:> && r<:-3:> == r<:-1:>)
		    return r<:-2:>;
	    }
```

This `e[1]` of course is the same as `*g` as above and as you can see has
multiple dimensions (that is the reference to Y does) too (and this is also
strewn about the code). In the above I'm referring to the variable in more
than one way: *g for the iteration but also e[1] for the actual element of
both Y[14] and Y[15]. I also happen to use S (via r which points to S + 10)
which I use as the two chars to compare (this is the plugboard function).

*   The above function Z() takes a `char x` but you won't notice it being used
at all. Why? In fact I call it like so:

``` <!---c-->
		k = Z(r<:-1:>=k);
```

The char is just used as a way to be able to call the function and assign to
the proper variable at the same time: in the function Z I don't care about x
because it's the same value as r[-1] (which I do care about). Why is it
attached to S? Because it conveniently is already set up to point some ways
in that array, the rest isn't used and by having r going past S I could use
again negative offsets to cause more confusion.

*   Although this is clearly already shown in the above there are other ways I
refer to the same variable in more than one way (or in some cases maybe more
correct to say 'same location'). In the Z() function for example:

``` <!---c-->
		r<:-2:> = Y<:14:><:*(e+1):>; r<:-3:> = Y<:15:><:1<:e:>:>;
```

    I refer to e[1] as both: *(e+1) and 1[e].


*   Replacing a number of `if .. `s with `... && (...)`s (in one case at least
it's nested further: `f && (f = 0 && (a = W(A,a)));`).

*   Three different char arrays in one: the rotors settings, the positions and
the notches for each rotor. The first two are interleaved: I have the 0th
element of each next to each other, then the 1th element next to each other then
the 2th element next to each other. Then it's the notch settings. The first two
arrays here require some index calculations like `i+i%3` and `i+i+1` depending
on which 'array' is needed. At other points I refer to those elements by direct
index (sort of).

*   Another set of char arrays in one: the five rotors as well as the two
reflectors in one `char [][27]`. This makes for some fun code like:

``` <!---c-->
	    (Y<:e<:-10:>+5:><:k-'A':>) && (k = Y<:e<:-10:>+5:><:k-'A':>);
```

    (Of course this also removes an if statement by joining with a &&).

*   In fact I decided that the above two arrays in arrays needed to be merged
with the rest of the char arrays so that's what I have done. They have
different purposes and they're referred to differently. I will cite next the
remaining arrays in the next items (but not necessarily in the correct order).
Notice that the array I'm talking about is the massive `Y<:19:><:27:>`.

*   The alphabet (this is one string).

*   The plugboard (this is two arrays).

*   The Enigma ciphered text for prompting for input (five strings).

*   The relevant notches (this is not the same as the five notch letters!) (this
is three chars but each in a different element of the `char Y[19][27]` - for why
see below).

*   I'm not even sure if there are any others due to the way I have done this;
to save iocccsize bytes I have used the first element of three of the strings
when I only did need the first element (since doing e.g. `f[3][2]` takes more
bytes than `*f[3]` or whatever). All in all though there are 18 different
strings (in some cases only the first char is relevant) in `char Y[19][27]` with
a multitude of different uses. Some of these are as I noted scrambled. Some
default to empty string which might hide that it's even there.


*   Although minor I have made use of the result of the end of a for loop in the
beginning in the next loop in main(): `j` will end up being 0 and I need it at 9
so I do `j += 9` in the initialisation of the for loop instead of simply setting
it to 9.

*   The judges don't like obfuscation through the C preprocessor. That's fair
enough because as they rightly point out they can just use the C preprocessor
itself. But although I have quite a few cpp directives I am not using them for
obfuscation but rather to save bytes. For examples:

``` <!---c-->
	    %:define J(x)		  do(*x)=getchar(); while((*x)=='\n')
```

Is used quite a number of times and although it could be a function that
takes a pointer to an int it was more convenient this way (I believe it used
more bytes but I no longer know that). There are many others and they all
save bytes (or at least most of them do if not all). There is one in
particular I want to bring up though because I think it's a curious one and
it ties in to another point above:

``` <!---c-->
	    %:define A(y)				  *(&Y<:7:><:1:>+(y))
```

What is special about this one: Above I noted how I sort of refer directly
to the notch settings (I think it was the notch settings anyway). Now I
could have done say

``` <!---c-->
	    char a = Y[7][1], b = Y[7][3], c = Y[7][5];
```

But I felt that doing instead the pointer arithmetic was worth doing.
However it used significantly more bytes even as a macro: 17 if I recall
right. That's with the macro. If I were to include it three times by itself
it'd be many more. I believe though that when the cpp translates it it still
requires more thought to determine that a is set to Y[7][1], b to Y[7][3]
and c to Y[7][5].


# Obfuscation wrt recode.c

*   To cause confusion I have used the same names of variables and functions
(well recode.c has more functions and variables) but with different meanings.
For example in recode.c `R` is a `char R[3]` but in prog.c it's `char *R[3]`.
Another example is where in prog.c `Y` is `char Y[19][27]` in recode.c it's `char
*Y[3]`. Some are use swaps but not necessarily all. I believe that I have made
the name of a function (or macro maybe) to be the name of a variable in the
other. Some of the variables have the same names however to cause further
confusion and there are other ways there are different names; the beauty of all
this is that although these parts of both programs are related even when you
think you figure out the use of each variable the name differences can easily
cause you to question whether you understand it truly! Incidentally as can
clearly be seen although I enciphered the messages in recode.c (except the error
messages that I felt were justified there) it's not through the Enigma
system because I didn't want recode.c to give many hints as to how prog.c works.
I don't believe deciphering recode.c will explain how my entry works because
recode.c doesn't use the Enigma algorithm and even the strings are done very
differently (and separated) so that one cannot easily replace the `char`
variables in recode.c, move them to prog.c, compile and expect it to work right.

* Also what is this about ?

``` <!---c-->
				/\
		    /		This is	    *not* what you think:
			    void D(char*x){ /* ... */ }
```


Is that valid and if so how does it function? Yes it's valid but I'll leave
the other part of the question up to the reader to answer. Hint: you already
know how it works (yes, really you do)! Another hint: This is and is not a
misleading comment (conversely this makes this hint both misleading - and
also not).


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
