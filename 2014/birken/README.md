# Best use of port 1701

Michael Birken  
<o__1@hotmail.com>  
<http://www.meatfighter.com/>  

Alexander Prishchepov  
<https://github.com/sans17/>  


## Judges' comments:
### To build:

    make

### To run:

    ./prog < some_secret_or_something

    ./prog http://host[:port]

### Try:

    ./prog.c

    ./prog http://127.0.0.1:1701

### Selected Judges Remarks:

Port 1701?  Well this is not the l2f registered TCP/1701 protocol.
Sniff the traffic to/from that port.  You will see HTTP client
and server traffic.  The HTML content you may see is static and
immutable.  Nothing funny with the HTTP status codes.  Even the
timestamp cookie, once set, remains static throughout the
session.  The data appears to not be transmitted within the
binary content communicated between client and server.

So how does this program do it?  A trek though the cloak of
obfuscation awaits the reader of the source!

## Author's comments:
### Abstract

When launched in web server mode, this application appears to deliver nothing more than a static HTML page.  But, in actuality, it provides covert file transfer over the Internet.  This is demonstrated by starting the application as a client-side downloader.  The hidden transmitted data cannot be reconstructed or even detected from the binary content of the traffic between the client and the server.

### To run web server

    ./prog < secret_file_to_be_downloaded

Try using the program's source code as the secret file:

    ./prog < prog.c

### To run client-side downloader

    ./prog http://host[:port]

The optional port defaults to 1701.  If the web server instance is started on the same box, try:

    ./prog http://127.0.0.1:1701

It will incrementally display the contents of the hidden file at a rate of approximately 1 baud.

The client-side downloader will automatically terminate if the web server is bounced.

### HTML content

Plug the URL into a browser to view a static HTML page containing ASCII artwork.

### Exploration

Studying the network traffic will reveal that the HTML content is static and immutable, the HTTP request and response fields do not contain anything remarkable, HTTP status and error codes are not exploited, no unusual or deprecated features of HTTP are used, and while the cookie is based on a timestamp, its value also remains unchanged throughout the session.  As mentioned in the abstract, the data is not transmitted within the binary content communicated between the client and the server.  A full explanation of the protocol appears below, but feel free to explore before reading further.

### Inspiration

The inspiration for this program comes from _Star Trek VI: The Undiscovered Country_, specifically the final confrontation between the _Enterprise_ and the enhanced prototype Klingon Bird of Prey.  The definitive feature of the prototype was its ability to fire while cloaked.  But, perhaps even more impressive was its able to keep an open communication channel with the _Enterprise_ throughout the battle, enabling the antagonist Chang to taunt Captain Kirk with Shakespearian quotes while he slowly pelted his ship with torpedoes.  Normally, cloaked vessels must maintain silent running to avoid detection.

The battle is commemorated in the form of ASCII artwork depicting the ships faced head-to-head in the page delivered by the web server.  Plus, the program source code is formatted in the shape of a Klingon Bird of Prey.  The code itself includes a number of Star Trek references: the registry number of the _Enterprise_ (NCC-1701) is defined as a constant; variable names spell out Cpt. James T. Kirk and Odo (the Deep Space 9 character was played by René Auberjonois who also appeared as Colonel West in _Star Trek VI_); the STARDATE constant makes timing configurable; and, the constant k stands for Khan (in the final engagement in _Star Trek II: The Wrath of Khan_, the damaged _Enterprise_ managed to disable the USS _Reliant_’s shield generator by accessing its prefix code: 16309).

### Secondary size limit

As obligated by a program that employs 23rd century cloaking technology, when the source is fed as input to IOCCC size tool version 2014-09-23-v19, and the -i command line option is used, the value printed is 0.

### Transmission protocol revealed

The client-side downloader relies on the response time of the web server rather than the binary content of the response.  The server transmits 1 nibble at a time by counting to the nibble value via a sequence of rapid responses terminated by a long response.  For instance, the value 5 would be transmitted by making a series of requests that result in 5 near instantaneous responses followed by a half-second delayed response.  The long delay is skipped in the case of 15, the maximal nibble value.  With the aid of an ASCII table, it is actually possible to read the nibbles by repeatedly pressing the refresh button within a browser and observing the page refresh delay.

Nibble Count Coding (file transfer protocol NCC-1701) is faster than transmitting each individual bit as a short or long delay because it sends each byte with 2 long delays whereas communicating individual bits requires 8 long delays in the worst case scenario.  In fact, Nibble Count Coding is faster than applying Huffman Coding since that is designed to produce compact codes under the assumption that the bit value does not affect transmission time.

The server relies on the cookie to identify each client uniquely, enabling it to transfer the sequence independently to each client.

### Configuration

As with all network communication, accurate transmission of data relies on the nature of hardware revealed through statistics and timeouts set accordingly.  The long delay is arbitrarily set to 0.5 seconds.  This is microsecond tunable via the STARDATE constant defined at the top of the source code.  Increase the value in the event of transmission errors.  Decrease the value to download faster and less reliably.

The NCC constant is the web server port number.

### Obfuscations

* The ASCII artwork is compressed using run-length encoding.
* One long string stores a series of strings concatenated together and referenced via pointers.
* The long string is shift encrypted.
* Short and meaningless identifiers are used throughout.
* Reversed array indexing was applied immoderately.
* Minus is used in place of not-equals.
* O and l were selected for their resemblance to 0 and 1 respectively.
* Standard constants and ASCII characters were replaced with their respective numerical values.

### Compiler warnings

For space considerations, the following include statements were dropped resulting in compiler warnings:

    #include <asm/byteorder.h>
    #include <ctype.h>
    #include <netinet/in.h>
    #include <stdlib.h>
    #include <string.h>
    #include <sys/select.h>
    #include <sys/socket.h>
    #include <sys/types.h>
    #include <sys/unistd.h>

It may be necessary to restore some of these under certain environments.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
