# translate AST into stack-based instruction sequence

require_relative "ast-def"

class PRead
  def emit
    [IRead[var]]
  end
end

class PImm
  def emit
    [IPush[num]]
  end
end

class PNop
  def emit
    [INop[]]
  end
end

class PBinary
  def emit
    if op == :<
      e2.emit + e1.emit + [IBinary[:>]]
    else
      e1.emit + e2.emit + [IBinary[op]]
    end
  end
end

class PIfThenElse
  def emit
    s1 = e1.emit
    s2 = e2.emit

    # merge the common tails if any
    tails = []
    s1.reverse.zip(s2.reverse) do |i1, i2|
      break if i1 != i2
      s1.pop
      s2.pop
      tails.unshift i1
    end

    cond.emit + [IBranch[s1, s2]] + tails
  end
end

class PARef
  def emit
    if e1 == PImm[0] && e2.is_a?(PBinary) && e2.op == :+
      e2.emit[0..-2] + [IARef[]]
    elsif e2 == PImm[0] && e1.is_a?(PBinary) && e1.op == :+
      e1.emit[0..-2] + [IARef[]]
    else
      e1.emit + e2.emit + [IARef[]]
    end
  end
end

class PASet
  def emit
    if e1 == PImm[0] && e2.is_a?(PBinary) && e2.op == :+
      e3.emit + e2.emit[0..-2] + [IASet[]]
    elsif e2 == PImm[0] && e1.is_a?(PBinary) && e1.op == :+
      e3.emit + e1.emit[0..-2] + [IASet[]]
    else
      e3.emit + e2.emit + e1.emit + [IASet[]]
    end
  end
end

class PAssign
  def emit
    exp.emit + [IWrite[var != ?_ ? var : nil]]
  end
end

class PSequence
  def emit
    seq.flat_map {|e| e.emit } + e.emit
  end
end

class PLoop
  def emit
    [ILoop[cond.emit, body.flat_map {|e| e.emit }]]
  end
end

class PTest
  def emit
    e.emit + [ITest[]]
  end
end

class PExit
  def emit
    e.emit + [IExit[]]
  end
end

class POut
  def emit
    e.emit + [IOut[]]
  end
end

class Array
  def emit
    flat_map {|e| e.emit }
  end
end

if ARGV.size != 2
  puts "usage: #$0 <ast.txt> <seq1.txt>"
else
  ast = eval(File.read(ARGV[0]))
  File.write(ARGV[1], ast.flat_map {|e| e.emit }.pretty_inspect)
end
