{-# LANGUAGE CPP #-}
import Prelude ((+), (-), (*))
import Data.Char (ord, chr)
import qualified Prelude
a <= b = if (a Prelude.<= b) then True else False
a / b = Prelude.div a b
#include "fib.hs"
main = Prelude.interact go
