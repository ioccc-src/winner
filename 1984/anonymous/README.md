# Dishonorable mention

Anonymous

## To build:

	make all

## Try:


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

## Author's comments:

No comments were provided by the author.


Copyright (c) 1984, Landon Curt Noll.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
