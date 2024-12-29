# Testing procedure

Because of the significant amount of possible combinations of settings and the
fact that based on each setting if the text does not have the same sequence -
even one letter off - then you cannot get the same output - I had to come up
with a way to test the entry. Here's the problem with just the default settings:
the same number of characters, the same starting, but the moment a letter
differs the rest of the message will change even if the rest of the message is
the same:

``` <!---sh-->
    $ echo A man and his dog walked in the park...|./prog
    G spy ige lqk eav ptccpu di clm erkh...

    $ echo A dog and his man walked in the park...|./prog
    G luq ige lqk jou ptccpu di clm erkh...

    $ echo A man and his dog and its dog walked in the park...|./prog
    G spy ige lqk eav mbt bwz iwb jsojus pe hnt imny...
```

As can be seen as soon as a letter is different in the sequence it changes the
result! So what could be done? First of all I had to make sure that the
invocations I gave could be properly duplicated. To do this I had key files that
I could use via `recode` and also I did input some manually. This includes the
cake recipe key file that originally was in this entry but is now only in
[2020/ferguson1](../ferguson1/index.html). Now, though, I have a simple
html file with a fun message for you to decipher, if you wish to find the right
key, to explore the entry. The script which I will include below can be modified
to try and find the right key.

## General script format

``` <!---sh-->
    STR="$(echo ABC | ./prog|tail -n1)"

    if [ "${STR}" != "GYM" ]; then
    echo "Failed 'ABC' test"
    exit 1
    fi
    STR="$(echo "${STR}" | ./prog|tail -n1)"
    if [ "${STR}" != "ABC" ]; then
    echo "Failed 'GYM' test"
    exit 1
    fi

    # a simpler way to check that it works:
    ./recode -Renigma.dat -fenigma.html | ./prog - 2>/dev/null > enigma.txt
    ./recode -Renigma.dat -fenigma.txt | ./prog - 2>/dev/null | diff -s - enigma.html

    ./recode -Robfuscation.key -fobfuscation.txt | ./prog - 2>/dev/null >  out
    diff out obfuscation.md || echo "Obfuscation test 0.5 failed"

    ./recode -Robfuscation.key -fout | ./prog - 2>/dev/null > out2
    diff out2 obfuscation.txt || echo "Obfuscation test 1.0 failed"

    ./prog < prog.c > out
    ./prog < out > out2
    diff out2 prog.c || echo "Self obfuscation test 1.0 failed"

    mkdir -p tests || exit 1
    cd tests || exit 1

    let n=0
    while [ "${n}" -lt 100 ]; do

    for f in ../input.txt ../prog.c ../README.md ../recode.md ../recode.1 ../enigma.1; do
        ../recode -r -oconfig -f"${f}" | ../prog - 2>/dev/null > out
        ../recode -Rconfig -fout | ../prog - 2>/dev/null > out2
        diff out2 "${f}" || echo "Failed randomised test for file: ${f}"
    done
    let n=n+1
    done
    rm -f out out2
    cd ..
    rm -f out out2
```

Please don't expect the above script to work without a bit of modification as
it's not been tested recently and I did make some adjustments when putting this
document in the website. Still that should give you the idea.

### Historical note:

At the time of development the server was CentOS but as Red Hat decided to axe
it it is now Rocky Linux. The above script was only tested in macOS but it
should work fine in linux too. Also, the enigma.txt part was added in June 2024
which expects output so below when I say if I got any output there was a problem
this is no longer true.


## Back to the testing:

Anyway, If I got any output I knew there was a problem. I did not get any output and since
this tested the default settings, two customised settings as well as 100
randomised runs for each of the files listed in the script I believed this
works well. Tests run under Fedora, CentOS and macOS with the same results.

I believe this entry can be used with EBCDIC as it appears that the characters
used are in contiguous sequence but I do not know for certain. Neither do I know
about big endian: I don't believe it matters but I have no way to test this
either.

If there are any discrepancies in the recode.html or any other thing I
pasted it's probably because of the way I changed the display (or else the
random option in `recode`!).

If there are any inconsistencies in input/output one also has to be certain that
input was put in correctly (as I discussed earlier). The results of the script
are the same under Fedora, CentOS and macOS but I have put the main testing
platform as macOS because these days I mostly use my laptop (I tend to ssh into
the other two boxes more and as for the CentOS it's only console anyway. Since
it's just text I/O it an terminal emulator shouldn't matter either.).

## Command that might be used to decipher the `enigma.txt` file:

The following command can be used to decipher the file except that you must
provide the key file (or the key as a string) with the correct key (see
[recode.html](recode.html) for a list of keys to try) in order to get correct
output:

``` <!---sh-->
        ./recode -Renigma.dat -fenigma.txt | ./prog - 2>/dev/null > enigma.html
```

Enjoy!
