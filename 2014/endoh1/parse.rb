# parse pseudo Ruby code and generate AST

require_relative "ast-def"
require "ripper"

Subroutines = {}

def expr(e)
  case e[0]
  when :binary then PBinary[e[2], expr(e[1]), expr(e[3])]
  when :var_ref, :vcall
    name = e[1][1]
    case name
    when "nop" then PNop[]
    when "minus1" then PImm[-1]
    when "Zero" then PImm[0]
    else PRead[name]
    end
  when :aref then PARef[expr(e[1]), expr(e[2][1][0])]
  when :assign then PASet[expr(e[1][1]), expr(e[1][2][1][0]), expr(e[2])]
  when :@int then PImm[e[1].to_i]
  when :paren
    PSequence[statements(e[1][0..-2]), expr(e[1][-1])]
  when :ifop
    PIfThenElse[expr(e[1]), expr(e[2]), expr(e[3])]
  when :method_add_arg
    case e[1][1][1]
    when "inc", "dec"
      r = e[2][1][1][0][1][1]
      PSequence[
        [PAssign[r, PBinary[e[1][1][1] == "inc" ? :+ : :-, PRead[r], PImm[1]]]],
        PRead[r]
      ]
    else
      pp e
      raise e[1][1][1]
    end
  when Array then expr(e[0])
  else
    pp e
    raise
  end
end

def statement(e)
  case e[0]
  when :assign then PAssign[e[1][1][1], expr(e[2])]
  when :method_add_block
    if e[1][1][1][1] == "loop"
      PLoop[expr(e[1][2][1][1]), statements(e[2][2])]
    else
      pp e
      raise
    end
  when :command
    case e[1][1]
    when "call" then Subroutines[e[2][1][0][1][1]]
    when "exit" then PExit[expr(e[2][1][0])]
    when "out"  then POut[expr(e[2][1][0])]
    when "test" then PTest[expr(e[2][1][0])]
    else
      pp e
      exit
    end
  when :void_stmt then PNop[]
  else
    pp e
    raise e[0].to_s
  end
end

def statements(s)
  s.map {|e| statement(e) }
end

def program(e)
  e[1].each do |e|
    Subroutines[e[1][1][1][1]] = statements(e[2][2])
  end
end

if ARGV.size != 2
  puts "usage: #$0 <src.rb> <ast.txt>"
else
  program(Ripper.sexp(File.read(ARGV[0])))
  File.write(ARGV[1], Subroutines["main"].pretty_inspect)
end
