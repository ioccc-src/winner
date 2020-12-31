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
      
# 1-bit Partial Adder/Subtractor
def xFullAdder subtract carryInNeg carryIn a b carryOutNeg carryOut sum :
  xor subtract b bNeg
  zuseFullAdder carryInNeg carryIn a bNeg carryOutNeg carryOut sum

# 2-bit Partial Adder/Subtractor
def xFullAdder2 subtract carryInNeg carryIn 
    a1 a0 b1 b0 carryOutNeg carryOut s1 s0 :
  xFullAdder subtract carryInNeg carryIn a0 b0 cOutNeg cOut s0 
  xFullAdder subtract cOutNeg cOut a1 b1 carryOutNeg carryOut s1

# 4-bit Partial Adder/Subtractor
def xFullAdder4 subtract carryInNeg carryIn a3 a2 a1 a0 b3 b2 b1 b0 
    carryOutNeg carryOut s3 s2 s1 s0 :
  xFullAdder2 subtract carryInNeg carryIn a1 a0 b1 b0 cOutNeg cOut s1 s0 
  xFullAdder2 subtract cOutNeg cOut a3 a2 b3 b2 carryOutNeg carryOut s3 s2

# 8-bit Partial Adder/Subtractor
def xFullAdder8 subtract carryInNeg carryIn 
                       a7 a6 a5 a4 a3 a2 a1 a0
                       b7 b6 b5 b4 b3 b2 b1 b0
    carryOutNeg carryOut s7 s6 s5 s4 s3 s2 s1 s0 :
  xFullAdder4 subtract carryInNeg carryIn a3 a2 a1 a0 b3 b2 b1 b0 
      cOutNeg cOut s3 s2 s1 s0 
  xFullAdder4 subtract cOutNeg cOut a7 a6 a5 a4 b7 b6 b5 b4 
      carryOutNeg carryOut s7 s6 s5 s4

# 8-bit Adder/Subtractor
def adderSubtractor subtract  
             a7 a6 a5 a4 a3 a2 a1 a0
             b7 b6 b5 b4 b3 b2 b1 b0
    carryOut s7 s6 s5 s4 s3 s2 s1 s0 :
  inv subtract carryInNeg 
  xFullAdder8 subtract carryInNeg subtract 
                       a7 a6 a5 a4 a3 a2 a1 a0
                       b7 b6 b5 b4 b3 b2 b1 b0
      carryOutNeg cOut s7 s6 s5 s4 s3 s2 s1 s0
  xor cOut subtract carryOut
  
# 2-to-1 Mux
def mux a i1 i0 o :
  r a o i1 i0

# 4-to-1 Mux
def mux4to1 a1 a0 i3 i2 i1 i0 o :
  mux a0 i1 i0 x
  mux a0 i3 i2 y
  mux a1 y x o

# 8-to-1 Mux
def mux8to1 a2 a1 a0 i7 i6 i5 i4 i3 i2 i1 i0 o :
  mux4to1 a1 a0 i3 i2 i1 i0 x
  mux4to1 a1 a0 i7 i6 i5 i4 y
  mux a2 y x o
  
# 3-to-8 Decoder
def decoder3to8 a2 a1 a0 o7 o6 o5 o4 o3 o2 o1 o0 :
  mux8to1 a2 a1 a0 o7 o6 o5 o4 o3 o2 o1 o0 1
  
def trans enabled a b :
  r enabled a b 0

# 2-bit transmission gate
def trans2 enabled a1 a0 b1 b0 :
  trans enabled a1 b1
  trans enabled a0 b0

# 4-bit transmission gate
def trans4 enabled a3 a2 a1 a0 b3 b2 b1 b0 :
  trans2 enabled a3 a2 b3 b2
  trans2 enabled a1 a0 b1 b0

# 8-bit transmission gate
def trans8 enabled a7 a6 a5 a4 a3 a2 a1 a0 b7 b6 b5 b4 b3 b2 b1 b0 :
  trans4 enabled a7 a6 a5 a4 b7 b6 b5 b4
  trans4 enabled a3 a2 a1 a0 b3 b2 b1 b0

# 16-bit transmission gate
def trans16 enabled 
    a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0 
    b15 b14 b13 b12 b11 b10 b9 b8 b7 b6 b5 b4 b3 b2 b1 b0 :
  trans8 enabled a15 a14 a13 a12 a11 a10 a9 a8 b15 b14 b13 b12 b11 b10 b9 b8
  trans8 enabled a7 a6 a5 a4 a3 a2 a1 a0 b7 b6 b5 b4 b3 b2 b1 b0
  
