#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2001/herrmann2
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

# we need to remove some files for later
rm -f ioccc.out ioccc.out2 cup.out cup.out2

echo "$ ./herrmann2 \
'char*d,A[9876];e;b;*ad,a,c;  tw,ndr,T; wri; ;*h; _,ar  ;on;'\
' ;l ;i(V)man,n    {-!har  ;   =Aadre(0,&e,o||n -- +,o4,=9,l=b=8,'\
'!( te-*Aim)|(0~l),srand  (l),,!A,d=,b))&&+((A + te-A(&(*)=+ +95>'\
'e?(*& c_*r=5,r+e-r +_:2-19<-+?|(d==d),!n ?*d| *( (char**)+V+), ('\
'  +0,*d-7 ) -r+8)c:7:+++7+! r: and%9- 85! ()-(r+o):(+w,_+ A*(=er'\
'i+(o)+b)),!write,(=_((-b+*h)(1,A+b,!!((((-+, a >T^l,( o-95=+))w?'\
'++  &&r:b<<2+a +w) ((!main(n*n,V) , +-) ),l)),w= +T-->o +o+;{ &!'\
'a;}return _+= ' < herrmann2.ioccc > herrmann2.orig.c && \
echo && diff -s herrmann2.alt.c herrmann2.orig.c" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./herrmann2 \
'char*d,A[9876];e;b;*ad,a,c;  tw,ndr,T; wri; ;*h; _,ar  ;on;'\
' ;l ;i(V)man,n    {-!har  ;   =Aadre(0,&e,o||n -- +,o4,=9,l=b=8,'\
'!( te-*Aim)|(0~l),srand  (l),,!A,d=,b))&&+((A + te-A(&(*)=+ +95>'\
'e?(*& c_*r=5,r+e-r +_:2-19<-+?|(d==d),!n ?*d| *( (char**)+V+), ('\
'  +0,*d-7 ) -r+8)c:7:+++7+! r: and%9- 85! ()-(r+o):(+w,_+ A*(=er'\
'i+(o)+b)),!write,(=_((-b+*h)(1,A+b,!!((((-+, a >T^l,( o-95=+))w?'\
'++  &&r:b<<2+a +w) ((!main(n*n,V) , +-) ),l)),w= +T-->o +o+;{ &!'\
'a;}return _+= ' < herrmann2.ioccc > herrmann2.orig.c && \
echo && diff -s herrmann2.alt.c herrmann2.orig.c
echo 1>&2

echo "./herrmann2 "234 84 045 5 6765 7487 65190 84 656 254 12 43931 818 0 6542 \
341 45 567 76967 7244 606 976567 895 81898 095 68678 1843 4650547 \
565980691 389 04974" < herrmann2.ioccc" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./herrmann2 "234 84 045 5 6765 7487 65190 84 656 254 12 43931 818 0 6542 \
341 45 567 76967 7244 606 976567 895 81898 095 68678 1843 4650547 \
565980691 389 04974" < herrmann2.ioccc
echo 1>&2

read -r -n 1 -p "Press any key to run: rm -vf ioccc.out ioccc.out2: "
echo 1>&2
rm -vf ioccc.out ioccc.out2

read -r -n 1 -p "Press any key to run: ./herrmann2 < herrmann2.ioccc | tee ioccc.out: "
echo 1>&2
./herrmann2 < herrmann2.ioccc | tee ioccc.out
sleep 2
read -r -n 1 -p "Press any key to run: ./herrmann2 < herrmann2.ioccc | tee ioccc.out2: "
echo 1>&2
./herrmann2 < herrmann2.ioccc | tee ioccc.out2
read -r -n 1 -p "Press any key to run: diff ioccc.out ioccc.out2 (space = next page, q = quit): "
echo 1>&2
diff ioccc.out ioccc.out2 | less -rEXFK
rm -f ioccc.out ioccc.out2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./herrmann2 < herrmann2.cup | tee cup.out: "
echo 1>&2
./herrmann2 < herrmann2.cup | tee cup.out
sleep 2
read -r -n 1 -p "Press any key to run: ./herrmann2 < herrmann2.cup | tee cup.out2: "
echo 1>&2
./herrmann2 < herrmann2.cup | tee cup.out2
read -r -n 1 -p "Press any key to run: diff cup.out cup.out2 (space = next page, q = quit): "
echo 1>&2
diff cup.out cup.out2 | less -rEXFK
echo 1>&2

rm -f cup.out cup.out2
