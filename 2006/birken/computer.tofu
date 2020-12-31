# Harry Porter's Relay Computer

# Buffer
def buf i o :
  r i o 1 0

# Inverter
def inv i o :
  r i o 0 1

# AND Gate
def and i0 i1 o :
  r i0 1 z 0
  r i1 z o 0

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

# Dual-rail-carry Full Adder (Konrad Zuse design)
def fullAdder carryIn carryInNeg a b carryOutNeg carryOut sum :
  r a carryIn 2 3
  r a 1 3 4
  r a sum 5 7
  r a carryInNeg 4 6
  r b carryOut 3 2
  r b carryIn 5 7
  r b carryInNeg 7 5
  r b carryOutNeg 6 4

# 2-bit Full Adder
def fullAdder2 carryIn carryInNeg a1 a0 b1 b0 carryOutNeg carryOut s1 s0 :
  fullAdder carryIn carryInNeg a0 b0 carryOutNeg0 carryOut0 s0
  fullAdder carryOut0 carryOutNeg0 a1 b1 carryOutNeg carryOut s1  

# 4-bit Full Adder
def fullAdder4 carryIn carryInNeg a3 a2 a1 a0 b3 b2 b1 b0 
    carryOutNeg carryOut s3 s2 s1 s0 :
  fullAdder2 carryIn carryInNeg a1 a0 b1 b0 carryOutNeg0 carryOut0 s1 s0
  fullAdder2 carryOut0 carryOutNeg0 a3 a2 b3 b2 carryOutNeg carryOut s3 s2

# 8-bit Full Adder
def fullAdder8 
      carryIn carryInNeg a7 a6 a5 a4 a3 a2 a1 a0 
                         b7 b6 b5 b4 b3 b2 b1 b0 
    carryOutNeg carryOut s7 s6 s5 s4 s3 s2 s1 s0 :
  fullAdder4 carryIn carryInNeg a3 a2 a1 a0 b3 b2 b1 b0 
      carryOutNeg0 carryOut0 s3 s2 s1 s0
  fullAdder4 carryOut0 carryOutNeg0 a7 a6 a5 a4 b7 b6 b5 b4 
      carryOutNeg carryOut s7 s6 s5 s4

# Zero-Detect Circuit
def zeroDetector b7 b6 b5 b4 b3 b2 b1 b0 zero :
  r b7 1 0 i6 
  r b6 i6 0 i5
  r b5 i5 0 i4
  r b4 i4 0 i3
  r b3 i3 0 i2
  r b2 i2 0 i1
  r b1 i1 0 i0
  r b0 i0 0 zero

# Enable Circuit
def enable enabled a7 a6 a5 a4 a3 a2 a1 a0 b7 b6 b5 b4 b3 b2 b1 b0 :
  r enabled a7 b7 0
  r enabled a6 b6 0
  r enabled a5 b5 0
  r enabled a4 b4 0
  r enabled a3 b3 0
  r enabled a2 b2 0
  r enabled a1 b1 0
  r enabled a0 b0 0

# Byte MUX
def muxByte 
    address 
    h7 h6 h5 h4 h3 h2 h1 h0 
    l7 l6 l5 l4 l3 l2 l1 l0 
    o7 o6 o5 o4 o3 o2 o1 o0 :
  r address o7 h7 l7
  r address o6 h6 l6
  r address o5 h5 l5
  r address o4 h4 l4
  r address o3 h3 l3
  r address o2 h2 l2
  r address o1 h1 l1
  r address o0 h0 l0

# Byte AND
def andByte 
    enabled 
    b7 b6 b5 b4 b3 b2 b1 b0 
    c7 c6 c5 c4 c3 c2 c1 c0 
    o7 o6 o5 o4 o3 o2 o1 o0 :
  and b7 c7 z7
  and b6 c6 z6
  and b5 c5 z5
  and b4 c4 z4
  and b3 c3 z3
  and b2 c2 z2
  and b1 c1 z1
  and b0 c0 z0
  enable enabled z7 z6 z5 z4 z3 z2 z1 z0 o7 o6 o5 o4 o3 o2 o1 o0

# Byte OR
def orByte 
    enabled 
    b7 b6 b5 b4 b3 b2 b1 b0 
    c7 c6 c5 c4 c3 c2 c1 c0 
    o7 o6 o5 o4 o3 o2 o1 o0 :
  or b7 c7 z7
  or b6 c6 z6
  or b5 c5 z5
  or b4 c4 z4
  or b3 c3 z3
  or b2 c2 z2
  or b1 c1 z1
  or b0 c0 z0
  enable enabled z7 z6 z5 z4 z3 z2 z1 z0 o7 o6 o5 o4 o3 o2 o1 o0

