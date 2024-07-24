<div id="guidelines">
# IOCCC markdown guidelines
</div>

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


<div id="name">
<div id="anchor-name">
## Please do NOT use the `name` attributes in HTML `<a>...</a>` hyperlink elements
</div>
</div>

Please do **NOT** use the HTML construct:

``` <!---html-->
    <a name="string">...</a>                                  <=== no thank you
```

as those are **NOT** part of the HTML 5 standard.

Instead use:

``` <!---html-->
    <div id="string">...</div>
```

where the `...` is the HTML you want to "name". The `<div>`
encapsulates the HTML you want to name: i.e., the target of some
`<a href="#string">` or some other `<a href="URL#string">`
for the given page URL.

### IMPORTANT POINT:

There are certain markdown constructs that **CANNOT** have an **internal** `<div
id="string">...</div>` element.

An example is headings (lines that start with a `#`). For example:


``` <!---markdown-->
    # <div id="string">THIS WILL NOT WORK!</div>              <=== this will not work
```

For things like headings, you have to surround them with the `<div
id="string">...</div>` element, as in:

``` <!---markdown-->
    <div id="string">
    # This will work
    </div>
```

While some browsers will still recognize the HTML construct `<a
name="string">...</a>`, it is possible **they MIGHT NOT** in the future.


<div id="links">
## If you can, it is PREFERABLE to use markdown links rather than `<a>...</a>`
</div>

It is easier and preferred to use markdown links rather than HTML `<a>..</a>`
anchors.

Instead of:


``` <!---html-->
    Use of <a href="#links>HTML anchors</a>
            is one option, however ...
```


``` <!---markdown-->
    [markdown links](#links) are easier and preferred
```


<div id="strike">
<div id="del">
## Please do NOT use the `<strike>` or the `<s>` HTML element
</div>
</div>

Please do **NOT** use the obsolete `<strike>` or the obsolete `<s>`
(<del>**strikeout**</del>) HTML elements:

``` <!---html-->
    <strike>...</strike>                                      <=== no thank you
    <s>...</s>                                                <=== no thank you
```

Use instead:

``` <!---html-->
    <del>...</del>
```


<div id="underline">
<div id="ins">
## Please do NOT use the `<u>` HTML element
</div>
</div>

Please **NOT** use the obsolete `<u>` (<ins>_underline_</ins>) HTML element:

``` <!---html-->
    <u>...</u>                                                <=== no thank you
```

Use instead:

``` <!---html-->
    <ins>...</ins>
```


<div id="tt">
<div id="span">
## Please do NOT use the `<tt>` HTML element
</div>
</div>

Please do **NOT** use the obsolete `<tt>`
(<span style="font-family: monospace;">**teletype**</span>) HTML element:

``` <!---html-->
    <tt>The tt element is obsolete</tt>              <=== no thank you
```

Instead use either a monospaced `<span>` or an inline markdown code block:

``` <!---html-->
    <span style="font-family: monospace;">Use of a monospaced font
                                          is one option,
                                          however ... </span>
```

We recommend using the inline markdown code block method instead:

``` <!---markdown-->
    Using the `inline markdown code block` is easier and is **preferred**.
```


<div id="unindented">
<div id="indented">
## Please do NOT use unindented code blocks
</div>
</div>

Please do **NOT** start code blocks at the first column.

For example:

```` <!---markdown-->
``` <%%NO_COMMENT%%!---sh-->
echo "This code block is NOT indented"                       <=== no thank you
```
````

We request that you indent the code block by multiples of 4 ASCII **SPACES**:

```` <!---markdown-->
``` <%%NO_COMMENT%%!---sh-->
    echo "This code block is indented by mutiples of 4 spaces"

    # The top level starts with a 4 ASCII space indent.
    #
    # Only indent with multiples of 4 ASCII spaces.
        # 2nd level indent needs 8 ASCII spaces (no tabs).
            # 3rd level indent needs 12 ASCII spaces (no tabs).
                # etc.
```
````

Moreover:

```` <!---markdown-->
```
    The same thing applies to any markdown block surrounded by ``` lines.
```
````

Please do **NOT** indent using ASCII tab characters in markdown files.


<div id="tabs">
<div id="spaces">
## Please do NOT use ASCII tabs in markdown files
</div>
</div>

While we have nothing against the ASCII tab character in general,
we have discovered that ASCII tab characters create problems when
used as part of the leading whitespace within a markdown file.

If you need to indent 2 or more levels, use multiples of 4 ASCII
**SPACES**.  Please do **NOT** indent with ASCII tabs, **OR** use any
ASCII tab characters anywhere inside a markdown file:

For example:

```` <!---markdown-->
```
    Please do **NOT**	use ASCII tabs	in markdown files.      <=== no thank you
	Please do **NOT** indent markdown with ASCII tabs.      <=== no thank you

	We	don't	mind	tabs	in	general,        <=== no thank you
     We just ask that you NOT use them in markdown files.
