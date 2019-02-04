=begin
 This is a machine generated stub using stdlib-doc for <b>class Integer</b>
 Sources used:  Ruby 2.4.0-preview1
 Created by IntelliJ Ruby Stubs Generator.
=end

# This class is the basis for the two concrete classes that hold whole
# numbers, Bignum and Fixnum.
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
    # int.to_s(base=10)  ->  string
    # 
    # Returns a string containing the representation of +int+ radix +base+
    # (between 2 and 36).
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
    # For example:
    # 
    #    5.upto(10) { |i| print i, " " }
    #    #=> 5 6 7 8 9 10
    def upto(*several_variants)
        #This is a stub, used for indexing
    end
    # int.downto(limit) {|i| block }  ->  self
    # int.downto(limit)               ->  an_enumerator
    # 
    # Iterates the given block, passing decreasing values from +int+ down to and
    # including +limit+.
    # 
    # If no block is given, an Enumerator is returned instead.
    # 
    #    5.downto(1) { |n| print n, ".. " }
    #    print "  Liftoff!\n"
    #    #=> "5.. 4.. 3.. 2.. 1..   Liftoff!"
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
    #    5.times do |i|
    #      print i, " "
    #    end
    #    #=> 0 1 2 3 4
    def times(*several_variants)
        #This is a stub, used for indexing
    end
    # int.succ  ->  integer
    # 
    # Returns the Integer equal to +int+ + 1.
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
    # Returns the Integer equal to +int+ + 1.
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
    # Returns the Integer equal to +int+ - 1.
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
    #    230.chr   #=> "\346"
    #    255.chr(Encoding::UTF_8)   #=> "\303\277"
    def chr(*encoding)
        #This is a stub, used for indexing
    end
    # int.ord  ->  self
    # 
    # Returns the +int+ itself.
    # 
    #    ?a.ord    #=> 97
    # 
    # This method is intended for compatibility to character constant in Ruby
    # 1.9.
    # 
    # For example, ?a.ord returns 97 both in 1.8 and 1.9.
    def ord()
        #This is a stub, used for indexing
    end
    # int.to_i      ->  integer
    # 
    # As +int+ is already an Integer, all these methods simply return the receiver.
    # 
    # Synonyms is #to_int
    def to_i()
        #This is a stub, used for indexing
    end
    # int.to_i      ->  integer
    # 
    # As +int+ is already an Integer, all these methods simply return the receiver.
    # 
    # Synonyms is #to_int
    def to_int()
        #This is a stub, used for indexing
    end
    # int.to_f  ->  float
    # 
    # Converts +int+ to a +Float+.  If +int+ doesn't fit in a +Float+,
    # the result is infinity.
    def to_f()
        #This is a stub, used for indexing
    end
    # int.floor([ndigits])  ->  integer or float
    # 
    # Returns the largest number less than or equal to +int+ in decimal
    # digits (default 0 digits).
    # 
    # Precision may be negative.  Returns a floating point number when +ndigits+
    # is positive, +self+ for zero, and floor down for negative.
    # 
    #    1.floor        #=> 1
    #    1.floor(2)     #=> 1.0
    #    15.floor(-1)   #=> 10
    def floor(*ndigits)
        #This is a stub, used for indexing
    end
    # int.ceil([ndigits])  ->  integer or float
    # 
    # Returns the smallest number than or equal to +int+ in decimal
    # digits (default 0 digits).
    # 
    # Precision may be negative.  Returns a floating point number when +ndigits+
    # is positive, +self+ for zero, and ceil up for negative.
    # 
    #    1.ceil        #=> 1
    #    1.ceil(2)     #=> 1.0
    #    15.ceil(-1)   #=> 20
    def ceil(*ndigits)
        #This is a stub, used for indexing
    end
    # int.truncate([ndigits])  ->  integer or float
    # 
    # Returns the smallest number than or equal to +int+ in decimal
    # digits (default 0 digits).
    # 
    # Precision may be negative.  Returns a floating point number when +ndigits+
    # is positive, +self+ for zero, and truncate up for negative.
    # 
    #    1.truncate        #=> 1
    #    1.truncate(2)     #=> 1.0
    #    15.truncate(-1)   #=> 10
    def truncate(*ndigits)
        #This is a stub, used for indexing
    end
    # int.round([ndigits])  ->  integer or float
    # 
    # Rounds +int+ to a given precision in decimal digits (default 0 digits).
    # 
    # Precision may be negative.  Returns a floating point number when +ndigits+
    # is positive, +self+ for zero, and round down for negative.
    # 
    #    1.round        #=> 1
    #    1.round(2)     #=> 1.0
    #    15.round(-1)   #=> 20
    def round(*ndigits)
        #This is a stub, used for indexing
    end
    # int <=> numeric  ->  -1, 0, +1 or nil
    # 
    # Comparison---Returns +-1+, +0+, ++1+ or +nil+ depending on whether +int+ is
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
    # Negates +int+.
    # (returns an integer whose value is 0-int)
    def -@ int
        #This is a stub, used for indexing
    end
    # int + numeric  ->  numeric_result
    #   +
    # 
    # Performs addition: the class of the resulting object depends on the class of
    # +numeric+ and on the magnitude of the result. It may return a Bignum.
    def + numeric
        #This is a stub, used for indexing
    end
    # int - numeric  ->  numeric_result
    #   -
    # 
    # Performs subtraction: the class of the resulting object depends on the class
    # of +numeric+ and on the magnitude of the result. It may return a Bignum.
    def - numeric
        #This is a stub, used for indexing
    end
    # int * numeric  ->  numeric_result
    #   *
    # 
    # Performs multiplication: the class of the resulting object depends on the
    # class of +numeric+ and on the magnitude of the result. It may return a
    # Bignum.
    def * numeric
        #This is a stub, used for indexing
    end
    # int / numeric  ->  numeric_result
    #   /
    # 
    # Performs division: the class of the resulting object depends on the class of
    # +numeric+ and on the magnitude of the result. It may return a Bignum.
    def / numeric
        #This is a stub, used for indexing
    end
    # int.div(numeric)  ->  integer
    # 
    # Performs integer division: returns integer result of dividing +int+ by
    # +numeric+.
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
    # Returns the remainder after dividing <i>big</i> by <i>numeric</i> as:
    # 
    #   x.remainder(y) means x-y*(x/y).truncate
    # 
    # Examples
    # 
    #   5.remainder(3)    #=> 2
    #   -5.remainder(3)   #=> -2
    #   5.remainder(-3)   #=> 2
    #   -5.remainder(-3)  #=> -2
    # 
    #   -1234567890987654321.remainder(13731)      #=> -6966
    #   -1234567890987654321.remainder(13731.24)   #=> -9906.22531493148
    # 
    # See Numeric#divmod.
    def remainder(numeric)
        #This is a stub, used for indexing
    end
    # integer.divmod(numeric)  ->  array
    # 
    # See <code>Numeric#divmod</code>.
    def divmod(numeric)
        #This is a stub, used for indexing
    end
    # integer.fdiv(numeric)  ->  float
    # 
    # Returns the floating point result of dividing +fix+ by +numeric+.
    # 
    #    654321.fdiv(13731)      #=> 47.6528293642124
    #    654321.fdiv(13731.24)   #=> 47.6519964693647
    # 
    #    -1234567890987654321.fdiv(13731)      #=> -89910996357705.5
    #    -1234567890987654321.fdiv(13731.24)   #=> -89909424858035.7
    def fdiv(numeric)
        #This is a stub, used for indexing
    end
    # integer ** numeric  ->  numeric_result
    # 
    # Raises +integer+ to the power of +numeric+, which may be negative or
    # fractional.
    # The result may be a Fixnum, Bignum, or Float
    # 
    #   2 ** 3      #=> 8
    #   2 ** -1     #=> (1/2)
    #   2 ** 0.5    #=> 1.4142135623731
    # 
    #   123456789 ** 2      #=> 15241578750190521
    #   123456789 ** 1.2    #=> 5126464716.09932
    #   123456789 ** -2     #=> (1/15241578750190521)
    def ** numeric
        #This is a stub, used for indexing
    end
    # int.abs        ->  integer
    # 
    # Returns the absolute value of +int+.
    # 
    #    -12345.abs   #=> 12345
    #    12345.abs    #=> 12345
    #    -1234567890987654321.abs   #=> 1234567890987654321
    def abs()
        #This is a stub, used for indexing
    end
    # int.magnitude  ->  integer
    # 
    # Returns the absolute value of +int+.
    # 
    #    -12345.abs   #=> 12345
    #    12345.abs    #=> 12345
    #    -1234567890987654321.abs   #=> 1234567890987654321
    def magnitude()
        #This is a stub, used for indexing
    end
    def ===(p1)
        #This is a stub, used for indexing
    end
    # int == other  ->  true or false
    # 
    # Return +true+ if +int+ equals +other+ numerically.
    # Contrast this with <code>Integer#eql?</code>, which
    # requires <i>other</i> to be a <code>Integer</code>.
    # 
    #   1 == 2      #=> false
    #   1 == 1.0    #=> true
    def == other
        #This is a stub, used for indexing
    end
    # int > real  ->  true or false
    #   >
    # 
    # Returns +true+ if the value of +int+ is greater than that of +real+.
    def > real
        #This is a stub, used for indexing
    end
    # int >= real  ->  true or false
    #   >=
    # 
    # Returns +true+ if the value of +int+ is greater than or equal to that of
    # +real+.
    def >= real
        #This is a stub, used for indexing
    end
    # int < real  ->  true or false
    #   <
    # 
    # Returns +true+ if the value of +int+ is less than that of +real+.
    def < real
        #This is a stub, used for indexing
    end
    # int <= real  ->  true or false
    #   <=
    # 
    # Returns +true+ if the value of +int+ is less than or equal to that of
    # +real+.
    def <= real
        #This is a stub, used for indexing
    end
    # ~integer  ->  integer
    # 
    # One's complement: returns a number where each bit is flipped.
    # 
    # Inverts the bits in a integer. As Integers are conceptually infinite
    # length, the result acts as if it had an infinite number of one
    # bits to the left. In hex representations, this is displayed
    # as two periods to the left of the digits.
    # 
    #   sprintf("%X", ~0x1122334455)    #=> "..FEEDDCCBBAA"
    def ~ integer
        #This is a stub, used for indexing
    end
    # integer & integer  ->  integer_result
    # 
    # Bitwise AND.
    def & integer
        #This is a stub, used for indexing
    end
    # integer | integer  ->  integer_result
    # 
    # Bitwise OR.
    def | integer
        #This is a stub, used for indexing
    end
    # integer ^ integer  ->  integer_result
    # 
    # Bitwise EXCLUSIVE OR.
    def ^ integer
        #This is a stub, used for indexing
    end
    # int[n]  ->  0, 1
    # 
    # Bit Reference---Returns the +n+th bit in the binary representation of
    # +int+, where <code>int[0]</code> is the least significant bit.
    # 
    # For example:
    # 
    #    a = 0b11001100101010
    #    30.downto(0) do |n| print a[n] end
    #    #=> 0000000000000000011001100101010
    # 
    #    a = 9**15
    #    50.downto(0) do |n|
    #      print a[n]
    #    end
    #    #=> 000101110110100000111000011110010100111100010111001
    def [] n
        #This is a stub, used for indexing
    end
    # int << count  ->  integer
    # 
    # Shifts +int+ left +count+ positions, or right if +count+ is negative.
    def << count
        #This is a stub, used for indexing
    end
    # int >> count  ->  integer
    # 
    # Shifts +int+ right +count+ positions, or left if +count+ is negative.
    def >> count
        #This is a stub, used for indexing
    end
    # int.size  ->  int
    # 
    # Returns the number of bytes in the machine representation of +fix+.
    # 
    #    1.size            #=> 4
    #    -1.size           #=> 4
    #    2147483647.size   #=> 4
    #    (256**10 - 1).size   #=> 12
    #    (256**20 - 1).size   #=> 20
    #    (256**40 - 1).size   #=> 40
    def size()
        #This is a stub, used for indexing
    end
    # int.bit_length -> integer
    # 
    # Returns the number of bits of the value of <i>int</i>.
    # 
    # "the number of bits" means that
    # the bit position of the highest bit which is different to the sign bit.
    # (The bit position of the bit 2**n is n+1.)
    # If there is no such bit (zero or minus one), zero is returned.
    # 
    # I.e. This method returns ceil(log2(int < 0 ? -int : int+1)).
    # 
    #    (-2**10000-1).bit_length  #=> 10001
    #    (-2**10000).bit_length    #=> 10000
    #    (-2**10000+1).bit_length  #=> 10000
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
    #    (2**10000-1).bit_length   #=> 10000
    #    (2**10000).bit_length     #=> 10001
    #    (2**10000+1).bit_length   #=> 10001
    # 
    # This method can be used to detect overflow in Array#pack as follows.
    # 
    #    if n.bit_length < 32
    #      [n].pack("l") # no overflow
    #    else
    #      raise "overflow"
    #    end
    def bit_length()
        #This is a stub, used for indexing
    end
    # int.digits       -> [int]
    # int.digits(base) -> [int]
    # 
    # Returns the array including the digits extracted by place-value notation
    # with radix +base+ of +int+.
    # 
    # +base+ should be greater than or equal to 2.
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
    # int.gcd(int2)  ->  integer
    # 
    # Returns the greatest common divisor (always positive).  0.gcd(x)
    # and x.gcd(0) return abs(x).
    # 
    #    2.gcd(2)                    #=> 2
    #    3.gcd(-7)                   #=> 1
    #    ((1<<31)-1).gcd((1<<61)-1)  #=> 1
    def gcd(int2)
        #This is a stub, used for indexing
    end
    # int.lcm(int2)  ->  integer
    # 
    # Returns the least common multiple (always positive).  0.lcm(x) and
    # x.lcm(0) return zero.
    # 
    #    2.lcm(2)                    #=> 2
    #    3.lcm(-7)                   #=> 21
    #    ((1<<31)-1).lcm((1<<61)-1)  #=> 4951760154835678088235319297
    def lcm(int2)
        #This is a stub, used for indexing
    end
    # int.gcdlcm(int2)  ->  array
    # 
    # Returns an array; [int.gcd(int2), int.lcm(int2)].
    # 
    #    2.gcdlcm(2)                    #=> [2, 2]
    #    3.gcdlcm(-7)                   #=> [1, 21]
    #    ((1<<31)-1).gcdlcm((1<<61)-1)  #=> [1, 4951760154835678088235319297]
    def gcdlcm(int2)
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
    # Returns the value as a rational.  The optional argument eps is
    # always ignored.
    def rationalize(*eps)
        #This is a stub, used for indexing
    end
end