# Byte XOR
def xorByte 
    enabled 
    b7 b6 b5 b4 b3 b2 b1 b0 
    c7 c6 c5 c4 c3 c2 c1 c0 
    o7 o6 o5 o4 o3 o2 o1 o0 :
  xor b7 c7 z7
  xor b6 c6 z6
  xor b5 c5 z5
  xor b4 c4 z4
  xor b3 c3 z3
  xor b2 c2 z2
  xor b1 c1 z1
  xor b0 c0 z0
  enable enabled z7 z6 z5 z4 z3 z2 z1 z0 o7 o6 o5 o4 o3 o2 o1 o0

# Byte NOT
def notByte enabled b7 b6 b5 b4 b3 b2 b1 b0 o7 o6 o5 o4 o3 o2 o1 o0 :
  inv b7 z7
  inv b6 z6
  inv b5 z5
  inv b4 z4
  inv b3 z3
  inv b2 z2
  inv b1 z1
  inv b0 z0
  enable enabled z7 z6 z5 z4 z3 z2 z1 z0 o7 o6 o5 o4 o3 o2 o1 o0

# Shift Left Circular Circuit
def shlByte enabled b7 b6 b5 b4 b3 b2 b1 b0 o7 o6 o5 o4 o3 o2 o1 o0 :
  enable enabled b7 b6 b5 b4 b3 b2 b1 b0 o0 o7 o6 o5 o4 o3 o2 o1

# 2-to-4 Decoder
def decoder2to4 f1 f0 o3 o2 o1 o0 :
  r f1 1 t1 n1
  r f0 t1 o3 o2
  r f0 n1 o1 o0

# 2-to-4 Decoder With Output Enable
def eDecoder2to4 enabled f1 f0 o3 o2 o1 o0 :
  decoder2to4 f1 f0 z3 z2 z1 z0
  r enabled o3 z3 0
  r enabled o2 z2 0
  r enabled o1 z1 0
  r enabled o0 z0 0

# 3-to-8 Decoder
def decoder3to8 f2 f1 f0 o7 o6 o5 o4 o3 o2 o1 o0 :
  r f2 1 t2 n2
  r f1 t2 t11 n11 
  r f1 n2 t10 n10
  r f0 t11 o7 o6
  r f0 n11 o5 o4
  r f0 t10 o3 o2
  r f0 n10 o1 o0

# 3-to-8 Decoder With Output Enable
def eDecoder3to8 enabled f2 f1 f0 o7 o6 o5 o4 o3 o2 o1 o0 :
  decoder3to8 f2 f1 f0 z7 z6 z5 z4 z3 z2 z1 z0
  enable enabled z7 z6 z5 z4 z3 z2 z1 z0 o7 o6 o5 o4 o3 o2 o1 o0

# 3-bit Flag Register
# B is bus, A for bulbs
def flagRegister
    load select Bzero Bcarry Bsign 
    Azero Acarry Asign :
  inv load loadNeg0
  inv load loadNeg1
  inv load loadNeg2 
  buf load load2
  buf load2 select
  r select Azero Bzero 0
  r select Acarry Bcarry 0
  r select Asign Bsign 0
  r Azero Azero loadNeg0 0
  r Acarry Acarry loadNeg1 0
  r Asign Asign loadNeg2 0

# 8-bit Register
# B is bus, A can feeds ALU and for bulbs
def register8 
    load select b7 b6 b5 b4 b3 b2 b1 b0 
    a7 a6 a5 a4 a3 a2 a1 a0 :
  inv load loadNeg
  buf load load2
  buf load2 select 
  enable select a7 a6 a5 a4 a3 a2 a1 a0 b7 b6 b5 b4 b3 b2 b1 b0
  r a7 a7 loadNeg 0
  r a6 a6 loadNeg 0
  r a5 a5 loadNeg 0
  r a4 a4 loadNeg 0
  r a3 a3 loadNeg 0
  r a2 a2 loadNeg 0
  r a1 a1 loadNeg 0
  r a0 a0 loadNeg 0
 
# 16-bit Register
# B is bus, A for bulbs
def register16 
    load select b15 b14 b13 b12 b11 b10 b9 b8 b7 b6 b5 b4 b3 b2 b1 b0 
    a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0 :
  inv load loadNeg 
  buf load load2
  buf load2 select 
  enable select a15 a14 a13 a12 a11 a10 a9 a8 b15 b14 b13 b12 b11 b10 b9 b8
  enable select a7 a6 a5 a4 a3 a2 a1 a0 b7 b6 b5 b4 b3 b2 b1 b0
  r a15 a15 loadNeg 0
  r a14 a14 loadNeg 0
  r a13 a13 loadNeg 0
  r a12 a12 loadNeg 0
  r a11 a11 loadNeg 0
  r a10 a10 loadNeg 0
  r a9 a9 loadNeg 0
  r a8 a8 loadNeg 0
  r a7 a7 loadNeg 0
  r a6 a6 loadNeg 0
  r a5 a5 loadNeg 0
  r a4 a4 loadNeg 0
  r a3 a3 loadNeg 0
  r a2 a2 loadNeg 0
  r a1 a1 loadNeg 0
  r a0 a0 loadNeg 0

