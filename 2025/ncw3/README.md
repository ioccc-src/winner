Award: Best use of Unicode

## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

We marveled at how few lines of code it takes to devolve (or to evolve?) C into FORTH.


### A fun challenge

Please checkout the [fun challenge&lpar;s&rpar;](../challenge.html#ncw3) for this winning entry.


## Author's remarks:


### About ＦＯＲＴＨ

We are proud to present ＦＯＲＴＨ - a
[FORTH](https://en.wikipedia.org/wiki/Forth_(programming_language)) for the
21st century, re-engineered from first principles and second guesses. This
revolutionary dialect compiles with any C compiler (given enough flags
and emotional support) and brings the legendary transparency of FORTH
programming straight into the C ecosystem, where it clearly belongs.

This modern FORTH uses double-precision floating-point numbers exclusively,
delivering the same mathematical integrity as JavaScript with none of the
user-friendly distractions. Integers were deprecated for philosophical
reasons.

ＦＯＲＴＨ fully embraces Unicode - because if you're not using
obscure multi-byte characters that don't render properly in your terminal,
are you even programming? APL had its chance. It's our turn to make your
keyboard cry.

Requirements:
- needs POSIX `usleep(3)`
- a terminal with UTF-8 Support with Block Elements
- a terminal with 24-bit color support
- terminal window set to at minimum 120x40
- gcc >= 10 or clang >= 14 - may compile with other compilers!

Beyond the architectural manifesto below, no explanation of the C source
mechanics is provided. The lucid self-documentation of the code should
be apparent to all. If you still find it confusing, that's not a bug,
it's a feature: ＦＯＲＴＨ is simply operating on a higher stack
frame of consciousness.

ＦＯＲＴＨ - for those who looked at C and thought, *"too straightforward."*


### Architectural "Decisions"

While lesser implementations might adhere blindly to the ANS Forth standard, ＦＯＲＴＨ takes a more... creative approach to compliance.

* **The Deprecation of State:** You will notice a distinct lack of the `VARIABLE` word. This is not because repeating the keyword blew the IOCCC size limit, but because mutable global state is the root of all evil. We have saved you from yourself.
* **Syntactic De-sugaring:** The `."` word is merely syntactic sugar for weak minds. In this implementation, we prefer the robust `" Hello" TYPE`. It separates data from action, as nature intended.
* **The Grand Unification of Numbers:** Standard Forths segregate Integers and Floating Point numbers on separate stacks, like some sort of numeric caste system. ＦＯＲＴＨ uses a single Double-Precision stack. If you need an integer, just ignore the bits after the decimal point.
* **Compact Output:** The `.` word does not print a trailing space. We consider whitespace to be a wasted resource in this economy.
* **Preprocessor Synergy:** All `IMMEDIATE` words are actually C macros. This means you cannot define your own immediate words, but it also means the C preprocessor is now your partial evaluator. You're welcome.
* **Scoped Execution:** Code cannot run outside of definitions. This enforces a discipline that spaghetti-coders may find restrictive, but architects will appreciate.
* **C-Compatible Identifiers:** Dictionary words must be valid C identifiers. We strictly adhere to the C standard regarding identifier naming, though we perhaps interpret the concept of "significant characters" more broadly than K&R intended.


### Debugging & "Generative Art"

Writing the demo program was a nostalgic trip back to the metal. `gdb`
was helpful, but ＦＯＲＴＨ includes a built-in "Chaos Monkey":
the stack is not checked for underflow or overflow.

When the stack becomes unbalanced, the program does not simply "error
out." It engages the **Memory Visualization Engine** (often confused
with "Segmentation Faults"), producing unintentional but aesthetically
pleasing graphical glitches before unceremoniously dying.


### The Source Code

The source code `prog.c` has been formatted according to the strict style guidelines of the ＦＯＲＴＨ steering committee.


### Spoilers

The following section explains exactly how the C preprocessor and
tokenizer were abused to make C look like FORTH. We recommend reading
the source code *before* decoding this.

The "FORTH" source code is actually valid C, made possible by a heavy abuse of Unicode characters and the C preprocessor.

1. **The "Invisible" Syntax:**
    The core trick relies on C macros defined with invisible Unicode characters. These handle the stack manipulation and control flow, allowing the visible text to remain clean.
    - `U+200B` (Zero Width Space) expands to `(void){`, turning function names into C function definitions.
    - `U+200C` (Zero Width Non-Joiner) expands to `();`, executing the previous word as a function call.
    - `U+200D` (Zero Width Joiner) acts as the C semicolon `;`.

2. **The "Visible" Mimicry:**
    Standard Forth words are implemented using Unicode Fullwidth forms to avoid C syntax collisions.
    - The Forth colon `:` is actually `U+FF1A` (Fullwidth Colon), defined as `void`.
    - The Forth semicolon `;` is actually `U+FF1B` (Fullwidth Semicolon), defined as `}`.
    - Operators like `＋`, `－`, `＞R` use their Fullwidth counterparts.

3. **Variables & Memory:**
    The `VARIABLES` keyword is a macro for `union E`. The variables themselves (like `u`, `v`) are declared with an invisible separator (`U+2063`) that expands to a designated initializer using `__COUNTER__`. This automatically links C variables to the Forth memory array `M`.

4. **Literals:**
    - Double literals are preceded by `U+2061` (Function Application), which expands to `(*--_).i=`.
    - String literals use `U+2062` (Invisible Times), which expands to `(*--_).s = 1+`. The `1+` skips the leading space inside the quote, allowing the source to mimic the Forth `" string"` syntax.


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
