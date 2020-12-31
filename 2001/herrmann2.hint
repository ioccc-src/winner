Most eye-crossing:

    Immanuel Herrmann
    University of Freiburg, Germany
    Rehlingstr. 17
    79100 Freiburg
    Germany

    http://pcpool.mathematik.uni-freiburg.de/~immi/


Judges' Comments:

    To build:

    	make herrmann2

     Try:

	./herrmann2 < herrmann2.ioccc
        ./herrmann2 < herrmann2.cup

     Be careful when staring at the source code - your eyes might cross, but
     if you concentrate on your focus you will find illumination!


Selected Author's Comments:

    You probably know those "magic eye" 3D pictures - pictures looking
    like random noise, but when you look "through" the paper, you
    either get a three dimensional picture or a head-ache. With this
    program, you can create your own 3D pictures in ascii art. And
    yes, the program itself is such a 3D picture.


    How to use it
    =============

    1. Create a file which describes the desired 3D picture. The file
    must be a block of lowercase letters the size of the desired
    picture. The letters specify the depth of the corresponding pixel:
    "a" means close to the paper, "z" means far away. The info files
    are examples. Be aware that the size of the picture is restricted
    to about 9k.

    2. Pipe your picture into the program. The output will be your
    3D picture, constructed of random characters (with ascii code between
    32 and 126). For example, type

      ./herrmann2 < herrmann2.ioccc


    3. If you want to control the characters used in the output (for
    example if your picture is to consist only of digits), pass them
    as the first argument. In this case, each time the program needs a
    new random character, it will take the next one from the
    argument. When it arrives at the end of the argument, it will
    start over at the beginning. Example:

      ./herrmann2 "234 84 045 5 6765 7487 65190 84 656 254 12 43931 818 0 6542\
      341 45 567 76967 7244 606 976567 895 81898 095 68678 1843 4650547\
      565980691 389 04974" < herrmann2.ioccc


    Some hints to get better results
    --------------------------------

    - Due to the way these 3D pictures work, the left part of the
      picture won't look really 3D, so don't put things too much on
      the left. The reason is that for each letter in the source file,
      a character for the right eye is printed. The 3D effect appears
      when the left eye sees the same character more to the left. This
      is of course impossible on the left border of the picture.

    - Don't use too different depths and don't use the depths very
      close to the paper (beginning of the alphabet). This would make
      it more difficult to see the picture.

    - When passing an argument, don't use a too short one; the
      repeating pattern which arises from the repetition of the argument
      could interfere with the repeating pattern which creates the 3D
      effect.


    Extra-Features
    ==============

    - The program is able to handle all common kinds of line breaks:
      Unix, Dos and Mac. To get an output with a certain kind of line
      breaks, simply use the same kind of line breaks in the input
      file.

    - As the source code is a 3D picture itself, the easiest way to
      get it (if you lost it or if you don't have it already) is to use
      the program itself on the right picture and with the right
      argument:

./herrmann2 \
'char*d,A[9876];e;b;*ad,a,c;  tw,ndr,T; wri; ;*h; _,ar  ;on;'\
' ;l ;i(V)man,n    {-!har  ;   =Aadre(0,&e,o||n -- +,o4,=9,l=b=8,'\
'!( te-*Aim)|(0~l),srand  (l),,!A,d=,b))&&+((A + te-A(&(*)=+ +95>'\
'e?(*& c_*r=5,r+e-r +_:2-19<-+?|(d==d),!n ?*d| *( (char**)+V+), ('\
'  +0,*d-7 ) -r+8)c:7:+++7+! r: and%9- 85! ()-(r+o):(+w,_+ A*(=er'\
'i+(o)+b)),!write,(=_((-b+*h)(1,A+b,!!((((-+, a >T^l,( o-95=+))w?'\
'++  &&r:b<<2+a +w) ((!main(n*n,V) , +-) ),l)),w= +T-->o +o+;{ &!'\
'a;}return _+= ' < herrmann2.ioccc

    - If I had submitted the program last year, I would have said that
      it has exactly the maximum allowed length: 1536 characters. Now
      let's say it's a way of protesting against the inflation in
      program length.

    - The size of the source 3D picture has been chosen carefully: as
      big as possible, but small enough to be viewed without problems
      on normal-sized terminals.


    Why this program should win
    ===========================

    - The layout is of a completely new kind. And it describes what
      the program does more precisely than any comment could.

    - I don't think there has ever been an ioccc program with so
      severe layout constraints. Once the 3D picture has been fixed,
      only a sixth of the characters can be chosen freely! (457 of
      1840, to be exact.) In contrast, in palindrome programs, for
      example, half of the characters can be chosen freely.

    - I did not cheat by using comments or -D options - something
      I've seen even some palindrome programs do. In fact, at my first
      attempt at writing the program I became convinced that it
      isn't possible without cheating. But then I found out that with
      comments or defines, it would become trivial, so I had to try
      harder...

    - If you don't believe the constraints are hard, try to write just
      one single line which satisfies them. (To be able to make one
      function call, for example, you have to fill an entire line with
      stuff doing mostly nothing.)

    - Just in case this is not enough: Yes, the code itself is
      obfuscated: It's (almost) only one big expression, with deep
      nesting of () and ?:, and full of unnecessary operations which
      do not really help making it readable. And it contains a lot of
      "magic numbers". (My favourite is the "7" in line 15 (each
      one). Which is the other digit I could have put there instead,
      and what other changes to the program would have been necessary?
      Without violating the constraints of course.)

    - The fact that the main loop of the program calls "main"
      recursively is nothing new. New however is that this program
      only needs a logarithmic recursion depth! (Find out how this
      works.)

    - When still in doubt about how to judge this program, type

        ./herrmann2 < herrmann2.cup

      and let the result inspire you. ;-)



    Requirements to the compiler / Compatibility
    ============================================

    - I fear that gcc is the only compiler for which this program
      works. Due to the severe restrictions, I was forced to use
      declarations of int variables, functions and parameters without
      specifying their type. The biggest problem was to put "int
      main(int c, char ** v){" into the program. After some time, I
      became convinced that this is impossible. Finally, at least I
      managed to squeeze "main(c, v){" into the constraints instead.

    - Also, a lot of warnings are produced - most of them "data
      definition has no type or storage class", but also some
      "parameter names (without types) in function declaration" and
      "assignment from incompatible pointer type". I wasn't able to
      get rid of them.

    - At least, it probably works with all sufficiently recent
      versions of gcc. I tested it with versions 2.7.2.1, 2.8.1,
      2.95.2, and ecgs-2.91.66.

    - Of course I couldn't put "#include"-lines at the beginning of
      the program. Usually, this is not really necessary with
      gcc. However, for this program it would have been, because some
      functions appear as function pointers, and as such they are not
      generated implicitly. So the build script has to pass "-include
      ..." to gcc. A problem with this is that the complete path of
      the include files has to be provided. In the build script, I
      assume that the path is /usr/include, but this can easily be
      adapted.


