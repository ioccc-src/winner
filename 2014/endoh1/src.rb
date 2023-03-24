# magical calculation methods!

# calculate the total code words for the version given
total_codewords {
  n = Version / 7 * 5 + 5
  TotalCodes =
    Size_1 * Size_1 / 8 - 24 -
    (Version > 6 ? n * n / 8 + n : (Version > 1) * 4)
}

# calculate the error correction code words for the version given
error_correction_codewords {
  ECCodes = TotalCodes * 54 / 265 - Zero[39999 + Version] + 43
}

# calculate the degree of the generator polynomial
generator_polynomial_degree {
  Degree =
    Version < 6 ? ECCodes :
    Version == 10 ? 18:
    (n = 16
     loop(ECCodes / 2 % dec(n)) {  }
     n * 2)
}

other_constants {
  N = ECCodes / Degree
  M = N - TotalCodes % N
  K = (TotalCodes - ECCodes) / N + 1
  S = Degree + K
  D = K * N - M
}


# GF(2^8)
gen_table {
  i = 511
  j = 1
  loop(i) {
    j = ((Forward[Backward[j] = dec(i)] = j) ^ (285 * (j % 2))) / 2
  }
}

# calculate the generator polynomial
setup_generator_polynomial {
  i = Degree + 1
  loop(dec(i)) {
    j = Degree + 1
    x = 0
    loop(j > i) {
      y = Coefs[dec(j)]
      dummy = Coefs[j] = Backward[x ^ Forward[Degree - i + y]]
      x = Forward[y]
    }
  }
}

# paint fixed cells
setup_fixed_patterns {
  # three big markers
  i = Size
  loop(i) {
    i = i - 1
    j = Size
    loop(j) {
      k = i - j * Size
      dummy =
      Zero[j * Size + i] =
      Zero[minus1 - k] =
      Zero[Size * Size + k] =
        (i < 7 && dec(j) < 7 && (((i - 6) * i + 19 + (j - 6) * j) / 5) ^ 2 < 3) -
        ((i > 7) + (j > 7) > 0)
    }
  }

  # alignment markers
  x = Version / 7 + 2
  n = Version - 32 ? (Version + x / 2) * 2 / (x - 1) * 2 : 26
  i = x * x
  loop(Version > 1 && dec(i) > 1) {
    j = 25
    loop(i - x && j) {
      y = Size_1 - 8 + n
      dummy = Zero[
        ((y - i / x * n) % (y - 4) + j / 5) * Size +
        ((y - i % x * n) % (y - 4) + j % 5)
      ] = (33084991 >> dec(j)) % 2
    }
  }

  # BCH for version info
  n = Version * 4096
  k = n
  j = 64
  loop(j) {
    k = k ^ ((7973 * j) * (k + 1 > 4096 * j))
    j = j / 2
  }
  # (n + k) is the code

  # version info and timing
  i = 18 * (Version > 6)
  loop(i + Size - 16) {
    dummy =
    Zero[x * Size + y] =
    Zero[y * Size + x] =
      dec(i) < 0 ?
        (x = Size -  8 + i    ; y = 6    ; (0 - i) % 2) :
        (x = Size - 11 + i % 3; y = i / 3; ((n + k) >> i) % 2)
  }

  # format info
  i = 15
  loop(i) {
    # BCH for format info (4 + 8) (mask = 4, error correction level = L)
    # 26159 is the code
    n = dec(i) > 7 ? Size_1 - 14 + i : i + (i > 5)
    dummy =
    Zero[Size * (Size - 8) + 8] =
    Zero[n * Size + 8] =
    Zero[9 * Size_1 - n + 8 + (i / 3 == 2)] =
      (26159 >> i) % 2
  }
}

# data encoding
setup_data {
  n = minus1
  buff = 64
  z = 17
  j = 0
  loop(inc(n) < D) {
    x = Input[j]
    _ = x ?
      (y = V9 < 0 ? (j = j + 1; x) : (V9 = V9 - 1; V9 ? InputLen % 256 : (InputLen >> 8))
       emit = buff + y / 16
       buff = (y % 16) * 16
       nop) :
      (emit = buff
       z = z ^ 253
       buff = z
       nop)
    dummy = EncodedData[n] = emit
  }
}

