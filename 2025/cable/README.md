Award: Best imaginary emulator

## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog < bootimage
```


## Try:

``` <!---sh-->
    ./prog < mandelbrot.bootimage

    ./prog < pong.bootimage
```

Download a special vmlinux image and try it:

``` <!---sh-->
    wget https://raw.githubusercontent.com/adriancable/eternal/main/ioccc/vmlinux.bootimage.xz
    xz -d vmlinux.bootimage.xz
    ./prog < vmlinux.bootimage
```

When the `vmlinux.bootimage` is running try:

``` <!---sh-->
    export TZ=PST8PDT   # or whatever is your timezome
    ~/fbclock -s -d

    # ^C to exit

    ./pi

    cd ~/doom
    ./doom
```


## Judges' remarks:

At 366 bytes, [2025/cable/prog.c](%%REPO_URL%%/2025/cable/prog.c) also qualifies for the "Best Small
Program" award!

When looking at the entry, our thoughts were not "what does this program do?", but "what good could this little piece of code do?"

As it turns out, quite a lot, including running some of the previous
IOCCC winners!  Moreover, you can do a lot with **just one instruction**!

**BTW**: If you try running this entry under WSL, and it does not respond
to key presses, you may need to restart the WSL, or reboot your computer.


### On purposes

Keep in mind that two of the purposes of this entry are to create a
sense of surprise and wonder: This **wonderful winning entry** is
[NOT intended for production use](../../SECURITY.html).  Adding bounds
checks to [2025/cable/prog.c](%%REPO_URL%%/2025/cable/prog.c) would make
it larger and slower, and diminish both of these attributes.

See also the [Eternal Software Initiative](https://eternal-software.org).



### A fun challenge

Please checkout the [fun challenge&lpar;s&rpar;](../challenge.html#cable) for this winning entry.


## Author's remarks:


# VM - eternal virtual machine


## About

Virtual machines are notoriously large pieces of software (QEMU is around 2 million lines of code). Previous
IOCCC winners have pushed the boundaries on how small you can make a virtual machine: see for example
[2024/macke](https://www.ioccc.org/2024/macke/index.html) (OpenRISC Linux, 4588 bytes). Or, there's
[2024/kurdyukov3](https://www.ioccc.org/2024/kurdyukov3/index.html) which runs DOOM and weighs in at an impressive
2495 bytes of C.

But with some creativity you can go much smaller, and thus, the author presents this year, for the delectation of
the judges, a virtual machine in 366 bytes of C, implementing:

- 32-bit CPU, 1.5GB RAM
- 800x512 resolution graphics card
- real time clock, keyboard driver, pre-emptive multitasking, etc.

And yes, it runs DOOM (and Linux).


## How to use

Only dependency is the SDL3 graphics library, to provide a portable way to write pixels to a screen. Install SDL3
with: `apt install libsdl3-dev` on Linux, `brew install sdl3` on macOS.

Build:

``` <!---sh-->
    make
```

Try (press `q` to quit):

``` <!---sh-->
    ./prog < mandelbrot.bootimage
```

Enjoy a classic game (player 1: `a` = up, `z` = down, player 2: `k` = up, `m` = down, press `q` to quit):

``` <!---sh-->
    ./prog < pong.bootimage
```

Then:

``` <!---sh-->
    wget https://raw.githubusercontent.com/adriancable/eternal/main/ioccc/vmlinux.bootimage.xz
    xz -d vmlinux.bootimage.xz
    ./prog < vmlinux.bootimage
```

Once Linux is running, there's lots to explore (just type `exit` when you're done). You can try some of the
author's favourite IOCCC winners from the past (have a look in `~/ioccc`). Then try DOOM:

``` <!---sh-->
    cd ~/doom
    ./doom
```

Or, enjoy a nice clock (remember to [set your time zone](https://man7.org/linux/man-pages/man3/tzset.3p.html)):

``` <!---sh-->
    export TZ=PST8PDT
    ~/fbclock -s -d
```

Or, try running a web server and browser:

``` <!---sh-->
    ping 127.0.0.1
    httpd -h /usr/share/www
    htop
    lynx http://127.0.0.1
