# Do not read this if you want to figure it out yourself! #

The file `deobfuscated.c` is simply a pretty-printed version of
`prog.c` with the macros expanded.  It is hopefully just as
difficult to understand as the original presentation:
obfuscation is not just presentation, after all.

If you read further, the remainder talks about how the code
works.  If you want to figure it out yourself, stop reading here
and do look at `deobfuscated.c`.


## Read Dictionary ##

The program begins by reading junk ;-) from the dictionary and processing
via `D()`.  The words are stored in `t[][]`, counted by `s` and `D()` ensures
this never has buffer overflow.  Notice the swap of index and array in `s[t]`.
It also ensures only 5 letter words are selected from the dictionary,
and folds uppercase to lowercase.  Each call of `D()` handles one word.

NB: if the dictionary has, for instance, "ARRAY" and "array" and "Array",
there will be 3 copies of "array" stored in `t[][]`.
This will degrade performance and may cause a malfunction of the algorithm,
and definitely if the target word is "array".  Thus the `makefile` builds
`usdw` with capital letters removed (avoiding this problem completely).
However, if there are duplicate words in the dictionary, use another.


## User Input ##

After the dictionary is read, it is time to prompt the user for the
input guess.  This happens in `main()`.  The input buffer is the upper
half of `i.a`, which is never used (ASCII lowercase letters only).
The newline is ignored by `n - 10`, at most 11 characters (`l < j`)
can be input, and EOF terminates the input loop.

Here is the explanation of how `i.c - 97` works to get an input buffer.
Assume `struct i` has the address 1000, then `i.a` begins at 1000.
`i.b` begins at 1257.  `i.c` begins at 9*5 = 45 + 1257 = 1302.
1302 - 97 = 1205.  Therefore, the `i.c - 97` sets the input buffer at
`&i.a[205]`, ASCII lowercase input ends at `i.a[123]`, and there are
53 characters before `i.b` is overwritten - plenty of room for the user IO.
Why 97?  The expression `x - 97` is used several times in the code,
leading to some confusion on the reason for the value.

Note that this abuse is what draws a compiler complaint, requiring:

```
    -Wno-array-bounds-pointer-arithmetic
```

It is safe.  It works.  There is no problem here, but the compiler
does not know this.


## Process User Input ##

Once the user input is received, the program calls `r()`, which populates
`struct i` with the guesses.  This serves to set the patterns known
and impossible, as well as letters used and required (remember, this is
hard mode Wordle, which requires you to use all green letters in the
same place for all subsequent guesses).  `r()` returns the next word
to guess via `E()` (aka choose() - see below).

Within `r()`, it is important to understand the ASCII values for g, y and b.

```
    b 98
    g 103
    y 121
```

Within `r()`, `n` is the guessed letter, and `o` is color - 103.
If `o` is greater than zero (121-103), this guess is correct, but
incorrect location (yellow).  If it is less than zero (98-103),
this guess is not possible (black).  If it is zero (103-103),
it is the correct letter in the correct location (green).

`struct i` can be re-written this way:

``` <!---c-->
    struct {
        char black[256];    // wrong letters guessed so far
        char words[9][5];   // words used in guesses so far
        char green[5];      // correct letters (must reuse these)
        char yellow[5];     // incorrect letters (impossible positions)
        int num_guesses;
        int num_yellow;
    } i;
```

And `r()` can be rewritten:

``` <!---c-->
    char *r(char *input) {
        int num_green = 0, l = 0;

        for (int j = 0; j < 5; ++j) {
               char n = input[j];
        signed char o = input[j + 6] - 103; // j - ~5 = j - -6 == j + 6

        // if this is a correct guess
        if (o == 0) {
            i.green[j] = n;
            i.black[n] = 0; // remove this from black
            ++num_green;

        } else {
            i.words[i.num_guesses][j] = n;

            // if not already a yellow letter
            if (memchr(i.yellow, n, 5) == NULL) {
                l = n;
                if (o < 0) i.black[n] = n;  // black, impossible
                else       i.yellow[i.num_yellow++] = n;
            }
        }
        }

        // l is 0 if all letters correct, else l = n
        i.num_guesses += l > 0 ? 1 : 0;
        filter(input, num_green);
        return choose("xyzzy");
    }
```


## Filter ##

The next step is to remove the impossible words from the in-memory dictionary.
This is handled by `L()`.  `L()` iterates over all the remaining words in the
dictionary. `L()` runs a number of filters, and if the word is plausible,
it is skipped, and if impossible, the current word is replaced from the end
of the list.  This prevents holes from appearing in the dictionary, and keeps
the count accurate.  The important action is carried out in the expression
`o ? W(t[l], t[--s]) : ++l`.  That is, if `o` is true, the word is replaced
by the end of the list, else the word is skipped.  Note in particular the
expressions `--s` and `++l` (decrement and replace, or skip, respectively).

Said another way, think of `W()` as an analog of `strncpy()`.  Thus, if `o`
is true, then `strncpy(t[l], t[--s], 5)`, which overwrites the current word
with the end of the list, and decrements the number of entries.  Note the
end of the list is not `t[s]`, but `t[s-1]`, thus the pre-decrement achieves
both the desired index and decrements the count.


