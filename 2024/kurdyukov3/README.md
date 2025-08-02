## To build:

``` <!---sh-->
    make all
```

This above needs the **X11** development environment installed.

See the
FAQ on "[X11](../../faq.html#X11)"
for more information on how to compile and run using **X11**.


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

While the main code is based on **X11**, the alternative is to use **SDL2** instead.


### Alternate build:

``` <!---sh-->
    make alt
```

This above needs the **SDL2** development environment installed.

See the
FAQ on "[SDL2](../../faq.html#SDL)"
for more information on how to compile and run using **SDL2**.


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

The prize, "**virtual quietus**", is a virtual reference to the doom that
awaits the execution .. of this code, let alone when your try to figure
out how the author was able to encode the virtual machine in under **2.5K
bytes** of [prog.c source code](%%REPO_URL%%/2024/kurdyukov3/prog.c)!

You may face your doom in several ways.  With the `make all` and
`try.sh` you may try the **X11** way into your doom.  With `make alt`
and `try.alt.sh` **SDL2** your way into your doom.

While you may meet your doom in the twisty maze of passages while running
the program, can you reach an understanding of the maze of twisty passages
in the [prog.c source code](%%REPO_URL%%/2024/kurdyukov3/prog.c)?

**NOTE**: The implementation does without sound or mouse
input.  You will need reply on your keyboard skills.  The
[2024/kurdyukov3/try.sh](%%REPO_URL%%/2024/kurdyukov3/try.sh)
demonstration script will give you some useful keyboard hints.


## Author's remarks:


### Obfuscated Gaming Virtual Machine

In short, it is a virtual machine capable of running Doom 1/2 at full speed on modern office computers.
It can also be used as a sandbox for C programs and for creating ports for other games.

See detailed story below build/run instructions.


### Build instructions

The instructions have been tested on a specific OS, on others they may differ in detail.


##### X11 (Ubuntu):

``` <!---sh-->
    cc -O3 prog.c -o prog -X11
```

* Needs "libx11-dev" package installed.


##### WinAPI (Msys64):

``` <!---sh-->
    cc -O3 prog.win.c -o prog.exe -s -lGDI32 -lwinmm
```


##### SDL1.2 (Ubuntu):

``` <!---sh-->
    cc -O3 -I/usr/include/SDL prog.sdl.c -o prog -lSDL
```

* Needs "libsdl1.2-dev" package installed.


##### SDL2 (Ubuntu):

``` <!---sh-->
    cc -O3 -I/usr/include/SDL2 prog.sdl.c -o prog -lSDL2
```

* Needs "libsdl2-dev" package installed.


### Running the game

``` <!---sh-->
    ./prog doomp.bin
```