```

Hint 1: build this entry with `gcc` rather than `clang` to get the best performance, at least on ARM.

Hint 2: the `8e5` number in the source controls the priority of CPU vs keyboard/display updates. Decrease it if
the keyboard/display feels laggy, increase it to improve CPU performance.


## How it works

This VM implements an OISC - a One Instruction Set Computer. That instruction takes three signed 32-bit operands,
`a`, `b` and `c`, and runs a program from memory `m[]` as follows:

1. PC (program counter) starts at 0
2. Fetch the next instruction (32-bit signed operands `a`, `b` and `c`)
3. If the low bit on any operand is set, remove it, and replace that operand with `m[operand]` i.e., a dereference of that address
4. Set `m[b] = m[b] - m[a]`
5. If `m[b]` is 0 or negative, set the PC to `c`, otherwise increment PC by 3 words
6. Go to step 2

(This is a variant of what is known as the SUBLEQ architecture, with an indirect addressing mode added. The indirect
addressing mode is rather important because without it, SUBLEQ is not Turing complete unless self-modifying code is
used, which is inherently non-reentrant - and every modern OS relies on the ability to define reentrant functions.)

The VM also features a memory-mapped register bank, real time clock/timers, framebuffer graphics, keyboard driver,
and interrupts.

Now you may say: just subtracting numbers in memory doesn't sound very useful. But it turns out this architecture is
a surprisingly efficient way to do general computation.

To make this useful, you just need to do a couple of small things so the VM can run real software:

- Create a new LLVM compiler backend for the architecture. This includes creating codegen primitives to handle
  registers, arithmetic, bitwise ops, control flow, stack/frame handling, calling conventions, etc.
- Port LLVM's softfloat library to the architecture, so you get an FPU
- Now you have a working C compiler, so you can compile and run some basic C programs (e.g. the Mandelbrot demo)
- Then, port the Linux kernel to the architecture. Implement everything needed to support any userspace software
  including kernel preemption, networking, keyboard/video drivers, ELF loader, etc.
- Now you have a working OS, so you can port the C runtime library (e.g uClibc-ng or musl), create a C++ ABI for the
  architecture, then port LLVM's C++ runtime library
- Now you have a working toolchain to build C/C++ userspace programs, so you can build coreutils, nano/htop, lynx,
  DOOM, and most importantly IOCCC entries

To save the reader a few moments, the author already did all the above so you can just enjoy.

The complete toolchain (including instructions on how to build the compiler and Linux) can be found
[here](https://github.com/adriancable/eternal).


## Background

The author developed the architecture implemented by this VM, and the toolchain, as part of the
soon-to-be-launched open source [Eternal Software Initiative](https://eternal-software.org).

With so much of today's culture - art, science, story, work and play - being represented by or accessed
through software, how do we preserve that software in usable form so that historians 1000 years in the
future will be able to look back to today and understand what it meant to be human in the 21st Century?
Cultures of the past can be reconstructed from 'self-preserving' physical artifacts like objects and
books, but software is inherently ephemeral. Without an active effort to preserve it in usable form,
today's culture will largely be 'dark' to far-future generations.

The challenge: preserving just the software isn't sufficient. To be runnable, not only the software but
the entire ecosystem (operating systems, libraries, compilers, frameworks) all the way up to the hardware
needs to be preserved in usable form. But this ecosystem is unimaginably complex: much of it is
proprietary and incompletely documented, and reconstructing it in the future may be very difficult or
even impossible, for example in the event of civilizational collapse and rebirth where complete
information on today's computing architectures is unlikely to be preserved.

The aim of the Eternal Software Initiative is to offer a solution to this problem. We define a new
computing architecture which is so simple that the steps to build a virtual machine can be written on a
napkin, along with a toolchain to compile any of today's software (complete with operating system,
frameworks, libraries etc.) into a single self-contained 'capsule' of numbers. These numbers can be
stored in physical form on a durable medium (for example, etched onto a titanium cylinder) which will
last for millennia without degradation. The Mandelbrot demo, Pong demo and Linux kernel with
applications provided with this IOCCC submission are examples of such capsules.

1000 years from now, an anthropologist finding the 'napkin' instructions and a capsule could reconstruct
the virtual machine in under an hour (without needing any knowledge of today's computing architectures or
languages) and hence revive the contents of the capsule in fully functional form. In this way, the
Eternal Software Initiative aims to preserve today's software so our digital culture can be reconstructed
and re-experienced in the far future.


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
