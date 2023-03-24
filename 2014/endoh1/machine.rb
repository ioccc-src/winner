# 33       : not used
# 34       : NG
# 35..55   : read
# 56..76   : write
# 77..85   : binary op
# 86..91   : not used
# 92       : NG
# 93..98   : control (0..5)
# 99..104  : other insns (6..12)
# 105..126 : num (13..32)

MNEMONIC = {
  :Nop => "",

  :+    => 77.chr,
  :-    => 78.chr,
  :*    => 79.chr,
  :"&&" => 79.chr,
  :^    => 80.chr,
  :>    => 81.chr,
  :/    => 82.chr,
  :%    => 83.chr,
  :">>" => 84.chr, #  6
  :"==" => 85.chr,

  :BranchS => 93.chr, # 0 -> BranchM
  :LoopM   => 94.chr, # 1 -> LoopE
  :BranchM => 95.chr, # 2 -> BranchE
  :LoopE   => 96.chr, # 3 -> LoopS (back)
  :BranchE => 97.chr, # 4
  :LoopS   => 98.chr, # 5

  :ARef =>  99.chr, # 6
  :ASet => 100.chr, # 7
  :Out  => 101.chr, # 8
  :Exit => 102.chr, # 9
  :Inc  => 103.chr, # 10
  :Dec  => 104.chr, # 11

  :Test => 105.chr,
}

REGISTER_READ = 35
REGISTER_WRITE = 56
IMM = 106

def encode_number(n)
  if n >= 0
    tt = n.to_s(126 - IMM + 1).tr("0-9a-z", [*IMM.chr..126.chr].join)
    raise if tt[0] == 126.chr
    tt[0, 1] = tt[0].tr([*IMM.chr..125.chr].join, [*(IMM + 1).chr..126.chr].join)
  else
    raise if n != -1
    tt = IMM.chr
  end
  tt
end
