# Best tool to reveal holes

    Yusuke Endoh  
    Twitter: @mametter  

## To build:

```sh
make
```

## To run:

```sh
./prog < textfile > output.gif
```

## Try:

```sh
./prog < golem.txt > golem.gif
./prog < smily.txt > smily.gif
```

## Judges' remarks:

To get the best experience, use a GIF viewer that can handle animated gifs.
On OS X you can use Safari using "open -a Safari smily.gif"

Some things to consider are that this 2.5KiB gem encodes a 96 character 8x8
font (naively this could already take 6144 bytes) and a GIF encoder.  But
how does it know which characters are closed?

You should only give this program printable ASCII characters.

Unfortunately this won't run on your PDP8, if you had one, as it needs at
least 2MiB of memory to run in.

## Author's remarks:

This program generates an animated GIF from a plain text.  Run:

```sh
cc -o prog prog.c
./prog < invisible.txt > invisible.gif
```

Open invisible.gif and then wait a minute.  You will see a hidden message.
Can you tell the difference between letters that leaves the mark and ones that does not?

Other examples:

```sh
./prog < golem.txt > golem.gif
./prog < smily.txt > smily.gif
```

The program itself has a hidden message.

```sh
./prog < prog.c > prog.gif
```

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
