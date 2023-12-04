# inc

The [inc](/inc) directory holds content that is used by the
[build-ioccc repo](https://github.com/ioccc-src/build-ioccc/tree/master)

**HOWEVER ...** XXX

While the build-ioccc repo is not ready, tools under
[temp-test-ioccc repo tmp directory](https://github.com/ioccc-src/temp-test-ioccc/tree/master/tmp)
will use files in this directory.


##  Why the name inc?

We use inc because "include" would be misleading for both C and because
the contents of HTML files under [inc](/inc) is not really included
by the web server nor the browser.  Content of HTML files is
processed by tools in the [build-ioccc repo](https://github.com/ioccc-src/build-ioccc/tree/master).
Processing can include substitution of strings of the form _%%CURDS%%_ with some command
line supplied value by the tool in question.


## How HTML content is built

Files under the [inc](/inc) directory contain HTML fragments that the
[build-ioccc repo](https://github.com/ioccc-src/build-ioccc/tree/master)
tools use to form HTML content for the official IOCCC web site](https://www.ioccc.org).

The canonical way that HTML content is built uses, by default, files of the form:

```
*.default.html
```

The command line of a [build-ioccc repo](https://github.com/ioccc-src/build-ioccc/tree/master)
tool, and perhaps modified via [exception file](/inc.exception.md) file may change
to using a different filename, such as using `body.graybg.html` instead of the default `body.default.html`.
In some cases the [HTML config file](/inc/html.cfg) may disable forming HTML content altogether.

The following is the canonical order for building HTML content from a winner `README.md` file:

0. top.default.html
1. head.default.html
2. body.default.html
3. before-row.default.html
4. page-top.default.html
5. topnav.default.html
6. before-row.default.html
7. before-leftcolumn.default.html
8. sidenav.default.html
9. before-rightcolumn.default.html
10. before-content.default.html

At this point, page content such as that produced sources such as authot JSON and
markdown converyerd by the `pandoc` tool is inserted.

This is followed by canonical order for the end of the HTML content:

11. after-content.default.html
12. after-rightcolumn.default.html
13. after-row.default.html
14. page-bottom.default.html
15. bottom.default.html

In some cases, the above canonical order may be skipped.

Files of the form will **NOT** exist, instead the tool will skip using such a file:

```
*.none.html
```


## Use CAUTION when modifying inc files

Some of the files under this directory are used to form **MOST** of the HTML content
on the [official IOCCC web site](https://www.ioccc.org):

**HOWEVER ...** XXX

Well, until the [official IOCCC web site](https://www.ioccc.org), via the
[IOCCC winner repo](https://github.com/ioccc-src/winner) is ready for the mass pull request/merge,
these files are used to form **MOST** of the HTML content
on the [experimental web site](https://ioccc-src.github.io/temp-test-ioccc/).

... and in particular files under [inc](/inc) that are of the form (called default HTML files) ...:

```
*.default.html
```

... contain default content used to form IOCCC HTML / IOCCC web pages.

Instead of editing the default HTML files in order to fix a special web page,
consider making a copy of the default file and modifying the [use.md](/inc/use.md)
file to refer to the copy instead.  That way your special case situation will
not impact **MOST** of the HTML content.


## Why do we do not use certain well know HTML technology

You may wonder why we need these files in the first place.
You may wonder why we even need the tools in the
[build-ioccc repo](https://github.com/ioccc-src/build-ioccc/tree/master)
when there other solutions available to form web pages.


### <a name="static-only"></a>Static web pages only

Here are some reasons why we are using these files and
special tools to create HTML content / IOCCC web pages:

We host [official IOCCC web site](https://www.ioccc.org) via [GitHub pages](https://pages.github.com).
As of the time this file written, **only static web pages are supported**.


### Cannot use server side include

We use [static web pages](#static-only), so use of "server side include" is not available to the IOCCC.

For example, Apache SSI "#include" does not work on [GitHub pages](https://pages.github.com).


### Cannot use a back-end database

We use [static web pages](#static-only), so use of "back-end database" is not available to the IOCCC.


### <a name="why-github"></a>Cannot use non-GitHub web servers

The [GitHub pages](https://pages.github.com) have the distributed server capacity needed to handle
the **huge download volume** or [Slashdot effect](https://en.wikipedia.org/wiki/Slashdot_effect)
that happens when a IOCCC winners are published.

Most so-called low cost web hosting sites have a somewhat hidden excessive bandwidth charge
and/or cap bandwidth when the volume gets too high, and/or do not have the infrastructure
that can handle the [Slashdot effect](https://en.wikipedia.org/wiki/Slashdot_effect).

The IOCCC had experience with people offering web mirrors and even free hosting
only to find that the generous benefactor moves on, or their service is purchased
by someone else who is not so generous.  While it is possible that GitHub might someday
suffer a similar fate, for the time being we are betting that GitHub will remain
willing to host the IOCCC.

The [official IOCCC web site](https://www.ioccc.org) is, after all, primarily C source code
with some supporting documentation.  As such it is a natural fit for GitHub and
[GitHub pages](https://pages.github.com).


### cannot use the HTML object tag

The _<_ object _>_ HTML tag does not work for our needs.

The browser context relationship between the HTML content holds the
HTML tag does not extend into the content that the tag includes.
For example, menu bars will not operate as specified by the [ioccc CSS](/ioccc.css).


### cannot use the HTML embed tag

The _<_ embed _>_ HTML tag does not work for our needs.

This tag wants one to specify the _width_ and _height_ in pixels.
Use of a percentage is not officially supported even if some browsers
might do so.  Our Responsive Web Design on the [ioccc CSS](/ioccc.css)
needs to be responsive to small-sized cell phone-like screens,
mid-sized table-like screens, as well as large-sized desktop-like screens.
Specifying a _width_ and _height_ in pixels will not work well in
all of those screen size contexts.


### cannot use the HTML iframe tag

The _<_ iframr _>_ HTML tag does not work for our needs.

This tag wants one to specify the _width_ and _height_ in pixels.
Use of a percentage is not officially supported even if some browsers
might do so.  Our Responsive Web Design on the [ioccc CSS](/ioccc.css)
needs to be responsive to small-sized cell phone-like screens,
mid-sized table-like screens, as well as large-sized desktop-like screens.
Specifying a _width_ and _height_ in pixels will not work well in
all of those screen size contexts.


### cannot use JavaScript to include content

We do not use JavaScript to include HTML content.

While the IOCCC may use JavaScript in the future to directly render things like C source code,
we will do so in such a way that someone will be able to view [official IOCCC web site](https://www.ioccc.org)
content with JavaScript disabled.

The IOCCC will **NOT MANDATE USE OF JavaScript** to view [official IOCCC web site](https://www.ioccc.org).

For this reason, we cannot use JavaScript include HTML content.