# High-low Register
# H/L/B buses, A for bulbs
def registerHighLow 
    loadHigh selectHigh
    loadLow selectLow
    load16 select16
    h7 h6 h5 h4 h3 h2 h1 h0 l7 l6 l5 l4 l3 l2 l1 l0 
    b15 b14 b13 b12 b11 b10 b9 b8 b7 b6 b5 b4 b3 b2 b1 b0
    a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0 :
  nor load16 loadHigh loadHighNeg
  nor load16 loadLow loadLowNeg
  buf loadHigh loadHigh2
  buf loadHigh2 selectHigh
  buf loadLow loadLow2
  buf loadLow2 selectLow
  buf load16 load162
  buf load162 select16     
  enable selectLow a7 a6 a5 a4 a3 a2 a1 a0 l7 l6 l5 l4 l3 l2 l1 l0 
  enable selectHigh a15 a14 a13 a12 a11 a10 a9 a8 h7 h6 h5 h4 h3 h2 h1 h0
  enable select16 a15 a14 a13 a12 a11 a10 a9 a8 b15 b14 b13 b12 b11 b10 b9 b8
  enable select16 a7 a6 a5 a4 a3 a2 a1 a0 b7 b6 b5 b4 b3 b2 b1 b0  
  r a15 a15 loadHighNeg 0
  r a14 a14 loadHighNeg 0
  r a13 a13 loadHighNeg 0
  r a12 a12 loadHighNeg 0
  r a11 a11 loadHighNeg 0
  r a10 a10 loadHighNeg 0
  r a9 a9 loadHighNeg 0
  r a8 a8 loadHighNeg 0  
  r a7 a7 loadLowNeg 0
  r a6 a6 loadLowNeg 0
  r a5 a5 loadLowNeg 0
  r a4 a4 loadLowNeg 0
  r a3 a3 loadLowNeg 0
  r a2 a2 loadLowNeg 0
  r a1 a1 loadLowNeg 0
  r a0 a0 loadLowNeg 0

# Arithmetic Logic Unit
def ALU selectB loadB selectC loadC selectFlag loadFlag f2 f1 f0 
    d7 d6 d5 d4 d3 d2 d1 d0 zero carry sign 
    b7 b6 b5 b4 b3 b2 b1 b0
    c7 c6 c5 c4 c3 c2 c1 c0 :
  flagRegister loadFlag selectFlag zero carry sign Azero Acarry Asign
  register8 loadB selectB d7 d6 d5 d4 d3 d2 d1 d0 b7 b6 b5 b4 b3 b2 b1 b0
  register8 loadC selectC d7 d6 d5 d4 d3 d2 d1 d0 c7 c6 c5 c4 c3 c2 c1 c0
  muxByte incSig 0 0 0 0 0 0 0 1 c7 c6 c5 c4 c3 c2 c1 c0 i7 i6 i5 i4 i3 i2 i1 i0
  decoder3to8 f2 f1 f0 0 shlSig notSig xorSig orSig andSig incSig addSig  
  fullAdder8 0 1 b7 b6 b5 b4 b3 b2 b1 b0 i7 i6 i5 i4 i3 i2 i1 i0 
      0 carryOut s7 s6 s5 s4 s3 s2 s1 s0
  or incSig addSig adderSig
  enable adderSig s7 s6 s5 s4 s3 s2 s1 s0 d7 d6 d5 d4 d3 d2 d1 d0  
  andByte andSig 
      b7 b6 b5 b4 b3 b2 b1 b0 c7 c6 c5 c4 c3 c2 c1 c0 d7 d6 d5 d4 d3 d2 d1 d0
  orByte orSig
      b7 b6 b5 b4 b3 b2 b1 b0 c7 c6 c5 c4 c3 c2 c1 c0 d7 d6 d5 d4 d3 d2 d1 d0
  xorByte xorSig
      b7 b6 b5 b4 b3 b2 b1 b0 c7 c6 c5 c4 c3 c2 c1 c0 d7 d6 d5 d4 d3 d2 d1 d0
  notByte notSig b7 b6 b5 b4 b3 b2 b1 b0 d7 d6 d5 d4 d3 d2 d1 d0
  shlByte shlSig b7 b6 b5 b4 b3 b2 b1 b0 d7 d6 d5 d4 d3 d2 d1 d0
  zeroDetector d7 d6 d5 d4 d3 d2 d1 d0 zeroOut 
  r loadFlag zero zeroOut 0
  r loadFlag carry carryOut 0
  r loadFlag sign d7 0

