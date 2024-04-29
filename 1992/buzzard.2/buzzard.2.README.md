## Useful files to view

- [buzzard.2.README.html](buzzard.2.README.html)	- this file
- [buzzard.2.design.html](buzzard.2.design.html)	- description of FIRST (design documentation of THIRD)
- [third](%%REPO_URL%%/1992/buzzard.2/third)		- implementation of THIRD in FIRST
- [help.th](%%REPO_URL%%/1992/buzzard.2/help.th)	- online listing of THIRD primitives


## FIRST demos:

Use:

```
    ./first < demo_file
```

- [demo1.1st](%%REPO_URL%%/1992/buzzard.2/demo1.1st)	- prints Hello World! assuming ASCII


## THIRD demos:

Use:

```
    cat third demo_file | ./first
```


## Demo files:

- [demo1.th](%%REPO_URL%%/1992/buzzard.2/demo1.th)	- prints Hello World! regardless of character set
- [demo2.th](%%REPO_URL%%/1992/buzzard.2/demo2.th)	- demonstrates a simple loop
- [demo3.th](%%REPO_URL%%/1992/buzzard.2/demo3.th)	- demonstrates a simple if test
- [demo4.th](%%REPO_URL%%/1992/buzzard.2/demo4.th)	- recursive factorial calculating on the way up
- [demo5.th](%%REPO_URL%%/1992/buzzard.2/demo5.th)	- recursive factorial calculating on the way down
- [demo6.th](%%REPO_URL%%/1992/buzzard.2/demo6.th)	- demonstrates switching from compiler to execution mode


## Interactive THIRD:

Use:

```
    cat third - | ./first
```

To include the primitive on-line help, use:

```
    cat third help.th - | ./first
```


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
