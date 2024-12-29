# Usage

1. First, build the kernel and filesystem (just `make`).  In short, you need to
build this on an x86 Linux machine.  If you wish to try to compile on an OS
other than Linux you may need modify the [Makefile](%%REPO_URL%%/2004/gavin/Makefile) to compile `sh`
using a cross-compiler that produces ELF binaries - i.e. a cross-compiler
targeting x86 Linux.  In short, you need to build this on an x86 Linux machine.

2. Next, find a suitable machine to run the OS on.  It should be perfectly safe,
and since it does not directly attempt to access any hard disk drives (only a
[RAM disk](https://en.wikipedia.org/wiki/RAM_drive) loaded by the bootloader) it
should do no damage to your existing setup, BUT I ACCEPT NO LIABILITY FOR ANY
DAMAGE DONE BY THIS PROGRAM.  Run it at your own risk.  The OS has been tested
on half a dozen machines or so, and worked on all but one.  The failure came in
the form of the machine rebooting itself midway through loading the OS, with no
nasty side-effects.

    Hardware requirements - i386 or better processor, but the GUI is
    surprisingly power-hungry, so I would recommend a fast P3 or P4 processor
    (has been tested on P3/P4/Athlon machines).  Minimum RAM is something like
    32MB.  PS/2 mouse & keyboard required - no USB I'm afraid, and the keyboard
    map is for a UK keyboard.  Uses VESA VBE 3.0, so should work on any modern
    graphics card (has been tested on NVIDIA, Matrox, and SiS cards).

3. Now you need to setup a bootloader to load the OS.  If you have a system
using a lilo bootloader you can simply add the OS to your boot menu.  Just add
appropriate `image=` and `initrd=` lines to your `/etc/lilo.conf`, pointing at
`kernel` and `fs.tar` respectively (as built by make earlier), then run `lilo`.
If you do not wish modify your lilo setup, one easy option is to get yourself a
GRUB boot disk image, and follow the instructions for GRUB below - Debian users
can simply run`apt-get install grub-disk` to get themselves a GRUB boot disk.

    If you run GRUB, then at the boot menu simply hit `c` to get a console, then
    type `kernel=(hd0,0)/<PATH>/kernel` (substituting appropriate hard
    drive/partition numbers & path, or using `(fd0)` to load a kernel on the
    floppy), then `initrd=(hd0,0)/<PATH>/fs.tar`, and finally `boot`.

4. Assuming the OS has booted, what can you do now?  Well, start by trying `sh`,
to open another shell.  Then, try `vi gavin.c` to open up the OS source in a
text file viewer (up/down or PgUp/PgDn to scroll). Note that the provided
applications, `sh` and `vi` both have windows of the same size, and both open in
the top left corner of the screen, so you may need drag the windows around a bit
to tell them apart.

5. To shut down - just hit the power button. :-)


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
