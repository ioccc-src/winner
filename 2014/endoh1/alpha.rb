# alpha conversion (variable renaming)

require_relative "ast-def"

class ID
  @@num = 0

  def initialize(name)
    @unified = nil
    @name = "#{ name }:#{ @@num }"
    @@num += 1
  end

  attr_reader :name, :unified

  def inspect
    if @unified
      @unified.inspect
    else
      "#<#{ self.class }:#{ @name }>"
    end
  end

  def unify(other)
    if @unified
      @unified.unify(other)
    elsif other.term != self
      @unified = other
    end
  end

  def term
    @unified ? @unified.term : self
  end

  def ==(other)
    term.name == other.term.name
  end

  alias eql? ==

  def hash
    if @unified
      @unified.hash
    else
      @name
    end
  end
end 

def merge(vars1, vars2)
  vars1.each do |key, var|
    if vars2[key] && vars2[key] != var
      var.unify(vars2[key])
    end
  end
  vars1.merge(vars2)
end

def check_opt_inc_dec(seq)
  seq.each_cons(4) do |insn1, insn2, insn3, insn4|
    next unless insn1.is_a?(IRead)
    next unless insn2 == IPush[1]
    next unless insn3 == IBinary[:+] || insn3 == IBinary[:-]
    next unless insn4 == IWrite[insn1.var]
    insn1.tmp.unify(insn4.tmp)
  end

  seq.each do |insn|
    case insn
    when IBranch, ILoop
      check_opt_inc_dec(insn.s1)
      check_opt_inc_dec(insn.s2)
    end
  end
end

def alpha(seq, vars)
  nvars = vars.dup
  seq.reverse_each do |insn|
    case insn
    when IRead
      if insn.var
        if insn.tmp
          nvars[insn.var] ||= insn.tmp
          nvars[insn.var].unify(insn.tmp)
        else
          insn.tmp = nvars[insn.var] ||= ID.new(insn.var)
        end
      end
    when IWrite
      if insn.var
        if insn.tmp
          nvars[insn.var] ||= insn.tmp
          nvars[insn.var].unify(insn.tmp)
        else
          insn.tmp = nvars[insn.var]
        end
        nvars.delete(insn.var)
      end
    when IExit
      nvars.clear
    when IBranch
      nvars1 = alpha(insn.s1, nvars)
      nvars2 = alpha(insn.s2, nvars)
      nvars = merge(nvars1, nvars2)
    when ILoop
      begin
        nvars_back = nvars.dup
        nvars1 = alpha(insn.s1, nvars)
        nvars2 = alpha(insn.s1, alpha(insn.s2, nvars))
        nvars = merge(nvars1, nvars2)
        merge(nvars, nvars_back)
      end until nvars.keys == nvars_back.keys
    end
  end
  nvars
end

def rename(seq)
  seq.each do |insn|
    case insn
    when IRead, IWrite
      insn.tmp = ID.new(insn.var) if insn.var == "dummy"
      insn.var.replace insn.tmp.term.name if insn.var
    when IBranch, ILoop
      rename(insn.s1)
      rename(insn.s2)
    end
  end
end

if ARGV.size != 2
  puts "usage: #$0 <seq1.txt> <seq2.txt>"
else
  seq = eval(File.read(ARGV[0]))
  alpha(seq, {})
  check_opt_inc_dec(seq)
  rename(seq)
  File.write(ARGV[1], seq.pretty_inspect)
end
