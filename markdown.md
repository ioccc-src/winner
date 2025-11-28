# IOCCC 29th Markdown Guidelines


## Markdown Guidelines Version

These [Markdown Guidelines](markdown.html) are version **29.01 2025-11-28**.


## Introduction

The IOCCC makes extensive use of [markdown](https://daringfireball.net/projects/markdown/).  For example, when
submitting to the IOCCC we have people submit remarks about their
entry in markdown format.  Every [winning entry](years.html) uses a `README.md`
markdown file as the basis for forming the `index.html` web page for
that entry. All HTML 5 generated pages on the [Official IOCCC website](https://www.ioccc.org/index.html)
start with some markdown content.  We no longer support older HTML
standards and some of our guidelines help integrate winning entries into
the website more easily.

See the [markdown syntax](https://www.markdownguide.org/basic-syntax) guide.
See also the [CommonMark Spec](https://spec.commonmark.org/current/).
See the FAQ on "[remarks.md submission file](faq.html#remarks_md)".

Nevertheless, the IOCCC does have certain practices that we ask authors to
follow. Some of these relate to use of markdown directly and others relate
to injecting HTML into the markdown file.

In the sections below, examples will mark by &#x274c; for the incorrect method
and ✔️ for preferred correct one.


<div id="sections"></div>


## Start `remarks.md` sections at level 3

If (it is not required) you do use sections in your `remarks.md` file (this does
not apply to other markdown files), **PLEASE** start at level three up to level six:

<span style="color:red">&#x274c;</span> Reserved in `remarks.md` only.
``` <!---markdown-->
    # Section Reserved
    ## Section Reserved
```

<span style="color:green">&#x2705;</span> Available every where.
```
    ### Section Level 3
    #### Section Level 4
    ##### Section Level 5
    ###### Section Level 6
```


<div id="anchor-name"></div>


## Replace `<a name="anchor_name"></a>` construct

<span style="color:red">&#x274c;</span> Incorrect.
``` <!---html-->
    <a name="old_way">Section title</a>
```

<span style="color:green">&#x2705;</span> Correct.
``` <!---html-->
    <div id="new_way"></div>

    ### Section title
```


<div id="links"></div>


## Markdown links instead of `<a>...</a>`

<span style="color:red">&#x274c;</span> Incorrect.
``` <!---html-->
    This <a href="#link_target>HTML link text</a> works, but we prefer see below...
```

<span style="color:green">&#x2705;</span> Correct.
``` <!---html-->
    [markdown link text](#link_target)
```


<div id="del"></div><div id="strike"></div>


## Replace `<strike>` or `<s>`

<span style="color:red">&#x274c;</span> Incorrect.
``` <!---html-->
    <strike>striked through text</strike>
    <s>HTML 5 striked through text</s>
```

<span style="color:green">&#x2705;</span> Correct.
``` <!---html-->
    ~~markdown striked through text~~
    <del>HTML 5 striked through text</del>
```


<div id="ins"></div><div id="underline"></div>


## Replace `<u>`

<span style="color:red">&#x274c;</span> Incorrect.
``` <!---html-->
    <u>old tags</u>
```

<span style="color:green">&#x2705;</span> Correct.
``` <!---html-->
    <ins>HTML 5 tags</ins>
```


<div id="tt"></div>


## Replace `<tt>`

<span style="color:red">&#x274c;</span> Incorrect.
``` <!---html-->
    <tt>obsolete HTML</tt>
```

<span style="color:green">&#x2705;</span> Correct.
``` <!---html-->
    <span style="font-family: monospace;">monospace font</span>
    `markdown style monospace`
```


<div id="indent"></div>


## Indent code blocks by four spaces, not by TAB

<span style="color:red">&#x274c;</span> Incorrect.
```` <!---markdown-->
 ``` <!---sh-->
echo "This shell code block is NOT properly indented!"
echo 'Please indent your code blocks with multiples of four (4) ASCII SPACES!"
```
````

We request that you indent the code block by multiples of four (4)
ASCII SPACES, never TAB (␉):

<span style="color:green">&#x2705;</span> Correct.
```` <!---markdown-->
    ``` <!---sh-->
        echo "This shell code block is indented by multiples of 4 spaces"
    ```
````

If you need to intent more than one level, use multiples of 4 ASCII spaces (no tabs):

<span style="color:green">&#x2705;</span> Also Correct.
```` <!---markdown-->
    ``` <!---sh-->
        echo "This shell code block is indented by multiples of 4 spaces"

        for i in $(seq 1 9); do
            echo "This 2nd level is intented by 8 spaces (no tabs)"
            if [[ $i -gt 5 ]]; then
                echo "This 3rd level is intented by 12 spaces (no tabs)"
                break
            fi
        done
    ```
````

While it is possible to use 3 backticks (&#x60;&#x60;&#x60;) without the initial
four (4) space indentation, we **prefer** that you multiples of 4 spaces if possible:

<span style="color:green">&#x2705;</span> Preferred.
```` <!---markdown-->
    ```
        Intent text by multiples of 4 spaces if possible.
    ```
````

A reasonable exception to the rule is when are displaying C:

<span style="color:green">&#x2705;</span> OK for C.

```` <!---markdown-->
    ``` <!---c-->
    /* not intending C code is OK */
    int
    bar(int foo)
    {
       return foo;
    }
    ```
````


<div id="tabs"></div><div id="spaces"></div>


## Do not use TAB in markdown files

Please do **NOT** indent with ASCII TABs (␉), **OR** use any ASCII TAB
(␉) anywhere inside a markdown file.

While we have nothing against the ASCII TAB (␉) character in general,
we have discovered that ASCII TAB (␉) characters create problems when
used as part of the leading whitespace within a markdown file.

If you need to indent two (2) or more levels, use multiples of four (4)
ASCII SPACES.

<span style="color:red">&#x274c;</span> Incorrect for markdown files only.
```` <!---markdown-->
    ```
    ␉Please do **NOT**␉use ASCII tabs␉in markdown files.
    ␉␉Please do **NOT** indent markdown with ASCII tabs.

    ␉We␉don't␉mind␉tabs␉in␉general,
    ␉We just ask that you NOT use them in markdown files.
    ```
````

<span style="color:green">&#x2705;</span> OK for all file types, e.g., `.c`, `.h`, `.mk`, `.sh`, **EXCEPT** `.md` markdown files.
```` <!---c-->
    ␉printf("It is fine␉to␉use tabs in Obfuscated C code.\n");
    ␉␉/*␉if␉you␉wish    */

    ␉// We ask that you to NOT use ASCII tab characters in your remarks.md writeup,
    ␉// or in any other markdown files within your entry, please.
````

**NOTE**: For purposes of visual illustration, ASCII TABs are shown above with the `␉` symbol.


<div id="code"></div><div id="languages"></div>


## Use HTML comments for code block language syntax

We request that [fenced markdown code blocks](https://www.markdownguide.org/extended-syntax/#fenced-code-blocks) **NOT** specify a language directly.

<span style="color:red">&#x274c;</span> Incorrect.
```` <!---markdown-->
    ```c
        int main(void) {return 0;}
    ```
````

Instead, put the language inside an HTML comment, separated from the
markdown code block starting fence by a space:

<span style="color:green">&#x2705;</span> Correct.
```` <!---markdown-->
    ``` <!---c-->
        int main(void) {return 0;}
    ```
````

**PLEASE NOTE**: There is an **IMPORTANT** ASCII SPACE between the 3 backticks (&#x60;&#x60;&#x60;)
and the start of the HTML comment!

**PLEASE**: Use an HTML comment that is of this form:

    * starts with `<!---` (note the 3 dashes)
    * is immediately followed by the language
    * and finally followed by `-->` (note the 2 dashes)


<div id="code-and-text"></div>


## Ensure blank line between code block and text

<span style="color:red">&#x274c;</span> Incorrect, missing empty line after closing 3 backtick (&#x60;&#x60;&#x60;) fence.
```` <!---markdown-->
    ``` <!---c-->
    /* The C compiler will insist in flagging this an error, unfortunately */
    int
    main(int foo)
    {
       return foo;
    }
    ```
    C compilers cannot be given a -Wno-main-arg-errors flag.
````

<span style="color:green">&#x2705;</span> Correct, has empty line between closing fence and subsequent text.
```` <!---markdown-->
    ``` <!---c-->
    /* The C compiler will insist in flagging this an error, unfortunately */
    int
    main(int foo)
    {
        return foo;
    }
    ```

    C compilers cannot be given a -Wno-main-arg-errors flag.
````


<div id="tag-slash"></div>


## Do not add trailing slash to void HTML tags

The trailing slash on [void HTML elements](https://github.com/validator/validator/wiki/Markup-»-Void-elements) has no effect and interacts
badly with unquoted attribute values; do not use.  See also this note
on [trailing slashes in void-element start tags](https://github.com/validator/validator/wiki/Markup-»-Void-elements#trailing-slashes-in-void-element-start-tags-do-NOT-mark-the-start-tags-as-self-closing).


<span style="color:red">&#x274c;</span> Incorrect.
``` <!---html-->
    <br/>
    <hr/>
    <img src="1984-anonymous-tattoo.jpg" alt="image of a tattoo of
    the 1984 anonymous C code" width=600 height=401 />
```

<span style="color:green">&#x2705;</span> Correct.
``` <!---html-->
    <br>
    <hr>
    <img src="1984-anonymous-tattoo.jpg" alt="image of a tattoo of
    the 1984 anonymous C code" width=600 height=401>
```


<div id="br"></div><div id="backslash"></div>


## Do not use a trailing backslash outside of a code block

<span style="color:red">&#x274c;</span> Incorrect, do not use escaped newlines outside of a code block.
``` <!---markdown-->
    In markdown,\
    do NOT use trailing\
    backslashes outside of\
    a code block
```

<span style="color:green">&#x2705;</span> Correct.
```` <!---html-->
    In markdown,<br>
    use trailing<br>
    br's outside of<br>
    a code block

    ```
    This is OK\
    inside a\
    markdown code\
    block
    ```

    `This is OK\`
````

Doing it this way will prevent `pandoc(1)` from generating deprecated
HTML elements, such as `<br />`.


<div id="img"></div>


## Do not use markdown style images

<span style="color:red">&#x274c;</span> Incorrect.
``` <!---markdown-->
    ![alt text](filename.png "Title")
```

<span style="color:green">&#x2705;</span> Correct.
``` <!---markdown-->
    <img src="filename.png"
    alt="describe the filename.png image for someone who cannot view it"
    width=PIXEL_WIDTH height=PIXEL_HEIGHT>

    Which allows for HTML <img> attributes `alt=`, `width=` and `length=`.
```

The problem is that `pandoc(1)` generates problematic HTML from the
markdown image construct, the resulting HTML does **NOT** have `width`
and `height` information so browsers have to slow down on rendering
text around the image until it can internally determine the image size.


<div id="hr"></div>


## Replace markdown style horizontal lines

Please do **NOT** use `---` style lines in markdown to create horizontal
lines or to separate sections.

Unless something is inside a markdown **code block**, do **NOT** start
a line with 3 or more dashes ("`-`"s).

Such markdown causes `pandoc(1)` to generate `<hr />`.  The `<hr />` has
no effect in standard HTML 5 and interacts badly with unquoted attribute
values.

<span style="color:red">&#x274c;</span> Incorrect.
``` <!---html-->
    * * *
    - - -
    ---
```

<span style="color:green">&#x2705;</span> Correct.
``` <!---html-->
    Regular divider...
    <hr>

    A short divider...
    <hr style="width:10%;text-align:left;margin-left:0">
```


<div id="parentheses"></div>


## Do not put a literal "`(`" or "`)`" in markdown link titles

<span style="color:red">&#x274c;</span> Incorrect.
``` <!---markdown-->
    [some (text)](https://example.com/curds)
    [ls(1)](https://example.com/ls-man-page.1)
```

<span style="color:green">&#x2705;</span> Correct.
``` <!---markdown-->
    [some &lpar;text&rpar;](https://example.com/curds)
    [ls&lpar;1&rpar;](https://example.com/ls-man-page.1)
```


<div id="closing-parentheses"></div>


## Do not end markdown links with "`))`"

Markdown links that end in "`))`" complicate parsing and sometimes lead
to incorrect URLs or file paths.

<span style="color:red">&#x274c;</span> Incorrect.
``` <!---markdown-->
    [some text](https://example.com/foo_(bar))
    This thing, ([some text](some/path)), is NOT ideal.
```

<span style="color:green">&#x2705;</span> Correct.
``` <!---markdown-->
    [some text](https://example.com/foo_&lpar;bar&rpar;)
    This thing, [some text](some/path), is better.
```


<div id="italics"></div>


## Use `_` for italics in markdown

Please do **NOT** use `*` (single asterisk) for italics in markdown.
Instead use an underscore (`_`). Using an asterisk can complicate
parsing and sometimes lead to incorrect results. This can especially
go for when it is **_bold and italic_**.

<span style="color:red">&#x274c;</span> Incorrect.
``` <!---markdown-->
    *this text is italic*
    ***this text is bold italic***
```

<span style="color:green">&#x2705;</span> Correct.
``` <!---markdown-->
    _this text is italic_
    **_this text is bold italic_**
    _**this text is bold italic**_
```

**BTW**: the astute reader might notice that some cases of `*` for italic
might have slipped through. We do ask you, however, to please
observe this rule, as best you can.
