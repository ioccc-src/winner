I a
U a
I b
U b
I c
U c
I d
U d
I e
U e
I f
U f
I g
U g
I h
U h
I i
U i
I j
U j
I k
U k
I l
U l
I m
U m
L
D m
E
L
D l
E
L
D k
E
L
D j
E
L
D i
E
L
D h
E
L
D g
E
L
D f
E
L
D e
E
L
D d
E
L
D c
E
L
D b
E
L
D a
E
I m
D n (1<<9)
L
D n 0
E
I l
D o (1<<8)
L
D o 0
E
I k
D p (1<<7)
L
D p 0
E
I j
D q (1<<6)
L
D q 0
E
I i
D r (1<<5)
L
D r 0
E
I h
D s (1<<4)
L
D s 0
E
I g
D t (1<<3)
L
D t 0
E
I f
D u (1<<2)
L
D u 0
E
I e
D v (1<<1)
L
D v 0
E
D vv (n+o+p+q+r+s+t+u+v+1)
D ff (defined(d)*16+defined(c)*8+defined(b)*4+defined(a)*2+1)
F vv==1
U vv
D vv 2
E
F ff<vv 
F ff!=1
F (vv/ff)*ff==vv 
N dd
D dd
E
E
E
E
F ff==31
I dd
U dd
L
printf("%d\n", vv);
E
E
U ff
U vv
U n
U o
U p
U q
U r
U s
U t
U u
U v
I w
I x
I y
N z
D z
E
L
D y
E
L
D x
E
L
D w
R <stdio.h>
main(){
E
N z
M
M
M
M
M
M
M
M
M
M
M
M
M
M
M
E
I z
U z
L
I y
U y
L
I x
U x
L
I w
U w
}
E
E
E
E
