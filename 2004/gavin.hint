Best of Show:

    Gavin Barraclough
    Flat 20, 83 Newton Street,
    Manchester,
    M1 1EP,
    U.K.


Judges' Comments:

    To build and run (on any platform, without root privileges):

        make gavin

    To enjoy the results (on a Linux/x86 machine):

        su

    # Make a floppy with an ext2 filesystem (mke2fs /dev/fd0),
    # mount it under /mnt/floppy

        cp kernel fs.tar lilo.conf boot.b /mnt/floppy

    # If the version of your lilo is not 21.4, use the appropriate boot.b
    # If your floppy drive is not /dev/fd0, edit lilo.conf appropriately

        lilo -C /mnt/floppy/lilo.conf

    # Boot from the floppy on an x86 machine with a PS/2 keyboard and mouse
    # Move the window away from the corner

        vi gavin.c

    # Scroll the file with up-arrow and down-arrow

        sh

    # Can have several shell windows

        vi gavin.hint
        prim

    # Press and hold any key

    Over the years, we've seen a program that dumps core
    if executed on a "wrong" architecture immediately (1984/mullender),
    or after a while (2001/bellard). This entry will happily compile and
    execute on any architecture - the trick is that the result, to be useful,
    must be produced (and can only be enjoyed) on a particular architecture.
    We have not decided yet whether to disallow this for future contests.

    If you do not want to mess with a floppy and you use GRUB, see below
    in the author's notes.
    You can put additional text files in fs.tar for browsing with vi.
    If you do not want to bother rebooting your computer at all,
    see http://bellard.org/ for QEMU (Fabrice Bellard is an IOCCC 2001 winner),
    but your experience will be limited (replace -DK=0 with -DK=1 in the Makefile,
    and you will have to move the mouse to trigger the initial screen update).

    The judges were able to write a few more programs to run on this OS
    What are the limitations for such programs?
    What you can do and what you cannot do in such programs?

    The program called "prim", written by the judges,
    computes and prints prime numbers.


Selected Author's Comments:

    This is a 32-bit multitasking operating system for x86 computers,
    with GUI and filesystem, support for loading and executing user
    applications in elf binary format, with ps2 mouse and keyboard drivers,
    and vesa graphics.  And a command shell.  And an application -
    a simple text-file viewer.

    The OS has ended up as a traditional monolith with one entry point
    for syscalls, with apps treated as cooperative-multitasking tasks
    that can be sent different messages (e.g. 'initialize', 'key hit',
    'render to buffer') through their main entry point, and which will
    return control to the OS having performed the necessary work.
    Applications are are passed a pointer to their task structure,
    which is partially defined by the OS, and partially for
    the application's own use.

    The program compiles into a tool to build a kernel image,
    so having built the program, the makefile will run it,
    piping the output into a file called 'kernel'.
    The makefile will then proceed to build a root filesystem image.
    This involves rebuilding the program with different compiler flags,
    then building a tar file containing the resulting programs
    (the filesystem format supported by the OS is the tar-file format).

    For further usage information see 'gavin_install.txt'.

    The filenames 'vi' and 'sh' are significant, and should not be changed.

    Known 'features'.

    Known issues are really too plentiful to list.

    If the mouse pointer goes off the left hand side of the screen
    it will reappear on the right, and vice-versa.
    If it goes off the top or bottom, it will go and corrupt some memory.

    The file system is kinda optimistic about matching names, so,
    for example if you type the command 'shell' into a command-line
    it will execute the program 'sh' - close enough a match for it.

    The elf binaries are not loaded at the correct address,
    and their entry point must be the start address of the text segment.

    The keyboard driver can cope with the basic alpha-numeric keys,
    but gets confused by fancy things like 'shift' or 'backspace'.

    In the text-file viewer, 'vi', the up/down and pgup/pgdn keys
    scroll up or down by one line.  There is nothing to stop you
    [from] scrolling above the top of the file, and pressing any
    other keys may have an undefined effect.

    The x86 is bootstrapped into 32bit mode in 6 instructions,
    with 4 more to set up data/stack segments and a stack-pointer
    to allow C code to be run.  On top of this there are also about
    a dozen instructions to switch the video card into graphics mode.
    All in all, a relatively tiny number of instructions next to
    the size of the C program.  Also, the string is mostly composed
    of data - a Linux-esque kernel header for the bootloader,
    protected mode descriptor tables, keyboard maps, etc.
    (I should also mention that it contains mini functions
    to perform an x86 'in' and 'out' instruction - to allow
    the keyboard & mouse to be driven from C code).

    Porting to another architecture should be relatively easy* -
    the string simply needs be replaced with one containing
    data & code suitable for the new target platform.
    Accesses to data in the string are made relative to the define 'V',
    so these may need updating as appropriate (0x90200 is the address
    at which a Linux bootloader loads an x86 kernel image).

    * ;-)
