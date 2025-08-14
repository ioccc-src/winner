The following hints were used for myself but also I offer them for those who
wish to more easily follow the code, though that might or might not help that
much. If a variable or other kind of symbol is missing or is not what it says
here that was by (in some cases) simply missing it or (in other cases) due to
having changed things a fair amount; this submission took a lot of work and time
to get everything in.

The following variables are of primary concern (some temporary ones are not
documented I think):

- O: how much you spend on oxen
- R: amount spent on food (and how much you have)
- E: amount spent on ammo (and how much you have)
- G: amount spent on clothing (and how 'much' you have - a misnomer)
- O: how much you spend on oxen (and how 'many' you have - a misnomer)
- N: amount spent on miscellaneous supplies (and how 'many' you have - a misnomer)
- T: how much money you have (in US dollars)
- e: ate an ox
- b: hp (hit points, starts out at 666, allows for survival in conditions you
can't in the original) or stamina (kind of a combination - if you get injured
and you see the doctor and can afford it you will not keep losing hp but you
won't gain any either). Alt code allows you to specify how many hp (default
666), if you specify also max number of turns (NB: only prog.alt.c, not
prog.alt2.c).
- A: turn number for setting date (the first week, Monday 29 March 1847 is at
16 so to print the second week day date month and year (though it does it March
29 like the American way) you would do `V(A+16)`) (note that the date is not set
in a variable but rather for printing the date)
- I: unused except to spell out OREGON TRAIL.
- L: amount spent on items at fort (used as a temporary money value for
calculations at fort)
- q: event number
- f: flag for injury
- M: total distance travelled
- a: flag for illness
- z: flag for fort option
- K: the `FILE *` (data file)
- y: contents of data file
- p: used to print (one character at a time) the strings (encrypted version only)
- r: (unsigned) answer to certain questions
- d: son froze to death (and you ate him)
- J: file length read (fun fact: as part of obfuscation in multiple levels, `J
!= strlen(y)`!). It's reused in the V function after being set to 0.
- l: non-zero when hunting.
- W: flag for clearing Blue Mountains.
- Q: got dysentery and went to doctor (I think only if you could afford the
doctor but not sure)
- B: if non-zero, can't afford the doctor, don't try again (this prevents a
flood of the message each turn).
- h: I believe this is if you were injured and could afford the doctor.
- c: hit blizzard.
- X: passed South Pass.
- i: been poisoned; you will be dead shortly (sorry - that's what happens when
you have a pact with the devil!).
- g: how many limbs you've had to cut off (surgeon's cut edition)
- t: temporary array for purchasing at forts.
- u: temporary unsigned int to iterate through array `t` (and maybe other
uses, not sure now).
- v: non-zero means ran out of oxen so as to not flood user every turn with
certain messages. But if you buy more that could in theory happen again. Note
that some messages might be printed instead of the you have run out of oxen
message, if they're the ones causing it, though I'm not going to say this is in
every case as there are a lot of ways for this to happen.
- `C`: alt code only, max number of turns (specified at command line, default
21).
- any other variable I haven't the foggiest, even if it's not related to fog (of
which there is an event where you encounter fog) - sorry. An example here is
`m`.


When an amount spent (if it happens, not necessarily going to for every
variable) spent ends up being < 0 (it's not allowed to go that low when
purchasing) it means that there is an insufficient amount (thus a variable
reuse).

The array:

``` <!---c-->
    long *o[]={ &O, &R, &E, &G, &N  } /* animals, food, ammo, clothing, misc. supplies
```

is used in at least one loop to not have to do checks individually. The
variables, btw, are not how many as such (well in some cases it is, although
with the number of animals it's a 'taken at liberty' and based on my
interpretation of the original 1978 BASIC game) but rather
how much was spent on them. As for the ammo: $1 spent on ammo means a belt of 50.
That means another variable has to exist (that would be the `I` one) and
every time a purchase is made (at fort or initially) `I` is set to `E * 50`.

The functions:

- main(): you know what this is: or...do you?
- k(): the function that determines if you shoot successfully.
- x: uses `rand()` to get a pRNG number in a range.
- V: the nasty function that decrypts (one character at a time) strings in the
data file. Or doesn't really decrypt it per se.
- Z: calculates address of a block in the file (used by function `V` and macro `S`).

The macro:

- S: scanf macro.
- w: death macro which will 'goto hell'.

If you expect me to try and describe the labels I will direct you straight to
line 22!
