## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    clear; ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

The original submitted entry was flickering when executed.  This alternate
code implements the original level of flickering.

The original submitted entry was flickering when executed. We added code to stop that.
After adding this to the compile line:

```
    -DQ='fputs("\033[H",stdout);'
```

We changed the source as follows:

``` <!---sh-->
    make diff_alt_prog
```


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./prog.alt
```


## Judges' remarks:

This prize in **cyclonic coding** will certainly twist your perspective on C code.

This is not your garden variety tempest in a teapot. It's a tornado in a window!


## Author's remarks:


### 3D fluid simulation

```
    advection=semi-lagrangian scheme
    projection=pressure solver with neumann boundary condition
    linear solver=gauss-seidel relaxation
    rendering=ray marching
```


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
