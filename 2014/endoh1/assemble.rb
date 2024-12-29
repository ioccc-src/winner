# dump machine code

require_relative "ast-def"
require_relative "machine"

def dump_seq(seq)
  seq.each_cons(2) do |insn1, insn2|
    if insn1.is_a?(IPush) && insn2.is_a?(IPush)
      p insn1, insn2
      raise "consecutive push"
    end
  end

  seq.map do |insn|
    case insn
    when IRead  then (REGISTER_READ  + insn.var.ord - ?a.ord).chr if insn.var
    when IWrite then (REGISTER_WRITE + insn.var.ord - ?a.ord).chr if insn.var
    when IInc then MNEMONIC[:Inc] + (REGISTER_READ + insn.var.ord - ?a.ord).chr
    when IDec then MNEMONIC[:Dec] + (REGISTER_READ + insn.var.ord - ?a.ord).chr
    when IPush then encode_number(insn.num)
    when IBranch
      MNEMONIC[:BranchS] + dump_seq(insn.s1) +
      MNEMONIC[:BranchM] + dump_seq(insn.s2) +
      MNEMONIC[:BranchE]
    when ILoop
      MNEMONIC[:LoopS] + dump_seq(insn.s1) +
      MNEMONIC[:LoopM] + dump_seq(insn.s2) +
      MNEMONIC[:LoopE]
    when IBinary then MNEMONIC[insn.op]
    when ITest   then MNEMONIC[:Test]
    when IARef   then MNEMONIC[:ARef]
    when IOut    then MNEMONIC[:Out]
    when IExit   then MNEMONIC[:Exit]
    when IASet   then MNEMONIC[:ASet]
    end
  end.join
end

def check_opt_inc_dec(seq, i)
  return unless seq[i].is_a?(IRead)
  return unless seq[i + 1] == IPush[1]
  return unless seq[i + 2] == IBinary[:+] || seq[i + 2] == IBinary[:-]
  return unless seq[i + 3] == IWrite[seq[i].var]
  insn = (seq[i + 2].op == :+ ? IInc : IDec)[seq[i].var]
  flag = seq[i + 4].is_a?(IRead) && seq[i + 4].var == seq[i].var
  [insn, seq[i].var, flag]
end

def opt_inc_dec(seq)
  while true
    modified = false
    (seq.size - 3).times do |i|
      new_insn, var, flag = check_opt_inc_dec(seq, i)
      if new_insn
        if flag
          seq[i, 5] = [new_insn]
        else
          seq[i, 4] = [new_insn, IWrite[var]]
        end
        modified = true
      end
    end
    break if !modified
  end

  seq.each do |insn|
    case insn
    when IBranch, ILoop
      opt_inc_dec(insn.s1)
      opt_inc_dec(insn.s2)
    end
  end
end

if ARGV.size != 2
  puts "usage: #$0 <seq3.txt> <raw.txt>"
else
  seq = eval(File.read(ARGV[0]))
  opt_inc_dec(seq)
  File.write(ARGV[1], dump_seq(seq))
end
