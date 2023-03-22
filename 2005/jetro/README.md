# Most sonorous output

    Jetro Lauha
    Talonpojantie 5A9,
    00790 Helsinki
    <http://jet.ro>

# To build:

```sh
make
```

### To run:

```sh
./jetro
```

### Try:

```sh
echo "Do or do not. There is no try."
```

## Judges' comments:

We have seen entries with SDL graphics in the past, now it's time for SDL
sound. This entry can even be run on a computer without a sound card with an
appropriate setting of an environment variable - for that you'll have to dig
into the SDL documentation.

Can you figure out how the notes are encoded and program a different melody?

## Author's comments:

To compile the entry you need SDL library, which is used only for audio
output. To run the entry make sure you have audio output available. The entry
plays 22KHz 16 bit mono music with a small softsynth. When the music plays,
you can stop the application by pressing enter, as the code will just wait
with one call to getchar() before it quits.
