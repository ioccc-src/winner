-- See M. Douglas McIlroy, "Enumerating the strings of regular languages".
undefined = undefined;
data Bool = True | False;
(==) x y = case x <= y of { True -> y <= x ; False -> x <= y };
ife b t f = case b of { True -> t ; False -> f };
foldr c n xs = case xs of
  { [] -> n
  ; (:) h t -> c h (foldr c n t)
  };
(++) = \xs ys -> foldr (:) ys xs;
unwords xs = case xs of
  { [] -> ""
  ; (:) x xt -> x ++ foldr (\a s -> ' ':a ++ s) "" xt
  };
take n xs = ife (n == 0) [] (case xs of
  { [] -> []
  ; (:) x xt -> x:take (n-1) xt
  });
length xs = case xs of { [] -> 0 ; (:) x xt -> 1 + length xt };

data Ordering = LT | GT | EQ;

intcmp x y = ife (x <= y) (ife (y <= x) EQ LT) GT;

flst xs n c = case xs of { [] -> n ; (:) x xt -> c x xt };

eqstrcmp xs ys = flst xs EQ (\x xt -> flst ys undefined (\y yt -> case intcmp x y of { LT -> LT ; GT -> GT ; EQ -> eqstrcmp xt yt }));

cmp xs ys = case intcmp (length xs) (length ys) of { LT -> LT ; GT -> GT ; EQ -> eqstrcmp xs ys };

alt xs ys = flst xs ys (\x xt -> flst ys xs (\y yt -> case cmp x y of { LT -> x:alt xt ys ; GT -> y:alt xs yt ; EQ -> x:alt xt yt } ));

cat xs ys = flst xs [] (\x xt -> flst ys [] (\y yt -> (x ++ y) : alt (cat [x] yt) (cat xt ys)));

clo xs = flst xs [""] (\x xt -> flst x (clo xt) (\_ _ -> "" : cat xs (clo xs)));

data Re = Nil
        | Eps
        | Sym Char
        | Clo Re
        | Cat Re Re
        | Alt Re Re
        ;

enumR expr = case expr of
  { Nil -> []
  ; Eps -> [""]
  ; Sym a -> [[a]]
  ; Clo x -> clo (enumR x)
  ; Cat x y -> cat (enumR x) (enumR y)
  ; Alt x y -> alt (enumR x) (enumR y)
  };

a = Sym 'a';
b = Sym 'b';
sandwich = Cat a (Cat (Clo b) a);
even_a = Clo (Alt sandwich b);

go stdin = unwords (take 32 (enumR even_a));
