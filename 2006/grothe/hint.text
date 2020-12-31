# Most Obfuscaed Audio

Aaron Grothe
2205 South 51st Street
Omaha, NE 68106
US

## Judges' Comments:

### To build:

        make grothe

### To run:

        ./grothe 65000000 10000000 1344 < twinkle.txt

... and then put on your "electronic ears".  You may find using
a tunable scanning electronic ear helps.

Most of the time, interference is annoying.  This entry is the
exception that proves the rule.  What is a bug to some is a
feature to this entry.  :-)

## Selected Author's Comments:

The program draws patterns on the screen that can be picked up by a
shortwave radio.   It emulates the frequencies for an old fashion touch
tone phone, so old songs can be played by hitting 0-9,#, and *.

To be able to run the program you need to determine the following
parameters

        carrier_freq     - base frequency used to host music
        pixelclock       - refresh rate of the monitor
        horizontal_total - total scan along the horizontal axis

If you have xvidtune installed you can get the pixelclock and
horizontal total with the following command

        xvidtune -show | head -n 1 |
                awk '{ print "pixelclock " $2 * 1000000 " horizontal_total = " $6 }'

example from my laptops

        ./grothe 65000000 10000000 1344 < twinkle.txt

Even if the user gets a setting off, the sound will usually be able to be
heard on AM at a multiple of the original frequency

The core idea of using a machine to play music on AM radio goes all the
way back to the Altair computers and Timex Sinclair ZX-81s.

### Several example songs

Olympic Fanfare - from antang@phakt.usc.edu - Tony

        4-9-91231,2222-321123123-9-91231,2222-32112321

Twinkle Twinkle Little Star - from fsufunkyb@aol.com - Ben Schmidt

        1199##9-6633221-9966332-9966332-1199#9-6633221-

Generic Arabian Tune - from rdippold@qualcomm.com -Ron "Asbestos" Dippold

        453,54,4569564459,9#95458,8987453 54

Others can be found by doing a search for "touch tone phone songs".

### Obfuscations

- Some numbers expressed in Octal, some in hex and some in decimal
  "A foolish consistency is the hobgoblin of little minds" -
  Ralph Waldo Emerson
- Funky scoping, looking at the nanosleep section and
  XsetWindowAttributes declares local variables
- Algorithm is very weird, uses y dimension to draw carrier frequency
  and x dimension to draw audio frequency, based on Erik Thiele's
  Tempest for Eliza
- lack of #defines confuses many people :-)
- figuring out your pixelclock and horizontal total and which carrier
  frequency to use can be an exercise in obfuscation for the user
- use of commas in various places, confuses most c code beautifiers
  sometimes making the beautified code harder to read
- use of static to ensure initilization is EVIL and done in several
  places
- uses static declarations & voids function returns we don't care about
  making the code harder to read
- does sound using only X11 libs, no other libs required
- demonstrates tempest emissions in a fun/easy way
- follows good programming practices of actually setting exit codes and
  giving usage when run with incorrect parameters

### References

Tempest for Eliza - Basis for Algorithms

> <http://www.erikyyy.de/tempest/>

Tempest AM - Another early program in this field

> <http://silcnet.org/priikone/programs.php?lang=en>

Paper by Markus G. Kuhn's and Ross J. Anderson's,
"Soft Tempest: Hidden Data Transmission Using Electromagnetic Emanations"

> <http://www.cl.cam.ac.uk/~mgk25/ih98-tempest.pdf>
