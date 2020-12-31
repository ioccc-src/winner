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
  
def counterElement andIn andOut value :
  xor andIn value data
  flipFlop c data value
  and andIn value andOut
  
def counter2 andIn andOut v1 v0 :
  counterElement andIn x v0
  counterElement x andOut v1

def counter4 andIn andOut v3 v2 v1 v0 :
  counter2 andIn x v1 v0
  counter2 x andOut v3 v2

def counter8 andIn andOut v7 v6 v5 v4 v3 v2 v1 v0 :
  counter4 andIn x v3 v2 v1 v0
  counter4 x andOut v7 v6 v5 v4

def shift2 shiftIn q1 q0 :
  flipFlop c shiftIn q1
  flipFlop c q1 q0 

def shift4 shiftIn q3 q2 q1 q0 :
  shift2 shiftIn q3 q2
  shift2 q2 q1 q0

def shift8 shiftIn q7 q6 q5 q4 q3 q2 q1 q0 :
  shift4 shiftIn q7 q6 q5 q4
  shift4 q4 q3 q2 q1 q0
  
def shiftOne q7 q6 q5 q4 q3 q2 q1 q0 :
  flipFlop c 1 q
  inv q shiftIn
  shift8 shiftIn q7 q6 q5 q4 q3 q2 q1 q0
  
def loop q7 q6 q5 q4 q3 q2 q1 q0 :
  flipFlop c 1 q
  inv q shiftIn
  shift8 shiftIn q7 q6 q5 q4 q3 q2 q1 q0
  buf q0 shiftIn
  
# 1-bit adder
def mAdder add carryInNeg carryIn a b carryOutNeg carryOut sum :
  trans add b s
  zuseFullAdder carryInNeg carryIn a s carryOutNeg carryOut sum
  
# 2-bit adder
def mAdder2 add carryInNeg carryIn a1 a0 b1 b0 carryOutNeg carryOut s1 s0 :
  mAdder add carryInNeg carryIn a0 b0 cOutNeg cOut s0 
  mAdder add cOutNeg cOut a1 b1 carryOutNeg carryOut s1
  
# 4-bit adder
def mAdder4 add carryInNeg carryIn a3 a2 a1 a0 b3 b2 b1 b0 
    carryOutNeg carryOut s3 s2 s1 s0 :
  mAdder2 add carryInNeg carryIn a1 a0 b1 b0 cOutNeg cOut s1 s0 
  mAdder2 add cOutNeg cOut a3 a2 b3 b2 carryOutNeg carryOut s3 s2

# 8-bit adder
def mAdder8 add 
    carryInNeg carryIn   a7 a6 a5 a4 a3 a2 a1 a0 
                         b7 b6 b5 b4 b3 b2 b1 b0 
    carryOutNeg carryOut s7 s6 s5 s4 s3 s2 s1 s0 :
  mAdder4 add carryInNeg carryIn a3 a2 a1 a0 b3 b2 b1 b0 
      cOutNeg cOut s3 s2 s1 s0 
  mAdder4 add cOutNeg cOut a7 a6 a5 a4 b7 b6 b5 b4 
      carryOutNeg carryOut s7 s6 s5 s4  

# 16-bit adder
def mAdder16 add 
    carryInNeg carryIn   a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0 
                         b15 b14 b13 b12 b11 b10 b9 b8 b7 b6 b5 b4 b3 b2 b1 b0 
    carryOutNeg carryOut s15 s14 s13 s12 s11 s10 s9 s8 s7 s6 s5 s4 s3 s2 s1 s0 :
  mAdder8 add carryInNeg carryIn a7 a6 a5 a4 a3 a2 a1 a0 b7 b6 b5 b4 b3 b2 b1 b0
      cOutNeg cOut s7 s6 s5 s4 s3 s2 s1 s0 
  mAdder8 add cOutNeg cOut 
      a15 a14 a13 a12 a11 a10 a9 a8 b15 b14 b13 b12 b11 b10 b9 b8 
      carryOutNeg carryOut s15 s14 s13 s12 s11 s10 s9 s8

