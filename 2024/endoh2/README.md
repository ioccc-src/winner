## Award presentation:

Watch the [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse)
YouTube show for this entry:

> [IOCCC28 - 2024/endoh2 - Prize in solid body physics](https://www.youtube.com/watch?v=KT9Fgg4t7gY)


## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog < body.txt
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Playing with this entry, we were able to experience joy akin to
[what Niels Bohr and Wolfgang Pauli could have experienced when they played with the Tippe-Top](https://repository.aip.org/wolfgang-pauli-and-niels-bohr-demonstrating-tippe-top-toy).

We invite you to experiment beyond the [try.sh](%%REPO_URL%%/2024/endoh2/try.sh), and test with these "_body.txt_" files:

* bottle.txt
* cylinder.txt
* egg.txt
* halo.txt
* stick.txt
* tippe-top.txt
* tippe-top2.txt
* tippe-top3.txt
* top.txt
* top2.txt
* top3.txt
* top4.txt
* umbrella.txt
* vase.txt

For example:

``` <!---sh-->
    ./prog < vase.txt
```

Moreover, you should experiment with various simulation parameters.  On the make line you may set:

```
    | Perameter   | Default  | Meaning
    |-------------|-----------------------------------------------------|
    | WIDTH       |  120     | Screen width                             |
    |             |          |                                          |
    | HEIGHT      |   24     | Screen height                            |
    |             |          |                                          |
    | TIMESTEP    |    0.01  | Simulation time step                     |
    |             |          |     a smaller dt                         |
    |             |          |     increases precision                  |
    |             |          |     down the simulation                  |
    |             |          |                                          |
    | RESTITUTION |    0.5   | Coefficient of restitution               |
    |             |          |                                          |
    | FRICTION    |    0.5   | Coefficient of friction                  |
    |             |          |                                          |
    | RPM         |  750     | Initial rotation speed in RPM            |
    |             |          |                                          |
    | FASTRPM     | 4000     | Tipple top initial rotation speed in RPM |
    |             |          |    used by ./tipple, not ./prog          |
    |             |          |                                          |
    | TILT        |    5     | Initial tilt angle                       |
    |             |          |    in degrees                            |
    |             |          |    0 is upright                          |
    |             |          |    positive values tilt to the right     |
```

For example, to increase the "_Coefficient of friction_" to **0.75**,
the "_Initial rotation speed in RPM_" to **600**, and the "_Initial
tilt angle_" to **15**:

``` <!---sh-->
    make clobber all FRICTION=0.75 RPM=600 TILT=15

    ./prog < top.txt
```

Now we would like to see if this entry can be hacked to demonstrate the
[Dzhanibekov effect](https://en.wikipedia.org/wiki/Tennis_racket_theorem).


## Author's remarks:


### A Spinning Top Simulator

```
                                       @@
                                      @@
                             @@@@@@@@@@@@
                         @@ @@@@@@@@@@@@@@@@
                        @@@@  @@@@@@@@@@@@@@@@
                       @@@@@@@    @@@@@@@@@@@  @
                       @@@@@@@@@@@           @@@
                        @@@@@@@@@@@@@@@@@@@@@@@@
                        @@@@@@@@@@@@@@@@@@@@@@@@
                         @@@@@@@@@@@@@@@@@@@@@
                         @@@@@@@@@@@@@@@@@@@@
                          @@@@@@@@@@@@@@@@
                          @@@@@@@@@@@@@
                           @@@@@@@@@
                             @@@@
                             @@
                            @@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
```

This is a physics engine that simulates the motion of a rotating rigid body, such as a [top](https://en.wikipedia.org/wiki/Top).


#### How to run

Compilation requires specifying several `-D` options:

```
$ gcc -O3 -DW=120 -DH=24 -Ddt=0.01 -De=0.5 -Du=0.5 -Drpm=1000 -Dtilt=5 -o prog prog.c
```

These options define the following parameters:

* `-DW=120`: Screen width.
* `-DH=24`: Screen height.
* `-Ddt=0.01`: Simulation time step (a smaller `dt` increases precision but slows down the simulation).
* `-De=0.5`: Coefficient of restitution.
* `-Du=0.5`: Coefficient of friction.
* `-Drpm=1000`: Initial rotation speed (in RPM).
* `-Dtilt=5`: Initial tilt angle (in degrees; 0 is upright; positive values tilt to the right).

Then, run the program like this:

```
$ ./prog < top.txt
```


#### Input file format

The input file defines the shape of a rigid body. Here's an example:

```
// A typical spinning top

// Use `-Drpm=1000 -Dtilt=5`

.
.
.  // Twirl here
.
.
.
...
   #####
        ##
          #  // Spin!
        ##
   #####
 ..
.
.
.  // Looks painful
```

This figure is rotated around its left edge to create a 3D object (a solid of revolution).
Only solids of revolution are supported by this simulator.

Internally, the rigid body is modeled as a collection of particles (point masses). Each character in the input file has the following meaning:

* A full-stop (or any printable character whose LSB is 0): Represents light particle.
* A hash (or any character whose LSB is 1): Represents heavy particle.
* A space: Represents no particle (empty space).
* A slash: Indicates the start of a comment; everything after it on the line is ignored.


#### Algorithm overview

The core algorithm works as follows:

1. Compute the inertia tensor
2. Compute an inverse of the tensor
3. For each particle in contact with the floor:
  3-1. Compute the normal force
  3-2. Compute friction
  3-3. Convert these into the resultant force and torque acting on the body's center of mass
4. Update the position, velocity, angular velocity, and orientation of the body

For the detailed theory, refer to a physics textbook.

To keep code size minimal, this simulator uses [quaternions](https://en.wikipedia.org/wiki/Quaternion) to represent 3D vectors and matrices.
Quaternion multiplication is powerful, allowing the inertia tensor and its inverse to be calculated concisely, each requiring only about 100 characters of code.
Because `math.h` doesn't natively support quaternions for these operations, it's not used at all. This also means linking with `-lm` is unnecessary.

Motion blur is used in the rendering. You can observe it more clearly by pausing the animation (e.g., with Ctrl+S in some terminals).

Distant points appear as colons (`:`), while closer ones appear as at-signs (`@`).


#### Included data

A few shape files are provided. The top*.txt files are standard spinning top shapes.

```
$ gcc -O3 -DW=120 -DH=24 -Ddt=0.01 -De=0.5 -Du=0.5 -Drpm=1000 -Dtilt=5 -o prog prog.c && ./prog < top.txt

$ gcc -O3 -DW=120 -DH=24 -Ddt=0.01 -De=0.5 -Du=0.5 -Drpm=500 -Dtilt=5 -o prog prog.c && ./prog < top2.txt

$ gcc -O3 -DW=120 -DH=24 -Ddt=0.01 -De=0.5 -Du=0.5 -Drpm=500 -Dtilt=5 -o prog prog.c && ./prog < top3.txt

$ gcc -O3 -DW=120 -DH=24 -Ddt=0.01 -De=0.5 -Du=0.5 -Drpm=500 -Dtilt=5 -o prog prog.c && ./prog < top4.txt
```

The [tippe top](https://en.wikipedia.org/wiki/Tippe_top) is a top that flips itself over when spun quickly.

```
$ gcc -O3 -DW=120 -DH=24 -Ddt=0.01 -De=0.5 -Du=0.5 -Drpm=2200 -Dtilt=5 -o prog prog.c && ./prog < tippe-top.txt

$ gcc -O3 -DW=120 -DH=24 -Ddt=0.01 -De=0.5 -Du=0.5 -Drpm=4000 -Dtilt=5 -o prog prog.c && ./prog < tippe-top2.txt

$ gcc -O3 -DW=120 -DH=24 -Ddt=0.01 -De=0.5 -Du=0.5 -Drpm=4000 -Dtilt=5 -o prog prog.c && ./prog < tippe-top3.txt
```

Spinning a boiled egg? Try this with `-Dtilt=90` to start it from a lying position.

```
$ gcc -O3 -DW=120 -DH=24 -Ddt=0.01 -De=0.5 -Du=0.5 -Drpm=1300 -Dtilt=90 -o prog prog.c && ./prog < egg.txt
```

Spin everyday items -- no risk of breaking them:

```
$ gcc -O3 -DW=120 -DH=24 -Ddt=0.01 -De=0.5 -Du=0.5 -Drpm=1000 -Dtilt=175 -o prog prog.c && ./prog < bottle.txt

$ gcc -O3 -DW=120 -DH=24 -Ddt=0.01 -De=0.5 -Du=0.5 -Drpm=1000 -Dtilt=5 -o prog prog.c && ./prog < bottle.txt

$ gcc -O3 -DW=120 -DH=24 -Ddt=0.01 -De=0.5 -Du=0.5 -Drpm=1000 -Dtilt=5 -o prog prog.c && ./prog < umbrella.txt

$ gcc -O3 -DW=120 -DH=24 -Ddt=0.01 -De=0.5 -Du=0.5 -Drpm=2000 -Dtilt=5 -o prog prog.c && ./prog < vase.txt

$ gcc -O3 -DW=120 -DH=24 -Ddt=0.01 -De=0.5 -Du=0.5 -Drpm=2000 -Dtilt=20 -o prog prog.c && ./prog < vase.txt
```

More shapes: `stick.txt`, `cylinder.txt`, `halo.txt`, and even `prog.c`.

Yes, `prog.c`  itself can be used as input.  Try it:

```
$ gcc -O3 -DW=120 -DH=24 -Ddt=0.01 -De=0.5 -Du=0.5 -Drpm=1000 -Dtilt=5 -o prog prog.c && ./prog < prog.c
```


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