# error correction
encode {
  x = D
  i = N
  loop(i) {
    y = D + S * i
    n = K - (dec(i) < M)
    j = n + Degree
    loop(j) {
      dummy = EncodedData[dec(y)] = dec(j) < n ? EncodedData[dec(x)] : 0
    }
    loop(j < n * Degree) {
      t = j % Degree + 1
      idx = EncodedData + y + j / Degree
      dummy = idx[t] = idx[t] ^ ((idx[0] > 0) * Forward[Coefs[t] + Backward[idx[0]]])
      j = j + 1
    }
  }
}

# make the pattern by placing the data
place {
  x = Size_1
  y = Size_1
  j = minus1
  loop(inc(j) < S) {
    i = M * (j == K - 1)
    loop(i < N) {
      t = 8
      loop(t) {
        xx = x + (x > 5)
        _ = Zero[y * Size + xx] < 0 ?
          (dummy = Zero[y * Size + xx] =
            ((EncodedData[j + (j < K ? i * K - (i < M ? i : M) : D + i * S)] >> dec(t)) ^
             (y / 2 + xx / 3)) % 2 == 0;
           nop) : nop
        x = x -
          (x % 2 ? 1 :
          (x / 2 % 2 ?
           (y          ? (y = y - 1; minus1) : 1) :
           (y - Size_1 ? (y = y + 1; minus1) : 1)))
      }
      i = i + 1
    }
  }
}

# print the pattern to stdout
output {
  k = Size + 4
  y = Size_1 - k
  loop(inc(y) < k) {
    x = Size_1 - k
    loop(inc(x) < k) {
      out 27; out 91; out 52
      out 55 - 
        (x > minus1 && x < Size && y > minus1 && y < Size) *
        (x + y * Size < 0 ? 0 : (Zero[x + y * Size] > 0)) * 7
      out 109; out 32; out 32
    }
    out 27; out 91; out 48; out 109; out 10
  }
}

# generate the code itself by decompression
decompress {
  i = 97531 # a placeholder value that will be replaced by assemble.rb
  InputLen = minus1
  # decompress
  loop((b = Zero[inc(i)]; b)) {
   _ = b < 92 ?
    (loop(dec(b) > 33) {
       x = Zero[inc(i)]
       _ = x - 81 ? nop :
          (k = 39900 # quine
           x = Input[inc(InputLen)] = 34
           loop((z = Zero[inc(k)]; z)) {
             dummy = Input[inc(InputLen)] = z
           }
           nop
          )
       dummy = Input[inc(InputLen)] = x
     }
     nop) :
    (i = i + 1
     loop(dec(b) > 91) {
       dummy = Input[InputLen] = Input[inc(InputLen) - i[0] + 36]
     }
     nop)
  }
  InputLen = InputLen + 1
  dummy = 17[Input] = 10 # newline after "#include<stdio.h>"
}

main {
  # memory layout
  #     0...31329: Pattern data
  # 32000...32512: Forward translation of GF(2^8)
  # 32512...32768: Backward translation of GF(2^8)
  # 32800...33000: Coefficients of generator polynomial
  # 33000...37000: EncodedData
  # 40000...     : Code + nul + Input
  Forward = 32000
  Backward = 32512
  Coefs = 32800
  EncodedData = 33000
  Input = 50000 # a placeholder

  loop(Input[InputLen]) { InputLen = InputLen + 1 }
  _ = InputLen ? nop : (call decompress; nop)

  Version = 0
  loop(Version < 40) {
    Size_1 = 4 * inc(Version) + 16
    Size = Size_1 + 1
    call total_codewords
    call error_correction_codewords
    call generator_polynomial_degree
    call other_constants
    V9 = Version > 9
    _ = D - 1 - V9 > InputLen ? (
	    call gen_table
	    call setup_generator_polynomial
	    call setup_fixed_patterns
	    call setup_data
	    call encode
	    call place
      call output
      exit 0
      nop
    ) : nop
  }
  exit 1
}