```
````

And to clarify, we are only talking about markdown files,
not C code or any other non-markdown content:

```` <!---c-->
	printf("It is fine	to	use tabs in Obfuscated C code.\n");
		/*	if	you	wish	*/

    // We ask that you to NOT use ASCII tab characters in your remarks.md writeup,
    // or in any other markdown files within your entry, please.
````

**NOTE**: Again, you are **perfectly welcome** to use ASCII tab characters in
your C code and other non-markdown files.  We simply ask that you **NOT** use any
ASCII tab characters in markdown files.

<div id="vim-tabs">
### Tip for `vim` users
</div>

If you use `vim` you can put in your `.vimrc` file (usually `~/.vimrc`) the
following settings to make sure the tabs are not put in without you noticing:

``` <!---vim-->
    set tabstop=8		" a tab is 8 spaces (or whatever you wish it to be set to)
    set softtabstop=4		" ...but when inserting/backspacing use 4 spaces
    set shiftwidth=4		" ...and auto-indent 4 spaces (when autoindent is set)
    set expandtab		" ...but don't expand tab to spaces.
```

If you have file type detection enabled you can, if you prefer, have these
settings set just for markdown files:

``` <!---vim-->
    autocmd! Filetype markdown setlocal set tabstop=8 softtabstop=4 shiftwidth=4 expandtab
```

or so.

This will prevent the tab key from inserting tabs; rather it will insert 4
spaces.

To **VERIFY** that there are no tabs in a file you may do, in command mode:

```
    /\t
```

If you're in insert mode hit `ESC` first.


<div id="languages">
<div id="code">
## Please do NOT _directly_ specify a language for a code block
</div>
</div>

We request that [fenced markdown code
blocks](https://www.markdownguide.org/extended-syntax/#fenced-code-blocks)
**NOT** specify a language directly.

For example:

```` <!---markdown-->
```c                                                            <=== no thank you
    int main(void) {return 0;}
```
````

Instead, put the language inside an HTML comment, separated from the
markdown code block starting fence by a space:

```` <!---markdown-->
``` <%%NO_COMMENT%%!---c-->
    int main(void) {return 0;}
```
````

**IMPORTANT**: The **initial** &nbsp; **\` \` \`** &nbsp; must be followed by an **ASCII SPACE**,
and **THEN** an **opening** **`<!---`** (a "`<`", a "`!`" and then three "`-`"s), and
**THEN** the **language** and **FINALLY** a **closing** "`-->`" (two "`-`"s
followed by a "`>`").



<div id="slash">
<div id="void">
## Please do NOT add trailing slash to void HTML elements
</div>
</div>

Please do **NOT** use a trailing slash on [void HTML
elements](https://github.com/validator/validator/wiki/Markup-»-Void-elements).

See also this note on [trailing slashes in void-element start
tags](https://github.com/validator/validator/wiki/Markup-»-Void-elements#trailing-slashes-in-void-element-start-tags-do-NOT-mark-the-start-tags-as-self-closing).

The trailing slash on void HTML elements has no effect and interacts badly with
unquoted attribute values.

For example, please do **NOT** use:

``` <!---html-->
    <br/>                                                     <=== no thank you
```

Instead use just:

``` <!---html-->
    <br>
```

And for example, please do **NOT** use:

``` <!---html-->
    <hr/>                                                     <=== no thank you
```

Instead use just:

``` <!---html-->
    <br>
```

and

``` <!---html-->
    <hr>
```

And for example, please do **NOT** use:

``` <!---html-->
    <img src="1984-anonymous-tattoo.jpg"
     alt="image of a tattoo of the 1984 anonymous C code"
     width=600 height=401 />                                  <=== no thank you
```

Instead use just:

``` <!---html-->
    <img src="1984-anonymous-tattoo.jpg"
     alt="image of a tattoo of the 1984 anonymous C code"
     width=600 height=401>
```

etc.


<div id="backslash">
<div id="br">
## Please do NOT use a TRAILING backslash (`\`) outside of a code block
</div>
</div>

Unless the line is inside a markdown code block, please do **NOT**
end a markdown line with a trailing backslash (`\`).  Instead use
a trailing `<br>`.

Instead of:

``` <!---markdown-->
    In markdown,\                                             <=== no thank you
    do NOT use trailing\
    backslashes outside of\
    a code block
```

use:

``` <!---markdown-->
    In markdown,<br>
    use trailing<br>
    br's outside of<br>
    a code block
```

Again, use of a trailing backslash (`\`) inside a markdown [**fenced code
block**](https://www.markdownguide.org/extended-syntax/#fenced-code-blocks) is fine:

```` <!---markdown-->
```
    This is OK\
    inside a\
    markdown code\
    block