* You will need the game resources, which are a .wad archive that you can grab from Doom 1/2 or its expansion packs. Doom has a shareware version available for free, you can download doom1.wad from it [here](http://distro.ibiblio.org/pub/linux/distributions/slitaz/sources/packages/d/doom1.wad). The resource file must be in the current directory when you run the VM.

* `doomp.bin` is a compressed binary of `doom.bin`, more on that below.


### Features missing

* No sound/music.
* No network game.
* No mouse capture.


### Doom port hacks

You can add command line arguments after the program binary. For example:

``` <!---sh-->
    ./prog doomp.bin -timedemo demo1
```

This will launch performance testing.

* -1, -2, -3, -4, -5: Pixel size multiplier (default is 3), the original game runs at 320x200, which is too small for modern displays. Affects performance (scaling is done at the game side).

* -upper : with this option, the game tries to use uppercase names for .wad/.svg files if no lowercase name is found. Useful for Linux, so you don't need to rename files copied from DOS version.

* -ridx N : the red color index in a pixel (0 to 3), may need adjustment if default doesn't work for you.


### The story


#### An idea

The idea of such a VM came up when I was looking at the winning works of the IOCCC competition, in which there are many games, in these games the game data is stored in separate files. So I think that in fact the complexity of games is not limited by the code size limit, as long as the game logic can be stored in a data file and then read and interpreted.

I also noticed emulators of virtual machines of a real CPU's and abstract Turing machines.

The idea for porting this game comes from tech fans who play this game on smartwatches, fridges, digital cameras, and even a scientific calculator.

So can virtual machive limited by the IOCCC rules run Doom? Yes, this is a confirmation of that.


#### Predecessor

This is actually VM mark II, because I was trying to write an obfuscated abstract virtual machine, it was too slow to run games, also difficult to program (but more complex than OISC), and I/O is limited by stdin/stdout. The good part is that the source code is small at ~380 bytes and that it can easily recursively emulate itself. But it was boring, so I kept thinking about how to do it better. The programs were written in assembly language consisting of handwritten NASM macros that emit opcodes for this VM (instead of x86 ones).

After I decided to emulate Doom in a VM, I had a question how I would compile the game source code into the binary code of a VM that never existed. And I tried the idea of ​​a workaround of compiling it into a 32-bit i386 binary and emulating a subset of the i386 instructions. I started writing an i386 emulator, but stopped halfway because I realized that this CISC architecture is too complex, so even if it complies with Rule 2B, it will have poor performance, and the code for graphics output and keyboard input may not even fit. After that I looked at the ARM thumb architecture, but even if it seems simpler to emulate - its instructions are too simple, and more instructions would be required compared to the same x86 code, so this option was also thrown out due to poor performance.

So, I went back to the predecessor and started rewriting and expanding its instruction set, but keeping it as small as possible in the amount of C code.


#### C compiler

After expanding the instruction set and reworking the assembler, I looked at basic C compilers that have backends for different architectures to create a backend for my own architecture. There was the Little C Compiler and the Tiny C Compiler that I knew before, of which I chose LCC because it has a parser for backends written mostly in pseudocode that is easier to work with. It is of course possible to make an LLVM backend, but creating an LLVM backend is much more complicated.

Choosing LCC turned out to be a good idea because I have successfully written my own backend. The downside to choosing LCC is that it is not very good at optimization, the generated code matches common compilers (like GCC) used with the -O0/-O1 switch.


#### Runtime library

Then I started writing implementations of common libc functions which include stuff like printf, malloc, memcpy, strcmp and so on. I wrote them in assembler because they are performance critical. It also required new code on the VM side in case of file I/O and timing functions.

And the final step was to add support for drawing in the window and handling keyboard events.


#### The Doom sources

These sources are available on [github](https://github.com/id-Software/DOOM) from the id Software account and have been forked many times with some improvements and fixes. But I took the original code.

The original source code for Doom (linux-xdoom to be exact) required some fixes to run on a 64-bit OS that doesn't need a 32-bit VM, but I fixed that so the same code would work in both the VM and linux, for a better debugging experience. Some other bugs have also been fixed, such as maintaining compatibility with the DOS version of the game and fixing the low detail mode. Some performance-critical functions have been rewritten in assembly (same as for the DOS game).

I'm not implemented network and sound support in a VM side, their interfaces replaced with a stub functions. I found a place for mouse support, but without mouse pointer capture (which is required for the FPS genre). Sound support isn't very portable and difficult to fit in the contest restrictions.


#### Last improvements

After making the X11 version, to make this entry more portable - I also made alternate versions using WinAPI and SDL1.2/SDL2.

The binary code for this VM takes up a lot of space, so the Doom binary takes 1.4Mb, while x86_64 one is less than 0.5Mb. To deal with this I wrote an executable packer for the VM bytecode that reduced the size of the game binary to 0.2Mb.


#### Doom port sources

I don't include modified Doom sources, but instead include a diff patch to avoid licensing issues.


#### VM SDK

I also include the NASM macros used to generate binary code, the VM runtime library sources and the backend for LCC-4.2 (does not include the LCC sources) and a simple patch to enable the backend.

Use:

``` <!---sh-->
    ./prog lzmadec.bin < sdk.zip.lzma > sdk.zip
``` <!---sh-->

to decompress the SDK (.zip archive is without compression).

Use:

``` <!---sh-->
    make sdk
```

To build the LCC and Doom and all examples from source,
for those systems with a compatible x86 processor, and the `nasm(1)` tool,
the `*.bin` files may be produced via this `make samples` rule:

``` <!---make-->
    samples: hello.bin loader.bin fizzbuzz.bin lzmadec.bin

    %.bin: sdk/examples/%.asm sdk)asmlib/vm.asm
        nasm -i sdk/asmlib/ -f bin -O9 $< -o $@
```


### VM features and specifications

* Interpreter of a 32-bit little-endian machine.
* The interpreter is designed to work on both big and little-endian machines (tested only on LE).
* Supported operations: +, -, &, |, ^, \*, /, %, <<, >>, ==, !=, <, <=, >, >=.
* Supports 8/16/32-bit signed/unsigned operations.
* Can access memory at a byte granularity and read from unaligned pointers.
* Any 32-bit aligned memory location can act as a register.
* A program running in a VM is sandboxed, it only has access to its working memory and can only call limited functions that interact with the user or the file system.


### Limitations

* No floating point support.
* No support for 64-bit integers.
* Divide overflow is not handled, the OS will terminate the VM process if this happens.
* The amount of RAM must be a power of two (up to 4 GBytes).
* Possible filenames are limited to alphanumeric characters, dot and underscore, and a length of 32. Any other characters are replaced by underscore. Since forward slashes are also filtered, it can only access files in the current directory.
* Only two file access modes: open an existing one for reading or create a new one for writing, both in binary mode.
* Can work with up to 8 file descriptors (the first three are standard streams).


### Other demo applications

* hello.bin : Simple "Hello World" program.
* fizzbuzz.bin : Solution for well-known job interview task.
* loader.bin : Loads another application from standard input into the VM's memory and runs it.
* window.bin : An example for the SDK on how to draw graphics and capture keyboard and mouse events.
* lzmadec.bin : LZMA stream decoder.


### Web version

I also wrote a web version in javascript. It is in `ogvm.html`, start a local server with `$ python3 -m http.server 8000` and open `http://127.0.0.1:8000/ogvm.html` in your browser.


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
