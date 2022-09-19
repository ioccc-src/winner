Grand Prize:

    Brian Westley (Merlyn LeRoy on usenet)
    DigiBoard, Inc.
    1026 Blair Ave.
    St. Paul, MN  55104  USA


Judges' comments:

    Make and run as follows:

	make westley
	westley [move_location] | tee nextmove.c
    
    where the 'move_location' is a digit from 1 to 9 that represents
    a move on a tic-tac-toe board:

		1 2 3
		4 5 6
		7 8 9

    If you omit 'move_location', then the computer moves first.  For your 
    next move, recompile nextmove.c and play it again:

	make nextmove
	nextmove move_location | tee nextmove.c

    We have provided the shell script, ttt, to make it easier to play the game:

	make ttt
	ttt [first_move]	<- omit first arg to have it move first
	ttt next_move

    The shell script determines when the game is over, and automatically 
    replaces merlyn.c with an improved version after a loss.  The ttt script 
    has two other modes:

	ttt quitgame	<- cancel any game in process, revert to merlyn.c
	ttt clobber	<- remove all game files, revert to original source
 
    Try not to cheat, the computer has not learned how to catch you doing it.


Selected notes from the author:

    A tic-tac-toe self-modifying program that "learns".  This C program
    plays standard tic-tac-toe on itself.  The code is written as a
    tic-tac-toe grid; moves are carried out within the code.

    The human is X, the computer 0 [sic, "zero", not letter "O"].

    The program, when run, reproduces itself with both the player's
    move and the computer's move added.  Recompile THIS program (using
    the same compile line) and repeat until the game is finished.

    If the computer wins, the "straight face" in the upper right-hand
    corner ":-|" will change into a happy face ":-)".  If it is a draw,
    the face does not change.  If the computer loses, the board is
    blanked and the face changes into a sad face ":-(".  If this
    happens, the blank board should replace the original program; the
    computer changes its play and will continue to do so until it no
    longer loses games.

    If you want a program that never loses, simply replace the string
    "9999999999  :-| " with "9883857753  :-| ".

    How It Works (rot13 to read)
    ----------------------------

    Gur iregvpny "onef" bs gur tevq ner vqragvpny shapgvbaf, jvgu gur
    anzr bs gur shapgvba nf n(), o(), be p().  Nsgre rnpu shapgvba vf
    pnyyrq, gur tybony inevnoyrf K naq B pbagnva ovgznfxf bs jurer nyy
    gur Kf naq Bf ner cynprq.  Gur fgngrzrag:

	K=-   <pune>   -1;

    rinyhngrf gb 1, -1, be -2 jura K vf 1 naq <pune> vf bar bs "K",
    "0", be " ".  Gur shapgvba F(&K) frgf gur nccebcevngr ovgf va
    (tybony ine) K naq B naq erfrgf gur inyhr bs &K gb 1.  Guvf vf ubj
    gur pheerag cbfvgvba vf pbzchgrq.

    Gur cynlre'f zbir vf BE'q vagb gur K znfx, naq (vs vg vf gur
    bcravat zbir) gur fgengrtl fgevat'f svefg punenpgre vf frg gb gur
    cynlre'f svefg zbir (be "5" vs gur pbzchgre zbirf svefg).

    Gur rinyhgvba shapgvba l(Z) purpxf vs gur znfx unf n jvaavat
    cnggrea (nal bs gur svefg rvtug ovgznfxf bs gur j[] neenl), naq
    frgf gur inevnoyr d gb 0 vs vg qbrf.

    Gur cynlre'f zbir vf rinyhngrq gb frr vs gur uhzna unf jba.  Gur
    fzvyrl vf frg gb :-) be :-( qrcraqvat ba guvf.  Nyfb, vs gur uhzna
    unf jba, gur qvtvg va gur fgengrtl fgevat vf qrperzragrq gb punatr
    gur pbzchgre'f cynl sbe arkg tnzr.

    Vs gur uhzna unf ABG jba, gur r(A,Z) shapgvba rinyhngrf vs NAL zbir
    abg va znfx A pna cebqhpr n jva va znfx Z.  Gur svefg rinyhngvba
    r(K,B) purpxf vs B pna znxr n yrtny jvaavat zbir.  Vs fb, gur
    pbzchgre unf n jvaavat zbir naq znxrf vg.  Vs abg, gur fzvyrl vf
    frg gb :-|, naq n aba-jvaavat zbir vf trarengrq.

    N aba-jvaavat zbir svefg purpxf vs K pna jva va bar zbir; vs fb,
    guvf zbir vf fryrpgrq, oybpxvat gur jva.  Bgurejvfr, n zbir vf
    trarengrq ol ybbxvat qbja gur yvfg bs "zbir grzcyngrf".  Gur svefg
    zbir grzcyngr gung trarengrf n zbir gung vf ABG nyernql bpphcvrq ol
    na K be B vf erghearq.

    Gur "zbir grzcyngrf" ner fgngvp gvp-gnp-gbr cbfvgvbaf gung trarengr
    cbffvoyr zbirf ol znxvat gur r() shapgvba erghea "jvaavat" zbirf,
    r.t. gur grzcyngr:

	. . .
	B , B    (guvf vf gur inyhr 40; 2^3+2^5)
	. . .    ("B"f ner 1 ovgf, "." naq "," ner 0 ovgf)

    ...jvyy znxr gur r() shapgvba erghea n pragre zbir, nf
    guvf vf gur bayl zbir gung cebqhprf guerr va n ebj.  Abgvpr gung
    gur pbzchgre qbrf abg pbafvqre juvpu pryyf pbagnva Kf naq Bf jura
    znxvat n grzcyngr zbir, bayl juvpu pryyf ner rzcgl naq abg-rzcgl.
    Guvf znxrf sbe hahfhny cynl.

    Gur grzcyngrf ner pnershyyl pubfra gb riraghnyyl oybpx nyy gencf
    gung K pna gel, ol whfg oyhaqrevat va gur jnl.

    Nyfb abgr gung gur jvaavat & fgengrtl grzcyngrf ner cneg bs gur
    pbzcvyr yvar, znxvat vg cbffvoyr gb punatr gur ehyrf bs gur tnzr ol
    punatvat gur pbzcvyr yvar.

    Gur grzcyngrf ner:

	B , B
	, , ,
	B , B

	, . .
	. B .
	. . B

	. . .
	B , B
	. . .

	. . .
	B B ,
	. . .

	. . .
	B , B
	. . .

	. , ,
	. B .
	B B ,

	B , B
	, , .
	B . .

	, . B
	B , B
	B . ,

	B . ,
	B , B
	, . B

	B , B
	, , ,
	B , B

    N qvtvg bs "9" zrnaf fgneg jvgu gur svefg grzcyngr, "8" fgnegf ng
    gur frpbaq, rgp.  Gur grzcyngrf ner fpnaarq hagvy n yrtny zbir vf
    sbhaq.  N grzcyngr vf fpnaarq sebz obggbz gb gbc, evtug gb yrsg
    (v.r.  zbir 9 vf grfgrq svefg, gura 8, qbja gb zbir 1).

Copyright (c) 1991, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
