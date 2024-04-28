## To build:

``` <!---sh-->
    make
```

There is alternate code that lets you redefine the port to bind to, in case
there is a firewall issue, and also lets you redefine the timing constant,
`STARDATE`. See [Alternate code](#alternate code) below.


## To use:

``` <!---sh-->
    ./prog < some_secret_or_something

    ./prog http://host[:port]
```


## Try:

``` <!---sh-->
    ./prog < README.md
```

or maybe:

``` <!---sh-->
    echo "IOCCC 2014!" | ./prog
```

Next, try in another terminal, as the above one is running:

``` <!---sh-->
    ./prog http://127.0.0.1:1701
```

What happens if you specify instead of a regular file something like
`/dev/null` ?


But there's more! Try opening in a browser the same address and then see what
happens. This is explained by the authors when explaining their inspiration.


## Alternate code:

This version allows you to redefine the port to bind to, should 1701 be a
problem for some reason, and it also allows you to change the timing as
described by the author. See [configuration](#configuration) below.


### Alternate build:

To specify the port to say, 31337, try:

``` <!---sh-->
    make clobber PORT=31337 alt
```

To change the timing constant, `STARDATE`, try:

``` <!---sh-->
    make clobber TIME=5000000 alt
```

You can combine them both of course.


### Alternate use:

Use `prog.alt` as you would `prog` above. Remember that ports < 1024 are
privileged ports that unprivileged users cannot use.


## Judges' remarks:

Port 1701?  Well this is not the l2f registered TCP/1701 protocol.
Sniff the traffic to/from that port.  You will see HTTP client
and server traffic.  The HTML content you may see is static and
immutable.  Nothing funny with the HTTP status codes.  Even the
timestamp cookie, once set, remains static throughout the
session.  The data appears to not be transmitted within the
binary content communicated between client and server.

So how does this program do it?  A trek though the cloak of
obfuscation awaits the reader of the source!


## Authors' remarks:

### Abstract

When launched in web server mode, this application appears to deliver nothing
more than a static HTML page.  But, in actuality, it allows covert file
transfer over the Internet.  This is demonstrated by starting the application as
a client-side downloader.  The hidden transmitted data cannot be reconstructed
or even detected from the binary content of the traffic between the client and
the server.

## To use web server

``` <!---sh-->
    ./prog < secret_file_to_be_downloaded
```

Try using the program's source code as the secret file:

``` <!---sh-->
    ./prog < prog.c
```

## To use client-side downloader

``` <!---sh-->
    ./prog http://host[:port]
```

The optional port defaults to 1701.  If the web server instance is started on
the same box, try:

``` <!---sh-->
    ./prog http://127.0.0.1:1701
```

It will incrementally display the contents of the hidden file at a rate of
approximately 1 baud.

The client-side downloader will automatically terminate if the web server is
bounced.


### HTML content

Plug the URL into a browser to view a static HTML page containing ASCII artwork.


### Exploration

Studying the network traffic will reveal that the HTML content is static and
immutable, the HTTP request and response fields do not contain anything
remarkable, HTTP status and error codes are not exploited, no unusual or
deprecated features of HTTP are used, and while the cookie is based on a
timestamp, its value also remains unchanged throughout the session.  As
mentioned in the abstract, the data is not transmitted within the binary content
communicated between the client and the server.  A full explanation of the
protocol appears below, but feel free to explore before reading further.


### Inspiration

The inspiration for this program comes from [Star Trek VI: The Undiscovered
Country](https://memory-alpha.fandom.com/wiki/Star_Trek_VI:_The_Undiscovered_Country),
specifically the final confrontation between the
[Enterprise](https://memory-alpha.fandom.com/wiki/USS_Enterprise_&#x28;NCC-1701&#x29;) and
the enhanced prototype [Klingon Bird of
Prey](https://memory-alpha.fandom.com/wiki/Klingon_Bird-of-Prey). The definitive
feature of the prototype was its ability to fire while cloaked. But, perhaps
even more impressive was its ability to keep an open communication channel with
the Enterprise throughout the battle, enabling the antagonist
[Chang](https://memory-alpha.fandom.com/wiki/Chang_&#x28;General&#x29;) to taunt [Captain
Kirk](https://memory-alpha.fandom.com/wiki/James_T._Kirk) with
[Shakespearian](https://en.wikipedia.org/wiki/William_Shakespeare) quotes while
he slowly pelted his ship with torpedoes.  Normally, cloaked vessels must
maintain silent running to avoid detection.

The battle is commemorated in the form of ASCII artwork depicting the ships
faced head-to-head in the page delivered by the web server.  Plus, the program
source code is formatted in the shape of a Klingon Bird of Prey.  The code
itself includes a number of Star Trek references: the registry number of the
Enterprise (NCC-1701) is defined as a constant; variable names spell out Cpt.
James T. Kirk and [Odo](https://memory-alpha.fandom.com/wiki/Odo) (the [Deep
Space 9](https://memory-alpha.fandom.com/wiki/Star_Trek:_Deep_Space_Nine)
character was played by René Auberjonois who also appeared as [Colonel
West](https://memory-alpha.fandom.com/wiki/West) in [Star Trek
VI](https://memory-alpha.fandom.com/wiki/Star_Trek_VI:_The_Undiscovered_Country) movie);
the `STARDATE` constant makes timing configurable; and, the constant `k` stands
for [Khan](https://memory-alpha.fandom.com/wiki/Khan_Noonien_Singh) (in the
final engagement in [Star Trek II: The Wrath of
Khan](https://memory-alpha.fandom.com/wiki/Star_Trek_II:_The_Wrath_of_Khan), the
damaged Enterprise managed to disable the USS
[Reliant](https://memory-alpha.fandom.com/wiki/USS_Reliant_&#x28;NCC-1864&#x29; ship)'s shield
generator by accessing its prefix code: 16309).


### Secondary size limit

As obligated by a program that employs 23rd century cloaking technology, when
the source is fed as input to [IOCCC size tool version
2014-09-23-v19](%%REPO_URL%%/2014/iocccsize.c), and the `-i` command line option is used, the
value printed is 0.


### Transmission protocol revealed

The client-side downloader relies on the response time of the web server rather
than the binary content of the response.  The server transmits 1 nibble at a
time by counting to the nibble value via a sequence of rapid responses
terminated by a long response.  For instance, the value 5 would be transmitted
by making a series of requests that result in 5 near instantaneous responses
followed by a half-second delayed response.  The long delay is skipped in the
case of 15, the maximal nibble value.  With the aid of an ASCII table, it is
actually possible to read the nibbles by repeatedly pressing the refresh button
within a browser and observing the page refresh delay.

Nibble Count Coding (file transfer protocol NCC-1701) is faster than
transmitting each individual bit as a short or long delay because it sends each
byte with 2 long delays whereas communicating individual bits requires 8 long
delays in the worst case scenario.  In fact, Nibble Count Coding is faster than
applying Huffman Coding since that is designed to produce compact codes under
the assumption that the bit value does not affect transmission time.

The server relies on the cookie to identify each client uniquely, enabling it to
transfer the sequence independently to each client.


### Configuration

As with all network communication, accurate transmission of data relies on the
nature of hardware revealed through statistics and timeouts set accordingly.
The long delay is arbitrarily set to `0.5` seconds.  This is microsecond tunable
via the `STARDATE` constant defined at the top of the source code.  Increase the
value in the event of transmission errors.  Decrease the value to download
faster and less reliably.

The NCC constant is the web server port number.


### Obfuscations

* The ASCII artwork is compressed using run-length encoding.
* One long string stores a series of strings concatenated together and
referenced via pointers.
* The long string is shift encrypted.
* Short and meaningless identifiers are used throughout.
* Reversed array indexing was applied immoderately.
* Minus is used in place of not-equals.
* `O` and `l` were selected for their resemblance to `0` and `1` respectively.
* Standard constants and ASCII characters were replaced with their respective
numerical values.


### Compiler warnings

For space considerations, the following include statements were dropped
resulting in compiler warnings:

``` <!---c-->
    #include <asm/byteorder.h>
    #include <ctype.h>
    #include <netinet/in.h>
    #include <stdlib.h>
    #include <string.h>
    #include <sys/select.h>
    #include <sys/socket.h>
    #include <sys/types.h>
    #include <sys/unistd.h>
```

It may be necessary to restore some of these under certain environments.

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
