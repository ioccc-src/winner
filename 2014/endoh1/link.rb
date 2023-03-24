require_relative "machine"

Table = "))*+,**,*)-)/),0).0(6/2+667,(&$###;=@D*0"

def compress(s)
  t = "\0".b * s.size
  a = [nil] * s.size
  n = 0
  30.downto(3) do |len|
    (s.size - 1).downto(0) do |i|
      j = s[0, i + len - 1].rindex(s[i, len])
      if s[i, len].size == len && j && i - j < 90 && t[i, len] == "\0".b * len && !s[j..i].include?(?Q)
          n += 1
          t[i, len] = (i-j).chr * len
          a[i] = [i-j, len]
      end
    end
  end
  n = 0
  s = t.gsub(/(.)\1{,56}/m) do
    offset = $`.size
    len = $&.size
    raise if len > 92 - 34
    if $1 == "\0"
      (len + 34).chr + s[offset, len]
    else
      (len + 92).chr + ($1.ord + 36).chr
    end
  end
end

if ARGV.size != 2
  puts "usage: #$0 <raw.txt> <prog.c>"
else
  Code = File.read(ARGV[0])

  vm_src = File.read("vm.c").lines.drop(1).join.gsub(/^\s*/, "").gsub("\n", "").chomp.gsub(/\s*\/\*.*?\*\//, "")
  quine_data = compress("#include<stdio.h>@" + vm_src.gsub('"CODE"', "Q").gsub('"', """'"))

  # back patch of absolute address
  Code.gsub!(encode_number(39999)) { encode_number((Code                     ).size + 39901 - 1) }
  Code.gsub!(encode_number(97531)) { encode_number((Code + Table             ).size + 39901 - 1) }
  Code.gsub!(encode_number(50000)) { encode_number((Code + Table + quine_data).size + 39901 + 1) }

  File.write(ARGV[1], "#include<stdio.h>\n" + vm_src.sub("CODE") { Code + Table + quine_data } + "\n")
end
