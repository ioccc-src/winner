{-# LANGUAGE CPP #-}
import Prelude ((+), (-), Char)
import qualified Prelude
a <= b = if (a Prelude.<= b) then True else False
#include "lol.hs"
main = Prelude.interact go
