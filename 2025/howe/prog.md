inv880(6)
=========

This mini `Space Invaders` like game was inspired by the Casio MG-880 and SL-880 calculators.  While the game resembles the original MG-880 game, the play might be slightly different.


Synopsis
--------

        inv880


Play
----

Digital invaders (`0`, `1`, `2`,... `9`, the veteran `👾`, and the UFO `🛸`) will attack your base.  Invaders will appear in waves of 16 and you only have 30 shots per wave.  The invaders will first appear at Angels 6 and every 2 seconds descend 1000 meters until they hit your shield at ground level, weakening it, and eventually destroying you.  As time progresses the invaders' descent will intensify for periods.  The game ends when you are destroyed.  The farther away from your own base you eliminate invaders, the higher your score (digit + angels * 10, `👾` = 150, `🛸` = 300).

       Aim Shield
      30 0 |||       7 6 👾
      Ammo           Invaders

Shield strength denoted by complete layers: `|||` 100%, `|| ` 66%, `|  ` 33%, and `  ` 0%.  When the shield is at 0% and an invader reaches your base, game over.

* ` TAB   `     Press to aim, cycles through target choices before firing.
* ` ENTER `     Fire!  Kill lowest matching invader.
* ` ^C    `     Quit early.


Example:

* Press `TAB` multiple times to aim at the invader you want to shoot.

       30 0 |||   8 6 7 6 👾

* Press `ENTER` to fire.  It knocks back invaders in front of the target.

       29 6 |||     8 7 6 👾

* Press `ENTER` again to fire.  Select a new target.

       28 6 |||       8 7 👾


MG-880 Differences
------------------

* The scoring is different.
* There were two stages of nine rounds each, with 16 units per round, which then repeated.
* You had a limit of 30 bullets per round.
* The UFO appearance was based on the score being a multiple of 10.
* There was no veteran `👾` invader.
* There was no ammo counter.


Issues
------

* Some terminal fonts might not have glyphs for some Unicode code points and will require finding a suitable fixed width font.

* Cygwin `mintty` might flicker when displaying the double-wide emoji for the veteran `👾` and UFO `🛸` characters:

  - Without `tmux`: Review `man mintty` with respect to Unicode and Emojis and check the Windows shortcut.  The shortcut command that was tested and works:

        D:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico -o Emojis=google -o Charwidth=locale -

  - With `tmux`: Currently the only solution is to downgrade the ASCII version of the game.


References
----------

* Casio SL-880 Calculator  
  <https://www.casio.com/content/dam/casio/global/support/manuals/calculators/pdf/004-ja/s/SL-880_WA_JA.pdf>

* Casio MG-880 V SL-880 Game Play  
  <https://www.youtube.com/shorts/igaKl4gdr5A>

* Space Invaders, Wikipedia  
  <https://en.wikipedia.org/wiki/Space_Invaders>

* Space Invaders (1980), Player One  
  <https://www.youtube.com/watch?v=8teuyCYeDxQ>

* Operator, Real McCoy  
  <https://www.youtube.com/watch?v=lRyDPqZhhz8>

* The Eve of the War, Jeff Wayne  
  <https://www.youtube.com/watch?v=Poii8JAbtng>

-END-
