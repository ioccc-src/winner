-- We define these because we're starting from scratch.
undefined = undefined;
(.) f g x = f (g x);
id x = x;
data Bool = True | False;
(==) x y = case x <= y of { True -> y <= x ; False -> x <= y };
ifz n x y = case 0 == n of { True -> x ; False -> y };
showsInt n = let
  { showsNonzero n = let { q = n/10 } in
    ifz n id ((.) (showsNonzero q) (chr (ord '0'+(n-(q*10))):) )
  } in ifz n ('0':) (showsNonzero n);
tail xs = case xs of { [] -> undefined; (:) _ t -> t };
(!!) xs n = case xs of { [] -> undefined; (:) h t -> ifz n h (t!!(n - 1)) };
zipWith f xs ys = case xs of
  { [] -> []
  ; (:) x xt -> case ys of
    { [] -> []
    ; (:) y yt -> f x y : zipWith f xt yt
    }
  };

-- One of the first Haskell examples I saw. It got my attention. How can it
-- possibly work? And even after I understood it, I wondered: how do I write
-- a compiler that can understand it? (Now, I know!)
--
-- Let f be the generating function for Fibonacci numbers. We have:
--
--   f = 0 + x + (f + f/x )x^2
--
-- This translates neatly to:

fibs = 0 : (1 : zipWith (+) fibs (tail fibs));

-- See M. Douglas McIlroy, "Power Series, Power Serious" for more examples.

go _ = showsInt (fibs !! 30) "\n";
