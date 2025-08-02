## To build:

``` <!---sh-->
    make all
```


## To use:


### Encryption

``` <!---sh-->
    prog < file.txt > file.enc.txt
```


### Decryption

``` <!---sh-->
    prog < file.enc.txt > file.txt
```


### Command line arguments

You can also specify SIZE of the text-stirring area and a PASSWORD.

``` <!---sh-->
    ./prog 30 < input > output
    ./prog PASSWORD < input > output
    ./prog 40 PASSWORD < input > output
```

You need to specify the same SIZE and PASSWORD to decrypt correctly.


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

It is well-known that the Enigma cipher was broken due to the fact that a letter could never map to itself.
Is this algorithm susceptible to a similar cryptanalysis?


## Author's remarks:


### Vortex Encryptor/Decryptor

Secure encryption/decryption is a black box. It's highly based on difficult mathematics. We just blindly TRUST when using it.

This entry is a visual vortex encryptor/decryptor for a text file.
You can visually see how this program stirs the text to encrypt/decrypt. It's not a black box at all.


### Easter Eggs


#### Random Encryptor/Decryptor

Some might dislike vortex-encryption algorithm. Alternately, there is one more visual text mixing algorithm.

``` <!---sh-->
    ./prog < prog.c > rand.c
```

This program `rand.c` is NOT A VORTEX encryptor/deryptor. You can see the text `N O /,T  ,A` somewhere in the code. It randomly swaps characters instead of stirring with vortex.

To check the randomness, compile it as an executable `rand` and try `./rand < prog.c` or `./rand < rand.c`.
You can find that the encrypted text claims to be really RAND/rand-om.


#### Important Passwords

"password" is the 1st most used alphabet password in the world. Wait, what's the 0th used password? It might be "ioccc" or "IOCCC".
Let's encrypt prog.c with these passwords.

``` <!---sh-->
    ./prog ioccc < prog.c > prog1.enc.c
    ./prog IOCCC < prog.c > prog2.enc.c
```

Imagine if you accidentally hit your head hard, forgot the password, lost everything except prog executable and the encrypted prog.c file.
There's nothing to worry about. Just like important passwords often written on sticky notes, you can find this password in the encrypted text.


### Internal


#### Encryption/Decryption

This program internally have forward-text-stir and backward-text-stir operation.
It tries both operation and select the one that makes the output have less entropy.
This is why this program doesn't need a command line argument such as `--encrypt` or `--decrypt`.


#### Seed and Hash

For security reason, vortex used to encrypt/decrypt varies over input text.
Seed is calculated with vortex-stir-stable hash algorithm. This hash doesn't change over encryption/decryption.
This is making hard to embed easter eggs into this program.


#### Vortex stirring algorithm

Character should not disappear by vortex stirring operation, so the velocity field of the vortex is required to be no divergence.
Velocity field that has no divergence can be created from a [stream function](https://en.wikipedia.org/wiki/Stream_function).
In this program, stream function which is a scalar field is made of horizontal, vertical and diagonal periodic waves.
With a simple mathematics, this vortex stirring operation can be decomposed into horizontal, vertical, and diagonal array rotation which is a reversible operation.


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
