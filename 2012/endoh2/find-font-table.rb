# This script finds table for 3x5 decimal fonts.

fonts = <<END
###  .#.  ###  ###  #.#  ###  ###  ###  ###  ###
#.#  ##.  ..#  ..#  #.#  #..  #..  #.#  #.#  #.#
#.#  .#.  ###  ###  ###  ###  ###  ..#  ###  ###
#.#  .#.  #..  ..#  ..#  ..#  #.#  .#.  #.#  ..#
###  ###  ###  ###  ..#  ###  ###  .#.  ###  ###
END
fonts = fonts.lines.map {|l| l.scan(/\S{3}/) }.transpose
fonts = fonts.join.scan(/.{15}/).map {|l| l.tr(".#", "01").reverse.to_i(2) }


def printable?(x)
  35 <= x && x != 92 && x <= 126
end

# Given integers d, e, and f, finds (x, y) s.t. x*d - y*e = f, where x and y
# are both printable.
def solve_identity(d, e, f)
  # First we solve Bezout's identity by using the extended gcd algorithm.
  # See the wikipedia entry in detail.
  g = d.gcd(e)
  return if f % g != 0  # No solution
  d, e, f = d / g, e / g, f / g
  a, b = d, -e
  x0, x1 = 1, 0
  y0, y1 = 0, 1
  while b != 0
    q = a / b
    a, b = b, a % b
    x0, x1 = x1, x0 - x1 * q
    y0, y1 = y1, y0 - y1 * q
  end

  # Now we have solution candidates.
  #   x = -f * x0 - e * t
  #   y = -f * y0 - d * t
  # where t is a free parameter.
  # Then, we consider another constraint: x and y is both printable.

  # We must satisfy: 35 <= x <= 126
  # ->  ceil((35+f*x0) / e)            <= -t <= floor((126+f*x0) / e)
  # ->  ceil((35+f*x0) / e) * d - f*y0 <=  y <= floor((126+f*x0) / e) * d - f*y0
  ymin = ( 35+f*x0+e+1) / e * d - f*y0
  ymax = (126+f*x0    ) / e * d - f*y0

  return if ymax < ymin || ymax < 33 || ymin > 126  # No solution.

  ((ymax + f*y0) / -d).upto((ymin + f*y0) / -d) do |t|
    x = -f * x0 - e * t
    y = -f * y0 - d * t
    return [x, y] if printable?(x) && printable?(y) # Solution found.
  end

  return # No solution.
end

# Given integers f0, f1, ..., f9, by brute force, finds (u, v, d) s.t. there is
# some xi and yi:
#   x0 * u - y0 * v = f0 + d
#   x1 * u - y1 * v = f1 + d
#   ...
#   x9 * u - y9 * v = f9 + d
# where both xi and yi are printable.
def find_params(fonts)
  1.upto(9) do |d|
    2.times do
      1.upto(999) do |u|
        1.upto(999) do |v|
          if fonts.all? {|f| solve_identity(u, v, f + d) }
            table = fonts.map do |f|
              solve_identity(u, v, f + d).reverse
            end.transpose.flatten.map {|c| c.chr }.join
            return u, v, d, table
          end
        end
      end
      d = -d
    end
  end
  puts "Not found."
  exit
end


puts "Searching..."

u, v, d, s = find_params(fonts)

puts "Found."
puts
puts "Let s = %p." % s
puts "You can get the font data of dicimal character 'n' (0--9):"
puts "  %d * s[n+10] - %d * s[n] - %d" % [u, v, d]
