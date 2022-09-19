Best Utility:

    Garry Glendown
    G\"uldene Kammer 35
    36251 Bad Hersfeld 
    Germany


Judges' comments:

    To use:
	make garry garry.test

    Try: 
	garry.test

    In general, try:

	garry <input_file >output_file

    While it may not have been the intention of the submitter, the
    judges noted that the C pre-processed version (with the #includes
    left intact) looked very much like a rat "dropping core".  See
    garry.cpp and judge for yourself!

    The author was kind enough to provide a less obfuscated version of
    the source called garry.fmt.c.


Selected notes from the author:

    This  program is a file filter, designed to do environment-expansion and
    incorporating  the  ability  to  create  binary from escaped data in the
    environment variables.

    The  calling syntax is pretty simple, just use it with stdio-redirection
    or inside pipelines, e.g.:

	progname <file_to_convert >converted_file

    or

	cat all_my_files/* | progname | lp

    The syntax of the conversion of the input file is as follows: To include
    the  value of an environment variable in the output file, place the name
    of the variable between "$"-signs in the input, e.g.:

	My Home-Directory is: $HOME$
	I'm using the path: $PATH$

    Unknown  Env-variables  or  misformed  expressions  are ignored and kept
    intact.

    Additionally,   the   filter   replaces  escaped  octal  values  in  the
    environment variables by their binary representation, e.g.:

	$ TEST="\110\145\154\154\157"
	$ export TEST
	$ echo '$TEST$' | progname
	Hello