## Word Selection ##

After the words are filtered, then comes the hard part: selecting which word
to guess next!  This is handled by `E()`, by far the most interesting routine
in the code.

The loops in order:

    - init `c[]` with ordinal values (a-z plus 6 slop) in the lower 5 bits
    - in the higher order bits, count the frequency of all remaining letters
    - sort by the frequency of letters in 3 sets of 7 (21 not 26!)
    - merge the separate sorts into one via `v()` (see below on merging)
    - for letters with same freq, re-sort by English frequency values `l()`
    - using the sorted list, put the corresponding ordinals into `b[]`
    - for each word, if scores below 97, put into `e[][]` (low score wins)
    - allow up to 5 duplicate scores, only keep first 5 words with same score
    - search the list for the lowest scoring word (best match)
    - if more than 2 words remain, find first word without duplicate letters
    - return whatever we found, if anything

The weakness in this scheme is at least two-fold: 1) if there are more than 5
words with the same score, words that come later are not selected, and 2) all
words with the same score are considered the same, without regard to letter
order or letter frequencies.  I have run no experiments here,
but I think this is an area for minor improvement.


## Network Sort ##

Network sort[1] is a simple, compact, constant time sort with minimal compares.

It is obfuscated in a number of ways.
The routine `S()` looks into the array `a[]` and determines the number of
elements to sort via the differences in the initial values of `a[]`.
Consider the possible number of values given in `O` from 0 (zero) to 7:
if `O` is 0 or 1, no sort is necessary (an empty list cannot be sorted,
and a list of one does not need to be sorted):

```
     O+1     O
    a[1] - a[0] =  9 - 9 = 0
    a[2] - a[1] =  9 - 9 = 0
    a[3] - a[2] = 10 - 9 = 1
```

If `O` is 2, then only one compare and swap is necessary.  Why is this?
Consider how many compares are necessary to determine the proper order of
variables A and B: one test and one possible swap are all that is needed.
If A > B, swap.  If A <= B, then no swap and the list is already ordered.

Where is this calculation done?  Address arithmetic FTW!
`e = a[-~O] + s - a[O]`.  `-~O` is the identity `O+1`.
So this expression restated is `e = s + a[O+1] - a[O]`.
If you look at the first numbers in `a[]` and their offsets (table 1):

```
    table 1
    offsets: 0  1  2  3  4  5  6  7  8
    values : 9  9  9 10 13 18 27 39 55
```

You can see the expression selects for O in 0..7 (table 2):

``` <!---c-->
    // table 2
    a[0+1] - a[0] = 9  - 9  = 0     // 0 selects no compares
    a[1+1] - a[1] = 9  - 9  = 0     // 1 selects no compares
    a[2+1] - a[2] = 10 - 9  = 1     // 2 selects 1 compare
    a[3+1] - a[3] = 13 - 10 = 3     // 3 selects 3 compares
    a[4+1] - a[4] = 18 - 13 = 5     // 4 selects 5 compares
    a[5+1] - a[5] = 27 - 18 = 9     // 5 selects 9 compares
    a[6+1] - a[6] = 39 - 27 = 12    // 6 selects 12 compares
    a[7+1] - a[7] = 55 - 39 = 16    // 7 selects 16 compares
```

What are we comparing?  `s` ranges from `&a[a[O]]` to `&a[a[O+1]]`.

```
    O   expr
    0   9  - 9  =  0: no compares
    1   9  - 9  =  0: no compares
    2   10 - 9  =  1: &a[a[9]]  + 1  or the set { 1 }
    3   13 - 10 =  3: &a[a[10]] + 3  or the set { 18, 2, 1 }
    4   18 - 13 =  5: &a[a[13]] + 5  or the set { 1, 35, 2, 19, 18 }
    ...
    7   55 - 39 = 16: &a[a[39]] + 16 or the set
        { 18, 52, 86, 2, 53, 70, 1, 69,
              38, 4, 21, 3, 37, 19, 36, 35 }
```

So what do these numbers mean for sorting?  Translate them to hex:

``` <!---c-->
        { 0x12, 0x34, 0x56, 0x02, 0x35, 0x46, 0x01, 0x45,
          0x26, 0x04, 0x15, 0x03, 0x25, 0x13, 0x24, 0x23 }
```

This compact arrangement can be split into high and low nibbles:

```
        { (1,2), (3,4), (5,6), (0,2), (3,5), ... }
```

which means compare and maybe swap (keeping order low to high):

``` <!---c-->
    if (s[1] > s[2]) swap();
    if (s[3] > s[4]) swap();
    if (s[5] > s[6]) swap();
    if (s[0] > s[2]) swap();
    if (s[3] > s[5]) swap();
    ....
```

For instance, when sorting 7 elements, start from `a[a[7]]` (39) until
`a[a[8]]` (55), or 16 elements starting at `a[39]`.

[1]: https://en.wikipedia.org/wiki/Sorting_network


## The Array a[] Explained, Finally ##