# 16-bit Incrementer
def incrementer 
    i15 i14 i13 i12 i11 i10 i9 i8 i7 i6 i5 i4 i3 i2 i1 i0
    o15 o14 o13 o12 o11 o10 o9 o8 o7 o6 o5 o4 o3 o2 o1 o0 :
  fullAdder8 1 0 i7 i6 i5 i4 i3 i2 i1 i0 0 0 0 0 0 0 0 0 
      carryOutNeg carryOut o7 o6 o5 o4 o3 o2 o1 o0
  fullAdder8 carryOut carryOutNeg i15 i14 i13 i12 i11 i10 i9 i8 0 0 0 0 0 0 0 0
      0 0 o15 o14 o13 o12 o11 o10 o9 o8

# Latch, stores when w = 1 
def latch w d q : 
  r w c2 d q 
  r c2 q 1 0 

# Latch, stores when w = 0 
def latchNeg w d q : 
  r w c2 q d 
  r c2 q 1 0 

# Flip flop, stores when w rises to 1, expresses new value when w drops to 0 
def flipFlop w d q : 
  latch w d q2 
  latchNeg w q2 q

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

# 2-to-1 Mux
def mux a i1 i0 o :
  r a o i1 i0 

# Multiplication program in ROM
def rom select d7 d6 d5 d4 d3 d2 d1 d0 a6 a5 a4 a3 a2 a1 a0 :
  mux a0 ad0000001 ad0000000 ad000000
  mux a0 ad0000011 ad0000010 ad000001
  mux a0 ad0000101 ad0000100 ad000010
  mux a0 ad0000111 ad0000110 ad000011
  mux a0 ad0001001 ad0001000 ad000100
  mux a0 ad0001011 ad0001010 ad000101
  mux a0 ad0001101 ad0001100 ad000110
  mux a0 ad0001111 ad0001110 ad000111
  mux a0 ad0010001 ad0010000 ad001000
  mux a0 ad0010011 ad0010010 ad001001
  mux a0 ad0010101 ad0010100 ad001010
  mux a0 ad0010111 ad0010110 ad001011
  mux a0 ad0011001 ad0011000 ad001100
  mux a0 ad0011011 ad0011010 ad001101
  mux a0 ad0011101 ad0011100 ad001110
  mux a0 ad0011111 ad0011110 ad001111
  mux a0 ad0100001 ad0100000 ad010000
  mux a0 ad0100011 ad0100010 ad010001
  mux a0 ad0100101 ad0100100 ad010010
  mux a0 ad0100111 ad0100110 ad010011
  mux a0 ad0101001 ad0101000 ad010100
  mux a0 ad0101011 ad0101010 ad010101
  mux a0 ad0101101 ad0101100 ad010110
  mux a0 ad0101111 ad0101110 ad010111
  mux a0 ad0110001 ad0110000 ad011000
  mux a0 ad0110011 ad0110010 ad011001
  mux a0 ad0110101 ad0110100 ad011010
  mux a0 ad0110111 ad0110110 ad011011
  mux a0 ad0111001 ad0111000 ad011100
  mux a0 ad0111011 ad0111010 ad011101
  mux a0 ad0111101 ad0111100 ad011110
  mux a0 ad0111111 ad0111110 ad011111
  mux a0 ad1000001 ad1000000 ad100000
  mux a0 ad1000011 ad1000010 ad100001
  mux a1 ad000001 ad000000 ad00000
  mux a1 ad000011 ad000010 ad00001
  mux a1 ad000101 ad000100 ad00010
  mux a1 ad000111 ad000110 ad00011
  mux a1 ad001001 ad001000 ad00100
  mux a1 ad001011 ad001010 ad00101
  mux a1 ad001101 ad001100 ad00110
  mux a1 ad001111 ad001110 ad00111
  mux a1 ad010001 ad010000 ad01000
  mux a1 ad010011 ad010010 ad01001
  mux a1 ad010101 ad010100 ad01010
  mux a1 ad010111 ad010110 ad01011
  mux a1 ad011001 ad011000 ad01100
  mux a1 ad011011 ad011010 ad01101
  mux a1 ad011101 ad011100 ad01110
  mux a1 ad011111 ad011110 ad01111
  mux a1 ad100001 ad100000 ad10000
  mux a2 ad00001 ad00000 ad0000
  mux a2 ad00011 ad00010 ad0001
  mux a2 ad00101 ad00100 ad0010
  mux a2 ad00111 ad00110 ad0011
  mux a2 ad01001 ad01000 ad0100
  mux a2 ad01011 ad01010 ad0101
  mux a2 ad01101 ad01100 ad0110
  mux a2 ad01111 ad01110 ad0111
  mux a2 ad10001 ad10000 ad1000
  mux a3 ad0001 ad0000 ad000
  mux a3 ad0011 ad0010 ad001
  mux a3 ad0101 ad0100 ad010
  mux a3 ad0111 ad0110 ad011
  mux a3 ad1001 ad1000 ad100
  mux a4 ad001 ad000 ad00
  mux a4 ad011 ad010 ad01
  mux a4 ad101 ad100 ad10
  mux a5 ad01 ad00 ad0
  mux a5 ad11 ad10 ad1
  mux a6 ad1 ad0 select
  trans8 ad0000000 d7 d6 d5 d4 d3 d2 d1 d0 1 1 0 0 0 0 0 0
  trans8 ad0000001 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 0 0 0 0 0
  trans8 ad0000010 d7 d6 d5 d4 d3 d2 d1 d0 0 1 0 0 0 0 0 1
  trans8 ad0000011 d7 d6 d5 d4 d3 d2 d1 d0 1 0 0 1 0 0 0 0
  trans8 ad0000100 d7 d6 d5 d4 d3 d2 d1 d0 0 0 1 1 0 0 0 0
  trans8 ad0000101 d7 d6 d5 d4 d3 d2 d1 d0 1 1 0 0 0 0 0 0
  trans8 ad0000110 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 0 0 0 0 0
  trans8 ad0000111 d7 d6 d5 d4 d3 d2 d1 d0 0 1 0 0 0 0 1 0
  trans8 ad0001000 d7 d6 d5 d4 d3 d2 d1 d0 1 0 0 1 0 0 0 0
  trans8 ad0001001 d7 d6 d5 d4 d3 d2 d1 d0 0 0 1 1 1 0 0 0
  trans8 ad0001010 d7 d6 d5 d4 d3 d2 d1 d0 0 0 1 0 0 1 0 0
  trans8 ad0001011 d7 d6 d5 d4 d3 d2 d1 d0 0 0 1 0 1 1 1 0
  trans8 ad0001100 d7 d6 d5 d4 d3 d2 d1 d0 0 1 0 1 1 0 0 1
  trans8 ad0001101 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 1 1 0 0 0
  trans8 ad0001110 d7 d6 d5 d4 d3 d2 d1 d0 0 1 1 0 0 0 0 0
  trans8 ad0001111 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 1 0 1 1 1
  trans8 ad0010000 d7 d6 d5 d4 d3 d2 d1 d0 1 0 0 0 0 0 1 1
  trans8 ad0010001 d7 d6 d5 d4 d3 d2 d1 d0 1 1 1 1 0 0 0 0
  trans8 ad0010010 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 0 0 0 0 0
  trans8 ad0010011 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 1 0 1 0 1
  trans8 ad0010100 d7 d6 d5 d4 d3 d2 d1 d0 0 0 1 0 1 0 0 1
  trans8 ad0010101 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 0 1 1 0 0
  trans8 ad0010110 d7 d6 d5 d4 d3 d2 d1 d0 1 0 0 0 0 1 1 0
  trans8 ad0010111 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 1 0 0 0 0
  trans8 ad0011000 d7 d6 d5 d4 d3 d2 d1 d0 0 1 1 1 1 1 1 0
  trans8 ad0011001 d7 d6 d5 d4 d3 d2 d1 d0 1 0 0 0 0 0 1 0
  trans8 ad0011010 d7 d6 d5 d4 d3 d2 d1 d0 0 0 1 0 0 0 0 0
  trans8 ad0011011 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 0 1 1 0 1
  trans8 ad0011100 d7 d6 d5 d4 d3 d2 d1 d0 1 0 0 0 0 1 0 1
  trans8 ad0011101 d7 d6 d5 d4 d3 d2 d1 d0 1 1 1 1 0 0 0 0
  trans8 ad0011110 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 0 0 0 0 0
  trans8 ad0011111 d7 d6 d5 d4 d3 d2 d1 d0 0 0 1 0 0 0 1 1
  trans8 ad0100000 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 0 1 1 0 0
  trans8 ad0100001 d7 d6 d5 d4 d3 d2 d1 d0 1 0 0 0 0 0 0 1
  trans8 ad0100010 d7 d6 d5 d4 d3 d2 d1 d0 0 0 1 0 0 0 0 0
  trans8 ad0100011 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 0 1 1 0 1
  trans8 ad0100100 d7 d6 d5 d4 d3 d2 d1 d0 1 0 0 0 0 1 1 0
  trans8 ad0100101 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 1 0 0 0 0
  trans8 ad0100110 d7 d6 d5 d4 d3 d2 d1 d0 0 1 1 1 1 1 1 0
  trans8 ad0100111 d7 d6 d5 d4 d3 d2 d1 d0 1 0 0 0 0 0 1 0
  trans8 ad0101000 d7 d6 d5 d4 d3 d2 d1 d0 0 0 1 0 1 0 0 0
  trans8 ad0101001 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 0 1 1 1 1
  trans8 ad0101010 d7 d6 d5 d4 d3 d2 d1 d0 1 0 0 0 0 1 1 0
  trans8 ad0101011 d7 d6 d5 d4 d3 d2 d1 d0 0 0 1 1 1 0 0 0
  trans8 ad0101100 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 0 1 1 1 1
  trans8 ad0101101 d7 d6 d5 d4 d3 d2 d1 d0 1 0 0 0 0 1 0 1
  trans8 ad0101110 d7 d6 d5 d4 d3 d2 d1 d0 1 1 1 1 0 0 0 0
  trans8 ad0101111 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 0 0 0 0 0
  trans8 ad0110000 d7 d6 d5 d4 d3 d2 d1 d0 0 0 1 1 1 0 1 1
  trans8 ad0110001 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 0 1 1 0 1
  trans8 ad0110010 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 1 0 1 1 0
  trans8 ad0110011 d7 d6 d5 d4 d3 d2 d1 d0 1 0 0 0 0 0 0 0
  trans8 ad0110100 d7 d6 d5 d4 d3 d2 d1 d0 0 0 1 0 1 0 0 0
  trans8 ad0110101 d7 d6 d5 d4 d3 d2 d1 d0 1 1 1 0 1 0 0 0
  trans8 ad0110110 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 0 0 0 0 0
  trans8 ad0110111 d7 d6 d5 d4 d3 d2 d1 d0 0 0 1 1 1 0 1 1
  trans8 ad0111000 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 0 1 1 0 0
  trans8 ad0111001 d7 d6 d5 d4 d3 d2 d1 d0 1 0 0 0 0 0 0 1
  trans8 ad0111010 d7 d6 d5 d4 d3 d2 d1 d0 0 0 1 0 0 0 0 0
  trans8 ad0111011 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 0 1 0 1 1
  trans8 ad0111100 d7 d6 d5 d4 d3 d2 d1 d0 1 0 0 0 1 0 0 1
  trans8 ad0111101 d7 d6 d5 d4 d3 d2 d1 d0 1 1 1 0 0 0 1 0
  trans8 ad0111110 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 0 0 0 0 0
  trans8 ad0111111 d7 d6 d5 d4 d3 d2 d1 d0 0 0 0 1 0 1 0 1
  trans8 ad1000000 d7 d6 d5 d4 d3 d2 d1 d0 1 0 1 0 1 1 1 0
  trans8 ad1000001 d7 d6 d5 d4 d3 d2 d1 d0 1 1 0 1 1 1 0 1
  trans8 ad1000010 d7 d6 d5 d4 d3 d2 d1 d0 1 0 1 1 0 0 1 1

