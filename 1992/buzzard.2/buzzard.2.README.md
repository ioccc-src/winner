[buzzard.2.README.md](buzzard.2.README.md)  this file\
[buzzard.2.design.md](buzzard.2.design.md)  description of FIRST (design documentation of THIRD)\
[third](third)				    implementation of THIRD in FIRST\
[help.th](help.th)			    online listing of THIRD primitives\


# FIRST demos:

Use  `./first < <demo>`.

[demo1.1st](demo1.1st)		prints Hello World! assuming ASCII


# THIRD demos:

Use `cat third <demo> | ./first`.


## Demo files:

[demo1.th](demo1.th)		prints Hello World! regardless of character set
[demo2.th](demo2.th)		demonstrates a simple loop
[demo3.th](demo3.th)		demonstrates a simple if test
[demo4.th](demo4.th)		recursive factorial calculating on the way up
[demo5.th](demo5.th)		recursive factorial calculating on the way down
[demo6.th](demo6.th)		demonstrates switching from compiler to execution mode


# Interactive THIRD:

Use `cat third - | ./first`.

To include the primitive on-line help, use
`cat third help.th - | ./first`.