The first set of 9 numbers are both the lengths AND the start and end indexes
into the array `a[]`, as explained above in the Network Sort.  The second set
of numbers runs from indexes 9 through 54, and are the Network Sort comparison
values.  At index 55 begins the third part of the array.  The final 26 values
encode the inverse frequency of letters in the English language.  The first
value is 25 for the letter 'a'.  If you count, then 26 is for the letter 'e',
the most common letter in the English language
(or at least for the dictionary used).

This final set of letters is used in the routine `l()`.  Notice the expression:
`a[f[j] + a[~-9]]`; `a[~-9]` is an obscure way of writing `a[8]`, which is the
value 55.  So `a[f[j]]` is an index into this frequency array, offset by 55.
Why is there a `<< 5`?  Again, the letter offsets are in the lowest 5 bits,
and the counts of the letters is in the upper bits.

The reason for putting the counts in the upper bits is simple: it makes the
value larger for larger counts.  Thus, sorting based upon frequency is natural.


## Merge Sort ##

The network sort as implemented handles up to 7 letters in 3 calls.
26 / 7 = 3 r 5.  Thus, we need to merge up to 4 sets of 7 letters.
This merge is handled by `v()`, which calls `o()` 3 times, once recursively.
This is followed by a rearrangement handled in `l()`.  This last step finds
all the letters with the same frequency, then sorts them according to their
English frequency.

Back to the merge sort, which is really handled in `o()`.  This is rather
difficult to follow.  The first call to `o()` is within the argument list
to the second call.  The first call has arguments
W=0, O=1, R=0, D=a, L=w, E=k; and `v()` was called with `v(l=7, w=b, k=c)`.
This first merge pass copies to: `L[R]` (`b[0]`) and selects from either
`c[o]` or `c[w]` depending upon which is greater or equal.  That is, it merges
two 7 letter arrays into a single 14 element array twice, then it merges two 14
element arrays into a single 28 element array.  Note on the third call
to `o()`, the last two arguments are swapped, which puts the final sort
into `c[]`.

Below is a hopefully easier way to read the merge sort code:

``` <!---c-->
    // merge residual
    int e(int mult_o, int start, int to, int off, int *a1, int *a2)
    {
        for (; start < off; )
            a1[to++] = a2[start++ + off * mult_o];
        return to;
    }

    // merge sort
    int o(int mult_o, int mult_w, int to, int len, int *a1, int *a2)
    {
        // first call: mult_o = 0, mult_w = 1, to = 0, len = 7, a1=b, a2=c
        // second:     mult_o = 2, mult_w = 3, to = N, len = 7, a1=b, a2=c
        // third:      mult_o = 0, mult_w = 1, to = 0, len = 14, a1=c, a2=b

        int o = 0, w = 0;
        for (; o < len && w < len; ) {

        // first call: to=0, len=7, mult_o=0, mult_w=1
        // a1[0++] = a2[0 + 7*0] >= a2[0 + 7*1]
        //      ? a2[0 + 7*0] : a2[0 + 7*1]
        // a1[0++] = a2[0] > a2[7] ? a[0++] : a2[7++]

        // second call: to=14, len=7, mult_o=2, mult_w=3
        // a1[14++] = a2[0 + 7*2] >= a2[0 + 7*3]
        //      ? a2[0 + 7*2] : a2[0 + 7*3]
        // a1[14++] = a2[14] > a2[21] ? a2[14++] : a2[21++]

        // third call: to=0, len=14, mult_o=0, mult_w=1
        // a1[0++] = a2[0 + 14*0] >= a2[0 + 14*1]
        //      ? a2[0 + 14*0] : a2[0 + 14*1];
        // a1[0++] = a[0] >= a2[14] ? a2[0++] : a2[14++]

        a1[to++] = a2[o + len * mult_o] >= a2[w + len * mult_w]
            ? a2[o++ + len * mult_o]
            : a2[w++ + len * mult_w]
        }
        int n = e(mult_o, o, to, len, a1, a2);
        return  e(mult_w, w, n,  len, a1, a2);
    }
```

Isn't that as clear as mud?  It is far easier to understand the flow when
you add `printf()` statements to follow the logic.  Included is the file
`deobfuscated.c` for you to start with.


## Why name the functions as they are? ##

Run `make spoiler`.


## Bug Explained ##

If you followed the above explanation, you will notice that only the first
21 of 26 letters are sorted (ignoring { v, w, x, y, z }.  But 28 of 26 letters
are merge sorted.  It was observed the program performs worse if all 26 letters
are sorted (which tends to over-favor `y`).
But some words do have `y` in them, which is why the merge sort takes 28
letters (including the ASCII values `{` and `|`), so all letters are still
selected when appropriate.  The merge sort puts the { v, w, x, y, z }
letters into the proper frequency set, eventually.

If you change the loop value `22` to `32`, then all letters are sorted,
the program will work correctly, but it will change the performance
of the algorithm to be slightly worse than the original.

If you change any values in the array `a[]`,
the program will no longer work correctly.

Finally, what is the significance of the array size 78557?
`usdw` only needs 8506.  Why was such a large value used?