def multiplier 
    a7 a6 a5 a4 a3 a2 a1 a0 
    b7 b6 b5 b4 b3 b2 b1 b0
    p15 p14 p13 p12 p11 p10 p9 p8 p7 p6 p5 p4 p3 p2 p1 p0 :
  mAdder16 b0 1 0 
      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
      0 0 0 0 0 0 0 0 a7 a6 a5 a4 a3 a2 a1 a0
      0 0 d15 d14 d13 d12 d11 d10 d9 d8 d7 d6 d5 d4 d3 d2 d1 d0
  mAdder16 b1 1 0 
      d15 d14 d13 d12 d11 d10 d9 d8 d7 d6 d5 d4 d3 d2 d1 d0
      0 0 0 0 0 0 0 a7 a6 a5 a4 a3 a2 a1 a0 0
      0 0 e15 e14 e13 e12 e11 e10 e9 e8 e7 e6 e5 e4 e3 e2 e1 e0
  mAdder16 b2 1 0 
      e15 e14 e13 e12 e11 e10 e9 e8 e7 e6 e5 e4 e3 e2 e1 e0
      0 0 0 0 0 0 a7 a6 a5 a4 a3 a2 a1 a0 0 0
      0 0 f15 f14 f13 f12 f11 f10 f9 f8 f7 f6 f5 f4 f3 f2 f1 f0
  mAdder16 b3 1 0 
      f15 f14 f13 f12 f11 f10 f9 f8 f7 f6 f5 f4 f3 f2 f1 f0
      0 0 0 0 0 a7 a6 a5 a4 a3 a2 a1 a0 0 0 0
      0 0 g15 g14 g13 g12 g11 g10 g9 g8 g7 g6 g5 g4 g3 g2 g1 g0
  mAdder16 b4 1 0 
      g15 g14 g13 g12 g11 g10 g9 g8 g7 g6 g5 g4 g3 g2 g1 g0
      0 0 0 0 a7 a6 a5 a4 a3 a2 a1 a0 0 0 0 0
      0 0 h15 h14 h13 h12 h11 h10 h9 h8 h7 h6 h5 h4 h3 h2 h1 h0
  mAdder16 b5 1 0 
      h15 h14 h13 h12 h11 h10 h9 h8 h7 h6 h5 h4 h3 h2 h1 h0
      0 0 0 a7 a6 a5 a4 a3 a2 a1 a0 0 0 0 0 0
      0 0 i15 i14 i13 i12 i11 i10 i9 i8 i7 i6 i5 i4 i3 i2 i1 i0
  mAdder16 b6 1 0 
      i15 i14 i13 i12 i11 i10 i9 i8 i7 i6 i5 i4 i3 i2 i1 i0
      0 0 a7 a6 a5 a4 a3 a2 a1 a0 0 0 0 0 0 0
      0 0 j15 j14 j13 j12 j11 j10 j9 j8 j7 j6 j5 j4 j3 j2 j1 j0
  mAdder16 b7 1 0 
      j15 j14 j13 j12 j11 j10 j9 j8 j7 j6 j5 j4 j3 j2 j1 j0
      0 a7 a6 a5 a4 a3 a2 a1 a0 0 0 0 0 0 0 0
      0 0 p15 p14 p13 p12 p11 p10 p9 p8 p7 p6 p5 p4 p3 p2 p1 p0
      
# 16-bit Partial Adder/Subtractor
def xFullAdder16 subtract carryInNeg carryIn 
                         a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0
                         b15 b14 b13 b12 b11 b10 b9 b8 b7 b6 b5 b4 b3 b2 b1 b0
    carryOutNeg carryOut s15 s14 s13 s12 s11 s10 s9 s8 s7 s6 s5 s4 s3 s2 s1 s0 :
  xFullAdder8 subtract carryInNeg carryIn 
      a7 a6 a5 a4 a3 a2 a1 a0 b7 b6 b5 b4 b3 b2 b1 b0 
      cOutNeg cOut s7 s6 s5 s4 s3 s2 s1 s0 
  xFullAdder8 subtract cOutNeg cOut 
      a15 a14 a13 a12 a11 a10 a9 a8 b15 b14 b13 b12 b11 b10 b9 b8 
      carryOutNeg carryOut s15 s14 s13 s12 s11 s10 s9 s8

# 16-bit Adder/Subtractor
def adderSubtractor16 subtract
             a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0
             b15 b14 b13 b12 b11 b10 b9 b8 b7 b6 b5 b4 b3 b2 b1 b0    
    carryOut s15 s14 s13 s12 s11 s10 s9 s8 s7 s6 s5 s4 s3 s2 s1 s0 :
  inv subtract carryInNeg
  xFullAdder16 subtract carryInNeg subtract 
                       a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0
                       b15 b14 b13 b12 b11 b10 b9 b8 b7 b6 b5 b4 b3 b2 b1 b0
      carryOutNeg cOut s15 s14 s13 s12 s11 s10 s9 s8 s7 s6 s5 s4 s3 s2 s1 s0
  xor cOut subtract carryOut

