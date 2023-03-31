# Dishonorable mention

    Anonymous


## To build:

	make all

## To run:

	./anonymous

NOTE: this entry will probably not work under macOS with the Apple chips (Intel
should be fine though we have no way to test this; if anyone can confirm whether
this will work under macOS with an Intel chip we'd appreciate if you let us
know). Although it will compile cleanly it will not print anything out. More
specifically, on modern systems one might need to specify `-m32` (though this
actually doesn't seem to be the case) but the Apple chips which are arm64 based
will not compile this entry:

	ld: unknown/unsupported architecture name for: -arch armv4t
	clang: error: linker command failed with exit code 1 (use -v to see invocation)
	make: *** [anonymous] Error 1

We were able to get it to work under linux on a 64-bit machine without
specifying `-m32`. However this will fail under the Apple chips because it is
arm64. If we specify `-arch i386` it will not compile:

	Undefined symbols for architecture i386:
	  "_write", referenced from:
	      _read in anonymous-a2a56d.o
	ld: symbol(s) not found for architecture i386


If we add to the CFLAGS `-include unistd.h` we will run into another problem:


	anonymous.c:2:25: error: conflicting types for 'read'
	o, world!\n",'/'/'/'));}read(j,i,p){write(j/p+p,i---j,i/i);}
				^
	/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/unistd.h:472:10: note: previous declaration is here
	ssize_t  read(int, void *, size_t) __DARWIN_ALIAS_C(read);
		 ^


## Judges' comments:

The author was too embarrassed that they could write such trash, so I
promised to protect their identity.  I will say that the author of this
program has a well known connection with the C programming language.

This program is a unique variation on the age old "Hello, world"
program.  What reads like a read may be written like a write!

In 2005 someone by the name of Thomas Scovell got a tattoo of this entry. See
his [web
page](https://web.archive.org/web/20070120220721/https://thomasscovell.com/tattoo.php)
for more information on the tattoo. This is what it looks like:  


![1984-anonymous-tattoo.jpg](1984-anonymous-tattoo.jpg)



## Author's comments:

### On remaining anonymous:

Some years after this entry was published we asked the author if they still
wished to remain anonymous and they said:

> Yes, I want to keep my anonymity.  But you can tell them that I am well known
for my connection to the C language.'

### On the famous tattoo (see above):

The author, when told about this tattoo, said:

> I feel honored that my entry will be the first IOCCC winner to become a
tattoo. It is the first entry to become a tattoo isn't it?

Landon Curt Noll, the one who told the author about the tattoo, wrote back:

> Yes, to our knowledge it is.

### Regrets:

Landon Curt Noll wrote that the author, if they had to do it over again, regrets not
making the program a one-liner and not moving the "int i" into an arg of main
(so that the line would have started with main). On the other hand the author
likes the "two line look" and the way hell o was split. :-) And they like the
fact that it ends in a smily face: ;}


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
