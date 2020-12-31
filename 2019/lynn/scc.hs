-- See Simon L. Peyton Jones and David R. Lester, "Implementing  Functional
-- Languages: a tutorial", section 6.8.

undefined = undefined;
data Bool = True | False;
id x = x;
(.) f g = \x -> f (g x);
flip f = \x y -> f y x;
(==) x y = case x <= y of { True -> y <= x ; False -> x <= y };
ife b t f = case b of { True -> t ; False -> f };
foldr c n xs = case xs of
  { [] -> n
  ; (:) h t -> c h (foldr c n t)
  };
foldl f a bs = foldr (\b g x -> g (f x b)) id bs a;
foldl1 f xs = case xs of { [] -> undefined ; (:) h t -> foldl f h t };
map = flip (foldr . ((.) (:))) [];
(++) = \xs ys -> foldr (:) ys xs;
concat = foldr (++) [];
concatMap =  (concat .) . map;
elemWith f k xs = foldr (\x t -> ife (f x k) True t) False xs;
elem = elemWith (==);
eqStr s t = case s of
  { [] -> case t of { [] -> True; (:) _ _ -> False }
  ; (:) x xs -> case t of
    { [] -> False
    ; (:) y ys -> ife (x == y) (eqStr xs ys) False
    }
  };
elemStr = elemWith eqStr;
data Maybe a = Nothing | Just a;
lookup n = foldr (\h t -> case h of { Pair k v -> ife (n == k) (Just v) t }) Nothing;
data Pair x y = Pair x y;
fst p = case p of { Pair x _ -> x };
snd p = case p of { Pair _ y -> y };
break p xs = case xs of
  { [] -> Pair [] []
  ; (:) x xs' -> ife (p x) (Pair [] xs) (case break p xs' of { Pair ys zs -> Pair (x:ys) zs })
  };
lines s = case s of
  { [] -> []
  ; (:) _ _ -> case break (\c -> '\n' == c) s of
    { Pair l s' -> l : case s' of
      { [] -> []
      ; (:) _ s'' -> lines s''
      }
    }
  };
dropWhile p xs = case xs of
  { [] -> []
  ; (:) x xs' -> ife (p x) (dropWhile p xs') xs
  };
length xs = case xs of { [] -> 0 ; (:) x xt -> 1 + length xt };
isSpace c = c `elem` " \n";
words s = case dropWhile isSpace s of
  { [] -> []
  ; (:) h t -> case break isSpace (h:t) of
    { Pair w s' -> w:words s' }
  };
unwords xs = case xs of
  { [] -> ""
  ; (:) x xt -> x ++ foldr (\a s -> ' ':a ++ s) "" xt
  };

depthFirstSearch = let
  { search relation st vertex = case st of
    { Pair visited sequence -> ife (vertex `elemStr` visited) st (case depthFirstSearch relation (Pair (vertex:visited) sequence) (relation vertex) of
      { Pair visited' sequence' -> Pair visited' (vertex:sequence')
      })
    }
  } in foldl . search;

spanningSearch = let
  { search relation st vertex = case st of
    { Pair visited setSequence -> ife (vertex `elemStr` visited) st (case depthFirstSearch relation (Pair (vertex:visited) []) (relation vertex) of
      { Pair visited' sequence -> Pair visited' ((vertex:sequence):setSequence)
      })
    }
  } in foldl . search;

scc ins outs = let
  { depthFirst = snd . depthFirstSearch outs (Pair [] [])
  ; spanning   = snd . spanningSearch   ins  (Pair [] [])
  } in spanning . depthFirst;

go s = let
  { nums = map words (lines s)
  ; outs v = foldr (\h t -> case h of
      { [] -> t
      ; (:) x xs -> ife (x `eqStr` v) xs t
      }) [] nums
  ; ins w = foldr (\h t -> case h of
      { [] -> t
      ; (:) x xs -> ife (w `elemStr` xs) (x:t) t
      }) [] nums
  } in concatMap (++ "\n") (map unwords (scc ins outs (concat nums)));
