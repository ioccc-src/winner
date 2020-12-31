Best Data Hiding:

    Daniel Fischer
    VNetx.com GbR
    Salenbergstrasse 11		(home address)
    D 72250 Freudenstadt
    German Federal Republic


Judge's Comments:

    To build:

	make df

    To use:

	./df

    Everyone talks about how data hiding can produce clearer code; I am
    pleased to offer this charming refutation.

    The program is a simple game.  A bit of observation reveals that the
    game has some data - but where?  It's unclear which of the contents of
    the program are used.

    Curiously, the program only works if its source is in the directory
    it's run in.  More curiously, the program will fail if the program's
    name's second letter isn't "r" (the source has been changed for your
    convenience and this restriction does no longer exist).

    Modern design has come a long way since the unreadable, tightly-coupled
    systems we used to have.

    Extra credit questions:

	Where are the words stored?
	How many words does this entry use?
	Can you add more words to the program and still make it work?


Selected Author's Comments:

    This program lets you guess English words. It displays an underscore
    for each letter in the word; guessing a letter that actually is in
    the word replaces the corresponding underscores with the letter
    itself. You can guess a letter simply by typing it in. If your C
    implementation requires it, you may have to hit Return before it
    is recognized.  In this case, you can also type multiple guesses
    on the same line (completely solve it by entering
    "abcdefghijklmnopqrstuvwxyz"). Execution stops when all underscores
    have been replaced.

    The program offers a number of different words to guess, time() is
    used to pick one at random. All words are eight characters long.

    The source should compile with any ANSI C compiler (I used CodeWarrior
    w/ ANSI strict).  Using non-ANSI compilers that implement the ANSI
    features it uses will not work (unless they defined __STDC__ 1
    which they shouldn't). Due to space restrictions, I did not use
    any trigraph sequences.  It does not require any special -D defines.

    The source passes lint without any complaint (if invoked with
    >/dev/null). (My lclint is unable to recover from some parts of it.)

    Actually, the code not only is compliant with the ANSI specifications,
    but uses a near minimum subset of them. C keywords that were not
    used have been re(de)fined to avoid unnecessary introduction of
    new, unknown character patterns. The source also includes all ANSI
    headers it needs (after most of the functions have been used), and
    the declaration of main() follows the guidelines (but the return
    type has a different meaning and the arguments are either mis- or
    unused). There also may be some compiler warnings. These are not
    bugs, but features. The more warnings, the better the compiler.
    There wouldn't be any if I had been allowed to use some extra space
    for prototypes etc.

    Multiple defines are used (but not all of them define), and #define
    y define is used with #y but the code doesn't assume #y to expand
    to #define. I have also included comments in the code, and vital
    code in the comments. And of course there is code that doesn't do
    anything but will crash the program if it is removed (just like
    those comments I mentioned above). Additionally, since you said
    you'd be preprocessing entries ignoring includes I figured I should
    use some more of them instead of other obfuscation methods.  Did
    I mention that preprocessed or beautified sources will crash or
    hang your system? The program will also crash on non-ASCII machines.

    The executable needs its source file present in the current directory
    or, depending on your system, in your path. The name of the source
    file is not hard-coded, __FILE__ is used instead.

    In the original version which was sent in to the contest, there were
    some restrictions on the file name:
	The second letter had to be a lowercase 'r'.
	The third letter could never be a '+' or a 'b'.
    Valid names would have been "pr4.c", "pr.c", "prog.c", "brownie.c" etc.
    My first private version would only run when compiled on a Friday.
    I decided it would be better this way...
    These restrictions have been removed for your convenience.

    The following lines describe how this program works; if you don't
    want to know it at this time, please skip them. If this entry would
    by some mistake win the contest, please do not rot13 this - I hate
    rot13'd spoilers since it is somewhat complicated on a Mac to
    reverse them. Anyone out there should have enough discipline and
    rot13 shouldn't be required, really. After all, we are no children
    anymore :-)

    This paragraph is not part of the author's comments, but is a helpful
    gift from the judges; if you read too fast to stop yourself, this should
    give you enough time to stop, which you really need to do RIGHT NOW if
    you don't want to read the spoilers, which really do spoil everything,
    we mean it.

    The source file needs to be present because the words are read from
    it. The wordlist is encoded within the source using a 24 entry
    sliding dictionary where lowercase letters are offsets into the
    dictionary, uppercase letters are new letters not yet in the
    dictionary, and all other characters are ignored. The words are
    spread over six lines in the source; decoding starts on a line
    after a tab and a whitespace have been found, and stops on a newline.
    The grin after the "Demonic Smiley" actually is one encoded letter
    while the string is completely ignored; and the "cut" in "cut here"
    is required while "here" is not.

    "For extra credit", explain why the words are sorted alphabetically
    (because I extracted them from a dictionary :-)

    The file name had to fulfill the restrictions mentioned above
    because __FILE__+1 was used as a second parameter to fopen(). (It
    essentially was fopen(__FILE__,__FILE__+1) ). This was an extra joke
    that does no longer exist in the released version.

    You probably discovered that the while(FILE) in main is not a while loop
    but the statement that opens the file and initializes the dictionary.
    Similarly, int and signed have been redefined (to save space, of
    course).

    The main function (the guessing part) is between the last #else..#endif,
    but still is declared before main(). The 5[O]() in main() calls
    this function.  Similarly, Most indexing operations have been
    changed to this form; and I tried to write each such operation
    different.
