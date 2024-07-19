## To build:

``` <!---sh-->
    make
```

There is an alternate version that is unobfuscated, provided by the author in
2024\. See [Alternate code](#alternate-code) below.


## To use:

``` <!---sh-->
    cd build; ./hibachi-start.sh &
```

Then use your web browser to visit `http://localhost:8008/`. When you're
finished make sure to kill `hibachi`.

NOTE: you must be in the `build` directory when running `hibachi-start.sh` for
this to work right.


## Alternate code:

This version, contained in `src-alt/`, is an unobfuscated version provided by
the author in 2024.


### Alternate build:

``` <!---sh-->
    make alt
```

This will run the `configure` script and then compile and link in (in
`build-alt/`) the binary `hibachi`.


### Alternate use:

``` <!---sh-->
    cd build-alt ; ./hibachi-start.sh &
```

Then with your browser do the same as for the original source.


## Judges' remarks:

This entry violates the [guidelines](../../2004/guidelines.txt) in so many ways!  We
are not exactly sure how many organisations will be upset with this entry, but
we are considering starting an IOCCC standards body just to reign in the likes
of Mr Howe.

This entry also has the dubious honour of being the only one to have been
submitted with its own `configure` script.

NOTE: the author states there is a tarball `hibachi.tgz` but this was extracted
so the file does not exist here.


## Author's remarks:

### README.TXT (Feb 2004)

`Hibachi` is a simple, small, and (probably) very secure web server.

There is a `hibachi.tgz` file (NOTE: this file was removed by the judges after
extraction) that unpacks several support files and a subdirectory tree
containing the documentation and examples. It can be viewed by:

``` <!---sh-->
    tar -zxf hibachi.tgz
    lynx hibachi/localhost/index.html
```

Or once `Hibachi` is running, use a web browser (preferably one that
supports images and JavaScript, to view the documentation and try
some of the CGI examples) to visit: `http://localhost:8008/`.


### Building

To build just the executable:

For Cygwin, FreeBSD, Linux (newer), Mac OS X:

``` <!---sh-->
    gcc -o hibachi hibachi.c
```

For Linux (older):

``` <!---sh-->
    gcc -DSHUT_WR=1 -o hibachi hibachi.c
```

For SunOS:

``` <!---sh-->
    gcc -o hibachi hibachi.c -lnsl -lsocket
```

Since some systems place socket and network functions into other libraries, a
[GNU autoconf](https://en.wikipedia.org/wiki/Autoconf)
[configure](https://en.wikipedia.org/wiki/Configure_script) script has been
provided to figure out the necessary link libraries, to verify all the necessary
headers and functions are present, and setup the `#!` paths for the CGI
examples. In which case the preferred build commands are:

```
    ./configure [--enable-port=number]
    make
```

To start the server on the default port (8008):

``` <!---sh-->
    cd build;
    ./hibachi-start.sh &
```

To test the server:

``` <!---sh-->
    lynx http://localhost:8008/
```

To stop the server:

``` <!---sh-->
    kill %1
```

### Features

*  Supports virtual hosts.

*  Supports all [MIME](https://en.wikipedia.org/wiki/MIME) types.

*  Supports CGI: [Common Gateway Interface](https://en.wikipedia.org/wiki/Common_Gateway_Interface) scripts and programs.

*  Supports multiple `index.*` file extensions and types:

        index.htm, index.html, index.php, index.pl, index.sh, index.rb, index.py

*  Supports subset of [RFC 2616](https://datatracker.ietf.org/doc/html/rfc2616)
[HTTP/1.1](https://en.wikipedia.org/wiki/HTTP) methods: `GET`, `HEAD`, and
`POST`.

*  Simple & straight forward configuration using environment variables.

*  Portability across Unix-like environments, such as: Cygwin, FreeBSD, Linux,
SunOS.

*  Known to work with Lynx, Mozilla, Opera, and Internet Explorer
  web browsers.

*  Is a dedicated process-forking server that does not use
[inetd](https://en.wikipedia.org/wiki/Inetd).

*  Is secure against [relative path file
snooping](https://cwe.mitre.org/data/definitions/23.html).

*  Is secure against directory searches.

*  CGI script execution managed through Unix file permissions.

*  ~155 lines of source, 1940 bytes long by IOCCC 2004 rules, ~6KB compiled &
stripped for FreeBSD.

*  Superior & smaller than
[micro_httpd](http://www.acme.com/software/micro_httpd/) from <http://www.acme.com/>.

*  And has a really cool tongue-in-cheek animated logo too.


### Comments

*  This code is properly indented using the [One True Brace
style](https://wiki.c2.com/?OneTrueBraceStyle).

*  `HTTP/1.0 200 OK` == `HTTP/1.1 200 OK CRLF Connection: close` ?

*  `getenv()` == `putenv()` ?

*  `Hibachi` can serve [www.ioccc.org](https://www.ioccc.org).

*  Commented obfuscation change log information available.

### Known Issues

*  The [links][1] text browser does not support RFC 2616 section 7.2.1
  paragraph 3 sentence 2, and so fails to display responses from
  `hibachi`.

[1]: https://en.wikipedia.org/wiki/Links_(web_browser)

### Suggested IOCCC Categories

* Best Utility
* Best Support
* Most Portable Package
* Most Likely to Cook Apache
* Best Interpretation of RFC 2616
* Winner of The Far Too Much Free Time Award


### NOTICE to those who wish for a greater challenge:

**If you want a greater challenge, don't read any further**:
just try to understand the program via the source.

If you get stuck, come back and read below for additional hints and information.


### Obfuscation change log

For additional hints about how the source was obfuscated, read [src/localhost/CHANGELOG.TXT](src/localhost/CHANGELOG.TXT).


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
