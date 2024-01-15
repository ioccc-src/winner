# inc

The [inc](README.md) directory holds content that is used by the
tools in the [bin](../bin/README.md) directory.


##  Why the name inc?

We use inc because "include" would be misleading for both C and because
the contents of HTML files under [inc](README.md) are not really included
by the web server or the browser.  Content of HTML files is
processed by tools the [bin](../bin/README.md) directory.
Processing can include substitution of strings of the form _%%CURDS%%_ with some command
line supplied value by the tool in question.
