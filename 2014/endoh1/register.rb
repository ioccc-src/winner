# register allocation (variable renaming again!)

require_relative "ast-def"
require "minisat"

Conflicts = {}

def liveness(seq, vars)
  nvars = vars.dup

  seq.reverse_each do |insn|
    case insn
    when IRead, IWrite
      nvars[insn.var] = true if insn.var
    when IExit
      nvars.clear
    when IBranch
      nvars1 = liveness(insn.s1, nvars)
      nvars2 = liveness(insn.s2, nvars)
      nvars = nvars1.merge(nvars2)
    when ILoop
      begin
        nvars_back = nvars
        nvars1 = liveness(insn.s1, nvars)
        nvars2 = liveness(insn.s1, liveness(insn.s2, nvars))
        nvars = nvars1.merge(nvars2)
      end until nvars.keys == nvars_back.keys
    end

    nvars.keys.sort.combination(2) do |v1, v2|
      Conflicts[[v1, v2].sort] = true
    end

    nvars.delete(insn.var) if insn.is_a?(IWrite) && insn.var
  end

  nvars
end

def graph_coloring(liveness, k)
  solver = MiniSat::Solver.new

  h = {}

  liveness.keys.flatten.uniq.each do |var|
    vs = (0...k).map { solver.new_var }
    solver << vs
    vs.combination(2) {|v1, v2| solver << [-v1, -v2] }
    h[var] = vs
  end

  liveness.each_key do |var1, var2|
    h[var1].zip(h[var2]) {|v1, v2| solver << [-v1, -v2] }
  end

  solver.solve

  h.each do |var, vs|
    h[var] = (vs.find_index {|v| solver[v] } + ?a.ord).chr
  end
  h
end

def rename(seq, h)
  seq.each do |insn|
    case insn
    when IRead, IWrite
      insn.var.replace h[insn.var] if insn.var
    when IBranch, ILoop
      rename(insn.s1, h)
      rename(insn.s2, h)
    end
  end
end

if ARGV.size != 2
  puts "usage: #$0 <seq2.txt> <seq3.txt>"
else
  seq = eval(File.read(ARGV[0]))
  liveness(seq, {})
  rename(seq, graph_coloring(Conflicts, 21))
  File.write(ARGV[1], seq.pretty_inspect)
end