def signedMultiplier signed
    a7 a6 a5 a4 a3 a2 a1 a0 
    b7 b6 b5 b4 b3 b2 b1 b0
    p15 p14 p13 p12 p11 p10 p9 p8 p7 p6 p5 p4 p3 p2 p1 p0 :
  and signed a7 negateA
  and signed b7 negateB  
  adderSubtractor negateA 0 0 0 0 0 0 0 0 
      a7 a6 a5 a4 a3 a2 a1 a0 0 c7 c6 c5 c4 c3 c2 c1 c0
  adderSubtractor negateB 0 0 0 0 0 0 0 0 
      b7 b6 b5 b4 b3 b2 b1 b0 0 d7 d6 d5 d4 d3 d2 d1 d0
  multiplier 
      c7 c6 c5 c4 c3 c2 c1 c0 
      d7 d6 d5 d4 d3 d2 d1 d0
      q15 q14 q13 q12 q11 q10 q9 q8 q7 q6 q5 q4 q3 q2 q1 q0
  xor a7 b7 negateProduct
  and signed negateProduct negateQ
  adderSubtractor16 negateQ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
      q15 q14 q13 q12 q11 q10 q9 q8 q7 q6 q5 q4 q3 q2 q1 q0
      0 p15 p14 p13 p12 p11 p10 p9 p8 p7 p6 p5 p4 p3 p2 p1 p0
      
# 4-input OR gate
def or4 i3 i2 i1 i0 o :
  or i3 i2 o
  or i1 i0 o

# 8-input OR gate
def or8 i7 i6 i5 i4 i3 i2 i1 i0 o :
  or4 i7 i6 i5 i4 o
  or4 i3 i2 i1 i0 o
  
def multiplier2 
    a7 a6 a5 a4 a3 a2 a1 a0 
    b7 b6 b5 b4 b3 b2 b1 b0
    p15 p14 p13 p12 p11 p10 p9 p8 p7 p6 p5 p4 p3 p2 p1 p0 :

  # 16-bit register made of flip flops
  flipFlop c d15 p15 
  flipFlop c d14 p14
  flipFlop c d13 p13
  flipFlop c d12 p12
  flipFlop c d11 p11
  flipFlop c d10 p10
  flipFlop c d9 p9
  flipFlop c d8 p8
  flipFlop c d7 p7
  flipFlop c d6 p6
  flipFlop c d5 p5
  flipFlop c d4 p4
  flipFlop c d3 p3
  flipFlop c d2 p2
  flipFlop c d1 p1
  flipFlop c d0 p0

  # Transmission gates and 8-bit adder
  trans8 loadB d7 d6 d5 d4 d3 d2 d1 d0 b7 b6 b5 b4 b3 b2 b1 b0
  trans8 p0 a7 a6 a5 a4 a3 a2 a1 a0 z7 z6 z5 z4 z3 z2 z1 z0
  zuseAdder8 1 0 p15 p14 p13 p12 p11 p10 p9 p8 z7 z6 z5 z4 z3 z2 z1 z0
      0 s8 s7 s6 s5 s4 s3 s2 s1 s0 
  trans16 tallyShift d15 d14 d13 d12 d11 d10 d9 d8 d7 d6 d5 d4 d3 d2 d1 d0 
      s8 s7 s6 s5 s4 s3 s2 s1 s0 p7 p6 p5 p4 p3 p2 p1
  trans16 keepValue d15 d14 d13 d12 d11 d10 d9 d8 d7 d6 d5 d4 d3 d2 d1 d0
      p15 p14 p13 p12 p11 p10 p9 p8 p7 p6 p5 p4 p3 p2 p1 p0

  # State machine 
  flipFlop c 1 boot
  inv boot loadB
  flipFlop c loadB state1
  flipFlop c state1 state2
  flipFlop c state2 state3
  flipFlop c state3 state4
  flipFlop c state4 state5
  flipFlop c state5 state6
  flipFlop c state6 state7
  flipFlop c state7 state8
  flipFlop c state8 keepValue
  or8 state1 state2 state3 state4 state5 state6 state7 state8 tallyShift
  buf keepValue keepValue