```
````

This will prevent `pandoc(1)` from generating deprecated HTML elements such as
`<br />`.


<div id="images">
<div id="img">
## Please do NOT use markdown style images
</div>
</div>

Please do **NOT** use the markdown embedded image element.

Instead of using this markdown element to embed an image:

``` <!---markdown-->
    ![alt text](filename.png "Title")                         <=== no thank you
```

Use an `<img>` HTML element with `alt=`, `width=` and `length=`
attributes:

``` <!---html-->
    <img src="filename.png"
     alt="describe the filename.png image for someone who cannot view it"
     width=PIXEL_WIDTH height=PIXEL_HEIGHT>
```

For example, instead of:

``` <!---markdown-->
    ![1984-anonymous-tattoo.jpg](1984-anonymous-tattoo.jpg)   <=== no thank you
```

use this HTML:

``` <!---html-->
    <img src="1984-anonymous-tattoo.jpg"
     alt="image of a tattoo of the 1984 anonymous C code"
     width=600 height=401>
```

The problem goes beyond the fact that `pandoc(1)` generates problematic
HTML from the markdown image construct, the resulting HTML does **NOT**
have `width` and `height` information so browsers have to slow down
on rendering text around the image until it can internally determine
the image size.


<div id="hr">
<div id="horizontal">
<div id="lines">
## Please do NOT use markdown style horizontal lines
</div>
</div>
</div>

Please do **NOT** use `---` style lines in markdown to create horizontal
lines or to separate sections.

Unless something is inside a markdown **code block**, do **NOT** start a
line with 3 or more dashes ("`-`"s).

Such markdown causes `pandoc(1)` to generate `<hr />`.  The  `<hr />` has no
effect in standard HTML 5 and interacts badly with unquoted attribute values.

If a horizontal line is really needed, use:

``` <!---html-->
    <hr>
```

If a short line is needed, use:

``` <!---html-->
    <hr style="width:10%;text-align:left;margin-left:0">
```



<div id="closing-parentheses">
## Please do NOT end markdown links with "`))`"
</div>

Please do **NOT** end a markdown links with a double closed parenthesis "`))`".

Markdown links that end in "`))`" complicate parsing and sometimes lead
to incorrect URLs or file paths.

Instead of:

``` <!---markdown-->
    [some text](https://example.com/foo_(bar))                <=== no thank you
```

use:

``` <!---markdown-->
    [some text](https://example.com/foo_&#x28;bar&#x29;)
```

As another example, instead of:

``` <!---markdown-->
    This thing, ([some text](some/path)), is NOT ideal.       <=== no thank you
```

use:

``` <!---markdown-->
    This thing, [some text](some/path), is better.
```


<div id="parentheses">
## Please do NOT put a LITERAL "`(`" or "`)`" in markdown link titles
</div>

Please do **NOT** use literal parentheses inside markdown link titles.

Instead of:

``` <!---markdown-->
    [some (text)](https://example.com/cyrds)                  <=== no thank you
```

use:

``` <!---markdown-->
    [some &#x28;text&#x29;](https://example.com/cyrds)
```

Instead of:

``` <!---markdown-->
    [ls(1)](https://example.com/ls-man-page.1)                <=== no thank you
```

use:

``` <!---markdown-->
    [ls&#x28;1&#x29;](https://example.com/ls-man-page.1)
```

<div id="code-text">
<div id="code-and-text">
<div id="text">
## Please do NOT place text on the IMMEDIATE (very next) line after a markdown code block
</div>
</div>
</div>

Please do **NOT** place text on the next line after a markdown code block.
Instead, place a blank line after the end of a markdown code block
as this makes it easier to detect when markdown code blocks are
**NOT** properly indented.

Instead of:

```` <!---markdown-->
```
    int
    main(int foo)
    {
        return foo;
    }
```
C compilers cannot be given a -Wno-main-arg-errors flag.      <=== no thank you
````

use:

```` <!---markdown-->
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


<div id="italics">
## Please use `_` for italics in markdown
</div>

Please do **NOT** use `*` (single asterisk) for italics in markdown. Instead use
an underscore (`_`). Using an asterisk can complicate parsing and sometimes lead
to incorrect results. This can especially go for when it is **_bold and
italic_**.

For example, instead of:

``` <!---markdown-->
     *this text is italic*        <=== no thank you
```

use:

``` <!---markdown-->
     _this text is italic_
```

Another example, for **_bold italic_**:

Do **NOT** use:


``` <!---markdown-->
     ***this text is bold italic***         <=== no thank you
```

Instead use:

``` <!---markdown-->
     **_this text is bold italic_**
```

or:

``` <!---markdown-->
     _**this text is bold italic**_
```

