# Best Abuse of the C Preprocessor

	David Goodenough
	anonymous organization
	541 Commonwealth Ave,
	Newton, MA 02159
	USA

## To build:

        make all

	NOTE: This entry may not compile when using modern compilers.

### To run

	echo "to C or not to C" | ./dg

## Judges' comments

    Some C preprocessors got confused about single quotes in certain cases.
    In particular, the following source line:

       b12(ase(bco(acp(bi(acp(bcp(acp(bpl(aqu(bqu(A))))))))))))))))))))))))))))))

    sometimes has to be changed to:

       b12(ase(bco(acp(bi(acp(bcp(acp(bpl('A'))))))))))))))))))))))))))))

    if the C preprocessor botches single quotes in cpp expansions, which we have
    done for the wider audience.


## Author's comments

    If my preprocessor could hack it, I could write this as one single
    line rather than 4, but when I do that I get a complaint "defines
    nested too deeply".

    Spoiler: (rot13 to read)

    Guvf vf nabgure ebg13 wbo (oryvrir vg be abg) - gur #qrsvarf ner n
    abiry jnl bs nqqvat gbxraf: '#qrsvar o12(k) 12 k' zrnaf gung ng
    fbzr cbvag va gur fbhepr n 12 vf sbyybjrq ol gur pbzcerffrq arfgrq
    qrsvarf. Gur o12 trgf gur cerivbhf pbzcerffvba nf na nethzrag, naq
    cercraqf gur 12, guhf znxvat nabgure fgrc va gur erperngvba bs gur
    fbhepr. Gur nkk() qrsvarf qb gur fnzr, ohg nqq gbxraf nsgre.

    Nf sbe gur ebg13 nytbevguz, vg eryvrf ba vaqrk() gb svaq vs gur
    punenpgre vf va gur frg N-Mn-m. y[] vf na neenl gung trgf svyyrq
    jvgu:

    "abcdefghijklmmmmnopqrstuvwxyzzzzABCDEFGHIJKLMMMMNOPQRSTUVWXYZZZZ"

    Vs vaqrk() fnlf gur pune vf va gur nycunorg, gura kbe gur bssfrg
    jvgu 16 gb genafyngr, naq bhgchg, bgurejvfr cnff vg hapunatrq.

Copyright (c) 1990, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
