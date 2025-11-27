
# IOCCC 29th Markdown Guidelines

## Markdown Guidelines Version

These [Markdown Guidelines](markdown.html) are version **29.0 2025-11-26**.

<div id="introduction"></div>

## Introduction

The IOCCC makes extensive use of [markdown](https://daringfireball.net/projects/markdown/).  For example, when
submitting to the IOCCC we have people submit remarks about their
entry in markdown format.  Every [winning entry](years.html) uses a `README.md`
markdown file as the basis for forming the `index.html` web page for
that entry. All HTML 5 generated pages on the [Official IOCCC website](https://www.ioccc.org/index.html)
start with some markdown content.  We no longer support older HTML
standards and some of our guidelines help integrate winning entries into
the website more easily.

See the [markdown syntax](https://www.markdownguide.org/basic-syntax) guide.  See also the [CommonMark Spec](https://spec.commonmark.org/current/).
See the FAQ on "[remarks.md submission file](faq.html#remarks_md)".

Nevertheless, the IOCCC does have certain practices that we ask authors to
follow. Some of these relate to use of markdown directly and others relate
to injecting HTML into the markdown file.

In the sections below, examples will mark by ❌ for the incorrect method
and ✔️ for preferred correct one.

<div id="sections"></div>

## Start `remarks.md` sections at level 3

If (it is not required) you do use sections in your `remarks.md` file (this does
not apply to other markdown files), **PLEASE** start at level three up to level six:

```<!---markdown-->
❌ # Section Reserved
❌ ## Section Reserved
✔️ ### Section Level 3
✔️ #### Section Level 4
✔️ ##### Section Level 5
✔️ ###### Section Level 6
```

<div id="anchor-name"></div>

## Replace `<a name="anchor_name"></a>` construct.

```<!---html-->
❌ <a name="old_way">...</a>
✔️ <span id="new_way">...</span>
```

<div id="links"></div>

## Markdown links instead of `<a>...</a>`

```<!---html-->
❌ This <a href="#link_target>HTML link text</a> works, but we prefer
✔️ [markdown link text](#link_target)
```

<div id="del"></div><div id="strike"></div>

## Replace `<strike>` or `<s>`

```<!---html-->
❌ <strike>striked through text</strike>
❌ <s>HTML 5 striked through text</s>

✔️ <del>HTML 5 striked through text</del>
✔️ ~~markdown striked through text~~
```

<div id="ins"></div><div id="underline"></div>

## Replace `<u>`

```<!---html-->
❌ <u>old tags</u>
✔️ <ins>HTML 5 tags</ins>
```

<div id="tt"></div>

## Replace `<tt>`

```<!---html-->
❌ <tt>obsolete HTML</tt>
✔️ <span style="font-family: monospace;">monospace font</span>
✔️ `markdown style monospace`
```

<div id="indent"></div>

## Indent code blocks by four spaces, not by TAB.

```<!---sh-->
❌ echo "This code block is NOT indented"
```

We request that you indent the code block by multiples of four (4)
ASCII SPACES, never TAB (␉):

````<!---sh-->
✔️     echo "This code block is indented by multiples of 4 spaces"

✔️     # The top level starts with a 4 ASCII space indent.
✔️     #
✔️     # Only indent with multiples of 4 ASCII spaces.
✔️         # 2nd level indent needs 8 ASCII spaces (no tabs).
✔️             # 3rd level indent needs 12 ASCII spaces (no tabs).
✔️                 # etc.
````

Alternatively its possible to use ` ``` ` marks, without the initial
four (4) space indentation.  This is usually the better method.

````<!---markdown-->
✔️ ```
✔️ The same thing applies to any markdown block bracketed by ``` lines.
✔️ ```
````

<div id="tabs"></div><div id="spaces"></div>

## Do not use TAB in markdown files.

Please do **NOT** indent with ASCII TABs (␉), **OR** use any ASCII TAB
(␉) anywhere inside a markdown file.

While we have nothing against the ASCII TAB (␉) character in general,
we have discovered that ASCII TAB (␉) characters create problems when
used as part of the leading whitespace within a markdown file.

If you need to indent two (2) or more levels, use multiples of four (4)
ASCII SPACES.

````<!---markdown-->
```
❌ ␉Please do **NOT**␉use ASCII tabs␉in markdown files.
❌ ␉␉Please do **NOT** indent markdown with ASCII tabs.

❌ ␉We	don't␉mind␉tabs␉in␉general,
❌ ␉We just ask that you NOT use them in markdown files.
```
````

And to clarify, we are only talking about markdown files, not C code or
any other non-markdown content:

````<!---c-->
✔️       printf("It is fine␉to␉use tabs in Obfuscated C code.\n");
✔️               /*␉if␉you␉wish    */

✔️       // We ask that you to NOT use ASCII tab characters in your remarks.md writeup,
✔️       // or in any other markdown files within your entry, please.
````

**NOTE**: Again, you are **perfectly welcome** to use ASCII tab characters
in your C code and other non-markdown files.  We simply ask that
you do **NOT** use any ASCII TAB (␉) characters in markdown files.

<div id="code"></div><div id="languages"></div>

## Use HTML comments for code block language syntax.

We request that [fenced markdown code blocks](https://www.markdownguide.org/extended-syntax/#fenced-code-blocks)
**NOT** specify a language directly.

````<!---markdown-->
❌ ```c
❌     int main(void) {return 0;}
❌ ```
````

Instead, put the language inside an HTML comment, separated from the
markdown code block starting fence by a space:

````<!---markdown-->
✔️ ```<!---c-->
✔️    int main(void) {return 0;}
✔️ ```
````

**IMPORTANT**: The **initial** &nbsp; **\` \` \`** &nbsp; must be
followed by an **ASCII SPACE**, and **THEN** an **opening** **
`<!---`** (a "`<`", a "`!`" and then three "`-`"s), and **THEN**
the **language** and **FINALLY** a **closing** "`-->`" (two "`-`"s
followed by a "`>`").

<div id="code-and-text"></div>

## Ensure blank line between code block and text.

Please do **NOT** place text on the next line after a markdown code
block. Instead, place a blank line after the end of a markdown code
block as this makes it easier to detect when markdown code blocks are
**NOT** properly indented.

````<!---markdown-->
   ```
   int
   main(int foo)
   {
      return foo;
   }
❌ ```
❌ C compilers cannot be given a -Wno-main-arg-errors flag.

   ```
       int
       main(int foo)
       {
           return foo;
       }
✔️ ```
✔️
✔️ C compilers cannot be given a -Wno-main-arg-errors flag.
````

<div id="tag-slash"></div>

## Do not add trailing slash to void HTML tags.

Please do **NOT** use a trailing slash on
[void HTML elements](https://github.com/validator/validator/wiki/Markup-»-Void-elements).

See also this note on [trailing slashes in void-element start tags](https://github.com/validator/validator/wiki/Markup-»-Void-elements#trailing-slashes-in-void-element-start-tags-do-NOT-mark-the-start-tags-as-self-closing).

The trailing slash on void HTML elements has no effect and interacts
badly with unquoted attribute values.

```<!---html-->
❌ <br/>
❌ <hr/>
❌ <img src="1984-anonymous-tattoo.jpg" alt="image of a tattoo of
   the 1984 anonymous C code" width=600 height=401 />

✔️ <br>
✔️ <hr>
✔️ <img src="1984-anonymous-tattoo.jpg" alt="image of a tattoo of
   the 1984 anonymous C code" width=600 height=401>
```

<div id="br"></div><div id="backslash"></div>

## Do not use a trailing backslash outside of a code block

Unless the line is inside a markdown code block, please do **NOT** end
a markdown line with a trailing backslash (`\`).  Instead use a trailing
`<br>`.

```<!---markdown-->
❌ In markdown,\
❌ do NOT use trailing\
❌ backslashes outside of\
❌ a code block

✔️ In markdown,<br>
✔️ use trailing<br>
✔️ br's outside of<br>
✔️ a code block

✔️ ```
✔️ This is OK\
✔️ inside a\
✔️ markdown code\
✔️ block
✔️ ```

✔️ `This is OK\`
````

Doing it this way will prevent `pandoc(1)` from generating deprecated
HTML elements such as `<br />`.

<div id="img"></div>

## Do not use markdown style images

Instead of using this markdown element to embed an image:

```<!---markdown-->
❌ ![alt text](filename.png "Title")

✔️ <img src="filename.png"
   alt="describe the filename.png image for someone who cannot view it"
   width=PIXEL_WIDTH height=PIXEL_HEIGHT>

   Which allows for HTML <img> attributes `alt=`, `width=` and `length=`.
```

The problem is that `pandoc(1)` generates problematic HTML from the
markdown image construct, the resulting HTML does **NOT** have `width`
and `height` information so browsers have to slow down on rendering
text around the image until it can internally determine the image size.

<div id="hr"></div>

## Replace markdown style horizontal lines.

Please do **NOT** use `---` style lines in markdown to create horizontal
lines or to separate sections.

Unless something is inside a markdown **code block**, do **NOT** start
a line with 3 or more dashes ("`-`"s).

Such markdown causes `pandoc(1)` to generate `<hr />`.  The `<hr />` has
no effect in standard HTML 5 and interacts badly with unquoted attribute
values.

If a horizontal line is really needed, use:

```<!---html-->
❌ * * *
❌ - - -
❌ ---

   Regular divider...
✔️ <hr>

   A short divider...
✔️ <hr style="width:10%;text-align:left;margin-left:0">
```

<div id="parentheses"></div>

## Do not put a literal "`(`" or "`)`" in markdown link titles

```<!---markdown-->
❌ [some (text)](https://example.com/curds)
✔️ [some &lpar;text&rpar;](https://example.com/curds)

❌ [ls(1)](https://example.com/ls-man-page.1)
✔️ [ls&lpar;1&rpar;](https://example.com/ls-man-page.1)
```

<div id="closing-parentheses"></div>

## Do not end markdown links with "`))`"

Markdown links that end in "`))`" complicate parsing and sometimes lead
to incorrect URLs or file paths.

```<!---markdown-->
❌ [some text](https://example.com/foo_(bar))
✔️ [some text](https://example.com/foo_&lpar;bar&rpar;)

❌ This thing, ([some text](some/path)), is NOT ideal.
✔️ This thing, [some text](some/path), is better.
```

<div id="italics"></div>

## Use `_` for italics in markdown

Please do **NOT** use `*` (single asterisk) for italics in markdown.
Instead use an underscore (`_`). Using an asterisk can complicate
parsing and sometimes lead to incorrect results. This can especially
go for when it is **_bold and italic_**.

```<!---markdown-->
❌ *this text is italic*
✔️ _this text is italic_

❌ ***this text is bold italic***
✔️ **_this text is bold italic_**
✔️ _**this text is bold italic**_
```
**BTW**: the astute reader might notice that some cases of `*` for
italic might have slipped through. We do ask you, however, to please
observe this rule, as best you can.
