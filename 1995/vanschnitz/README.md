Worst Abuse of the C Preprocessor:
and Most Likely To Amaze:

    Mark Schnitzius & David Van Brackle
    ISX Corporation
    1165 Northchase Parkway
    Suite 120
    Marietta, GA  30067 
    USA


Judges' comments:

    To use:
	make vanschnitz

    Try:
	vanschnitz

    For a good time, try:

	rm -f vanschnitz
	make vanschnitz LEVEL=8

    Warning: Values of LEVEL>8 have been known to cause compilers
    (and in one case a system) to crash during compilation.

    For a bad/slow time try LEVEL=15.

Selected notes from the authors:

    A classic problem in computer science is known as the Towers
    of Hanoi.  It involves a set of different-sized disks mounted
    on one of three pegs.  The object is to move the pile of disks
    to one of the other pegs.  You may only move one disk at a
    time, and there is an additional constraint that a disk may
    never be placed on top of a smaller disk.

    Our program solves the Towers of Hanoi problem.  Well, that's
    not exactly true; actually, it's the compiler that solves the
    problem.  The resulting program just prints out the correct 
    solution.

    How do you trick a compiler into actually solving the problem?
    First, you must tell it how many disks you wish to solve it
    for.  This is done by defining the symbol 'n' on the compile
    line.  For instance, to cause the compiler to solve the Towers
    of Hanoi problem with four disks, you would compile the program
    like this:

        gcc hanoi.c -o hanoi -Dn=4

    A default value of 5 will be used for n if you do not define
    it on the command line.  The value of n cannot be greater than
    fifteen (the compiler we used to test has a limit on the #include
    depth).  The compiler then solves the problem using binary 
    arithmetic based on whether particular symbols are defined or not.
    
    To loop, the program #include's itself.  This is, of course,
    expensive; one compile we did with n=14 took about fifty
    minutes to compile on our system (compiling with n=15
    caused our system to crash).

    The resulting program that the compiler generates simply
    prints out the answer.  Did I say "simply"?  Actually, the
    whole resulting program consists of a single printf statement,
    consisting of a massive string constant of length 35*(2^n-1),
    followed by 3*(2^n-1) integers which get formatted into the
    string.  For our n=14 run, this adds up to a string constant
    of length 573405, followed by 49149 integers delimeted by
    commas.  (Generating the string constant depends on the
    ANSI C feature in which adjacent character strings are
    catenated; a version that does not use this feature has been
    included for people who can only run K&R).  A good way to see
    the resulting program (on a Unix system) is to do the command

        gcc hanoi.c -E -Dn=5 | grep -v \# | grep -v ^\$

    For an odd number of disks, the program will provide a
    solution wherein the disks end up on peg 2; for an even
    number of disks, they will end on peg 3.  This should 
    provide some hint as to what sort of algorithm is used.

    We have included a "spoiler" version of the program, with
    meaningful symbol names and comments, but we encourage you
    to try to decipher the program without it...

