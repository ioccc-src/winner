## Award presentation:

Watch the following [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse) YouTube show:

> [IOCCC28 - 2024/macke - Prize in imitative rebooting](https://www.youtube.com/watch?v=jeQFI_8kGA4)


## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

When we ran this entry the first time (in a virtual machine window), it felt like the VM has rebooted.
Then, after the initial feeling had subsided, we were able to appreciate the entry in greater detail.

Have you ever wondered would what would happen if you recursively removed
files starting from the root directory?  Are you curious what happens when
you launch a [fork bomb](https://en.wikipedia.org/wiki/Fork_bomb)?
Within the safety of an virtual walls, can safely give those and other scenarios:
just check out the "[Things You Can Do](#todo")" section below.

**NOTE**: For those who do not have a clang compiler environment that
supports the `wasm32` target, we provide a `prog.wasm` file.

**SUGGESTION / REQUEST**: Having a way to build custom boot-up images for this entry would be of interest.


## Author's remarks:


### Emulator Running Linux


#### What It Does

This is an emulator capable of running a full modern Linux system with a minimal set of features. The system includes:

* An OpenRISC 32-Bit CPU
* A Memory Management Unit
* A UART connected to the Terminal
* An Interrupt Controller
* A Timer Controller


<div id="todo">
### Things You Can Do
</div>


#### Look Up Specs

First, you can look up the specs of the emulated system. The following commands will give you a good overview:

``` <!---sh-->
    uname -a
    free -h
    cat /proc/cpuinfo
    cat /proc/meminfo
    cat /proc/interrupts
    cat /proc/timer_list
```


#### Fork Bomb Visualized

For educational purposes, type the following two lines and watch the process tree grow:

``` <!---sh-->
    b(){ sleep 2; b|b; }
    (b &) && watch -n1 pstree -p
```

Or just run:

``` <!---sh-->
    ./fork_bomb.sh
```

Note: You won't be able to stop the emulator anymore and will need to kill the process.


#### Delete Filesystem

Ever wanted to know what happens when you delete your computer's filesystem?
Now is your chance to find out!

``` <!---sh-->
    rm -rf /
```

Even after removal, your system will still be in a well-defined state.
For example, you can still run commands such as:

``` <!---sh-->
    cd /proc
    echo *
```

Be careful: You won't be able to stop the emulation anymore and will need to kill the process.


#### Run C64 Emulation

A full-fledged C64 emulator is included. Run it via:

``` <!---sh-->
    ./c64
```

Since the C64 is little-endian and runs on a big-endian machine, which itself runs on a little-endian machine, it combines the best of both worlds into a cool intermediate format. Might this be the future of endianness? 🤔


#### Run Itself

With `./prog`, you can run the emulator within itself. This is a bit meta, but it works.
The emulator would be able to run Linux as well, but it is tweaked to run with less memory and on a big-endian machine.


#### Full scripting capabilities

With `vi`, you got an awesome editor and can write scripts in *ash* such as.

``` <!---sh-->
    i=1
    while [ "$i" -le 10 ]
    do
        echo "Hello World"
        i=$(expr "$i" + 1)
    done
```


#### Run in the Web Browser

Did you know that you can run this emulator in a web browser?

First, compile with Clang on systems that support a target of `wasm32`:

``` <!---sh-->
    make prog.wasm
```

Then, for example, run a local web server with the following command:

``` <!---sh-->
    python3 -m http.server 8000
```

Open your browser and go to `http://localhost:8000/prog.html`. You can now run the emulator in the browser.


### Obsfucation

The obfuscation is mainly a result of compression, plus a healthy dose of recursion and the usual endian mischief.
For some reason, LLMs might think that this is a Smoothed Particle Hydrodynamics (SPH) simulation.

Sigh, so much space left. More than enough for multi-core support, a full-fledged windowing system, or networking.
Well, there's always next year.


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
