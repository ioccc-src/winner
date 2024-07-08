#
# LUHN.rb
#
# Copyright 2000, 2004 by Anthony Howe.  All rights reserved.
#

class LUHN
	def LUHN.base(str, radix)
		if radix < 2 then
			return nil
		end

		num = 0
		str.downcase!
		str.each_byte do |byte|
			i = "0123456789abcdefghijklmnopqrstuvwxyz".index(byte)
			if i.nil? || radix <= i then
				return nil
			end
			num = num * radix + i
		end

		return num
	end

	#
	# Internal routine that computes the LUHN sum.
	#
	# The LUHN Algorithm ("mod 10 Double-Add-Double"):
	#
	# 1.   Position from right           8   7   6   5   4   3   2   1
	#                                   ------------------------------
	#      Number string                 4   8   9   5   1   3   1   3
	#      x2 even positions             2   1   2   1   2   1   2   1
	#                                   ------------------------------
	#      Add odd positions &           8  +8 +1+8 +5  +2  +3  +2  +3
	#      add digits of doubled
	#      positions
	#
	#      Sum                          40
	#
	#      Number is valid if sum is a multiple of 10.
	#
	#
	# 2.   Alpha-numeric ISIN        U     S  3  8  3  8  8  3  1  0  5  1
	#      (ISO 6166)            -----------------------------------------
	#      base 36 digits           30    28  3  8  3  8  8  3  1  0  5  1
	#                            -----------------------------------------
	#      consider digit string  3  0  2  8  3  8  3  8  8  3  1  0  5  1
	#      & x2 even digits from  2  1  2  1  2  1  2  1  2  1  2  1  2  1
	#                            -----------------------------------------
	#                             6  0  4  8  6  8  6  8 16  3  2  0 10  1
	#                            -----------------------------------------
	#      sum the digits of      6 +0 +4 +8 +6 +8 +6 +8+1+6+3 +2 +0+1+0+1
	#
	#      Sum                   60
	#
	#      Number is valid if sum is a multiple of 10.
	#
	def LUHN.sum(str)
		if ! str.instance_of?(String) || str.length < 1 then
			return nil
		end

		total = 0
		even = false
		str = str.reverse.downcase

		# Working right to left...		
		str.each_byte do |byte|
			# Convert base36 digit to a base10 value.		
			digit36 = base(byte.chr, 36)
			if digit36.nil? then
				return nil
			end
			
			# For each base10 digit of a base36 digit...
			begin
				digit10 = digit36 % 10				
			
				if even then
					# Multiply even digits by 2.
					digit10 <<= 1
					
					# Sum digits of product.
					if 10 <= digit10 then 
						digit10 -= 9
					end
				end
				
				# Add digits of product to total.
				total += digit10

				# Next digit.
				digit36 = (digit36 / 10).floor

				# Toggle from digit to digit.
				even = !even
			end while 0 < digit36
		end

		return total
	end

	#
	# Return true if the string of digits is valid.
	# Assumes LUHN check digit is right most digit.
	#
	def LUHN.valid?(str)
		if ! str.instance_of?(String) || str.length < 2 then
			return false
		end

		total = sum(str)

		return total.nil? ? false : (total % 10) == 0
	end

	#
	# Return the LUHN check digit (mod 10) for the 
	# given string of digits; otherwise nil on error.
	#
	def LUHN.generate(str)
		if ! str.instance_of?(String) || str.length < 1 then
			return nil
		end

		total = sum(str + '0')

		return total.nil? ? nil : (10 - (total % 10)) % 10
	end
end

if $DEBUG && $0 == 'LUHN.rb' then
	def generate(str, expect)
		digit = LUHN.generate(str)
		puts(str + "-" + digit.to_s + ' ' + (digit == expect).to_s)
	end
	def validate(str)
		puts(str + ' ' + LUHN.valid?(str).to_s)
	end
	
	generate('1', 8)
	generate('12', 5)
	generate('123', 0)
	generate('A', 9)
	generate('AB', 6)
	
	validate('AB6')
end
