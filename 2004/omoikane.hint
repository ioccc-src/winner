Best Utility:

    Don Yang
    259 E. Bellbrook St.
    Covina, CA 91722
    USA

    http://uguu.org/


Judges' Comments:

    To build:

	make omoikane

    Try:

	./omoikane omoikane.info omoikane.info omoikane.output

    For extra credit, spot the checksum in the source file itself.
    What makes this one particularly interesting is that the checksum,
    strictly speaking, isn't being computed at all.  Rather, the file
    is modified to have the desired checksum!  This does, we suppose,
    solve the problem that inserting a checksum would change the file's
    checksum; if you have to change it, you might as well change it!

    This program was submitted under the name "Rinia", so the Author's
    Comments refer to it as such.


Selected Author's Comments:

  Rinia (1/14/04)

  Rinia is a tool for embedding CRCs in text files.  No need to assign
  strange file names or package .SFVs with your files!  Rinia will
  insert a human-readable checksum string in the text itself!  ^_^

  0. Usage                                                                   `

     rinia <infile> <layout> <outfile>

     All three arguments may reference the same file.  All files is
     assumed to be of ASCII character set.

  1. Input                                                                   %

     Any file larger than 8 bytes is valid.  Upper limit on file size is
     limited by memory.

     If input file can't be loaded for any reason, Rinia will say "bad
     input" and exit immediately.

  2. Layout                                                                  _

     The layout file contains a map of where Rinia can patch.  The
     content consists of marker characters (where Rinia is allowed to
     change in the original text) and other characters (where the
     original text will stay as is).  Rinia will select the marker
     character using these heuristics:

     1. Ignore all space/control/extended characters.
     2. Select characters that appeared 8 times in a row.
     3. Of those selected characters, pick one with the lowest
        frequency.

     One way to create the layout file is to make a copy of the original
     file, replace where you want Rinia to match with a rare character,
     then replace the remaining ones with space.  Often it's possible to
     write the original file in such a way that it can be used as a
     layout.

     Example file/layout:

        file:                layout:
           crc = ########       ... . XXXXXXXX
           patch = ######       ..... . XXXXXX
           other text here      ..... .... ....

     And Rinia may generate a file similar to this:

        crc = 1bad73cf
        patch = #FR-QQ
        other text here

     Note that the original file by itself is a valid layout file, since
     Rinia will recognize that only # marks enough space to hold the
     checksum, and has the lowest frequency.

     If layout file can't be used for any reason, Rinia will say "bad
     layout" and exit immediately.

  3. Output                                                                  m

     If Rinia finds a usuable checksum, she will say "OK." and write to
     the specified output file.  Otherwise the exit message is "fail"
     and nothing is written.

     Chances of success and how long it takes to run to completion is
     completely dominated by the layout file design.  In general, Rinia
     runs faster if the checksum is placed before the other marker
     characters rather than after, e.g.:

         a: X X XXX      b: XXXXXXXX     c: XXXXXXXX
            XXXXXXXX        X X XXX         XXXXX

     "a" usually takes the longest time, while "c" usually is the
     fastest.

     That said, each run is randomized with respect to system time, so
     it's not always certain whether Rinia will succeed in a short time
     or not.  In general, 5 marker characters is sufficient, and takes
     a few minutes.

     For reference, rinia.c was produced on a 1.7GHz machine (the
     checksum is at line 17).  Out of 25 runs, the shortest was 2
     seconds while the longest took 5 minutes.  Average was about a
     minute.  Checksum for this file (b7a81524) took about 4 minutes.

  4. Algorithm                                                               3

     Inserting a checksum in the file you are computing the checksum of
     isn't quite trivial, since changing the file content would change
     the final checksum value.

     To insert the checksum, Rinia first assumes a random final
     checksum, insert that string, then modify other parts to compensate
     for the change in content.

     The compensation bytes are very easy to compute for binary files
     with enough consecutive scratch areas, but for text files with
     non-consecutive areas and limited degrees of freedom, Rinia has to
     try out all character combinations.  This is done in a hierarchical
     fashion, computing only smallest partial checksum after each
     change.

     For computers few years ago, this is probably still too slow to be
     acceptible... but at the speed the IOCCC judges run the contest
     these days, I am sure you have enough patience for it ^_^;

  5. Source code                                                             =

     rinia.c should compile anywhere (but with a few warnings).  I don't
     have a big-endian machine to test but Rinia should work there as
     well.  ASCII character set required though.

     Code is formatted to the shape of "Rinia" from the anime/game
     "Moekko Company".  Of course at 90x50 it's hard to recognize anything
     ^_^;

     Rinia is the slow but hardworking android.  On some jobs she does
     very well, on others she would spend lots of time and effort but
     still fail...

  (text above is also included as an info file, so that the checksum
  would match)
