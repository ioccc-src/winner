## To build:

``` <!---sh-->
    make
```

There is an alternate version provided. See [Alternate code](#alternate-code)
below.


## To use:

``` <!---sh-->
    ./prog file1 file2

    ./prog -d file1 file2
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

This alternate version does not use a 64-bit FNV hash. This was the original
entry but was changed to be the alt version.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `prog.alt` as you would `prog` above.


## Judges' remarks:

This is the best use of the FNV that we have seen in the IOCCC so far!
The output, when used without `-d`, is compatible with POSIX `diff(1)` and
is suitable for use with `patch(1)`.

We welcome back Canada to the list of nations from where winning
entries have been submitted.

Is this code a bug or a feature? :-)  Or is this an attempt to corrupt the
programming of our youth?  Should we heed Kyle's mom words that she uttered
during a South Park P.T.A. Meeting?

   "We must stop dirty (C) language from getting to our children's ears!"

   [Blame Canada](https://www.youtube.com/watch?v=bOR38552MJA)

Or should we teach our youth to understand the intricacies of this code?
Ying Tong Iddle I Po!  We suggest you read the source for yourself, which
might be easier than the academic papers it was inspired by.

NOTE: Unlike the original entry source, [prog.alt.c](%%REPO_URL%%/2015/howe/prog.alt.c),
[prog.c](%%REPO_URL%%/2015/howe/prog.c) uses a
64 bit FNV hash and fixes a function call warning.


## Author's remarks:

### Features

* "An O(NP) Sequence Comparison Algorithm" by Wu, Manber, Myers, Miller.

* Output compatible with `patch(1)`.

* Strokes one of the judge's ego (I couldn't email chocolate or curry).


### Description

This is a functioning micro `diff(1)` tool using an [O(NP) algorithm][Wu+89],
compared to the older [O(ND) difference algorithm][Mye86] used by some versions
of `diff(1)`.  Its output is based on the default `diff(1)` output described by POSIX
and [the Open Group Base Specifications][SUSV7].  The output is suitable for use
with `patch(1)`.

The `-d` option simply writes the edit distance between `file1` and `file2`.


### Observations

The FNV1a hash is a little slow compared to the trivial hash [GNU
diff](https://www.gnu.org/software/diffutils/) uses. I downloaded a plain text
copy of "War And Peace" from [Project Gutenberg](https://www.gutenberg.org),
used [makeholes.c](%%REPO_URL%%/2015/howe/makeholes.c) to make 1000 random changes, then profiled and
timed the program verses GNU `diff(1)`.  The bottleneck appears to be in the
file I/O and line hashing with an average +0.05s slower.  Using a huge file like
"War And Peace" for testing offsets the `diff(1)` optimised file I/O.

There is no hash collision checking, partly because FNV1a appears to generate
very [few collisions][HshCmp] and an assumption that localised collisions within
a region of edits are highly unlikely.


### Support Files

* [prog-test.sh](%%REPO_URL%%/2015/howe/prog-test.sh)
    Basic test program verifies known test edit distances and `patch(1)` support.

* [avgtime.sh](%%REPO_URL%%/2015/howe/avgtime.sh)

* [makeholes.c](%%REPO_URL%%/2015/howe/makeholes.c)
    Random edits (holes) made to a file in-place.

### References

Wu, Manber, Myers, and Miller; August 1989;<br>
"An O(NP) Sequence Comparison Algorithm";<br>
<http://myerslab.mpi-cbg.de/wp-content/uploads/2014/06/np_diff.pdf>

Fowler, Noll, Vo; 1994<br>
<http://www.isthe.com/chongo/tech/comp/fnv/index.html>

Fowler, Noll, Vo on Wikipedia<br>
<https://en.wikipedia.org/wiki/Fowler%E2%80%93Noll%E2%80%93Vo_hash_function>

"diff", The Open Group Base Specifications Issue 7<br>
IEEE Std 1003.1, 2013 Edition<br>
<http://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html>

Eugene W. Myers; "An O(ND) Difference Algorithm and Its Variations";<br>
Algorithmica, 1986, pages. 251-266<br>
<http://www.xmailserver.org/diff2.pdf>

Webb Miller and Eugene W. Myers; "A File Comparison Program";<br>
Software-Practice And Experience, Vol. 15(11). 1025-1040 (November 1985)<br>
<http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.189.70&rep=rep1&type=pdf>

D.S. Hirschberg, "A linear space algorithm for computing maximal common subsequence problem";<br>
Comm. of ACM, Vol. 18, June 1975, pages 341-343<br>
<http://www.mathcs.emory.edu/~cheung/Courses/323/Syllabus/DynProg/Docs/Hirschberg-LCS-1975.pdf>

Which hashing algorithm is best for uniqueness and speed?<br>
<http://programmers.stackexchange.com/questions/49550/which-hashing-algorithm-is-best-for-uniqueness-and-speed>

[Wu+89]: http://myerslab.mpi-cbg.de/wp-content/uploads/2014/06/np_diff.pdf

[FNV94]: http://www.isthe.com/chongo/tech/comp/fnv/index.html

[FNVWi]: https://en.wikipedia.org/wiki/Fowler%E2%80%93Noll%E2%80%93Vo_hash_function

[Mye86]: http://www.xmailserver.org/diff2.pdf

[SUSV7]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html

[Mil85]: http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.189.70&rep=rep1&type=pdf

[Hir75]: http://www.mathcs.emory.edu/~cheung/Courses/323/Syllabus/DynProg/Docs/Hirschberg-LCS-1975.pdf

[HshCmp]: http://programmers.stackexchange.com/questions/49550/which-hashing-algorithm-is-best-for-uniqueness-and-speed

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
