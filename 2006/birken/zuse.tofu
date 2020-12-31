# Four double-pole relay
def r4 coil l3 nd3 nc3 l2 nd2 nc2 l1 nd1 nc1 l0 nd0 nc0 :
  r coil l3 nd3 nc3
  r coil l2 nd2 nc2
  r coil l1 nd1 nc1
  r coil l0 nd0 nc0

# Buffer
def buf input output :
  r input output 1 0

# Inverter
def inv input output :
  r input output 0 1

# AND Gate
def and i1 i0 o :
  r i0 z 1 0
  r i1 o z 0
  
# NAND Gate
def nand i0 i1 o :
  r i0 1 0 o
  r i1 1 0 o
  
# OR Gate
def or i0 i1 o :
  r i0 1 o 0
  r i1 1 o 0
  
# NOR Gate
def nor i0 i1 o :
  r i0 1 0 z
  r i1 z 0 o
  
# XOR Gate
def xor i0 i1 o :
  r i0 1 b a
  r i1 o a b
  
# XNOR Gate
def xnor i0 i1 o :
  r i0 1 a b
  r i1 o a b
  
# Half Adder
def halfAdder a b s1 s0 :
  and a b s1
  xor a b s0
  
# Full Adder
def fullAdder carryIn a b carryOut sum :
  halfAdder a b s1 s0
  halfAdder s0 carryIn carry sum
  or s1 carry carryOut
  
# 2-bit Adder
def adder2 carryIn a1 a0 b1 b0 carryOut s1 s0 :
  fullAdder carryIn a0 b0 carry s0
  fullAdder carry a1 b1 carryOut s1

# 4-bit Adder
def adder4 carryIn a3 a2 a1 a0 b3 b2 b1 b0 carryOut s3 s2 s1 s0 :
  adder2 carryIn a1 a0 b1 b0 carry s1 s0
  adder2 carry a3 a2 b3 b2 carryOut s3 s2  

# 8-bit Adder
def adder8 carryIn
             a7 a6 a5 a4 a3 a2 a1 a0
             b7 b6 b5 b4 b3 b2 b1 b0
    carryOut s7 s6 s5 s4 s3 s2 s1 s0 :
  adder4 carryIn a3 a2 a1 a0 b3 b2 b1 b0 carry s3 s2 s1 s0
  adder4 carry a7 a6 a5 a4 b7 b6 b5 b4 carryOut s7 s6 s5 s4
  
# Konrad Zuse Dual-Rail-Carry Full Adder
def zuseFullAdder carryInNeg carryIn a b carryOutNeg carryOut sum :
  r4 a carryInNeg y z sum w x 1 v y carryIn u v 
  r4 b carryOutNeg z y carryInNeg x w carryIn w x carryOut v u

# Konrad Zuse Dual-Rail-Carry 2-bit Adder
def zuseAdder2 carryInNeg carryIn a1 a0 b1 b0 carryOutNeg carryOut s1 s0 :
  zuseFullAdder carryInNeg carryIn a0 b0 cOutNeg cOut s0 
  zuseFullAdder cOutNeg cOut a1 b1 carryOutNeg carryOut s1

# Konrad Zuse Dual-Rail-Carry 4-bit Adder
def zuseAdder4 carryInNeg carryIn a3 a2 a1 a0 b3 b2 b1 b0 
    carryOutNeg carryOut s3 s2 s1 s0 :
  zuseAdder2 carryInNeg carryIn a1 a0 b1 b0 cOutNeg cOut s1 s0 
  zuseAdder2 cOutNeg cOut a3 a2 b3 b2 carryOutNeg carryOut s3 s2

# Konrad Zuse Dual-Rail-Carry 8-bit Adder
def zuseAdder8 carryInNeg carryIn 
                         a7 a6 a5 a4 a3 a2 a1 a0
                         b7 b6 b5 b4 b3 b2 b1 b0
    carryOutNeg carryOut s7 s6 s5 s4 s3 s2 s1 s0 :
  zuseAdder4 carryInNeg carryIn a3 a2 a1 a0 b3 b2 b1 b0 cOutNeg cOut s3 s2 s1 s0 
  zuseAdder4 cOutNeg cOut a7 a6 a5 a4 b7 b6 b5 b4 
      carryOutNeg carryOut s7 s6 s5 s4
      
# 57 + 142 = ?
run 100 1 zuseAdder8 1 0  
    0 0 1 1 1 0 0 1    
    1 0 0 0 1 1 1 0
? ? ? ? ? ? ? ? ? ?


