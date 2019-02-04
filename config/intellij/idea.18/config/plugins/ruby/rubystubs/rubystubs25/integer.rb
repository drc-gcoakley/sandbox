=begin
 This is a machine generated stub using stdlib-doc for <b>class Integer</b>
 Sources used:  Ruby 2.5.0-preview1
 Created by IntelliJ Ruby Stubs Generator.
=end

# Holds Integer values.  You cannot add a singleton method to an
# Integer object, any attempt to do so will raise a TypeError.
class Integer < Numeric
    # The version of loaded GMP.   
    GMP_VERSION = nil #value is unknown, used for indexing.
    # big.coerce(numeric)  ->  array
    # 
    # Returns an array with both a +numeric+ and a +big+ represented as Bignum
    # objects.
    # 
    # This is achieved by converting +numeric+ to a Bignum.
    # 
    # A TypeError is raised if the +numeric+ is not a Fixnum or Bignum type.
    # 
    #     (0x3FFFFFFFFFFFFFFF+1).coerce(42)   #=> [42, 4611686018427387904]
    def coerce(numeric)
        #This is a stub, used for indexing
    end
    # Integer.sqrt(n)  ->  integer
    # 
    # Returns the integer square root of the non-negative integer +n+,
    # i.e. the largest non-negative integer less than or equal to the
    # square root of +n+.
    # 
    #   Integer.sqrt(0)        #=> 0
    #   Integer.sqrt(1)        #=> 1
    #   Integer.sqrt(24)       #=> 4
    #   Integer.sqrt(25)       #=> 5
    #   Integer.sqrt(10**400)  #=> 10**200
    # 
    # Equivalent to <code>Math.sqrt(n).floor</code>, except that
    # the result of the latter code may differ from the true value
    # due to the limited precision of floating point arithmetic.
    # 
    #   Integer.sqrt(10**46)     #=> 100000000000000000000000
    #   Math.sqrt(10**46).floor  #=>  99999999999999991611392 (!)
    # 
    # If +n+ is not an Integer, it is converted to an Integer first.
    # If +n+ is negative, a Math::DomainError is raised.
    def self.sqrt(n)
        #This is a stub, used for indexing
    end
    # int.to_s(base=10)  ->  string
    # 
    # Returns a string containing the place-value representation of +int+
    # with radix +base+ (between 2 and 36).
    # 
    #    12345.to_s       #=> "12345"
    #    12345.to_s(2)    #=> "11000000111001"
    #    12345.to_s(8)    #=> "30071"
    #    12345.to_s(10)   #=> "12345"
    #    12345.to_s(16)   #=> "3039"
    #    12345.to_s(36)   #=> "9ix"
    #    78546939656932.to_s(36)  #=> "rubyrules"
    def to_s(base=10)
        #This is a stub, used for indexing
    end
    alias inspect to_s
    # int.integer?  ->  true
    # 
    # Since +int+ is already an Integer, this always returns +true+.
    def integer?()
        #This is a stub, used for indexing
    end
    # int.odd?  ->  true or false
    # 
    # Returns +true+ if +int+ is an odd number.
    def odd?()
        #This is a stub, used for indexing
    end
    # int.even?  ->  true or false
    # 
    # Returns +true+ if +int+ is an even number.
    def even?()
        #This is a stub, used for indexing
    end
    # int.upto(limit) {|i| block }  ->  self
    # int.upto(limit)               ->  an_enumerator
    # 
    # Iterates the given block, passing in integer values from +int+ up to and
    # including +limit+.
    # 
    # If no block is given, an Enumerator is returned instead.
    # 
    #    5.upto(10) {|i| print i, " " }   #=> 5 6 7 8 9 10
    def upto(*several_variants)
        #This is a stub, used for indexing
    end
    # int.downto(limit) {|i| block }  ->  self
    # int.downto(limit)               ->  an_enumerator
    # 
    # Iterates the given block, passing in decreasing values from +int+ down to
    # and including +limit+.
    # 
    # If no block is given, an Enumerator is returned instead.
    # 
    #    5.downto(1) { |n| print n, ".. " }
    #    puts "Liftoff!"
    #    #=> "5.. 4.. 3.. 2.. 1.. Liftoff!"
    def downto(*several_variants)
        #This is a stub, used for indexing
    end
    # int.times {|i| block }  ->  self
    # int.times               ->  an_enumerator
    # 
    # Iterates the given block +int+ times, passing in values from zero to
    # <code>int - 1</code>.
    # 
    # If no block is given, an Enumerator is returned instead.
    # 
    #    5.times {|i| print i, " " }   #=> 0 1 2 3 4
    def times(*several_variants)
        #This is a stub, used for indexing
    end
    # int.succ  ->  integer
    # 
    # Returns the successor of +int+,
    # i.e. the Integer equal to <code>int+1</code>.
    # 
    #    1.next      #=> 2
    #    (-1).next   #=> 0
    #    1.succ      #=> 2
    #    (-1).succ   #=> 0
    def succ()
        #This is a stub, used for indexing
    end
    # int.next  ->  integer
    # 
    # Returns the successor of +int+,
    # i.e. the Integer equal to <code>int+1</code>.
    # 
    #    1.next      #=> 2
    #    (-1).next   #=> 0
    #    1.succ      #=> 2
    #    (-1).succ   #=> 0
    def next()
        #This is a stub, used for indexing
    end
    # int.pred  ->  integer
    # 
    # Returns the predecessor of +int+,
    # i.e. the Integer equal to <code>int-1</code>.
    # 
    #    1.pred      #=> 0
    #    (-1).pred   #=> -2
    def pred()
        #This is a stub, used for indexing
    end
    # int.chr([encoding])  ->  string
    # 
    # Returns a string containing the character represented by the +int+'s value
    # according to +encoding+.
    # 
    #    65.chr    #=> "A"
    #    230.chr   #=> "\xE6"
    #    255.chr(Encoding::UTF_8)   #=> "\u00FF"
    def chr(*encoding)
        #This is a stub, used for indexing
    end
    # int.ord  ->  self
    # 
    # Returns the +int+ itself.
    # 
    #    97.ord   #=> 97
    # 
    # This method is intended for compatibility to character literals
    # in Ruby 1.9.
    # 
    # For example, <code>?a.ord</code> returns 97 both in 1.8 and 1.9.
    def ord()
        #This is a stub, used for indexing
    end
    # int.to_i    ->  integer
    # int.to_int  ->  integer
    # 
    # Since +int+ is already an Integer, returns +self+.
    # 
    # #to_int is an alias for #to_i.
    def to_i(*several_variants)
        #This is a stub, used for indexing
    end
    # int.to_int  ->  integer
    # 
    # Since +int+ is already an Integer, returns +self+.
    # 
    # #to_int is an alias for #to_i.
    def to_int()
        #This is a stub, used for indexing
    end
    # int.to_f  ->  float
    # 
    # Converts +int+ to a Float.  If +int+ doesn't fit in a Float,
    # the result is infinity.
    def to_f()
        #This is a stub, used for indexing
    end
    # int.floor([ndigits])  ->  integer or float
    # 
    # Returns the largest number less than or equal to +int+ with
    # a precision of +ndigits+ decimal digits (default: 0).
    # 
    # When the precision is negative, the returned value is an integer
    # with at least <code>ndigits.abs</code> trailing zeros.
    # 
    # Returns +self+ when +ndigits+ is zero or positive.
    # 
    #    1.floor           #=> 1
    #    1.floor(2)        #=> 1
    #    18.floor(-1)      #=> 10
    #    (-18).floor(-1)   #=> -20
    def floor(*ndigits)
        #This is a stub, used for indexing
    end
    # int.ceil([ndigits])  ->  integer or float
    # 
    # Returns the smallest number greater than or equal to +int+ with
    # a precision of +ndigits+ decimal digits (default: 0).
    # 
    # When the precision is negative, the returned value is an integer
    # with at least <code>ndigits.abs</code> trailing zeros.
    # 
    # Returns +self+ when +ndigits+ is zero or positive.
    # 
    #    1.ceil           #=> 1
    #    1.ceil(2)        #=> 1
    #    18.ceil(-1)      #=> 20
    #    (-18).ceil(-1)   #=> -10
    def ceil(*ndigits)
        #This is a stub, used for indexing
    end
    # int.truncate([ndigits])  ->  integer or float
    # 
    # Returns +int+ truncated (toward zero) to
    # a precision of +ndigits+ decimal digits (default: 0).
    # 
    # When the precision is negative, the returned value is an integer
    # with at least <code>ndigits.abs</code> trailing zeros.
    # 
    # Returns +self+ when +ndigits+ is zero or positive.
    # 
    #    1.truncate           #=> 1
    #    1.truncate(2)        #=> 1
    #    18.truncate(-1)      #=> 10
    #    (-18).truncate(-1)   #=> -10
    def truncate(*ndigits)
        #This is a stub, used for indexing
    end
    # int.round([ndigits] [, half: mode])  ->  integer or float
    # 
    # Returns +int+ rounded to the nearest value with
    # a precision of +ndigits+ decimal digits (default: 0).
    # 
    # When the precision is negative, the returned value is an integer
    # with at least <code>ndigits.abs</code> trailing zeros.
    # 
    # Returns +self+ when +ndigits+ is zero or positive.
    # 
    #    1.round           #=> 1
    #    1.round(2)        #=> 1
    #    15.round(-1)      #=> 20
    #    (-15).round(-1)   #=> -20
    # 
    # The optional +half+ keyword argument is available
    # similar to Float#round.
    # 
    #    25.round(-1, half: :up)      #=> 30
    #    25.round(-1, half: :down)    #=> 20
    #    25.round(-1, half: :even)    #=> 20
    #    35.round(-1, half: :up)      #=> 40
    #    35.round(-1, half: :down)    #=> 30
    #    35.round(-1, half: :even)    #=> 40
    #    (-25).round(-1, half: :up)   #=> -30
    #    (-25).round(-1, half: :down) #=> -20
    #    (-25).round(-1, half: :even) #=> -20
    def round(p1 = v1, p2 = {})
        #This is a stub, used for indexing
    end
    # int <=> numeric  ->  -1, 0, +1, or nil
    # 
    # Comparison---Returns -1, 0, or +1 depending on whether +int+ is
    # less than, equal to, or greater than +numeric+.
    # 
    # This is the basis for the tests in the Comparable module.
    # 
    # +nil+ is returned if the two values are incomparable.
    def <=> numeric
        #This is a stub, used for indexing
    end
    # -int  ->  integer
    # 
    # Returns +int+, negated.
    def -@ int
        #This is a stub, used for indexing
    end
    # int + numeric  ->  numeric_result
    # 
    # Performs addition: the class of the resulting object depends on
    # the class of +numeric+.
    def + numeric
        #This is a stub, used for indexing
    end
    # int - numeric  ->  numeric_result
    # 
    # Performs subtraction: the class of the resulting object depends on
    # the class of +numeric+.
    def - numeric
        #This is a stub, used for indexing
    end
    # int * numeric  ->  numeric_result
    # 
    # Performs multiplication: the class of the resulting object depends on
    # the class of +numeric+.
    def * numeric
        #This is a stub, used for indexing
    end
    # int / numeric  ->  numeric_result
    # 
    # Performs division: the class of the resulting object depends on
    # the class of +numeric+.
    def / numeric
        #This is a stub, used for indexing
    end
    # int.div(numeric)  ->  integer
    # 
    # Performs integer division: returns the integer result of dividing +int+
    # by +numeric+.
    def div(numeric)
        #This is a stub, used for indexing
    end
    # int % other        ->  real
    # 
    # Returns +int+ modulo +other+.
    # 
    # See Numeric#divmod for more information.
    def % other
        #This is a stub, used for indexing
    end
    # int.modulo(other)  ->  real
    # 
    # Returns +int+ modulo +other+.
    # 
    # See Numeric#divmod for more information.
    def modulo(other)
        #This is a stub, used for indexing
    end
    # int.remainder(numeric)  ->  real
    # 
    # Returns the remainder after dividing +int+ by +numeric+.
    # 
    # <code>x.remainder(y)</code> means <code>x-y*(x/y).truncate</code>.
    # 
    #    5.remainder(3)     #=> 2
    #    -5.remainder(3)    #=> -2
    #    5.remainder(-3)    #=> 2
    #    -5.remainder(-3)   #=> -2
    #    5.remainder(1.5)   #=> 0.5
    # 
    # See Numeric#divmod.
    def remainder(numeric)
        #This is a stub, used for indexing
    end
    # int.divmod(numeric)  ->  array
    # 
    # See Numeric#divmod.
    def divmod(numeric)
        #This is a stub, used for indexing
    end
    # int.fdiv(numeric)  ->  float
    # 
    # Returns the floating point result of dividing +int+ by +numeric+.
    # 
    #    654321.fdiv(13731)      #=> 47.652829364212366
    #    654321.fdiv(13731.24)   #=> 47.65199646936475
    #    -654321.fdiv(13731)     #=> -47.652829364212366
    def fdiv(numeric)
        #This is a stub, used for indexing
    end
    # int ** numeric  ->  numeric_result
    # 
    # Raises +int+ to the power of +numeric+, which may be negative or
    # fractional.
    # The result may be an Integer, a Float, a Rational, or a complex number.
    # 
    #    2 ** 3        #=> 8
    #    2 ** -1       #=> (1/2)
    #    2 ** 0.5      #=> 1.4142135623730951
    #    (-1) ** 0.5   #=> (0.0+1.0i)
    # 
    #    123456789 ** 2     #=> 15241578750190521
    #    123456789 ** 1.2   #=> 5126464716.0993185
    #    123456789 ** -2    #=> (1/15241578750190521)
    def ** numeric
        #This is a stub, used for indexing
    end
    # int.abs        ->  integer
    # 
    # Returns the absolute value of +int+.
    # 
    #    (-12345).abs   #=> 12345
    #    -12345.abs     #=> 12345
    #    12345.abs      #=> 12345
    # 
    # Integer#magnitude is an alias for Integer#abs.
    def abs()
        #This is a stub, used for indexing
    end
    # int.magnitude  ->  integer
    # 
    # Returns the absolute value of +int+.
    # 
    #    (-12345).abs   #=> 12345
    #    -12345.abs     #=> 12345
    #    12345.abs      #=> 12345
    # 
    # Integer#magnitude is an alias for Integer#abs.
    def magnitude()
        #This is a stub, used for indexing
    end
    # int == other  ->  true or false
    # 
    # Returns +true+ if +int+ equals +other+ numerically.
    # Contrast this with Integer#eql?, which requires +other+ to be an Integer.
    # 
    #    1 == 2     #=> false
    #    1 == 1.0   #=> true
    def ===(p1)
        #This is a stub, used for indexing
    end
    # int == other  ->  true or false
    # 
    # Returns +true+ if +int+ equals +other+ numerically.
    # Contrast this with Integer#eql?, which requires +other+ to be an Integer.
    # 
    #    1 == 2     #=> false
    #    1 == 1.0   #=> true
    def == other
        #This is a stub, used for indexing
    end
    # int > real  ->  true or false
    # 
    # Returns +true+ if the value of +int+ is greater than that of +real+.
    def > real
        #This is a stub, used for indexing
    end
    # int >= real  ->  true or false
    # 
    # Returns +true+ if the value of +int+ is greater than or equal to that of
    # +real+.
    def >= real
        #This is a stub, used for indexing
    end
    # int < real  ->  true or false
    # 
    # Returns +true+ if the value of +int+ is less than that of +real+.
    def < real
        #This is a stub, used for indexing
    end
    # int <= real  ->  true or false
    # 
    # Returns +true+ if the value of +int+ is less than or equal to that of
    # +real+.
    def <= real
        #This is a stub, used for indexing
    end
    # ~int  ->  integer
    # 
    # One's complement: returns a number where each bit is flipped.
    # 
    # Inverts the bits in an Integer. As integers are conceptually of
    # infinite length, the result acts as if it had an infinite number of
    # one bits to the left. In hex representations, this is displayed
    # as two periods to the left of the digits.
    # 
    #   sprintf("%X", ~0x1122334455)    #=> "..FEEDDCCBBAA"
    def ~ int
        #This is a stub, used for indexing
    end
    # int & other_int  ->  integer
    # 
    # Bitwise AND.
    def & other_int
        #This is a stub, used for indexing
    end
    # int | other_int  ->  integer
    # 
    # Bitwise OR.
    def | other_int
        #This is a stub, used for indexing
    end
    # int ^ other_int  ->  integer
    # 
    # Bitwise EXCLUSIVE OR.
    def ^ other_int
        #This is a stub, used for indexing
    end
    # int[n]  ->  0, 1
    # 
    # Bit Reference---Returns the <code>n</code>th bit in the
    # binary representation of +int+, where <code>int[0]</code>
    # is the least significant bit.
    # 
    #    a = 0b11001100101010
    #    30.downto(0) {|n| print a[n] }
    #    #=> 0000000000000000011001100101010
    # 
    #    a = 9**15
    #    50.downto(0) {|n| print a[n] }
    #    #=> 000101110110100000111000011110010100111100010111001
    def [] n
        #This is a stub, used for indexing
    end
    # int << count  ->  integer
    # 
    # Returns +int+ shifted left +count+ positions, or right if +count+
    # is negative.
    def << count
        #This is a stub, used for indexing
    end
    # int >> count  ->  integer
    # 
    # Returns +int+ shifted right +count+ positions, or left if +count+
    # is negative.
    def >> count
        #This is a stub, used for indexing
    end
    # int.size  ->  int
    # 
    # Returns the number of bytes in the machine representation of +int+
    # (machine dependent).
    # 
    #    1.size               #=> 8
    #    -1.size              #=> 8
    #    2147483647.size      #=> 8
    #    (256**10 - 1).size   #=> 10
    #    (256**20 - 1).size   #=> 20
    #    (256**40 - 1).size   #=> 40
    def size()
        #This is a stub, used for indexing
    end
    # int.bit_length  ->  integer
    # 
    # Returns the number of bits of the value of +int+.
    # 
    # "Number of bits" means the bit position of the highest bit
    # which is different from the sign bit
    # (where the least significant bit has bit position 1).
    # If there is no such bit (zero or minus one), zero is returned.
    # 
    # I.e. this method returns <i>ceil(log2(int < 0 ? -int : int+1))</i>.
    # 
    #    (-2**1000-1).bit_length   #=> 1001
    #    (-2**1000).bit_length     #=> 1000
    #    (-2**1000+1).bit_length   #=> 1000
    #    (-2**12-1).bit_length     #=> 13
    #    (-2**12).bit_length       #=> 12
    #    (-2**12+1).bit_length     #=> 12
    #    -0x101.bit_length         #=> 9
    #    -0x100.bit_length         #=> 8
    #    -0xff.bit_length          #=> 8
    #    -2.bit_length             #=> 1
    #    -1.bit_length             #=> 0
    #    0.bit_length              #=> 0
    #    1.bit_length              #=> 1
    #    0xff.bit_length           #=> 8
    #    0x100.bit_length          #=> 9
    #    (2**12-1).bit_length      #=> 12
    #    (2**12).bit_length        #=> 13
    #    (2**12+1).bit_length      #=> 13
    #    (2**1000-1).bit_length    #=> 1000
    #    (2**1000).bit_length      #=> 1001
    #    (2**1000+1).bit_length    #=> 1001
    # 
    # This method can be used to detect overflow in Array#pack as follows:
    # 
    #    if n.bit_length < 32
    #      [n].pack("l") # no overflow
    #    else
    #      raise "overflow"
    #    end
    def bit_length()
        #This is a stub, used for indexing
    end
    # int.digits        ->  array
    # int.digits(base)  ->  array
    # 
    # Returns the digits of +int+'s place-value representation
    # with radix +base+ (default: 10).
    # The digits are returned as an array with the least significant digit
    # as the first array element.
    # 
    # +base+ must be greater than or equal to 2.
    # 
    #    12345.digits      #=> [5, 4, 3, 2, 1]
    #    12345.digits(7)   #=> [4, 6, 6, 0, 5]
    #    12345.digits(100) #=> [45, 23, 1]
    # 
    #    -12345.digits(7)  #=> Math::DomainError
    def digits(*several_variants)
        #This is a stub, used for indexing
    end
    def inspect(*args)
        #This is a stub, used for indexing
    end
    # int.gcd(other_int)  ->  integer
    # 
    # Returns the greatest common divisor of the two integers.
    # The result is always positive. 0.gcd(x) and x.gcd(0) return x.abs.
    # 
    #    36.gcd(60)                  #=> 12
    #    2.gcd(2)                    #=> 2
    #    3.gcd(-7)                   #=> 1
    #    ((1<<31)-1).gcd((1<<61)-1)  #=> 1
    def gcd(other_int)
        #This is a stub, used for indexing
    end
    # int.lcm(other_int)  ->  integer
    # 
    # Returns the least common multiple of the two integers.
    # The result is always positive. 0.lcm(x) and x.lcm(0) return zero.
    # 
    #    36.lcm(60)                  #=> 180
    #    2.lcm(2)                    #=> 2
    #    3.lcm(-7)                   #=> 21
    #    ((1<<31)-1).lcm((1<<61)-1)  #=> 4951760154835678088235319297
    def lcm(other_int)
        #This is a stub, used for indexing
    end
    # int.gcdlcm(other_int)  ->  array
    # 
    # Returns an array with the greatest common divisor and
    # the least common multiple of the two integers, [gcd, lcm].
    # 
    #    36.gcdlcm(60)                  #=> [12, 180]
    #    2.gcdlcm(2)                    #=> [2, 2]
    #    3.gcdlcm(-7)                   #=> [1, 21]
    #    ((1<<31)-1).gcdlcm((1<<61)-1)  #=> [1, 4951760154835678088235319297]
    def gcdlcm(other_int)
        #This is a stub, used for indexing
    end
    # int.numerator  ->  self
    # 
    # Returns self.
    def numerator()
        #This is a stub, used for indexing
    end
    # int.denominator  ->  1
    # 
    # Returns 1.
    def denominator()
        #This is a stub, used for indexing
    end
    # int.to_r  ->  rational
    # 
    # Returns the value as a rational.
    # 
    #    1.to_r        #=> (1/1)
    #    (1<<64).to_r  #=> (18446744073709551616/1)
    def to_r()
        #This is a stub, used for indexing
    end
    # int.rationalize([eps])  ->  rational
    # 
    # Returns the value as a rational.  The optional argument +eps+ is
    # always ignored.
    def rationalize(*eps)
        #This is a stub, used for indexing
    end
end
