# Best One Liner

Thomas A. Fine  
Ohio State University  
Department of Computer and Information Science  
2036 Neil Avenue Mall  
Columbus, Ohio  43210  
US  

## To build:

```sh
make all
```

## To run:

```sh
echo text | ./fine
```

## Try:

```sh
echo "green terra
vex
tang
vend onyx
cheryl be flashy
rail
clerk
the rug gary lenT
" | ./fine
```

Read the last line backwards! Credit goes to [Merlyn LeRoy (Brian
Westley)](/winners.html#Brian_Westley) for that. See his 22 August 1992
[rec.puzzles
post](https://groups.google.com/g/rec.puzzles/c/z_xVPMRVBtg/m/lyEYSAeBD4gJ). To
those who have a harder time reading backwards it says: `Gary lent the rug`,
rotated from `the rug gary lent`!


## Judges' remarks:

This filter, 80 chars plus a newline, fits into a single line on most 
terminals (unless your terminal has a line wrap mis-feature :-)).

This entry is likely one of the smallest C implementations of this
filter, excluding programs that resort to command line or include 
file tricks.

How does this program work?  Which 3 bytes of C code can be changed
into 2 bytes, allowing the program to still work, but also stripping 
the high bit off of some input?

## Author's remarks:

The author wishes to thank J Greely for the last 6 bytes.

Here's about how it does it:  [rot13 to read]


    ABGR:  Ovgf ner ersreerq gb nf 76543210, uvtu gb ybj.
    
    1.  Trg gur punenpgre va inevnoyr n.  Abgr gur sha jnl jr purpx sbe RBS.
        (gunaxf W).
    
    2.  Erirefr ovg 6, naq fgevc ovg 5.  Ovg 6 qrgrezvarf (zbfgyl) jurgure
        be abg guvf punenpgre vf n yrggre.  Ovg 5 jbhyq qrgrezvar pnfr vs
        jr pnerq.  Nffvta guvf inyhr gb inevnoyr o (Jr arrq gb fnir vg,
        fvapr jr arrq gb znxr 2 pbzcnevfbaf naq znlor bar bcrengvba jvgu
        guvf inyhr).  Jr pna'g nohfr bhe svefg inevnoyr, fvapr vg fnirf gur
        ovgf jr'er punatvat.
    
    3.  Purpx guvf inyhr gb frr vs vg vf n yrggre.  Vg zhfg or aba-mreb -
        vs vg vf mreb, gura jr unir rvgure gur ng-fvta (64) be gur
        onpxdhbgr (96).  Vg nyfb zhfg or yrff guna 27 - guvf purpxf gur
        enatr sbe yrggref nf jryy nf vzcyvpvgyl purpxvat gur inyhr bs ovg 6
        (vs vg jnf bevtvanyyl pyrne, vg vf frg abj, fb o jbhyq or gb ovt).
    
    4.  Vs vg vf abg n yrggre, gur pbaqvgvbany rkcerffvba vafvqr bs gur
        chgpune() ergheaf gur bevtvany punenpgre (n).  Bgurejvfr, vg
        ergheaf n ernyyl zrffl rkcerffvba gung cresbezf gur npghny ebgngvba
        naq svkrf gur svsgu naq fvkgu ovgf:
    
        N.  Fhogenpg 1, gb trg vagb gur enatr 0-25 (sbe gur zbqhyb bcrengvba).
        O.  Nqq 13 gb gur punenpgre.  Fgrcf N naq O ner pbzovarq.
        P.  Gnxr guvf zbqhyb 26 gb znxr gur nqqvgvba jenc nebhaq.
        Q.  Svk ovgf 5 naq 6, onfrq ba inevnoyr n.
        R.  Nqq 1 onpx va (jr gbbx vg bhg va fgrc N.)  Guvf vf bxnl gb qb
    	*nsgre* fgrc Q, orpnhfr jr xabj gur nqqvgvba jba'g gevpxyr hc
    	cnfg gur sbhegu ovg (o jbhyq unir gb or 31 sbe guvf gb unccra).
    
    Abgvpr gung guvf vzcyrzragngvba bcrengrf bayl ba punenpgref jvgu gur
    uvtu ovg pyrne.  Gur uvtu ovg pna or vtaberq jvgubhg punatvat gur fvmr
    bs gur cebtenz.  Nyfb, vs lbh xabj lbh ner bayl qrnyvat jvgu frira ovg
    qngn, gur fvmr pna or erqhprq ol bar olgr.  Gurfr ner yrsg nf rkrepvfrf
    sbe gur fghqrag.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
