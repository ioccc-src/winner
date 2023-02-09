Most Obfuscated Algorithm:

	Sean Barrett
	Software Construction Company
	430 Southwest Parkway, #1906
	College Station, TX 77840
	USA


Judges' comments:

    To see clearly why this won an award:
	make babble
    
    Try:
	babble 0 10
	babble 56 720
	babble 1 521
    
    To see good C Preprocessor babble, try:
	make babble.cppcb
	cat babble.cppcb
    
    Notice how many statements it takes to do anything useful?


Selected notes from the author:

    What you shouldn't think about babble:

      babble doesn't just do a mass of #defines as its obfuscation.


    What you should be glad about:

      I didn't just submit the post-C-preprocessed output as an entry.


    Cute trick warning:

      babble contains only a numeric printf, yet sometimes it prints out
      short strings.


    What it does:

      babble is a simple mathematical program. It expects two numeric
      arguments.

      % babble 0 <num>
      will print out the factorial of <num>.

      % babble <num1> <num2>
      will print out the largest common factor of num1 and num2.

      % babble 1 <num2>
      will print out a factor of num2 if it's composite, or else
      it will print a string informing you that num2 is prime.

      If the first argument is less than 0, it prints out an
      error message.


    What it is:

      babble is a translator from a pseudo-assembly language into a
      subset of C suitable for execution on Charles Babbage's
      Analytical Engine.  Or rather, the #defines in babble are that
      translator.  The rest of babble is a babble program.  If you run the
      whole mess through CPP and a beautifier, you will see that
      all you have is a loop that runs until a variable is not 0, and
      a sequence of assignment statements.  The assignment statements
      are all of the form 'a op= b' or 'a = b'.  The Engine actually
      allowed 'a = b op c'.  Only +, -, /, and * are used--no boolean
      or bitwise operators.  The infinite loop could have been
      simulated on the AE by connecting the already-processed 
      card stack to the input card stack.


    How to try to understand it:

      *Don't* expand the #defines!  Rather, decipher what they do.
      Some of them are mere obfuscational fodder, put in to encourage
      you to run it through CPP.


    What it doesn't quite do right as an emulator:

      Because of the definitional constraints, calls to atoi(argv[#])
      also appear inside the loop.  These could be put outside--
      the initial values of the "registers" on the AE--but the
      macro conventions being used didn't lend themselves to it.


    Theoretical observations:

      The simulated comparison operations only work with a certain
      range of numbers; numbers that are too large will cause the
      output code to fail to simulate the input code.  This means
      that this implementation of babble would not be turing-complete,
      even if the AE could process indefinitely-sized numbers.
      However, this is actually a constraint that no actual computer
      can meet, either, so we can conclude that if an AE, with
      card bins connected as suggested above, were hooked up to
      a memory unit of sufficient size, it would be as turing
      complete as any existing machine (or, for those who
      interpret that excessively critically, i.e. "not at all" for
      both, we can simply say that the AE could simulate any
      existing machine--although not quickly).  This would be a
      good place to site some references on the AE, but I don't
      have any.


    Definition of the input language to babble:
    (OR What Exactly Do All The Macros Do?)

    [Don't read this unless you're stumped!]


      MACRO		FUNCTION				MNEMONIC
        V               begin variable declarations		Variable
        C               begin program				Code

        Q(b,a)          let b = a				eQuals
        A(c,a,b)        let c = a + b				Add
        S(c,a,b)        let c = a - b				Subtract
        D(c,a,b)        let c = a / b, where b is a *constant*  Divide
        U(c,a,b)        let c = a / b, where b is anything      Unknown
        M(c,a,b)        let c = a * b				Multiply

        O(c,a,b)        let c = a boolean-or b (a,b are 0 or 1) Or
        B(b, a)         let b = boolean value of a		Boolean
        P(b, a)         let b = 1 if a>0, else 0.		Positive

        l               emit next sequential label		Label
        J(x)            goto label #x				Jump

        Z(a,d)          if a is 0 goto d    (a is 0 or 1)	Zero
        E(a,d)          if a is 1 goto d    (a is 0 or 1)	Else

        H               halt					Haly

        K(x)            let x = number of cmd line arguments	Kount
        G(x,y)          let x = the value if the yth argument   Get argument

        T               end of code; begin output section	Terminate
        X(y)            print out hexadecimal value of y	heXadecimal
        T               end of output section and program	Terminate

        You can figure out the other macros yourself.  In the sample
        program, I've actually implemented subroutines by saving
        a return address in a variable and then jumping to a routine--
        specifically, a routine that converts a number into bcd, so
        it can be output by the hexadecimal output statement.


    How it works, i.e., how to get useful programs from a op= b

      The essential statement to be able to do to do interesting
      programs is the conditional (given that we have loops).
      Since all you can do in the given operation output set is
      assignment, we implement "conditional assignment":

        if (x) y = z;

      To implement this, we constrain x to be either 0 or 1, and
      simply compute:

        y = (z * x) + (y * (1-x));

      This is more obscured by factoring out common terms and restricting
      ourselves to two operand operations:

        temp = z;                       (temp == z)
        temp -= y;                      (temp == z-y)
        temp *= x;                      (temp == (z-y)*x)
        y += temp;                      (y    == (z-y)*x + y)
                                        (     == z*x - y*x + y)
                                        (     == z*x + y*(1-x))

      Next we imagine we have a pc.  "I'm supposed to execute statement
      pc next", says our emulator.  But suppose we're not currently
      coming up on statement pc.  To handle this, we simply make every
      operation conditional on the pc having the correct value:

        if (pc == some_constant) y = z;

      To combine this with other operations, we simply multiply by our
      (pc == some_constant) flag right after the above 'temp *= x'.

      To evaluate pc == some_constant requires one more trick.  We assume
      that numbers can only be in some limited range.  Then we use successive
      additions and divisions to reduce that number down to -1, 0, or 1.
      You could, for instance, do this by using mod by 2 and div by 2 to
      count bits, stopping after, say, 32 iterations.  The number you get
      is between 0..32, so another 6 iterations on it reduces it to 0..6.
      Three iterations on this produces 0..2 (3 would be '7'), and then
      two iterations on this produces 0 or 1.  Instead I use a shorter
      two-divide approach that assumes I'm allowed to use numbers slightly 
      larger than the numbers I'm operating on.

      A similar approach is used to detect positive numbers.

      Note that the obvious code to compute y/x will not work correctly,
      because every value is computed, even if the pc is not set correctly;
      if x is ever 0 when the real C code reaches this computation the
      program will die.  (This was discovered the hard way.)  The solution
      is to stick x in a temporary, and if the current code is not about
      to be executed, set the temporary to 1.
  
    Thanks to Bill Pugh for bringing the loopability of the AE to
    my attention.

    babble was originally named 'cb', for obvious reasons, and is
    dedicated to the memory of Charles Barrett.

Copyright (c) 1992, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
