# Best Font Engine:

    Jeff Newbern
    28 Jeanette Ave. #1
    Belmont, MA 02478

# To build:

```sh
make
```

### To run:

```sh
./newbern [file.dat arg]
```

### Try:

```sh
./newbern newbern.dat "IOCCC 2004"
echo SOS | ./newbern
```

## Judges' comments:

The program is formatted using the same font glyphs as the example
data file.

## Author's comments:

This is a configurable banner-like program.

### Examples:

- To convert a character glyph into a data file

```sh
./newbern char < some_nicely_shaped_text >> data_file
```

- To print a string using glyphs from a data file

```sh
./newbern data_file a_string
```

### Extra functionality:

The program can also act as a Morse encoder, unarguably.

It also has double-super-secret encryption capabilities.
Decryption is left as an exercise for the reader.

### Portability:

The program assumes an ASCII operating environment.

The program is best viewed with tab-stops set to 8.