def signedMultiplier2 signed
    a7 a6 a5 a4 a3 a2 a1 a0 
    b7 b6 b5 b4 b3 b2 b1 b0
    p15 p14 p13 p12 p11 p10 p9 p8 p7 p6 p5 p4 p3 p2 p1 p0 :
  and signed a7 negateA
  and signed b7 negateB  
  adderSubtractor negateA 0 0 0 0 0 0 0 0 
      a7 a6 a5 a4 a3 a2 a1 a0 0 c7 c6 c5 c4 c3 c2 c1 c0
  adderSubtractor negateB 0 0 0 0 0 0 0 0 
      b7 b6 b5 b4 b3 b2 b1 b0 0 d7 d6 d5 d4 d3 d2 d1 d0
  multiplier2 
      c7 c6 c5 c4 c3 c2 c1 c0 
      d7 d6 d5 d4 d3 d2 d1 d0
      q15 q14 q13 q12 q11 q10 q9 q8 q7 q6 q5 q4 q3 q2 q1 q0
  xor a7 b7 negateProduct
  and signed negateProduct negateQ
  adderSubtractor16 negateQ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
      q15 q14 q13 q12 q11 q10 q9 q8 q7 q6 q5 q4 q3 q2 q1 q0
      0 p15 p14 p13 p12 p11 p10 p9 p8 p7 p6 p5 p4 p3 p2 p1 p0

# Divider (A = Dividend, B = Divisor, P = Quotient, Q = Remainder)
def divider 
    a7 a6 a5 a4 a3 a2 a1 a0
    b7 b6 b5 b4 b3 b2 b1 b0
    divideByZeroError
    p7 p6 p5 p4 p3 p2 p1 p0
    q7 q6 q5 q4 q3 q2 q1 q0 :

  # 16-bit register made of flip flops
  flipFlop c d15 q7 
  flipFlop c d14 q6
  flipFlop c d13 q5
  flipFlop c d12 q4
  flipFlop c d11 q3
  flipFlop c d10 q2
  flipFlop c d9 q1
  flipFlop c d8 q0
  flipFlop c d7 p7
  flipFlop c d6 p6
  flipFlop c d5 p5
  flipFlop c d4 p4
  flipFlop c d3 p3
  flipFlop c d2 p2
  flipFlop c d1 p1
  flipFlop c d0 p0

  # Transmission gates and 8-bit subtractor
  trans8 loadA d7 d6 d5 d4 d3 d2 d1 d0 a7 a6 a5 a4 a3 a2 a1 a0
  trans16 positive d15 d14 d13 d12 d11 d10 d9 d8 d7 d6 d5 d4 d3 d2 d1 d0
      s7 s6 s5 s4 s3 s2 s1 s0 p6 p5 p4 p3 p2 p1 p0 1
  trans16 negative d15 d14 d13 d12 d11 d10 d9 d8 d7 d6 d5 d4 d3 d2 d1 d0
      q6 q5 q4 q3 q2 q1 q0 p7 p6 p5 p4 p3 p2 p1 p0 0
  trans16 keepValue d15 d14 d13 d12 d11 d10 d9 d8 d7 d6 d5 d4 d3 d2 d1 d0
      q7 q6 q5 q4 q3 q2 q1 q0 p7 p6 p5 p4 p3 p2 p1 p0
  adderSubtractor 1 q6 q5 q4 q3 q2 q1 q0 p7 b7 b6 b5 b4 b3 b2 b1 b0
      0 s7 s6 s5 s4 s3 s2 s1 s0
  inv s7 s7Neg
  and shift s7 negative
  and shift s7Neg positive

  # Divide-by-zero check
  or8 b7 b6 b5 b4 b3 b2 b1 b0 divideByZeroErrorNeg
  inv divideByZeroErrorNeg divideByZeroError

  # State machine
  flipFlop c 1 boot
  inv boot bootNeg
  trans divideByZeroErrorNeg bootNeg loadA
  flipFlop c loadA state1
  flipFlop c state1 state2
  flipFlop c state2 state3
  flipFlop c state3 state4
  flipFlop c state4 state5
  flipFlop c state5 state6
  flipFlop c state6 state7
  flipFlop c state7 state8
  flipFlop c state8 keepValue
  or8 state1 state2 state3 state4 state5 state6 state7 state8 shift
  buf keepValue keepValue

run 1000 5 divider 
    0 0 0 0 1 1 1 0 
    0 0 0 0 0 0 1 1
    ?
    ? ? ? ? ? ? ? ?
    ? ? ? ? ? ? ? ?