# Latch, stores when w = 1 
def latch w d q : 
  mux w d q z
  buf z q

# Latch, stores when w = 0 
def latchNeg w d q : 
  mux w q d z
  buf z q
  
# Flip flop, stores when w rises to 1, expresses new value when w drops to 0 
def flipFlop w d q : 
  latch w d q2 
  latchNeg w q2 q
  
def flipFlopRegister w d7 d6 d5 d4 d3 d2 d1 d0 q7 q6 q5 q4 q3 q2 q1 q0:
  flipFlop w d7 q7
  flipFlop w d6 q6
  flipFlop w d5 q5
  flipFlop w d4 q4
  flipFlop w d3 q3
  flipFlop w d2 q2
  flipFlop w d1 q1
  flipFlop w d0 q0
  
def latchRegister w d7 d6 d5 d4 d3 d2 d1 d0 q7 q6 q5 q4 q3 q2 q1 q0:
  latch w d7 q7
  latch w d6 q6
  latch w d5 q5
  latch w d4 q4
  latch w d3 q3
  latch w d2 q2
  latch w d1 q1
  latch w d0 q0
  
def tinyLatchRegister writeNeg d7 d6 d5 d4 d3 d2 d1 d0 :
  r d7 d7 writeNeg 0 
  r d6 d6 writeNeg 0
  r d5 d5 writeNeg 0
  r d4 d4 writeNeg 0
  r d3 d3 writeNeg 0
  r d2 d2 writeNeg 0
  r d1 d1 writeNeg 0
  r d0 d0 writeNeg 0
  
def memoryRegister select load d7 d6 d5 d4 d3 d2 d1 d0 :
  inv load writeNeg
  inv writeNeg select
  trans8 select d7 d6 d5 d4 d3 d2 d1 d0 z7 z6 z5 z4 z3 z2 z1 z0
  tinyLatchRegister writeNeg z7 z6 z5 z4 z3 z2 z1 z0
  
# 2 Bytes of memory
def memory2 address select load d7 d6 d5 d4 d3 d2 d1 d0 :
  mux address select1 select0 select
  mux address load1 load0 load
  memoryRegister select0 load0 d7 d6 d5 d4 d3 d2 d1 d0
  memoryRegister select1 load1 d7 d6 d5 d4 d3 d2 d1 d0
  
# 4 Bytes of memory
def memory4 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0 :
  mux a1 select1 select0 select
  mux a1 load1 load0 load
  memory2 a0 select load d7 d6 d5 d4 d3 d2 d1 d0
  memory2 a0 select load d7 d6 d5 d4 d3 d2 d1 d0

# 8 Bytes of memory
def memory8 a2 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0 :
  mux a2 select1 select0 select
  mux a2 load1 load0 load
  memory4 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0
  memory4 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0

# 16 Bytes of memory
def memory16 a3 a2 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0 :
  mux a3 select1 select0 select
  mux a3 load1 load0 load
  memory8 a2 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0
  memory8 a2 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0

# 32 Bytes of memory
def memory32 a4 a3 a2 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0 :
  mux a4 select1 select0 select
  mux a4 load1 load0 load
  memory16 a3 a2 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0
  memory16 a3 a2 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0

# 64 Bytes of memory
def memory64 a5 a4 a3 a2 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0 :
  mux a5 select1 select0 select
  mux a5 load1 load0 load
  memory32 a4 a3 a2 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0
  memory32 a4 a3 a2 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0

# 128 Bytes of memory
def memory128 a6 a5 a4 a3 a2 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0 :
  mux a6 select1 select0 select
  mux a6 load1 load0 load
  memory64 a5 a4 a3 a2 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0
  memory64 a5 a4 a3 a2 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0

# 256 Bytes of memory
def memory256 a7 a6 a5 a4 a3 a2 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0 :
  mux a7 select1 select0 select
  mux a7 load1 load0 load
  memory128 a6 a5 a4 a3 a2 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0
  memory128 a6 a5 a4 a3 a2 a1 a0 select load d7 d6 d5 d4 d3 d2 d1 d0
  
run 100 1 memory256 0 0 0 0 0 0 0 0  1 0  ? ? ? ? ? ? ? ?


