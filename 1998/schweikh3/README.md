Most Space Efficient:

    Jens Schweikhardt
    DFN Network Operation Center
    Schlartaeckerweg 3 (Home address)
    D-71384 Weinstadt
    Germany

    http://www.shuttle.de/schweikh/


Judges' comments:

    To build:

	make schweikh3

    To use:

	If "dir" is the directory (or a directory tree) where you keep
	all your favorite pictures off the Internet or from
	alt.binaries.pictures.*, do

	find dir -type f -print | ./schweikh3

    Maybe you will not need to buy another 10 Gb disk to store them.  :-)

    Also Try:

	cp schweikh3 file1
	cp schweikh3 file2
	cp schweikh3.c file3
	ln file3 file4

	ls -1 file? | ./schweikh3

    NOTE: this program is not as smart as to detect identity of JPEG
          files with the same picture but with different compression levels.

    NOTE: Some non-gcc compilers that are not fully ANSI standard do
	  not compile this entry correctly.


Selected author's comments:

    The source is expected to conform to IEEE Std 1003.1-1990 ("POSIX").
    Thank God the IEEE does not standardize a coding style...

    What this program does
    ----------------------

    This is best explained in the man page. The troff source for this
    man page can be found in the file samefile.1.

    SAMEFILE(1)                User Manuals               SAMEFILE(1)


    NAME
       samefile - find identical files

    SYNOPSIS
       samefile

    DESCRIPTION
       samefile  reads  a  list  of file names (one file name per
       line) from stdin.  For each file name pair with  identical
       contents, a line consisting of six tab separated fields is
       output: The size in bytes, two file names,  the  character
       ``=''  if the two files are on the same device, ``X'' oth-
       erwise, and the link counts of the two files.  The  output
       is sorted in reverse order by size.

       samefile uses two stages to give optimum performance.

       In  the  first  stage,  all  non-plain  files are silently
       ignored (directories, devices,  FIFOs,  sockets,  symbolic
       links)  as  well  as  files  for  which stat(2) or open(2)
       fails.  The result of the first stage (the file names)  is
       written  into  a  binary tree with one node for every file
       size. Each node is in turn a linked  list  of  file  names
       along  with  inode  and device information.  It is also at
       this first stage where checks for  hard  links  are  done.
       For  any  inode  only  one  filename  will be added to the
       binary tree.

       In the second stage all files having  the  same  size  are
       compared  against  each  other.  The rules of mathematical
       logic are applied to reduce  work  and  output  noise:  if
       files  A,  B,  and C have the same size and samefile finds
       that A = B and A = C then it will not compare B against  C
       (and  will not output a line for B and C) but only for A =
       B and A = C. The algorithm  will  detect  equality  across
       arbitrarily  long chains.  Note however, that because only
       the first filename per inode gets into  the  first  stage,
       the  output  for a group of identical files with different
       inode numbers is also  minimized.  Suppose  you  have  six
       identical  files  of size 100 in an inode group consisting
       of the three inodes with numbers 10, 20 and 30:

       $ ls -i   # output edited for readability:
          10 file1     20 file4     30 file6
          10 file2     20 file5
          10 file3
       $ ls | samefile
       100     file1   file4   =       3       2
       100     file1   file6   =       3       1

       The sum of the sizes in the first column is the amount  of
       disk  space  you could gain by making all 6 files links to
       only one file or remove all but one of the  files.  To  be
       precise,  disk  space  is  allocated  in blocks - you will
       probably gain two blocks  here,  rather  than  200  bytes.
       Note  that it is not enough to just remove file4 and file6
       (you  would  gain  only  100  bytes  because  file5  still
       exists.)


    LIMITATIONS
       Samefile was written with no limits in mind. The number of
       input lines is unlimited. The size of the actual files  is
       only limited by available virtual memory needed to compare
       one pair of files.  The only hard limit is the  constraint
       that there should not be more than about 8192 files having
       the same size. Experience has shown that there are  rarely
       more than a couple dozen files of the same size.

    EXAMPLES
       For everybody:
       What are the duplicates under my home directory?

           $ find $HOME | samefile

       For the sysadmin folks:
       Report all duplicate files under /usr larger than 16k:

           $ find /usr -size +16384c -a -type f | samefile

       For the ftp and WWW admins:
       How much space is wasted below our site's /pub directory?

           $ find /pub -type f | samefile | awk '{sum += $1} END {print sum}'



    EXIT STATUS
       If  samefile runs out of memory the exit status is 1, zero
       otherwise.

    SEE ALSO
       find(1), ln(1), rm(1)


    Why I think it is obfuscated
    ----------------------------

    - the code is commented but this gives only an *extremely* faint clue.
    - the layout does not reflect the program structure, or does it?
    - The data structure the program builds is an ordered binary tree
      where each node consists of a linked list. This is probably too
      heavy to comprehend for N percent of all programmers ;-)
    - The tree is built and traversed by recursive function calls.
    - Why does this program look at dev_t and ino_t? Heavy wizardry.
    - Can you find out how the algorithm works that detects identity
      of files across arbitrarily long chains? In my private unobfuscated
      source there are 17 lines describing just that. A classical case for
      the well known /* You're not supposed to understand this */ comment.
    - Would Dijkstra consider this goto harmful?
    - The only string literal is split in more than a dozen substrings
    - For the task at hand the code is pretty terse. Some dynamic memory
      is even freed as soon as it's no longer needed. I have tried to
      make the preprocessor directives as short as possible. This means
      no spaces after #include and no spaces after some of the macro
      names.

    Are you an algorithms guru? If so you should know why the output
    appears sorted without any use of qsort() or system("sort").

    Rewrite (hah!) the program to use memory mapping of files instead
    of read(). Does this affect performance noticeably?

    It's easy to write a script that takes samefile's output and
    hardlinks (or symlinks) identical files. Writing such a script is
    left as an exercise for the deobfuscator.

    When you run samefile on some directory tree, try to estimate
    how much you think it will find. Is the actual result anywhere
    near your estimate? How many copies of the GPL COPYING file
    are there on your filesystems? :-)

    In the remote event that the input has more than 8192 files with
    the same size (on systems where sizeof (char *) == 4, or 4096 when
    sizeof (char *) == 8), increase the manifest constant 32767 on line
    31.
