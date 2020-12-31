-- The output of a certain stage of our compiler when run on its source,
-- with these differences:
--
--  * Definitions of the basic combinators so this file compiles.
--  (GHC won't like this file though, as the Scott encodings are unrolled,
--  which messes up the types.)
--  * A few syntax-based rewrites, e.g. Y(Kx) -> x.
--  * Inlined a few functions to shrink the code further.
--  * The original compiler produced a list of numbers and relied on the C
--  program to print them as a comma-separated list along with a certain header
--  and footer. This version of the compiler does all this itself.
--
-- Studying the code below may partially spoil this entry; please avert your
-- eyes if you want to honestly reverse-engineer the compiler!

y x = x(y x);
s x y z = x z(y z);
b x y z = x(y z);
c x y z = x z y;
r x y z = y z x;
t x y = y x;
k x _ = x;
i x = x;

f0 = b c t;
f1 = y(b(b(s(b c t)))(s(b b(b c(b b)))));
f2 = b c(r i(b f1(b(b(c b)) c)));
f3 = b(c(t b)) f2;
f4 = t k;
f5 = b(r(k i))(s(b s (<=))(c (<=)));
f6 = y(b(c(b s(b(b s)(b(b(b s))(r(b(r(b k k))(b b))(b b(b b b)))))))(b(c(b b(b s(b(b b)(b b)))))(b(r i)(b(b s)(b(b(b c))(b(b(b(b c)))(b(b(b(b(b c))))(b(b(b(b(b(b c)))))(b(b(b(c(b b(b c(b(b b) f5))))))(b(b c)(b(b(b c))(b c(b c)))))))))))));
f7 = c(b f1(b (:))) k;
f8 = b c(b(b c)(b(b f1)(b c(c f5))));
f9 = b k t;
f10 = b(b(b k))(b(b(b k))(b(b(b k))(b(b(b k))(b c t))));
f11 = b k(b(b k)(b(b k)(b(b k) t)));
f12 = b k(b k(b(b k)(b(b k) t)));
f13 = b k(b k(b k(b(b k) t)));
f14 = b(b k)(b(b k)(b(b k)(b(b k)(b c t))));
f15 = b k(b k(b k k));
f16 = c(t k);
f17 = b f16(b f9);
f18 = c(f1 (:));
f19 = f1 f18 k;
f20 = f5 0;
f21 = f11 8;
f22 = f11 9;
f23 = f11 6;
f24 = f11 5;
f25 = f11 3;
f26 = f11 2;
f27 = b(b(b f12))(r f11 b);
f28 = b(b(b(b f12)))(s(b b b)(r f11 b));
f29 = y(b(b(r b))(s(b c(b(b s)(s(b c(b(b s)(s(b s(b(b s)(b(c b)(b(r b)(s(b c(b(c(r(b f12(b f11(f14 f23)))(t(f12(f11(f14(f14 f26 f22) f22))))))(r(f14 f26 f22) f27)))(r f23 f27))))))(b(b(b(r b)))(s(b b(b c(b(b c)(b(c(b s(r(b(b f11) f14)(b s(r(b f12 f11) b)))))(r(f14 f24)(b b f27))))))(b(b f13)))))))(b(b(r b))(s(b c(b(b s)(s(b c(b(b s)(s(b c(b(b s)(b(c b)(b(r(f11 f22))(r f26 f28)))))(b c(r(f14(f11 4))(b b f27))))))(r f26 f28))))(r f25 f28))))))(b(b(r b))(s(b c(b(b s)(s(b c(b(b s)(b(s(b s(r f12 b)))(b(b(b k))(b(b(b f13)) c)))))(r f24 f28))))(b(b f13))))));
f30 = b(b(r b(r b(r b(r i(t b)))))(y(s(b c(b(r f11)(s(b c(b(c(t f15))(b f13)))(b(r b)(b(r(f29(f11 f21)))(b(r i)(b(r(b f11(f14 f21)))(r(f11 f22)))))))))(s(b c(b(b b)(b f29))) i))))(y(s(b s(b(b c)(r(b(r i)(r(b f13 f13)(b s(c(r k(b f1(b(r(f17 f11))(b(b b)(b(r(f9 f15))(c f6))))))))))(b s(b(b c)(b(b(r(b f13 f12)))(b(b(r(b f13 f11)))(b(b t)(b(b(b(b f12)))(r(c (:))(b b b)))))))))))(s(b s(b(b c)(b(b(b b))(b(b f14))))) i)) k);
f31 = b(b f9) f0;
f32 = c(b b(b f16(b t(c(b b(b f17(b t(b f0))))))));
f33 = b f32 f31;
f34 = b(b(r f9)) s;
f35 = b f32(f33(k i));
f36 = y(b(r(f31 k))(b(b f34)(s(b f32(f33 (:))))));
f37 = s(b f32(f33 (:))) f36;
f38 = b(f0 k)(b(b(r k))(r f31(b s(b b))));
f39 = b(b(b c))(b(c(b s(b(b(b s(b b))) (<=))))(c (<=)));
f40 = b f38 f5;
f41 = b f32(f33 k);
f42 = r(c f41)(b b(b b f35));
f43 = b b(b f16(b(r k)(r f9(b s(r f4 b)))));
f44 = c(b f43 f6);
f45 = f37(f38(c f8 [58,33,35,36,37,38,42,43,46,47,60,61,62,63,64,92,94,124,45,126]));
f46 = f36(f34(f38(r [32,10] f8))(f35(f35(f44 f45 [45,45])(f36(f38(b c(f5 10)))))(f40 10)));
f47 = r f46 f41;
f48 = b f47 f40;
f49 = b(r(f31 k))(b(b f34)(s(b b(b f32(f32(f31 (:)))))(b(b f36)(c(b f35 f48)))));
f50 = b(f33 f12)(b(f34(f35(f40 92)(f34(f38(r [92,39,34] f8))(f33(k 10)(f40 110)))))(b f38(b(b c) f5)));
f51 = f38(f39 47 58);
f52 = b f14 f13;
f53 = f33(f1(b f14(f52 [58])) f21);
f54 = r f48(b b f42);
f55 = b f54 f48;
f56 = f55 91 93;
f57 = f38(s(b(b s(b b))(s(b(b s(b b))(f39 96 123))(f39 64 91)))(f5 95));
f58 = [111,102];
f59 = f47(f32(f33 (:) f57)(f36(f34(f34 f57 f51)(f40 39))));
f60 = f43(b c(f6 f58)) f59;
f61 = f47(f34 f45(f55 96 96 f60));
f62 = f55 40 41;
f63 = f34 f60(f62 f61);
f64 = f1 f10;
f65 = b(f34(f33 f13 f63))(b f53(b f56(r 44 f49)));
f66 = f44 f61 [45,62];
f67 = b(f55 123 125)(r 59 f49);
f68 = f44 f59;
f69 = f37 f60;
f70 = b(f32(f33(s(b b f0)(b(b f30)(b(b(f52 k)) f10))) f63))(b(f32(f33(c f64)(f36 f60)))(f35(f48 61)));
f71 = b(f33(f3 f14))(b f37(s(b f34(r(f34(f34(f54(f40 39) 39(f50 39))(f53(f54(f40 34) 34(f36(f50 34)))))(f33 f12(f33(f2(b(r 48)(b(b (-))(r i(b b(b (+)(r 10 (*))))))) 0)(f47(f37 f51)))))(b f34(s(b f34(s(b f34(s(b f34(s(b f32(b(f33(c(f1(c(b t(b(b f14)(c f10)))))))(b(f42(f68 [108,101,116])(f68 [105,110]))(b f67 f70)))) i))(s(b f32(b(f33(b(b(f3 f14)) (:)))(f42(f68 [99,97,115,101])(f68 f58))))(b f67(s(b f35 f65)(b(f32(f33(c f64)(f36 f60)))(f35 f66)))))))(f32(f33(c(f1 f10))(f42(f48 92) f66 f69)))))(b f62(s(b f34(r(f34(f33 f52 f61)(f31 i))(b f32(f33 t))))(f32(f33(b f14(b(f14 f25) f13)) f61)))))))) f65));
f72 = b(b(t(k i)))(r(f0 0 k)(b f2(b c(b(b t)(b(b(s(b b(b f0((+) 1)))))(b(b (:))))))));
f73 = r(b(b(b t))(b(b(b(s(b b f0))))(b(b(c(b b(b b f0))))(b(b(c(b b(b f0(r 2 (+))))))(b(c(b b (:))) (:))))))(b b b);
f74 = b f4(r i(t b));
f75 = r [47,42,10](b f18(b(f18 [35,100,101,102,105,110,101,32,120,32,92,10])(b(b(b f19) f7(r [44](s(r((:) 48) f20)(y(b(s(r i f20))(r(b (:)(b((+) 48)(r 10(s(b b (-))(r i(b s(b(b (*)) (/))))))))(b s(b(b b)(r(r 10 (/)) b)))))))))(r(b t(b(c(b b (:)))(r(b(f18(y(b(s(b b(r k f20)))(b(b(s (:)))(r(r 1 (-)) b))) 22 0))(f2(c (:)) k))(b b(b (:)(b(t(k i))(f1 k b)))))))(b(b(f2(b t(r(b(b t)(b(b(b f0))(b(b (:)) f0)))(b b(b c(y(b(s(b c(s(b c(s(b c(b(c(t b))(c f0)))(r 1 f73)))(s(b b(c f0))(b(c(r 9(b f1(b(c b)(b c(b(b c) f6)))))) f4)))))(s(b c(b(b c)(b(b b))))(b(r(b c(c f73)))(b(b b)(b(b c) c))))))))))(f0(f72(r((+) 16)(b b f0))((:) k(f74(f36 f61 [58,32,60,61,32,42,32,43,32,45,32,47]))))(f0 24 k))) f74)(f35 f46(f33 f19(f49(f34(f35(f54(f68 [100,97,116,97]) 61 f69)(f33(s(b f7(b t(b(s(b b f0))(b(b(b f30))(b(c(b s(b(b f64)(b(f2(r f13(b b f14))) f13))))(b(c f18)(f7 f4))))))) i)(f49(f32(f33 f0 f63)(f33(f72(k(c (:) k)))(f36(f34(f34(f62 f69)(f56 f69)) f60)))) 124)))(f33(c (:) k)(f70(y(s(b f32(b(f33(f2 t)) f71))(b f36(b(f32(f33(b c(b(b f14) f52)) f61)) f71))))))) 59))))))));
