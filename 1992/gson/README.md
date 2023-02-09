Most Humorous Output:

	Andreas Gustafsson
	Helsinki University of Technology
	Arentikuja 1 D 305			(home address)
	00410 Helsinki
	FINLAND


Judges' comments:

    To make:
	make ag
    
    Determine where your system dictionary is located.  You may find
    it located in one of the following places:

	    /usr/dict/words
	    /usr/share/lib/spell/words
	    /usr/ucblib/dict/words
	    /dev/null			<-- for machines with nothing to say
    
    Then using the proper dictionary:

        ag free software foundation	< /usr/dict/words
        ag obfuscated c contest		< /usr/dict/words
        ag unix international		< /usr/dict/words
	ag george bush			< /usr/dict/words
	ag bill clinton			< /usr/dict/words
	ag ross perot			< /usr/dict/words
	ag paul e tsongas		< /usr/dict/words

    Recently some newspapers printed amusing anagrams of one of the
    names listed above.  Run this program to find the anagrams they
    weren't allowed to print!


Selected notes from the author:

    The name of the game:
    
    AG is short for either Anagram Generator or simply AnaGram.
    It might also be construed to mean Alphabet Game, and by pure
    coincidence it happens to be the author's initials.
    
    
    What it does:
    
    AG takes one or more words as arguments, and tries to find
    anagrams of those words, i.e. words or sentences containing
    exactly the same letters.
    
    
    How to use it:
    
    To run AG, you need a dictionary file consisting of distinct words
    in the natural language of your choice, one word on each line.  If
    your machine doesn't have one already, you can make your own
    dictionary by concatenating a few hundred of your favourite Usenet
    articles and piping them through the following obfuscated shell
    script:
    
        #!/bin/sh
        z=a-z];tr [A-Z\] \[$z|sed s/[\^$z[\^$z*/_/g|tr _ \\012|grep ..|sort -u
    
    Using articles from alt.folklore.computers is likely to make
    a more professional-looking dictionary than rec.arts.erotica.
    
    AG must be run with the dictionary file as standard input.
    
    Because anagrams consisting of just a few words are generally more
    meaningful than those consisting of dozens of very short words, the
    number of words in the anagrams is limited to 3 by default.  This
    limit can be changed using a numeric command line option, as in
    "ag -4 international obfuscated c code contest </usr/dict/words".
    
    Bugs:
    
      - There is no error checking
      - Standard input must be seekable, so you can't pipe the dictionary
        into AG.
      - The input sentence and each line in the dictionary may contain
        at most 32 distinct letters, and each letter may occur at most 15
        times.
      - Words in the dictionary may be at most 255 bytes long
      - AG cannot handle characters that sign-extend to negative values
      - Although AG works on both 16-bit and 32-bit machines, 
        the size of the problems it can solve is severely limited 
        on machines that limit the stack size to 64k or less.
    
    
    Obfuscatory notes:
    
    As you can see, AG takes advantage of the new '92 whitespace rules to
    achieve a clear, readable, self-documenting layout.  The identifiers
    have been chosen in a way appropriate for an alphabet game, and common
    sources of bugs such as goto statements and malloc/free have been
    eliminated.  As AG also refrains from abusing the preprocessor, it
    doesn't really have much to offer in terms of "surface obfuscation".
    Instead, it tries to achieve both its speed and its obscurity through a
    careful choice of algorithms.  Some of the finer points of those
    algorithms are outlined in the rot-13 encoded spoiler below.
    
    How it works:  (ROT13 to read)
    
    Urer sbyybjf n qrfpevcgvba bs fbzr bs gur qngn fgehpgherf naq
    nytbevguzf hfrq ol NT.  Vg vf ol ab zrnaf pbzcyrgr, ohg vg znl uryc
    lbh trg na vqrn nobhg gur trareny cevapvcyrf.
    
    --
    
    Vagreanyyl, NT ercerfragf jbeqf naq fragraprf nf neenlf bs 32
    4-ovg vagrtre ryrzragf.  Rnpu ryrzrag ercerfragf gur ahzore bs
    gvzrf n yrggre bpphef va gur jbeq/fragrapr.  Gurer ner 32 ryrzragf
    orpnhfr 32 vf n pbairavrag cbjre bs gjb ynetre guna gur ahzore bs
    yrggref va zbfg jrfgrea nycunorgf, naq gur ryrzragf ner 4 ovgf
    rnpu orpnhfr gur fnzr yrggre vf hayvxryl gb bpphe zber guna 15
    gvzrf va n cenpgvpny nantenz trarengvba ceboyrz.
    
    Gurfr 32*4-ovg neenlf ner npghnyyl fgberq va zrzbel va n
    "ovg-genafcbfrq" sbezng, nf neenlf bs sbhe "ybat" inyhrf.  Vg vf
    nffhzrq gung n "ybat" vf ng yrnfg 32 ovgf.  Gur svefg 4-ovg yrggre
    pbhag vf sbezrq ol gur yrnfg fvtavsvpnag (2^0) ovg va rnpu bs gur
    sbhe ybatf, gur arkg bar vf sbezrq ol gur 2^1 ovgf, rgp.
    
    Guvf fgbentr sbezng znxrf vg cbffvoyr gb nqq be fhogenpg gjb fhpu
    irpgbef bs 32 4-ovg inyhrf va cnenyyry ol fvzhyngvat n frg bs 32
    ovanel shyy nqqref va fbsgjner hfvat ovgjvfr ybtvpny bcrengvbaf.
    R.t., nyy gur YFO:f bs gur erfhyg ner sbezrq va cnenyyry ol gnxvat
    gur rkpyhfvir BE bs gur YFO:f va rnpu fhzznaq, naq 32 pneel ovgf
    ner sbezrq va cnenyyry va n fvzvyne jnl hfvat n ybtvpny NAQ.
    Guhf, 32 vaqrcraqrag 4-ovg nqqvgvbaf pna or cresbezrq ol whfg sbhe
    vgrengvbaf bs n ybbc pbagnvavat fbzr 32-ovg ovgjvfr ybtvpny
    bcrengvbaf, ohg ab nevguzrgvp bcrengvbaf bgure guna gubfr vzcyvrq
    ol neenl vaqrkvat.
    
    Fhogenpgvba jbexf fvzvyneyl, naq va snpg NT bayl vzcyrzragf
    fhogenpgvba qverpgyl, unaqyvat nqqvgvba ol zrnaf bs gur vqragvgl
    n+o = n-(0-o).
    
    Va nqqvgvba gb guvf 32*4-ovg ercerfragngvba, NT nyfb sbezf n fb-pnyyrq
    "fvtangher" gung vf gur ovgjvfr BE bs gur sbhe ybatf, juvpu vf
    rdhvinyrag gb fnlvat gung gur fvtangher bs n jbeq pbagnvaf n ybtvpny 1
    va gur ovg cbfvgvbaf pbeerfcbaqvat gb yrggref bppheevat ng yrnfg bapr
    va gung jbeq.
    
    Gur svefg guvat NT qbrf vf gb pbafgehpg n ybbxhc gnoyr bs 256
    ybatf, bar sbe rnpu 8-ovg punenpgre inyhr.  Gur ragel sbe n
    punenpgre jvyy or mreb vs gung punenpgre qbrfa'g nccrne va gur
    fragrapr tvira ba gur pbzznaq yvar, be vg jvyy unir n fvatyr ovg
    frg vs gur punenpgre qbrf nccrne va gur fragrapr.  Ol nqqvat
    gbtrgure gur ovg znfxf sbe nyy gur yrggref va gur vachg fragrapr
    hfvat gur genafcbfr nqqvgvba zrgubq qrfpevorq nobir, NT sbezf gur
    32*4 ovg neenl ercerfragngvba bs gur vachg fragrapr.
    
    Gur arkg npgvba cresbezrq vf ernqvat gur qvpgvbanel.  Gubfr jbeqf gung
    pbagnva yrggref abg va gur vachg fragrapr ner vzzrqvngryl qvfpneqrq.
    Jbeqf pbagnvavat gur evtug yrggref ohg va rkprffvir ahzoref ner
    ryvzvangrq va n frcnengr purpx vaibyivat gur 32*4 ovg neenl.
    
    Gur erznvavat jbeqf, juvpu jvyy or ersreerq gb nf "pnaqvqngr jbeqf",
    ner fgberq va 32*4-ovg ercerfragngvba, gbtrgure jvgu gurve fvtangherf 
    naq bssfrgf vagb gur qvpgvbanel svyr fb gung gur cynva-grkg irefvba bs
    n jbeq pna yngre or sbhaq sbe cevagvat.  Guvf vasbezngvba vf xrcg va n
    ybpny "fgehpg" va gur qvpgvbanel-ernqvat shapgvba, naq zrzbel vf
    nyybpngrq sbe rnpu pnaqvqngr jbeq fvzcyl ol znxvat nabgure erphefvir
    pnyy gb gung shapgvba.
    
    Rnpu fgehpg fb nyybpngrq vf yvaxrq vagb n svkrq-fvmr unfu gnoyr bs
    4096 ragevrf vaqrkrq ol gur 12 ybj ovgf bs gur jbeq'f fvtangher. 
    Jura gur qvpgvbanel-ernqvat shapgvba rapbhagref raq-bs-svyr, nyy gur
    pnaqvqngr jbeqf unir orra fgberq va arfgrq npgvingvba erpbeqf ba gur
    fgnpx, npprffvoyr guebhtu gur unfu gnoyr.
    
    Trarengvat gur nantenzf vf gura qbar ol genirefvat gur unfu gnoyr naq
    fhogenpgvat gur yrggref bs rnpu jbeq va gur unfu gnoyr sebz gur
    "pheerag fragrapr", juvpu vavgvnyyl vf gur fragrapr tvira ba gur
    pbzznaq yvar.
    
    Gur fhogenpgvba vf cresbezrq va cnenyyry ba gur 4-ovg yrggre pbhagf
    nf qrfpevorq nobir, naq vs nyy 32 erfhygf ner mreb, na nantenz unf
    orra sbhaq.  Vs gur erfhyg vf artngvir sbe bar be zber bs gur yrggref
    (nf vaqvpngrq ol bar be zber "1" va n irpgbe bs 32 obeebj ovgf
    erghearq ol gur fhogenpgvba ebhgvar), gur jbeq qvq abg zngpu gur
    pheerag fragrapr naq vf vtaberq.  Svanyyl, vs gur erfhyg pbagnvarq
    bayl abaartngvir yrggre pbhagf, jr unir sbhaq n cnegvny nantenz: 
    n jbeq pbagnvavat fbzr, ohg abg nyy, bs gur yrggref va gur pheerag
    fragrapr.  Va guvf pnfr jr erphefviryl gel gb svaq na nantenz bs gur
    erznvavat yrggref.  Gur qrcgu bs gur erphefvba vf yvzvgrq gb gur
    znkvzhz ahzore bs jbeqf va gur nantenz, nf fcrpvsvrq ol gur hfre.
    
    Jura gur qrrcrfg erphefvba yriry unf orra ernpurq, na bcgvzvmngvba pna
    or nccyvrq: orpnhfr ab shegure erphefvba jvyy or qbar, gurer vf ab
    arrq gb ybbx sbe cnegvny nantenzf, naq gurersber NT bayl arrqf gb
    purpx sbe jbeqf gung pbagnva rknpgyl gur fnzr yrggref nf gur pheerag
    fragrapr.  Gubfr jbeqf pna or sbhaq fvzcyl ol vaqrkvat gur unfu gnoyr
    jvgu gur fvtangher bs gur pheerag fragrapr.
    
    Rira jura abg ba gur qrrcrfg erphefvba yriry, NT trarenyyl nibvqf
    rknzvavat nyy gur ragevrf bs gur unfu gnoyr.  Gur vqrn vf gung jr ner
    abg vagrerfgrq va unfu ohpxrgf jubfr jbeqf pbagnva nal yrggref abg
    va gur pheerag fragrapr; gurfr ohpxrgf ner rknpgyl gubfr jubfr vaqrk
    unf n ybtvpny bar va n ovg cbfvgvba jurer gur fvtangher bs gur pheerag
    fragrapr unf n mreb.  Chg nabgure jnl, jr jnag gb ybbc guebhtu bayl
    gubfr unfu ohpxrg vaqvprf "v" gung pbagnva mrebrf va nyy gur ovg
    cbfvgvbaf jurer gur fvtangher "f" bs gur pheerag fragrapr pbagnvaf
    n mreb; guvf pna or rkcerffrq va P nf (v & ~f == 0).
    
    Vg vf cbffvoyr gb ybbc guebhtu nyy fhpu ahzoref va na rssvpvrag jnl ol
    gnxvat nqinagntr bs pregnva cebcregvrf bs ovanel nevguzrgvp: ol
    sbepvat gur ovgf pbeerfcbaqvat gb mrebrf va "f" gb barf, jr pna znxr
    gur pneevrf trarengrq va vaperzragvat "v" cebcntngr fgenvtug npebff
    gubfr ovgf gung fubhyq erznva mreb.  Sbe rknzcyr, gur sbyybjvat
    cebtenz cevagf nyy gubfr 16-ovg vagrtref gung pbagnva mrebrf va nyy
    rira ovg cbfvgvbaf:
    
        znva(){vag v=0,f=0kNNNN;qb{cevags("%04k\g",v);}juvyr(v=((v|~f)+1)&f);}
    
    NT hfrf n fvzvyne zrgubq ohg jbexf va gur bccbfvgr qverpgvba, svaqvat
    gur arkg ybjre inyhr jvgu mrebrf va tvira ovg cbfvgvbaf ol cebcntngvat
    obeebjf npebff gubfr ovgf.  Fbzr nqqvgvbany nqwhfgzragf ner znqr
    gb gur unfu gnoyr vaqrk jura vavgvngvat n erphefvir frnepu, hfvat
    fvzvyne ovg-gjvqqyvat grpuavdhrf.
    
    Jurarire na nantenz unf orra sbhaq, vg vf cevagrq ol genirefvat n
    yvaxrq yvfg sbezrq ol fgehpgf va gur npgvingvba erpbeqf bs gur
    erphefvir vaibpngvbaf bs gur frnepu shapgvba, frrxvat gb gur ortvaavat
    bs gur jbeq zngpurq ol gung vaibpngvba, naq pbclvat gur punenpgref bs
    gur jbeq qverpgyl sebz fgnaqneq vachg gb fgnaqneq bhgchg.

Copyright (c) 1992, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
