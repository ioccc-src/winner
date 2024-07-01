Xmax = 13
Ymax = 21

glyphs = {}

points = []
open("glyphs.txt") do |f|
  while ch = f.gets
    ch = ch.to_i
    glyphs[ch] = []
    while pnt = f.gets
      break if pnt.chomp == ""
      x, y, c = pnt.split(",").map {|s| s.to_i }
      points << (y * Xmax + x)
      glyphs[ch] << [y * Xmax + x, c == 1]
    end
  end
end
points = points.sort.uniq
glyphs.each do |ch, pnts|
  pnts.map! do |pnt, c|
    points.index(pnt) * 2 + (c ? 1 : 0) + 36
  end
end
pointtable = points.each_cons(2).map {|a, b| b-a+34 }.pack("C*")
s = []
glyphs.values.each do |points|
  s += points
  s << 33
end
s.pop
glyphs = s.pack("C*")

src = File.read("code.c")
src = src.gsub(/\/\/.*/, "")
src = src.lines.map {|n| n.strip }.join
src = src.gsub("POINTTABLE") { pointtable }
src = src.gsub("POINTSTART") { points.first }
src = src.gsub("GLYPHS") { glyphs }
src = src.gsub("XMAX") { Xmax }
src = File.read("tmpl.txt").gsub(/[#!]/) { src.slice!(0, 1) }
File.write("prog.c", src)
