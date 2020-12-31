Best one-liner:

    Jens Schweikhardt
    Marconi Communications
    Schlartaeckerweg 3
    D-71384 Weinstadt
    Germany

    http://www.schweikhardt.net/


Judges' Comments:

    To build:

    	make schweikh

     Try:

	./schweikh foo 'f??'; echo $?
	./schweikh 'best short program' '??st*o**p?*'; echo $?
	./schweikh bar 'f??'; echo $?

     Do you get the pattern here?


Selected Author's Comments:

    This one-liner program is a glob pattern matcher. It understands
    the glob characters `*' meaning `zero or more characters' and
    `?' meaning exactly one character, just like your unix shell.

    Run it with two args, the string and the glob pattern. The exit
    status is 0 (shell true) when the pattern matches, 1 otherwise.
    The glob pattern must match the whole string, so you may want to
    use * at the beginning and end of the pattern if you are looking
    for something in the middle.

    You can use it for your shell scripting needs similar to a silent grep
    (and without stdout redirected to /dev/null):

    if prog "${VARIABLE}" '<glob>'; then
        echo VARIABLE matches
    else
        echo no match
    fi

    Bugs: there is no way to escape the meta characters. Dammit Jim, I'm a
    one-liner, not a regexp lib.

    All obfuscation is obviously in the recursive m() function, an 86
    character glob pattern evaluator, returning nonzero for a match:
    * just a single complex return expression.
    * nested ternary operator ?: to save on if/else verbosity.
    * short circuiting && and || to save even more on if/else verbosity.
    * Subtraction instead of an equality operator in "*t - 42".
    * ASCII codes for '*' and '?'.
    * careful use of blanks even though this year's rules have extended
      that resource limit.
    * the source is a complete preprocessed C program. Because it communicates
      with the world out there by means of argv and the exit status, there
      is no need for stdio bloat. An asm guru could surely squeeze this
      program in less than a screenful.
    * indent(1) is probably not too helpful.

    The recursion wonderfully and magically takes care of iteration and
    backtracking. I could tell you how it works but then I would have to
    kill^Wrequest an NDA from you :-) Run it under a debugger with several
    inputs, it will be quite helpful and instructive. Handling of '?' is
    straightforward; for '*' start out with '*foo' and 'foo*' against 'foo'.
    How does it deal with sequences of adjacent `*'? How could this be
    improved? If all else fails, recode the ?: operators with if/else and
    try again. For extra credit implement character classes like [a-z].
