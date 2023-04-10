# Best Abuse of the Guidelines:

    Anthony Howe
    Snert
    42 av. Isola Bella
    06400 Cannes
    France

    http://www.snert.com/

## To build:

```sh
make
```

## To run:

```sh
cd build; ./hibachi-start.sh
```

## Try:

```sh
cd build; ./hibachi-start.sh
```

Then use your web browser to visit http://localhost:8008/

## Judges' remarks:

This entry violates the guidelines in so many ways!  We are not
exactly sure how many org's will be upset with this entry, but we
are considering starting an IOCCC standards body just to reign in
the likes Mr Howe.

This entry also has the dubious honour of being the only one to have
been submitted with its own ./configure script.

## Author's remarks:

### README.TXT (Feb 2004)

Hibachi is a simple, small, and (probably) very secure web server.

There is a `hibachi.tgz' file that unpacks several support
files and a sub-directory tree containing the documentation and
examples. It can be viewed by:

    tar -zxf hibachi.tgz
    lynx hibachi/localhost/index.html

Or once Hibachi is running, use a web browser, preferably one that
supports images and JavaScript, to view the documentation and try
some of the CGI examples:

    http://localhost:8008/

### Building

To build just the executable:

For Cygwin, FreeBSD, Linux (newer), Mac OS X:

```sh
gcc -o hibachi hibachi.c
```

For Linux (older):

```sh
gcc -DSHUT_WR=1 -o hibachi hibachi.c
``

For SunOS:

```sh
gcc -o hibachi hibachi.c -lnsl -lsocket
```

Since some systems place socket and network functions into other
libraries, a GNU autoconf ./configure script has been provided to
figure out the necessary link libraries, to verify all the
necessary headers and functions are present, and setup the #!
paths for the CGI examples. In which case the preferred build
commands are:

```
./configure [--enable-port=number]
make
```

To start the server on the default port (8008):

```sh
./hibachi-start.sh &
```

To test the server:

```sh
lynx http://localhost:8008/
```

To stop the server:

```sh
kill %1
```

### Features

*  Supports virtual hosts.

*  Supports all MIME types.

*  Supports Common Gateway Interface (CGI) scripts and programs.

*  Supports multiple index.* file types:

    index.htm, index.html, index.php, index.pl,
    index.sh, index.rb, index.py

*  Supports subset of RFC 2616 HTTP/1.1 methods:

    GET, HEAD, and POST

*  Simple & straight forward configuration using environment variables.

*  Portability across Unix-like environments, such as:

    Cygwin, FreeBSD, Linux, SunOS.

*  Known to work with Lynx, Mozilla, Opera, and Internet Explorer
  web browsers.

*  Is a dedicated process-forking server that does not use inetd.

*  Is secure against relative path file snooping.

*  Is secure against directory searches.

*  CGI script execution managed through Unix file permissions.

*  ~155 lines of source,
  1940 bytes long by IOCCC 2004 rules,
  ~6KB compiled & stripped for FreeBSD.

*  Superior & smaller than micro_httpd from http://www.acme.com/

*  And has a really cool tongue-in-cheek animated logo too.

### Comments

*  This code is properly indented using the One True Brace style.

*  HTTP/1.0 200 OK == HTTP/1.1 200 OK CRLF Connection: close ?

*  getenv() == putenv() ?

*  Hibachi can serve www.ioccc.org.

*  Commented spoiler available.

### Known Issues

*  The "links" text browser does not support RFC 2616 section 7.2.1
  paragraph 3 sentence 2, and so fails to display responses from
  hibachi.

### Suggested IOCCC Categories

    Best Utility
    Best Support
    Most Portable Package
    Most Likely to Cook Apache
    Best Interpretation of RFC 2616
    Winner of The Far Too Much Free Time Award

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
