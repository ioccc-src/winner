# Best Output:

    Carlos Duarte
    Instituto Superior Tecnico
    Largo da Igreja, 5 R/C DTo
    Damaia
    2720 Amadora 
    Portugal

## To build:

        make all

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this so that it
would work with macOS. Once it could compile it additionally segfaulted under
macOS (it did not under linux) which he also fixed. Thank you Cody for your
assistance!


### To run

	./cdua

NOTE: on modern systems this might be hard to see it solve it in running time as
it goes so quickly but it will still show the result after execution.

## Judges' comments

This could be used as the basis of an a-maze-ing screen exerciser.

## Author's comments

A program that generates a maze, and then solves it, all this being
seen by the user.  Some highlights of obfuscation are: 3 steps
functions in one - main(), several recursive calls with conditional
actions, and just one (big and ugly) statement to solve the maze.
