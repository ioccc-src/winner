#include                                                      <EXTERN.h>
#include                                                        <perl.h>
#include                                                        <XSUB.h>
#include                                                        <math.h>
#define                            qq                           __FILE__
#define                            cc                            (((3)))
#define                     ZZ(YY,WW) XS(YY)                     {AV*gg\
= perl_get_av(              "SS",cc-cc); SV*              Ss,*uu; char \
ii=*(SvPV(                  perl_get_sv("_",                  0*cc),na)\
) %(36+cc); (               av_len(gg) <1)?(               perl_call_pv\
("__",0/cc)):(Ss            =av_pop(gg), uu=            av_pop(gg),(((i\
i==pow(2,cc))||(            ii==(40-cc)))&&(            SvNV(Ss)==0))?(\
av_push(gg,uu),             av_push (gg,Ss),             perl_call_pv("\
_",3-cc)):(                   av_push (gg,                   newSVnv(WW\
) )                               ,1))                               ; }
ZZ(uu,SvNV(uu)-             (SvNV(Ss)*(SvIV(             uu)/SvIV(Ss))))
ZZ(ii,SvNV                  (uu)-SvNV(Ss))ZZ                 (ff,SvNV(Ss
)+SvNV(uu))ZZ(gg             ,pow(SvNV(uu),             SvNV(Ss)))ZZ(Ss,
SvNV(uu)/SvNV(Ss            ))ZZ(ss,SvNV(Ss)            * SvNV(uu)) void
bb( ){                      newXSproto("UU",                      ff,qq,
""); newXSproto(            "W""W",ii,qq,"")            ;newXSproto("TT"
,ss,qq,"")                  ; newXSproto("Y"                  "Y",Ss,qq,
""); newXSproto(            "vv",uu, qq,"");            newXSproto("aa",
gg,qq,""); }int             main(int _,char*             *__, char**ee){
PerlInterpreter*            aa=perl_alloc();            char*dd[]= { "",
"-e", "0"} ;                 perl_construct                 (aa); perl_\
parse(aa, bb,                  cc,dd ,ee)                  ;perl_eval_sv
(newSVpv("_:$_=               <> ; defined               or exit; @ARGV"
"=split; __:$_=             shift;defined or             goto _; chomp "
";(m*^\\x70oO"              "\\x74$*i)?(pri"              "nt \"$_ w\\x"
"61s h\\145r\\x"            "65!\\n\"):((m*"            "^\\s\\*(-?\\d+"
"(\\.\\d+)?)\\s"            "\\*$*)?(push@SS            ,$1):(&{chr(((o"
"rd)%39)+3**4)x2             } )); goto __;             sub ff { @SS= ("
")} sub __{print            \"stack empty\\"            "n\"} sub ss{$#"
"SS<0 and goto &            __; print $SS[$"            "#SS].\"\\n\"} "
"sub SS{ $#SS<0              and goto &__ ;              print pop @SS}"
"sub _ { print              \"divide by zer"            "o\\n\"}sub ii{"
"map{ print\"$_"            "\\n\" } reverse            @SS} sub AUTOLO"
"AD { print\"un"            "implemented\\n"            "\"} sub gg{ $#"
"SS<0 and goto              &__;push@SS,$SS[            $#SS]} sub uu{ "
"$#SS<1 and goto            &__;$SS[ $#SS]+=            $SS[$#SS-1];$SS"
"[$#SS-1]=$SS[$"            "#SS]-$SS[$#SS-"            "1]; $SS[$#SS]-"
"=$SS[$#SS-1]}                   ",0),0                   ); exit(cc); }