# Putting it all together
def computer 
      ra7 ra6 ra5 ra4 ra3 ra2 ra1 ra0
      rb7 rb6 rb5 rb4 rb3 rb2 rb1 rb0
      rc7 rc6 rc5 rc4 rc3 rc2 rc1 rc0
      rd7 rd6 rd5 rd4 rd3 rd2 rd1 rd0
      m15 m14 m13 m12 m11 m10 m9 m8 m7 m6 m5 m4 m3 m2 m1 m0
      xy15 xy14 xy13 xy12 xy11 xy10 xy9 xy8 xy7 xy6 xy5 xy4 xy3 xy2 xy1 xy0 :
  rom selectMemory d7 d6 d5 d4 d3 d2 d1 d0 a6 a5 a4 a3 a2 a1 a0
  register16 loadPC selectPC 
      a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0
      pc15 pc14 pc13 pc12 pc11 pc10 pc9 pc8 pc7 pc6 pc5 pc4 pc3 pc2 pc1 pc0 
  registerHighLow loadIN 0 loadIN 0 0 selectIN  
      ic15 ic14 ic13 ic12 ic11 ic10 ic9 ic8 ic7 ic6 ic5 ic4 ic3 ic2 ic1 ic0
      a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0 
      in15 in14 in13 in12 in11 in10 in9 in8 in7 in6 in5 in4 in3 in2 in1 in0
  incrementer 
      a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0
      ic15 ic14 ic13 ic12 ic11 ic10 ic9 ic8 ic7 ic6 ic5 ic4 ic3 ic2 ic1 ic0
  ALU selectB loadB selectC loadC selectFlag loadFlag 
      alu2 alu1 alu0 
      d7 d6 d5 d4 d3 d2 d1 d0 zero carry sign
      rb7 rb6 rb5 rb4 rb3 rb2 rb1 rb0
      rc7 rc6 rc5 rc4 rc3 rc2 rc1 rc0
  register8 loadA selectA 
      d7 d6 d5 d4 d3 d2 d1 d0 ra7 ra6 ra5 ra4 ra3 ra2 ra1 ra0
  register8 loadD selectD 
      d7 d6 d5 d4 d3 d2 d1 d0 rd7 rd6 rd5 rd4 rd3 rd2 rd1 rd0
  register8 loadInst selectInst 
      d7 d6 d5 d4 d3 d2 d1 d0 ns7 ns6 ns5 ns4 ns3 ns2 ns1 ns0
  registerHighLow loadM1 selectM1 loadM2 selectM2 loadM selectM  
      d7 d6 d5 d4 d3 d2 d1 d0 d7 d6 d5 d4 d3 d2 d1 d0 
      a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0 
      m15 m14 m13 m12 m11 m10 m9 m8 m7 m6 m5 m4 m3 m2 m1 m0
  registerHighLow loadJ1 selectJ1 loadJ2 selectJ2 loadJ selectJ  
      d7 d6 d5 d4 d3 d2 d1 d0 d7 d6 d5 d4 d3 d2 d1 d0 
      a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0 
      j15 j14 j13 j12 j11 j10 j9 j8 j7 j6 j5 j4 j3 j2 j1 j0
  registerHighLow loadX selectX loadY selectY loadXY selectXY  
      d7 d6 d5 d4 d3 d2 d1 d0 d7 d6 d5 d4 d3 d2 d1 d0 
      a15 a14 a13 a12 a11 a10 a9 a8 a7 a6 a5 a4 a3 a2 a1 a0 
      xy15 xy14 xy13 xy12 xy11 xy10 xy9 xy8 xy7 xy6 xy5 xy4 xy3 xy2 xy1 xy0
  
  # BOOT (starts as 0, locks into 1 forever)
  flipFlop C 1 boot
  inv boot bootNeg  

  # PC = 0
  flipFlop C bootNeg state4
  buf state4 loadPC
  buf state4 mainLoop

  # -- COPY INSTRUCTION IN MEMORY TO INSTRUCTION REGISTER BEGIN ----------------   
  flipFlop C mainLoop stateMainLoop

  flipFlop C stateMainLoop state5
  buf state5 selectPC

  flipFlop C state5 state6
  buf state6 selectPC
  buf state6 selectMemory
  buf state6 loadInst
  buf state6 loadIN          # IN = PC + 1

  flipFlop C state6 state7
  buf state7 selectPC
  buf state7 selectMemory  

  flipFlop C state7 state8
  buf state8 loadPC          # PC = IN
  buf state8 selectIN

  flipFlop C state8 state9
  buf state9 selectIN 
  buf state9 processInst
  # -- COPY INSTRUCTION IN MEMORY TO INSTRUCTION REGISTER END ------------------

  # -- RETURN (1010 dss0) BEGIN ------------------------------------------------  
  r ns7 rt7 processInst 0
  r ns6 rt6 0 rt7
  r ns5 rt5 rt6 0
  r ns4 rt4 0 rt5
  flipFlop C rt4 state38
  buf state38 state38b
  buf state38 state38c
  r ns3 state38c loadPC loadXY
  eDecoder2to4 state38b ns2 ns1 halt selectJ selectXY selectM

  flipFlop C state38 state39
  buf state39 state38b
  inv halt haltNeg
  and haltNeg state39 mainLoop
  # -- RETURN (1010 dss0) END --------------------------------------------------

  # -- 16-BIT INSTRUCTION (11rs cznx) BEGIN ------------------------------------
  r ns7 nx7 processInst 0
  r ns6 nx6 nx7 0
  flipFlop C nx6 state24b
  buf state24b selectPC

  flipFlop C state24b state25
  buf state25 selectPC
  buf state25 selectMemory
  buf state25 state25b
  r ns5 state25b loadJ1 loadM1      # M1/J1 <- MEM
  buf state25 loadIN                # IN = PC + 1
  
  flipFlop C state25 state26
  buf state26 selectPC
  buf state26 selectMemory

  flipFlop C state26 state27
  buf state27 loadPC                # PC = IN
  buf state27 selectIN

  flipFlop C state27 state28
  buf state28 selectIN

  flipFlop C state28 state29
  buf state29 selectPC
  buf state29 selectMemory
  buf state29 state29b
  r ns5 state29b loadJ2 loadM2      # M2/J2 <- MEM
  buf state29 loadIN                # IN = PC + 1

  flipFlop C state29 state30
  buf state30 selectPC
  buf state30 selectMemory

  flipFlop C state30 state31
  buf state31 loadPC                # PC = IN
  buf state31 selectIN

  flipFlop C state31 state35
  buf state35 selectFlag
  inv carry carryNeg
  inv zero zeroNeg
  and ns4 sign jmp0
  and ns3 carryNeg jmp1
  and ns2 zero jmp2
  and ns1 zeroNeg jmp3
  buf jmp0 jmp
  buf jmp1 jmp
  buf jmp2 jmp
  buf jmp3 jmp
  inv jmp jmpNeg
  and state35 jmp doJump
  and state35 jmpNeg mainLoop

  flipFlop C doJump state32
  inv ns0 ns0neg
  and state32 ns0 savePC
  and state32 ns0neg dontSavePC

  flipFlop C savePC state33         
  buf state33 selectPC
  buf state33 loadXY                # XY = PC
  
  flipFlop C state33 state34
  buf state34 selectPC
  buf state34 dontSavePC

  flipFlop C dontSavePC state36
  buf state36 state36b
  r ns5 state36b selectJ selectM
  buf state36 loadPC                # PC = M/J

  flipFlop C state36 state37
  buf state37 state36b
  buf state37 mainLoop  
  # -- 16-BIT INSTRUCTION (11rs cznx) END --------------------------------------

  # -- INC XY (1011 0000) BEGIN ------------------------------------------------
  r ns7 ix7 processInst 0
  r ns6 ix6 0 ix7
  r ns5 ix5 ix6 0
  r ns4 ix4 ix5 0
  r ns3 ix3 0 ix4
  r ns2 ix2 0 ix3
  r ns1 ix1 0 ix2
  r ns0 ix0 0 ix1
  flipFlop C ix0 state21
  buf state21 selectXY
  buf state21 loadIN

  flipFlop C state21 state22
  buf state22 selectXY
  
  flipFlop C state22 state23
  buf state23 loadXY
  buf state23 selectIN

  flipFlop C state23 state24
  buf state24 selectIN
  buf state24 mainLoop  
  # -- INC XY (1011 0000) END --------------------------------------------------

  # -- ALU (1000 rfff) BEGIN ---------------------------------------------------
  r ns7 al7 processInst 0
  r ns6 al6 0 al7
  r ns5 al5 0 al6
  r ns4 al4 0 al5
  flipFlop C al4 state19
  buf state19 aluing
  r aluing alu2 ns2 1
  r aluing alu1 ns1 1
  r aluing alu0 ns0 1
  buf state19 loadFlag  
  buf state19 state19b
  r ns3 state19b loadD loadA

  flipFlop C state19 state20
  buf state20 aluing
  buf state20 mainLoop
  # -- ALU (1000 rfff) END -----------------------------------------------------

  # -- LD (1001 0xrr) BEGIN ----------------------------------------------------
  r ns3 ld3 0 sto4
  flipFlop C ld3 state17
  buf state17 selectM
  buf state17 selectMemory  
  eDecoder2to4 state17 ns1 ns0 loadD loadC loadB loadA

  flipFlop C state17 state18
  buf state18 selectM
  buf state18 selectMemory
  buf state18 mainLoop  
  # -- LD (1001 0xrr) END ------------------------------------------------------

  # -- STO (1001 1xrr) BEGIN ---------------------------------------------------
  r ns7 sto7 processInst 0 
  r ns6 sto6 0 sto7
  r ns5 sto5 0 sto6
  r ns4 sto4 sto5 0
  r ns3 sto3 sto4 0
  flipFlop C sto3 state14
  buf state14 storing
  buf storing selectM
  eDecoder2to4 storing ns1 ns0 selectD selectC selectB selectA
  
  flipFlop C state14 state15
  buf state15 storing
  buf state15 loadMemory

  flipFlop C state15 state16
  buf state16 storing
  buf state16 mainLoop
  # -- STO (1001 1xrr) END -----------------------------------------------------

  # -- MOV (00dd dsss) BEGIN ---------------------------------------------------
  r ns7 mo7 0 processInst
  r ns6 mo6 0 mo7  
  flipFlop C mo6 state12
  or state12 state13 movSrc
  eDecoder3to8 state12 ns5 ns4 ns3 
      loadY loadX loadM2 loadM1 loadD loadC loadB loadA
  eDecoder3to8 movSrc ns2 ns1 ns0 
      selectY selectX selectM2 selectM1 selectD selectC selectB selectA

  flipFlop C state12 state13
  buf state13 mainLoop
  # -- MOV (00dd dsss) END -----------------------------------------------------

  # -- SET-8 (01rv vvvv) BEGIN -------------------------------------------------
  r ns7 se7 0 processInst
  r ns6 se6 se7 0
  flipFlop C se6 state10
  buf state10 state10load
  r ns5 state10load loadB loadA
  or state10 state11 enable1011
  enable enable1011 ns4 ns4 ns4 ns4 ns3 ns2 ns1 ns0 d7 d6 d5 d4 d3 d2 d1 d0

  flipFlop C state10 state11
  buf state11 mainLoop  
  # -- SET-8 (01rv vvvv) END ---------------------------------------------------

run 41000 10 computer
    ? ? ? ? ? ? ? ?
    ? ? ? ? ? ? ? ?
    ? ? ? ? ? ? ? ?
    ? ? ? ? ? ? ? ?
    ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?
    ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?