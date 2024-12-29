tmpl = <<END
111111100010101111111
100000101000001000001
101110100001101011101
101110101100101011101
101110101101001011101
100000100110101000001
111111101010101111111
000000001100100000000
010111101010111011010
100101011011110011100
011101111111000101101
001111011010111110100
111001101000111110101
000000001011111110100
111111100010100110110
100000101011001010011
101110101111111100111
101110101100111111100
101110100101110001111
100000101111100010110
111111100110110110100
END

tmpl = "\n" * 8 +  tmpl.lines.flat_map do |l|
  l = l.chomp.gsub(/./) { $& * 4 } + "\n"
  [l, l]
end.join + "\n" * 8
tmpl.gsub!(/^/, "0" * 4 * 4)
tmpl.gsub!(/0+$/, "")
tmpl.gsub!("1\n") { "\\\n" }
tmpl.tr!("10", "# ")

Code = File.read(ARGV[0]).chomp[/"(.*)"/, 1].tr(" ", "Y")

code = File.read("prog-tmpl.c")
code.gsub!('"CODE"') { "\"\\\"" + Code + '"' }
code.gsub!('INDX', (Code.index("#include") - 1 + 1).to_s)
code.gsub!(/^\s+/, "")
code.gsub!("\n", "")

#ode = "#include<stdio.h>/*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*/" + code
code = "#include<stdio.h>/*IOCCC201420142014IOCCC2014IOCCC2014IOCCC201*/" + code

tmpl[(tmpl =~ /(\\)$/m)] = "#"

count = 0
code = tmpl.gsub(/./) do
  if $& == ?# || ($& != " " && count == 3)
    c = code.slice!(0, 1)
    count += 1 if c == ?"
    c
  else
    $&
  end
end

File.write(ARGV[1], code)