begin 444 spoiler.c
M(VEF;F1E9B`@24Y)5$E!3$E:140*"B\J"B`J("!)9B!N(&ES;B=T(&1E9FEN
M960L(&UA:V4@:70@-0H@*B\*(VEF;F1E9B`@;@HC9&5F:6YE("!N(#`U"B-E
M;F1I9@H*+RH*("H@4V]M92!U<V5F=6P@=F%R:6%B;&5S"B`J+PHC9&5F:6YE
M("!42$E37T9)3$4@7U]&24Q%7U\@"B-D969I;F4@($9/4DU!5%]35%))3D<@
M(DUO=F4@9&ES:R`E9"!F<F]M('!E9R`E9"!T;R!P96<@)61<;B(*(V1E9FEN
M92`@24Y)5$E!3$E:140*"B\J"B`J(%1R86YS;&%T92!N(&EN=&\@8FET<PH@
M*B\*(VEF("`@("`@;B8P,0HC9&5F:6YE("!B:70P"B-E;F1I9@HC:68@("`@
M("!N)C`R"B-D969I;F4@(&)I=#$*(V5N9&EF"B-I9B`@("`@(&XF,#0*(V1E
M9FEN92`@8FET,@HC96YD:68*(VEF("`@("`@;CX^,PHC9&5F:6YE("!B:70S
M"B-E;F1I9@H*+RH*("H@2&5R92=S('1H92!P<F]G<F%M(0H@*B\*;6%I;B@I
M>PIP<FEN=&8H"B-I;F-L=61E(%1(25-?1DE,10HC9&5F:6YE("!.3U=?1$]?
M5$A%7TY534)%4E,*(VEN8VQU9&4@5$A)4U]&24Q%"BD[?0H*(V5L<V4*"B\J
M"B`J($-H96-K('1O('-E92!I9B!T:&4@;G5M8F5R(&ES('IE<F\@*&)O='1O
M;2!O9B!R96-U<G-I;VXI"B`J+PHC:69D968@("!B:70P"B-D969I;F4@($Y?
M25-?3D]47UI%4D\*(V5N9&EF"B-I9F1E9B`@(&)I=#$*(V1E9FEN92`@3E])
M4U].3U1?6D523PHC96YD:68*(VEF9&5F("`@8FET,@HC9&5F:6YE("!.7TE3
M7TY/5%]:15)/"B-E;F1I9@HC:69D968@("!B:70S"B-D969I;F4@($Y?25-?
M3D]47UI%4D\*(V5N9&EF"@HC:69D968@("!.7TE37TY/5%]:15)/"B-U;F1E
M9B`@($Y?25-?3D]47UI%4D\*"B\J"B`J($1E8W)E;65N="!N"B`J+PHC:69N
M9&5F("!B:70P"B-D969I;F4@(&)I=#`*(VEF;F1E9B`@8FET,0HC9&5F:6YE
M("!B:70Q"B-I9FYD968@(&)I=#(*(V1E9FEN92`@8FET,@HC:69N9&5F("!B
M:70S"B-D969I;F4@(&)I=#,*(V5L<V4*(W5N9&5F("`@8FET,PHC96YD:68*
M(V5L<V4*(W5N9&5F("`@8FET,@HC96YD:68*(V5L<V4*(W5N9&5F("`@8FET
M,0HC96YD:68*(V5L<V4*(W5N9&5F("`@8FET,`HC96YD:68*"B\J"B`J("!(
M97)E)W,@<F5C=7)S:6]N"B`J+PHC:6YC;'5D92!42$E37T9)3$4*"B\J"B`J
M("!.;W1E.B!/9&0@;G5M8F5R960@9&ES:W,@86QW87ES(&-Y8VQE(&9R;VT@
M,2`]/B`R(#T^(#,@/3X@,2`]/B`R(#T^(#,*("H@($5V96X@;G5M8F5R960@
M9&ES:W,@86QW87ES(&-Y8VQE(&9R;VT@,2`]/B`S(#T^(#(@/3X@,2`]/B`S
M(#T^(#(*("HO"@HO*@H@*B!#:&5C:R!T;R!S964@:68@;B!I<R!Z97)O+B!)
M9B!S;RP@=V4G<F4@;6]V:6YG(&1I<VL@,2X*("H@26X@9V5N97)A;"P@9F]R
M(&%N>2!N('=E)W)E(&UO=FEN9R!D:7-K(&XK,2X@5&AA="!M96%N<R!T:&%T
M"B`J('=H96X@;B!I<R!O9&0L('=E)W)E(&UO=FEN9R!A;B!E=F5N(&1I<VLL
M(&%N9"!V:6-E('9E<G-A+@H@*B\*(VEF;F1E9B`@8FET,`HC:69N9&5F("!B
M:70Q"B-I9FYD968@(&)I=#(*(VEF;F1E9B`@8FET,PHC9&5F:6YE("!.7TE3
M7UI%4D\*(V5N9&EF"B-E;F1I9@HC96YD:68*(V5N9&EF"@HC:69D968@("!.
M7TE37UI%4D\*(W5N9&5F("`@3E])4U]:15)/"@HC:69N9&5F("!.3U=?1$]?
M5$A%7TY534)%4E,*1D]234%47U-44DE.1PHC96QS90H*+RH*("H@($EF(&1I
M<VL@,2!I<R!O;B!P96<@,BP@;6]V92!I="`R(#T^(#,*("HO"B-I9F1E9B`@
M($1)4TM?3TY%7TE37T].7U!%1U]45T\*+#$L,BPS"B-U;F1E9B`@($1)4TM?
M3TY%7TE37T].7U!%1U]45T\*(V1E9FEN92`@1$E32U]/3D5?25-?3TY?4$5'
M7U1(4D5%"B-E;'-E"@HO*@H@*B`@268@9&ES:R`Q(&ES(&]N('!E9R`S+"!M
M;W9E(&ET(#,@/3X@,0H@*B\*(VEF9&5F("`@1$E32U]/3D5?25-?3TY?4$5'
M7U1(4D5%"BPQ+#,L,0HC=6YD968@("!$25-+7T].15])4U]/3E]014=?5$A2
M144*(V5L<V4*"B\J"B`J("!$:7-K(#$@;75S="!B92!O;B!P96<@,2X@36]V
M92!I="`Q(#T^(#(*("HO"BPQ+#$L,@HC9&5F:6YE("!$25-+7T].15])4U]/
M3E]014=?5%=/"B-E;F1I9@HC96YD:68*(V5N9&EF"B-E;'-E"@HO*@H@*B`@
M2&5R92P@=V4@:&%N9&QE(&1I<VMS(#XQ+B!296UE;6)E<B!T:&%T(&]D9',@
M8WEC;&4@,2`]/B`R(#T^(#,@/3X@,2P*("H@(&%N9"!E=F5N<R!C>6-L92`Q
M(#T^(#(@/3X@,R`]/B`Q+B!#;VUB:6YE('1H:7,@=VET:"!T:&4@:VYO=VQE
M9&=E"B`J("!O9B!W:&5R92!D:7-K(#$@:7,L(&%N9"!W92!C86X@9&5T97)M
M:6YE(&AO=R!T;R!M;W9E(&%N>2!D:7-K+@H@*B\*(VEF;F1E9B`@3D]77T1/
M7U1(15].54U"15)3"D9/4DU!5%]35%))3D<*(V5L<V4*"B\J"B`J("!0<FEN
M="!T:&4@9&ES:R!N=6UB97(N(%)E;65M8F5R+"!D:7-K(&YU;6)E<B`](&XK
M,0H@*B\*+#$*(VEF9&5F("`@8FET,`HK,0HC96YD:68*(VEF9&5F("`@8FET
M,0HK,@HC96YD:68*(VEF9&5F("`@8FET,@HK-`HC96YD:68*(VEF9&5F("`@
M8FET,PHK.`HC96YD:68*"B\J"B`J("!$:7-K(#$@;VX@<&5G(#(@"B`J+PHC
M:69D968@("!$25-+7T].15])4U]/3E]014=?5%=/"B-I9F1E9B`@(&)I=#`*
M+#$L,R`@("`O*B!%=F5N.B`Q(#T^(#,@("AN(&ES(&]D9"P@<V\@=&AE(&1I
M<VL@:7,@979E;BD@*B\*(V5L<V4*+#,L,2`@("`O*B`@3V1D.B`S(#T^(#$@
M("HO"B-E;F1I9@HC96QS90H*+RH*("H@($1I<VL@,2!O;B!P96<@,R`*("HO
M"B-I9F1E9B`@($1)4TM?3TY%7TE37T].7U!%1U]42%)%10HC:69D968@("!B
M:70P"BPR+#$@("`@+RH@179E;CH@,B`]/B`Q("HO"B-E;'-E"BPQ+#(@("`@
M+RH@($]D9#H@,2`]/B`R("HO"B-E;F1I9@HC96QS90H*+RH*("H@($1I<VL@
M,2!O;B!P96<@,2`*("HO"B-I9F1E9B`@(&)I=#`*+#,L,B`@("`O*B!%=F5N
M.B`S(#T^(#(@*B\*(V5L<V4*+#(L,R`@("`O*B`@3V1D.B`R(#T^(#,@*B\*
M(V5N9&EF"B-E;F1I9@HC96YD:68*(V5N9&EF"B-E;F1I9@H*+RH*("H@($UO
M<F4@<F5C=7)S:6]N"B`J+PHC:6YC;'5D92!42$E37T9)3$4*"B\J"B`J("!)
M;F-R96UE;G0@;@H@*B\*(VEF9&5F("`@8FET,`HC=6YD968@("!B:70P"B-I
M9F1E9B`@(&)I=#$*(W5N9&5F("`@8FET,0HC:69D968@("!B:70R"B-U;F1E
M9B`@(&)I=#(*(VEF9&5F("`@8FET,PHC=6YD968@("!B:70S"B-E;'-E"B-D
M969I;F4@(&)I=#,*(V5N9&EF"B-E;'-E"B-D969I;F4@(&)I=#(*(V5N9&EF
M"B-E;'-E"B-D969I;F4@(&)I=#$*(V5N9&EF"B-E;'-E"B-D969I;F4@(&)I
M=#`*(V5N9&EF"@HC96YD:68@("\J("-I9F1E9B!.7TE37TY/5%]:15)/("HO
M"@HC96YD:68@("\J("-E;'-E(&]F("-I9FYD968@24Y)5$E!3$E:140@*B\*
`
end


