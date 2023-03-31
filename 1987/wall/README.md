# Most Useful Obfuscation

Larry Wall  
Unisys - System Development Group Santa Monica  
9132 Kester Ave  
Panorama City, CA  91402  USA  

## To build:

        make all

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) made this entry safer
by changing `gets()` to `fgets()`. Thank you Cody for your assistance! If you
wish for the original unsafe version you can make the following change:

	-signal())();char*V,cm,D['x'],M='\n',I;L(MV,V,(c+='d',ix))m(x){v)
	+signal())();char*V,cm,D['x'],M='\n',I,*gets();L(MV,V,(c+='d',ix))m(x){v)
	 signal(X/'I',vi[x]);}d(x)char*x;{v)write(i,x,i);}L(MC,V,M+I)xv(){c>=i?m(
	 c/M/M+M):(d(&M),m(cm));}L(mi,V+cm,M)L(md,V,M)MM(){c=c*M%X;V-=cm;m(ix);}
	-LXX(){fgets(D,'x',stdin)||(vi[iv])();c=atoi(D);while(c>=X){c-=X;d("m");}V="ivxlcdm"
	+LXX(){gets(D)||(vi[iv])();c=atoi(D);while(c>=X){c-=X;d("m");}V="ivxlcdm"	

## To run:


	./wall
	# enter some strings

	./wall | some_command
	# enter some strings

## Try:

	./wall | bc | ./wall

and input the following:

	x*x
	c^2
	m*m

	# can you figure out what this does?
	500

### Also try:

	./wall | bc

	./wall | cat


and enter some input like:

	x*x
	2^x
	quit # for the cat version


## Judges' comments:


What we found amazing was how the flow of control was transferred
between subroutines.  Careful inspection will show that the array of
pointers to functions named 'vi' refers to functions which seem to not
be directly called.  Even so, these pointers to functions are being
used as an argument to signal.  Can you determine why this is being
done and how it is being exploited?

Some compilers complained about this file, so we changed: '=++I' to '= ++I'.


## Author's comments:

No comments were provided by the author.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
