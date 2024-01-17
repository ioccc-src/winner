# bin

The directory holds [bin](README.md) directory
holds tools that build files, such as HTML content, for the
[official IOCCC web site](https://www.ioccc.org).

For HTML content, the [bin](README.md) directory tools
makes use of HTML fragments from the [inc](../inc/README.md) directory
as well as various JSON files and other content from the
[IOCCC GitHub repo](https://github.com/ioccc-src/temp-test-ioccc).


## bin tools


### [all_run.sh](all_run.sh)

Run a command on all winning entries.


### [gen-author.sh](gen-author.sh)

Output winning author(s) Related HTML.


### [gen-inventory.sh](gen-inventory.sh)

Output the inventory in HTML form for a winner index.html page.


### [ioccc-status.sh](ioccc-status)

Updates the [status.json](/status.json) file.


### [manifest.winner.json.awk](manifest.winner.json.awk)

Output manifest table from a winner .winner.json file.


### [pandoc_wrapper.sh](pandoc_wrapper.sh)

Wrapper tool to run pandoc.


### [readme2index.sh](readme2index.sh)

Convert README.md into index.html.


### [subst.default.sh](subst.default.sh)

Print default substitutions.


### [subst.winner-index.sh](subst.winner-index.sh)

Print substitutions for a winner index.html.


### [subst.winner-navbar.awk](subst.winner-navbar.awk)

Output substitutions for navbar on behalf of a winner.


## How HTML content is built

Files under the [inc](../inc/README.md) directory contain HTML fragments that the
tools in the [bin](README.md) directory
tools use to form HTML content for the [official IOCCC web site](https://www.ioccc.org).

The canonical way that HTML content is built uses, by default, files of the form:

```
*.default.html
```


### HTML phases

The following HTML phase files are used to build HTML content:

0. inc/top.default.html
1. inc/head.default.html
2. inc/body.default.html
3. inc/header.default.html
4. inc/topnav.default.html
5. inc/begin-row.default.html
6. inc/begin-leftcolumn.default.html
7. inc/sidenav.default.html
8. inc/end-leftcolumn.default.html
9. inc/begin-rightcolumn.default.html
10. inc/before-content.default.html

Phases 11-19 are reserved for future use.

20. ((insert 'before tool' output))
21. ((insert 'pandoc wrapper tool' output))
22. ((insert 'after tool' output))

Phases 23-29 are reserved for future use.

30. inc/after-content.default.html
31. inc/end-rightcolumn.default.html
32. inc/end-row.default.html
33. inc/footer.default.html
34. inc/bottom.default.html

Phases 35-39 are reserved for future use.

In the above HTML phase numbers, except during HTML phase numbers 20-29, symbols of the form %%TOKEN%% are substituted.
Any %%TOKEN%% printed by the 'before tool' (-b tool), the 'pandoc wrapper tool' (-p tool), and the 'after tool' (-a tool)
are ignored (i.e., not substituted).

See the tool [readme2index.sh](readme2index.sh) for an example of
how HTML phases are implemented.


### Tool command line

The command line of tools in the [bin](README.md) directory,
and perhaps modified via [md2html config file](../inc/md2html.cfg) file may change
to using a different filename for a given phase.

For example when forming the HTML from `2020/ferguson2/chocolate-cake.md`,
a different "topnav" navigation bar is needed.  So instead of the
usual top navigation bar that normally directs people to the previous
entry for the year, or go up to the year page, or to the next entry
for the year, a top navigation bar to just go up to the entry's
main page is needed.   A line the [md2html config file](../inc/md2html.cfg) file
that refers to `2020/ferguson1/chocolate-cake.md` may specify use
of `topnav.up2index.html` instead of using the `topnav.default.html` default.

The HTML phase may be skipped resulting in no HTML output during a given phase.
Furthermore, forming HTML content from a given markdown file altogether.

See comments in the [md2html config file](../inc/md2html.cfg) file for details.
See also, the tool [readme2index.sh](readme2index.sh) for an example of
how such command lines are used.


## Use CAUTION when modifying inc files

Some of the files under this directory are used to form **MOST** of the HTML content
on the [official IOCCC web site](https://www.ioccc.org).

These files are used to form **MOST** of the HTML content
on the [experimental web site](https://ioccc-src.github.io/temp-test-ioccc/).

... and in particular files under [inc](../inc/README.md) that are of the form (called default HTML files) ...:

```
*.default.html
```

... contain default content used to form IOCCC HTML / IOCCC web pages.

Instead of editing the default HTML files in order to fix a special web page,
consider making a copy of the default file and modifying the [md2html config file](md2html.cfg) to refer to the copy instead.  That way your special case situation will
not impact **MOST** of the HTML content.


## Why do we do not use certain well know HTML technology

You may wonder why we need these files in the first place.
You may wonder why we even need the tools in the [bin](README.md) directory
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
For example, menu bars will not operate as specified by the [ioccc CSS](../ioccc.css).


### cannot use the HTML embed tag

The _<_ embed _>_ HTML tag does not work for our needs.

This tag wants one to specify the _width_ and _height_ in pixels.
Use of a percentage is not officially supported even if some browsers
might do so.  Our Responsive Web Design on the [ioccc CSS](../ioccc.css)
needs to be responsive to small-sized cell phone-like screens,
mid-sized table-like screens, as well as large-sized desktop-like screens.
Specifying a _width_ and _height_ in pixels will not work well in
all of those screen size contexts.


### cannot use the HTML iframe tag

The _<_ iframe _>_ HTML tag does not work for our needs.

This tag wants one to specify the _width_ and _height_ in pixels.
Use of a percentage is not officially supported even if some browsers
might do so.  Our Responsive Web Design on the [ioccc CSS](../ioccc.css)
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
