require "zlib"

lines = [*$<]

if lines.join.gsub(/\e\[\d*m/, "").chars.uniq.sort == ["\n", " "]

  matrix = lines.map do |line|
    row = []
    cell = nil
    line.chomp.scan(/\G(?:\e\[(\d+)m|..)/) do
      if $1
        cell = $1 == "40" ? :black : :white
      else
        row << cell
      end
    end
    row
  end

  size = matrix.size
  if size != matrix.first.size
    raise "not square: #{ matrix.first.size } x #{ matrix.size }"
  end
  $stderr.puts "Version: #{ (size - 25) / 4 }"

  scale = 400 / size
  data = (0 ... scale * size).flat_map do |y|
    [0] + (0 ... scale * size).flat_map do |x|
      matrix[y / scale][x / scale] == :black ? [0, 0, 0] : [255, 255, 255]
    end
  end

  print "\x89PNG\r\n\x1a\n"
  [
    ["IHDR", [scale * size, scale * size, 8, 2, 0, 0, 0].pack("NNCCCCC")],
    ["IDAT", Zlib::Deflate.deflate(data.pack("C*"))],
    ["IEND", ""],
  ].each do |type, data|
    print [data.bytesize, type, data, Zlib.crc32(type + data)].pack("NA4A*N")
  end

else

  width = lines.map {|line| line.chomp.size + 4 * 4 }.max
  lines.each do |line|
    puts line.chomp.ljust(width).gsub(/../) { "\e[#{ $& == "  " ? 47 : 40 }m  " }
  end

end
