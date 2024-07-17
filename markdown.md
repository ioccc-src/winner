# IOCCC markdown guidelines

The IOCCC makes extensive use of [markdown](https://daringfireball.net/projects/markdown/).
For example, when submitting to the IOCCC
we have people
submit remarks about their entry in markdown format.  Every
[winning IOCCC entry](years.html) uses a `README.md` markdown file
as the basis for forming the `index.html` web page for that entry.
All generated HTML pages on the [Official IOCCC website](https://www.ioccc.org/index.html)
start with some markdown content.

See the [markdown syntax](https://www.markdownguide.org/basic-syntax) guide.
See also the [CommonMark Spec](https://spec.commonmark.org/current/).
See the
FAQ on "[how to submit](faq.html#submit)".

Nevertheless, the IOCCC does have certain practices that we ask authors to follow.
Some of these relate to use of markdown directly and others relate to injecting HTML
into the markdown file.

In particular there are things we ask people to please **NOT** use in
markdown files for the IOCCC:


## Please do NOT use name attributes in HTML `<a ..>` hyperlink elements

Please do **NOT** use the HTML construct:

```
    <a name="string">...</a>                                  <=== no thank you
```

as those are **NOT** part of the HTML 5 standard.

Instead use:

```
    <div id="string">...</div>
```

where the `...` is the HTML you want to "name". The `<div>`
encapsulates the HTML you want to name: i.e., the target of some
`<a href="#string">` or some other `<a href="URL#string">`
for the given page URL.

There are certain HTML Elements that cannot have internal `<div
id="string">...</div>`.

For example:

```
    # <div id="string">THIS WILL NOT WORK!</div>              <=== this will not work
```

For things like headings, you have to surround them, as in:

```
    <div id="string">
    # This will work
    </div>
```

While some browsers will still recognize the HTML construct `<a
name="string">...</a>`, it is possible they might NOT in the future.


## Please do NOT use the `<strike>` or the `<s>` HTML element

Please do NOT use the obsolete `<strike>` or the obsolete `<s>` (<del>_strikeout_</del>) HTML elements:

```
    <strike>...</strike>                                      <=== no thank you
    <s>...</s>                                                <=== no thank you
```

Use instead:

```
    <del>...</del>
```


## Please do NOT use the `<u>` HTML element

Please NOT use the obsolete `<u>` (<ins>_underline_</ins>) HTML element:

```
    <u>...</u>                                                <=== no thank you
```

Use instead:

```
    <ins>...</ins>
```


## Please do NOT use the `<tt>` HTML element

Please do **NOT** use the obsolete `<tt>` (<span style="font-family: monospace;">_teletype_</span>) HTML element:

```
    <tt>The obsolete tt element is obsolete</tt>              <=== no thank you
```

Instead use either a monospaced span:

```
    <span style="font-family: monospace;">Use of a monospaced font
                                          is one option,
                                          however ... </span>
```

We recommend using the inline markdown code block method instead:

```
    Using the `inline markdown code block` is easier and is `preferred`.
```


## Please do NOT use unindented code blocks

Please do **NOT** start code blocks at the left-hand edge.

For example:

````
``` <%%NO_COMMENT%%!---sh-->
echo "This code block is NOT indented\"                       <=== no thank you
```
````

We request that you indent the code block by multiples of 4 ASCII spaces:

````
``` <%%NO_COMMENT%%!---sh-->
    echo "This code block is intended by mutiples of 4 spaces"

    # The top level starts with a 4 ASCII space indent.
    #
    # Only indent with multiples of 4 ASCII spaces.
        # 2nd level indent needs 8 ASCII spaces (no tabs).
            # 3rd level indent needs 12 ASCII spaces (no tabs).
                # etc.
```
````

Moreover:

````
```
    The same thing applies to any markdown block surrounded by ``` lines.
```
````

Please do **NOT** indent using ASCII tab characters in markdown files.


## Please do NOT use ASCII tabs in markdown files

While we have nothing against the ASCII tab character in general,
we have discovered that ASCII tab characters create problems when
used as part of the leading whitespace within a markdown file.

If you need to indent 2 or more levels, use multiples of 4 ASCII
spaces.  Please do **NOT** indent with ASCII tabs, **NOR** use any
ASCII tab characters anywhere inside a markdown file:

For example:

````
```
    Please do **NOT**	use ASCII tabs	in markdown files.      <=== no thank you
	Please do **NOT** indent markdown with ASCII tabs.      <=== no thank you

	We	don't	mind	tabs	in	general,        <=== no thank you
     We just ask that you NOT use them in markdown files.
```
````

And to clarify, we are only talking about markdown files,
not C code or any other non-markdown content:

````
	printf("Is is fine	to	use tabs in Obfucated C code.\n");
		/*	if	you	wish	*/

    // We ask that you to NOT use ASCII tab characters in your remarks.md writeup,
    // or in any other markdown files within your entry, please.
````

**NOTE**: Again, you are **perfectly welcome** to use ASCII tab characters in
your C code and other non-markdown files.  We simply ask that you **NOT** use any
ASCII tab characters in markdown files.


## Please do NOT specify a language for a code block

We request that (fenced) markdown code blocks **NOT** specify a language.

For example:

````
```c                                                            <=== no thank you
    int main(void) {return 0;}
```
````

Instead, put the language inside an HTML comment, separated from the
markdown code block starting fence by a space:

````
``` <%%NO_COMMENT%%!---c-->
    int main(void) {return 0;}
```
````

**IMPORTANT**: The **initial** &nbsp; **\` \` \`** &nbsp; must be followed by an **`ASCII space`**,
then by an **opening** **`<!---`**, then by the **language**, then by a **closing** **`-->`**.



## Please do NOT add trailing slash to HTML elements

Please do **NOT** use a trailing slash on [void HTML
elements](https://github.com/validator/validator/wiki/Markup-»-Void-elements).

See also this note on [trailing slashes in void-element start
tags](https://github.com/validator/validator/wiki/Markup-»-Void-elements#trailing-slashes-in-void-element-start-tags-do-NOT-mark-the-start-tags-as-self-closing).

The trailing slash on void HTML elements has no effect and interacts badly with
unquoted attribute values.

For example, please do NOT use:

```
    <br/>                                                     <=== no thank you
```

Instead use just:

```
    <br>
```

And for example, please do NOT use:

```
    <hr/>                                                     <=== no thank you
```

Instead use just:

```
    <hr>
```

And for example, please do NOT use:

```
    <img src="1984-anonymous-tattoo.jpg"
     alt="image of a tattoo of the 1984 anonymous C code"
     width=600 height=401 />                                  <=== no thank you
```

Instead use just:

```
    <img src="1984-anonymous-tattoo.jpg"
     alt="image of a tattoo of the 1984 anonymous C code"
     width=600 height=401>
```

etc.


## Please do NOT use trailing backslash outside of a code block

Unless the line is inside a markdown code block, please do **NOT**
end a markdown line with a trailing backslash (`\`).  Instead use
a trailing `<br>`.

Instead of:

```
    In markdown,\                                             <=== no thank you
    do NOT use trailing\
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

Again, use of a trailing backslash (`\`) inside a markdown code block is fine:

````
```
    This is OK\
    inside a\
    markdown code\
    block
```
````

This will prevent `pandoc(1)` from generating deprecated HTML elements such as
`<br />`.


## Please do NOT use markdown style images

Please do **NOT** use the markdown embedded image element.

Instead of using this markdown element to embed an image:

```
    ![alt text](filename.png "Title")                         <=== no thank you
```

Use an `<img ..>` HTML element with `alt=`, `width=` and `length=`
attributes:

```
    <img src="filename.png"
     alt="describe the filename.png image for someone who cannot view it"
     width=PIXEL_WIDTH height=PIXEL_HEIGHT>
```

For example, instead of:

```
    ![1984-anonymous-tattoo.jpg](1984-anonymous-tattoo.jpg)   <=== no thank you
```

use this HTML:

```
    <img src="1984-anonymous-tattoo.jpg"
     alt="image of a tattoo of the 1984 anonymous C code"
     width=600 height=401>
```

The problem goes beyond the fact that `pandoc(1)` generates problematic
HTML from the markdown image construct, the resulting HTML does NOT
have `width` and `height` information so browsers have to slow down
on rendering text around the image until it can internally determine
the image size.


## Please do NOT use markdown style horizontal lines

Please do **NOT** use `**---**`-style lines in markdown to create horizontal
lines or to separate sections.

Unless something is inside a markdown code block, do NOT start a
line with 3 or more dashes (`-`s).

Such causes `pandoc(1)` to generate `<hr />`.  The  `<hr />` has no effect in
standard HTML 5 and interacts badly with unquoted attribute values.

If a horizontal line is really needed, use:

```
    <hr>
```

If a short line is needed, use:

```
    <hr style="width:10%;text-align:left;margin-left:0">
```


## Please do NOT end markdown links in "))"

Please do **NOT** end a markdown links with a double closed parenthesis "))".

Markdown links that end in "))" complicate parsing and sometimes lead
to incorrect URLs or file paths.

Instead of:

```
    [some text](https://example.com/foo_(bar))                <=== no thank you
```

Use:

```
    [some text](https://example.com/foo_&#x28;bar&#x29;)
```

Instead of:

```
    This thing, ([some text](some/path)), is NOT ideal.       <=== no thank you
```

Use:

```
    This thing, [some text](some/path), is better.
```


## Please do NOT place text on the next line after a markdown code block

Please do **NOT** place text on the next line after a markdown code block.
Instead, place a blank line after the end of a markdown code block
as this makes it easier to detect when markdown code blocks are
NOT properly indented.

Instead of:

````
```
    int
    main(int foo)
    {
        return foo;
    }
```
C compilers cannot be given a -Wno-main-arg-errors flag.      <=== no thank you
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
````

**BTW**: Please note the blank line after the code block.


## Please do NOT put "("s or ")"s in markdown link titles

Please do **NOT** use literal parentheses inside the markdown link titles.

Instead of:

```
    [some (text)](https://example.com/cyrds)                  <=== no thank you
```

Use:

```
    [some &#x28;text&#x29;](https://example.com/cyrds)
```

Instead of:

```
    [ls(1)](https://example.com/ls-man-page.1)                <=== no thank you
```

Use:

```
    [ls&#x28;1&#x29;](https://example.com/ls-man-page.1)
```
