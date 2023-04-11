# Grand Prize:

Brian Westley (Merlyn LeRoy on usenet)  
DigiBoard, Inc.  
1026 Blair Ave.  
St. Paul, MN  55104  
USA   
<http://www.westley.org>  

## To build:

```sh
make all
```

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed a segfault in
this program which prevented it from working. The problem was the read-only
char array `char *z[]` was being written to. The fix was to change it to `char
z[][100]` in two spots (see if you can determine why two places, not one!). Why
100 when the longest string is < 100? Because a shorter value caused strange
output and it's easier to just choose a larger value that works without having
to find the correct value. Thank you Cody for your assistance!

## To run:

Make and run as follows:


```sh
./westley [move_location] | tee nextmove.c
```

where the `move_location` is a digit from 1 to 9 that represents
a move on a tic-tac-toe board:

		1 2 3
		4 5 6
		7 8 9

If you omit `move_location`, then the computer moves first.  For your 
next move, recompile `nextmove.c` and play it again:

```sh
make nextmove
./nextmove move_location | tee nextmove.c
```

## Try:

We have provided the shell script, [ttt](ttt.sh), to make it easier to play the game:

```sh
make ttt
./ttt [first_move]	# <- omit first arg to have it move first
./ttt next_move

```
  
The shell script determines when the game is over, and automatically 
replaces `merlyn.c` (copied from [westley.c](westley.c) with an improved version after a loss.  The [ttt](ttt.sh) script 
has two other modes:

```sh
./ttt quitgame	# cancel any game in process, revert to merlyn.c
./ttt clobber	# remove all game files, revert to original source
```

For example here is a potentially losing game:

```sh
./ttt 1
./ttt 4
./ttt 6
```

The final might look like:


```c
		a(X){/*/X=-		a(X){/*/X=-
	X	-1;F;X=-	 	-1;F;X=-
		-1;F;}/*/		-1;F;}/*/
char z[][100]={"char z[][100]={","a(X){/*/X=-","-1;F;X=-","-1;F;}/*/","1999999999  :-) ",
"int q,i,j,k,X,O=0,H;S(x)int*x;{X+=X;O+=O;*x+1?*x+2||X++:O++;*x=1;}L(n){for(*",
"z[i=1]=n+97;i<4;i++)M(256),s(i),M(128),s(i),M(64),N;X*=8;O*=8;}s(R){char*r=z",
"[R];for(q&&Q;*r;)P(*r++);q&&(Q,P(44));}M(m){P(9);i-2||P(X&m?88:O&m?48:32);P(",
"9);}y(A){for(j=8;j;)~A&w[--j]||(q=0);}e(W,Z){for(i-=i*q;i<9&&q;)y(W|(1<<i++&",
"~Z));}R(){for(k=J[*J-48]-40;k;)e(w[k--],X|O);}main(u,v)char**v;{a(q=1);b(1);",
"c(1);*J=--u?O?*J:*v[1]:53;X|=u<<57-*v[u];y(X);K=40+q;q?e(O,X),q&&(K='|'),e(X",
",O),R(),O|=1<<--i:J[*J-48+(X=O=0)]--;L(q=0);for(s(i=0);q=i<12;)s(i++),i>4&&N",
";s(q=12);P(48);P('}');P(59);N;q=0;L(1);for(i=5;i<13;)s(i++),N;L(2);}",0};
		b(X){/*/X=-		b(X){/*/X=-
	X	-1;F;X=-	 	-1;F;X=-	X
		-1;F;}/*/		-1;F;}/*/
int q,i,j,k,X,O=0,H;S(x)int*x;{X+=X;O+=O;*x+1?*x+2||X++:O++;*x=1;}L(n){for(*
z[i=1]=n+97;i<4;i++)M(256),s(i),M(128),s(i),M(64),N;X*=8;O*=8;}s(R){char*r=z
[R];for(q&&Q;*r;)P(*r++);q&&(Q,P(44));}M(m){P(9);i-2||P(X&m?88:O&m?48:32);P(
9);}y(A){for(j=8;j;)~A&w[--j]||(q=0);}e(W,Z){for(i-=i*q;i<9&&q;)y(W|(1<<i++&
~Z));}R(){for(k=J[*J-48]-40;k;)e(w[k--],X|O);}main(u,v)char**v;{a(q=1);b(1);
c(1);*J=--u?O?*J:*v[1]:53;X|=u<<57-*v[u];y(X);K=40+q;q?e(O,X),q&&(K='|'),e(X
,O),R(),O|=1<<--i:J[*J-48+(X=O=0)]--;L(q=0);for(s(i=0);q=i<12;)s(i++),i>4&&N
;s(q=12);P(48);P('}');P(59);N;q=0;L(1);for(i=5;i<13;)s(i++),N;L(2);}
		c(X){/*/X=-		c(X){/*/X=-
	0	-1;F;X=-	0	-1;F;X=-	0
		-1;F;}/*/		-1;F;}/*/

ttt: I win!
```


## Judges' remarks:

Can you figure out why the board looks different than the
[westley.c](westley.c)?

What happens if you make a move already made?

Now go try and draw or better yet win!
Why is win better than draw? Because everyone knows how to draw:

> Professor Falken: Did you ever play tic-tac-toe?
> Jennifer Mack: Yeah. Of course.
> Falken: But you don't any more.
> Jennifer: No.
> Falken: Why?
> Jennifer: Because it's a boring game. It's always a tie.
> Falken: Exactly. There's no way to win. The game itself is pointless. But back
at the [International Obfuscated C Code Contest judges'
room](https://www.ioccc.org/https://www.ioccc.org/judges.html) they believe that
you can win tic-tac-toe, that there can be acceptable draws.

Try not to cheat, the computer has not learned how to catch you doing it.

## Author's remarks:

A tic-tac-toe self-modifying program that "learns".  This C program
plays standard tic-tac-toe on itself.  The code is written as a
tic-tac-toe grid; moves are carried out within the code.

The human is `X`, the computer `0` [sic, "zero", not letter "O"].

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
`"9999999999  :-| "` with `"9883857753  :-| "`.

### How It Works (rot13 to read):


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

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
