# IOCCC markdown best practices

The IOCCC makes extensive use of [markdown](https://daringfireball.net/projects/markdown/).
For example, we [submitting to the IOCCC](faq.html#submit), we have people
to submit remarks about entry in markdown format.  Every
[winning IOCCC entry](years.html) uses a `README.md` markdown file
as the basis for forming the `index.html` web page for that entry.
All generated HTML pages on the [Official IOCCC web site](https://www.ioccc.org/index.html)
start with some markdown content.

See the [markdown syntax](https://www.markdownguide.org/basic-syntax) guide.
See also [CommonMark Spec](https://spec.commonmark.org/current/).

Nevertheless, the IOCCC does have certain practices that we ask authors to follow.
Some these relate to use of markdown directly, others relate to injecting HTML
into the markdown file.

In particular there are things we ask people to please do **NOT** use markdown files:


## Do not use name attributes in HTML a tags

Please do not use the HTML construct:

```
    <a name="string">\</a>		<=== no thank you
```

as those are **NOT** part of the HTML 5 standard.

Instead use:

```
    <div id="string">...\</div>
```

where the "..." is the HTML you want to "name". The **div**
encapsulates the HTML you want to name: I.e., the target of some
"**\<a href="#string">**" or some other "**\<a href="URL#string">**"
for the given page URL.

There are certain HTML Elements that cannot have internal "**\<div
id="string">...\</div>**".  For example you cannot do this:

```
    # <div id="string">This will not work</div>
```

For things like headings, you have to surround them as in:

```
    <div id="string">
    # This will work
    </div>
```

While some browsers will still recognize the HTML construct "**\<a
name="string">\</a>**", they may not in the future.


## Do not use trailing backslash outside of a code block

Unless the line is inside a markdown code block, please do **NOT**
end a markdown line with a trailing backslash ("\\").  Instead use
a trailing "**\<br>**".

Instead of:

```
    In markdown,\			<=== no thank you
    do not use trailing\
    backslashes outside of\
    a code block
```

use:

```
    In markdown,<br>
    use trailing<br>
    br's outside of<br>
    a code block
```

Again, use of a trailing backslash ("\\") inside a markdown code block is fine:

````
```
    This is OK\
    inside a\
    markdown code\
    block
```
````

This will avoid `pandoc(1)` generating deprecated HTML elements such as `\<br />`.


## Do not use markdown image elements

Please do not use the markdown embedded image element.

Instead of using this markdown element to embed an image:

```
    ![alt text](filename.png "Title")		<=== no thank you
```

Use a "img" HTML element with "alt", "alt", "width" and "length"
attributes:

```
    <img src="filename.png"
     alt="describe the filename.png image for someone who cannot view it"
     width=PIXEL_WIDTH height=PIXEL_HEIGHT>
```

For example, instead of:

```
    ![1984-anonymous-tattoo.jpg](1984-anonymous-tattoo.jpg)	<=== no thank you
```

use this HTML:

```
    <img src="1984-anonymous-tattoo.jpg"
     alt="image of a tattoo of the 1984 anonymous C code"
     width=600 height=401>
```

The problem goes beyond the fact that `pandoc(1)` generates problematic
HTML from the markdown image construct, the resulting HTML does not
have "width" and "height" information so browsers have to slow down
on rendering text around the image until it can internally determine
the image size.


## Do not use markdown style horizontal lines

Please do not use "**---**"-style lines in markdown to create horizontal
lines, nor to separate sections.

Unless something is inside a markdown code block, do not start a
line with 3 or more dashes ("-").

Such causes `pandoc(1)` to generate "**\<hr />**".  The  "**\<hr
/>**" has no effect in standard HTML 5 and interacts badly with
unquoted attribute values.

If a horizontal line is really needed, use:

```
    <hr>
```

If a short line is needed, use:

```
    <hr style="width:10%;text-align:left;margin-left:0">
```


## Do not use the strike HTML element

Please not use HTML elements:

```
    <strike>...</strike>	<=== no thank you
```

Use instead:

```
    <del>...</del>
```


## Do not use the tt HTML element

Please do not use the tt HTML elements:

```html
    <tt>The HTML 5 obsolete tt element is obsolete</tt>		<=== no thank you
```

Instead use either a monospaced span:

```html
    <span style="font-family: monospace;">Use of monospaced font is one option</span>
```

Or better and easier still, use an inline markdown code block:

```
    `inline markdown code block is easier and much better`
```


## Do not use un-indented code clocks

Please do not start code blocks at the left-hand edge.

````
```
This code block		<=== no thank you
is not indendted
```
```

We request that you indent the code block by 4 spaces:

````
```
    This code block
    is intented 4 spaces
```
````

One exception is where change bars are needed, such as
those used in `next/rules.md` and in `next/guidelines.md`.

For example, `next/guidelines.md` uses this markdown code block:

````
```
    main() {
|       void please_do_not_submit_this() {
|           printf("The machine that goes BING!\n");
        }
|       please_do_not_submit_this();
    }
```
````


## Do not add trailing slash on void HTML elements

Please do not use trailing slash on [void HTML
elements](https://github.com/validator/validator/wiki/Markup-»-Void-elements).

See also this note on [trailing slashes in void-element start
tags](https://github.com/validator/validator/wiki/Markup-»-Void-elements#trailing-slashes-in-void-element-start-tags-do-not-mark-the-start-tags-as-self-closing).

The trailing slash on void HTML elements has no effect and interacts badly with unquoted attribute values.

For example, please do not use:

```
    <br/>	<=== no thank you
```

Instead use just:

```
    <br>
```

And for example, please do not use:

```
    <hr/>	<=== no thank you
```

Instead use just:

```
    <hr>
```

And for example, please do not use:

```
    <img src="1984-anonymous-tattoo.jpg"
     alt="image of a tattoo of the 1984 anonymous C code"
     width=600 height=401 />					<=== no thank you
```

Instead use just:

```
    <img src="1984-anonymous-tattoo.jpg"
     alt="image of a tattoo of the 1984 anonymous C code"
     width=600 height=401>
```

etc.


## Do not end markdown links in ))

Please do not end a markdown links with a double closed parenthesis "))".

Markdown links that end in "))" complicate parsing and sometimes lead
to incorrect URLs or file paths.

Instead of:

```
    [some text](https://example.com/foo_(bar))	<=== no thank you
```

Use:

```
    [some text](https://example.com/foo_&#x28;bar&#x29;)
```

Instead of:

```
    This thing ([some text](some/path)) is not ideal.	<=== no thank you
```

Use:

```
    This thing, [some text](some/path), is better.
```


## Do not place text on the next line after a markdown code block

Please do not place text on the next line after a markdown code block.
Instead, place a blank line after the end of a markdown code block
is this makes it easier to detect when markdown code blocks are
not properly indented.

Instead of:

````
```
    int
    main(int foo)
    {
        return foo;
    }
```
C compilers cannot be given a -Wno-main-arg-errors flag.	 <=== no thank you
````

Use:

````
```
    int
    main(int foo)
    {
        return foo;
    }
```

C compilers cannot be given a -Wno-main-arg-errors flag.

BTW: Not the blank line after the code block.
````


## Do not put ('s or )' markdown link titles

Please do not use parenthesis inside the markdown link titles.

Instead of:

```
    [some (text)](https://example.com/cyrds)      <=== no thank you
```

Use:

```
    [some &#x28;text&#x29;](https://example.com/cyrds)
```

Instead of:

```
    [ls(1)](https://example.com/ls-man-page.1)      <=== no thank you
```

Use:

```
    [ls&#x28;1&#x29;](https://example.com/ls-man-page.1)
```
