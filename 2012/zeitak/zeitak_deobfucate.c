#include <stdio.h>
#include <stdlib.h>
typedef void *(*(*(*(*p) (void *, void *)) (void *, void *)) (void *, void *)) (void *, void *);

typedef struct frst {
    struct frst *a;
    struct frst *UNUSED;
}    frst;

typedef struct scnd {
    struct frst *UNUSED;
    struct frst *a;
}   *scnd;

void *
arg1(void *a1, void *a2)
{
    return a1;
}

void *
arg2(void *a1, void *a2)
{
    return a2;
}

typedef unsigned char u_char;

frst *w,
     a = {(frst *) arg1, (frst *) arg1},
     b = {(frst *) arg1, (frst *) arg2},
     c = {
    (frst *) arg2, (frst *) arg1
},
d = {
    (frst *) arg2, (frst *) arg2
};

frst table[] = {
    &b, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,
    &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,
    &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,
    &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,
    &d, &d, &d, &d,     &c, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &c, &b,
    &b, &d, &a, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,
    &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,
    &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,
    &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,
    &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,
    &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,
    &d, &d, &d, &d,     &d, &d, &b, &b,     &d, &d, &a, &b,     &d, &d, &d, &d,
    &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,
    &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,
    &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,     &d, &d, &d, &d,
    &d, &d, &d, &d,     &d, &d, &b, &c,     &d, &d, &a, &c,     &d, &d, &d, &d,
    &c, &b, &b, &b,     &d, &d, &a, &a
};

frst *
C(frst * a, frst * b)
{
    frst *p = malloc(sizeof(frst));

    p->a = a;
    p->UNUSED = b;
    return p;
}

u_char k2 = sizeof(table);

p
f(p a, p b)
{
    u_char k;
    frst d;
    p v,
      r,
      q,
      i,
      C,
      c,
      u,
      g,
      m = (p)
    ((*((*((*w).a)).a)).a);

    C = (p) ((*((*&table[fread(&k, sizeof(u_char), sizeof(u_char), stdin)]).a)).a);

    v = C(arg2, arg1);
    d = table[k = (u_char) C(k2, k)];
    c = (u = a(b, arg2), i = ((p) ((*(scnd) ((*((*w).a)).a)).a)) (arg2, ((*((*&d).a)).a)), (a(((*((*(scnd) & d).a)).a), ((p)
															 ((*((*(scnd) & d).a)).a)) (arg2, arg1))) (b(((*(scnd) ((*(scnd) & d).a)).a)
																				     ,((p) ((*(scnd) ((*(scnd) & d).a)).a)) (arg2, arg1)), arg2)); {
	p a = (p)
	((*(scnd) ((*&d).a)).a); {
	    p b = C(arg2, i(u(arg2, arg1), arg2)); {
		p u = C(arg2, ((p) ((*((*&d).a)).a)) (arg2, arg1));

		((*((*((*w).a)).a)).a)
		  = (frst *) i(arg1, ((*((*((*w).a)).a)).a));
		r = b(m(c, arg2)
		      ,C(m(arg2, ((p) ((*(scnd) ((*((*w).a)).a)).a)) (arg2, arg1))
			 ,(f)));
		v = b(arg2, v);
		i = b(a(arg2, arg1), arg2);
		g = (b) (a(m(c(arg2, arg1), arg1), arg2), arg2);
		q = u(((*(scnd) ((*&d).a)).a), arg2) (((p) ((*(scnd) ((*((*w).a)).a)).a)) (((p)
											    ((*((*(scnd) & d).a)).a)) (((*((*(scnd) ((*w).a)).a)).a), ((p) ((*((*(scnd) ((*w).a)).a)).a)) (arg2, arg1)) (arg2, arg1), arg2) (arg2, arg1), arg2);
		((*((*(scnd) ((*w).a)).a)).a) = (frst *) u(((*(scnd) ((*&d).a)).a), arg2)
		  (((p) ((*(scnd) ((*((*w).a)).a)).a)) (arg2, arg1), arg2) (((*((*(scnd) & d).a)).a)
									    ,((*((*(scnd) ((*w).a)).a)).a));
	    }
	} ((*(scnd) ((*((*w).a)).a)).a) = (frst *)
	  q(a = ((p) ((*(scnd) ((*((*w).a)).a)).a)) (arg2, arg1), ((*(scnd) ((*((*w).a)).a)).a));
	fwrite((k = k, &k2), sizeof(u_char), u(arg2, g) (sizeof(u_char)
							 ,(u_char) sizeof(frst[sizeof(frst[sizeof(frst[sizeof(frst)])])])), stdout);
	fwrite((k2 = k, &k), sizeof(u_char), u(arg1, g) (sizeof(u_char)
							 ,(u_char) sizeof(frst[sizeof(frst[sizeof(frst[sizeof(frst)])])])), stdout);
	((*((*((*(scnd) w).a)).a)).a) = (frst *) u(((p) ((*((*((*(scnd) w).a)).a)).a))
						   (arg2, arg1), ((*((*((*(scnd) w).a)).a)).a));
	((*((*(scnd) ((*w).a)).a)).a)
	  = (frst *) q(a(((*((*(scnd) & d).a)).a), ((*((*(scnd) ((*w).a)).a)).a))
		       ,((*((*(scnd) ((*w).a)).a)).a));
    }
    ((*(scnd) ((*((*(scnd) w).a)).a)).a) = (frst *)
      ((p) ((*((*((*(scnd) w).a)).a)).a)) (((*(scnd) ((*((*(scnd) w).a)).a)).a)
					   ,u(((p) ((*(scnd) ((*((*(scnd) w).a)).a)).a)) (arg2, arg1), ((*(scnd) ((*((*(scnd) w).a)).a)).a)));

    g = u((q = u(C(arg1, ((p)
			  ((*((*((*(scnd) w).a)).a)).a)) (((*(scnd) ((*((*(scnd) w).a)).a)).a), arg2)), arg2))
	  (arg2, arg1), g);
    v = g(arg1, i(u(arg2, i(f, arg2))
		  (((*((*(scnd) & d).a)).a), ((*(scnd) ((*(scnd) & d).a)).a)), v))
      ,r = q(arg2
	     ,g(f, i
		(v(f, (((*((*((*w).a)).a)).a) = (frst *) m, arg2)), r)));
    return q(arg2, v) (r(g(arg1, a), g(arg1, b)), r);
}

int
main()
{
    w = C(C(C((frst *) arg2, (frst *) arg2), C((frst *) arg2, (frst *) arg2)), C(C((frst *) arg2, (frst *) arg2), C((frst *) arg2, (frst *) arg2)));
    return printf((u_char *) f(arg2, arg2) ("OK\n", "\n ^ Error\n"
					    ""));
}
