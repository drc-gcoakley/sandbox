=begin
 This is a machine generated stub using stdlib-doc for <b>class Rational</b>
 Sources used:  Ruby 2.5.0-preview1
 Created by IntelliJ Ruby Stubs Generator.
=end

# A rational number can be represented as a pair of integer numbers:
# a/b (b>0), where a is the numerator and b is the denominator.
# Integer a equals rational a/1 mathematically.
# 
# In Ruby, you can create rational objects with the Kernel#Rational,
# to_r, or rationalize methods or by suffixing +r+ to a literal.
# The return values will be irreducible fractions.
# 
#    Rational(1)      #=> (1/1)
#    Rational(2, 3)   #=> (2/3)
#    Rational(4, -6)  #=> (-2/3)
#    3.to_r           #=> (3/1)
#    2/3r             #=> (2/3)
# 
# You can also create rational objects from floating-point numbers or
# strings.
# 
#    Rational(0.3)    #=> (5404319552844595/18014398509481984)
#    Rational('0.3')  #=> (3/10)
#    Rational('2/3')  #=> (2/3)
# 
#    0.3.to_r         #=> (5404319552844595/18014398509481984)
#    '0.3'.to_r       #=> (3/10)
#    '2/3'.to_r       #=> (2/3)
#    0.3.rationalize  #=> (3/10)
# 
# A rational object is an exact number, which helps you to write
# programs without any rounding errors.
# 
#    10.times.inject(0) {|t| t + 0.1 }              #=> 0.9999999999999999
#    10.times.inject(0) {|t| t + Rational('0.1') }  #=> (1/1)
# 
# However, when an expression includes an inexact component (numerical value
# or operation), it will produce an inexact result.
# 
#    Rational(10) / 3   #=> (10/3)
#    Rational(10) / 3.0 #=> 3.3333333333333335
# 
#    Rational(-8) ** Rational(1, 3)
#                       #=> (1.0000000000000002+1.7320508075688772i)
class Rational < Numeric
    # rat.numerator  ->  integer
    # 
    # Returns the numerator.
    # 
    #    Rational(7).numerator        #=> 7
    #    Rational(7, 1).numerator     #=> 7
    #    Rational(9, -4).numerator    #=> -9
    #    Rational(-2, -10).numerator  #=> 1
    def numerator()
        #This is a stub, used for indexing
    end
    # rat.denominator  ->  integer
    # 
    # Returns the denominator (always positive).
    # 
    #    Rational(7).denominator             #=> 1
    #    Rational(7, 1).denominator          #=> 1
    #    Rational(9, -4).denominator         #=> 4
    #    Rational(-2, -10).denominator       #=> 5
    def denominator()
        #This is a stub, used for indexing
    end
    # -rat  ->  rational
    # 
    # Negates +rat+.
    def -@ rat
        #This is a stub, used for indexing
    end
    # rat + numeric  ->  numeric
    # 
    # Performs addition.
    # 
    #    Rational(2, 3)  + Rational(2, 3)   #=> (4/3)
    #    Rational(900)   + Rational(1)      #=> (901/1)
    #    Rational(-2, 9) + Rational(-9, 2)  #=> (-85/18)
    #    Rational(9, 8)  + 4                #=> (41/8)
    #    Rational(20, 9) + 9.8              #=> 12.022222222222222
    def + numeric
        #This is a stub, used for indexing
    end
    # rat - numeric  ->  numeric
    # 
    # Performs subtraction.
    # 
    #    Rational(2, 3)  - Rational(2, 3)   #=> (0/1)
    #    Rational(900)   - Rational(1)      #=> (899/1)
    #    Rational(-2, 9) - Rational(-9, 2)  #=> (77/18)
    #    Rational(9, 8)  - 4                #=> (-23/8)
    #    Rational(20, 9) - 9.8              #=> -7.577777777777778
    def - numeric
        #This is a stub, used for indexing
    end
    # rat * numeric  ->  numeric
    # 
    # Performs multiplication.
    # 
    #    Rational(2, 3)  * Rational(2, 3)   #=> (4/9)
    #    Rational(900)   * Rational(1)      #=> (900/1)
    #    Rational(-2, 9) * Rational(-9, 2)  #=> (1/1)
    #    Rational(9, 8)  * 4                #=> (9/2)
    #    Rational(20, 9) * 9.8              #=> 21.77777777777778
    def * numeric
        #This is a stub, used for indexing
    end
    # rat / numeric     ->  numeric
    # 
    # Performs division.
    # 
    #    Rational(2, 3)  / Rational(2, 3)   #=> (1/1)
    #    Rational(900)   / Rational(1)      #=> (900/1)
    #    Rational(-2, 9) / Rational(-9, 2)  #=> (4/81)
    #    Rational(9, 8)  / 4                #=> (9/32)
    #    Rational(20, 9) / 9.8              #=> 0.22675736961451246
    def / numeric
        #This is a stub, used for indexing
    end
    # rat.quo(numeric)  ->  numeric
    # 
    # Performs division.
    # 
    #    Rational(2, 3)  / Rational(2, 3)   #=> (1/1)
    #    Rational(900)   / Rational(1)      #=> (900/1)
    #    Rational(-2, 9) / Rational(-9, 2)  #=> (4/81)
    #    Rational(9, 8)  / 4                #=> (9/32)
    #    Rational(20, 9) / 9.8              #=> 0.22675736961451246
    def quo(numeric)
        #This is a stub, used for indexing
    end
    # rat.fdiv(numeric)  ->  float
    # 
    # Performs division and returns the value as a Float.
    # 
    #    Rational(2, 3).fdiv(1)       #=> 0.6666666666666666
    #    Rational(2, 3).fdiv(0.5)     #=> 1.3333333333333333
    #    Rational(2).fdiv(3)          #=> 0.6666666666666666
    def fdiv(numeric)
        #This is a stub, used for indexing
    end
    # rat ** numeric  ->  numeric
    # 
    # Performs exponentiation.
    # 
    #    Rational(2)    ** Rational(3)     #=> (8/1)
    #    Rational(10)   ** -2              #=> (1/100)
    #    Rational(10)   ** -2.0            #=> 0.01
    #    Rational(-4)   ** Rational(1, 2)  #=> (0.0+2.0i)
    #    Rational(1, 2) ** 0               #=> (1/1)
    #    Rational(1, 2) ** 0.0             #=> 1.0
    def ** numeric
        #This is a stub, used for indexing
    end
    # rational <=> numeric  ->  -1, 0, +1, or nil
    # 
    # Returns -1, 0, or +1 depending on whether +rational+ is
    # less than, equal to, or greater than +numeric+.
    # 
    # +nil+ is returned if the two values are incomparable.
    # 
    #    Rational(2, 3) <=> Rational(2, 3)  #=> 0
    #    Rational(5)    <=> 5               #=> 0
    #    Rational(2, 3) <=> Rational(1, 3)  #=> 1
    #    Rational(1, 3) <=> 1               #=> -1
    #    Rational(1, 3) <=> 0.3             #=> 1
    # 
    #    Rational(1, 3) <=> "0.3"           #=> nil
    def <=> numeric
        #This is a stub, used for indexing
    end
    # rat == object  ->  true or false
    # 
    # Returns +true+ if +rat+ equals +object+ numerically.
    # 
    #    Rational(2, 3)  == Rational(2, 3)   #=> true
    #    Rational(5)     == 5                #=> true
    #    Rational(0)     == 0.0              #=> true
    #    Rational('1/3') == 0.33             #=> false
    #    Rational('1/2') == '1/2'            #=> false
    def == object
        #This is a stub, used for indexing
    end
    # rat.positive?  ->  true or false
    # 
    # Returns +true+ if +rat+ is greater than 0.
    def positive?()
        #This is a stub, used for indexing
    end
    # rat.negative?  ->  true or false
    # 
    # Returns +true+ if +rat+ is less than 0.
    def negative?()
        #This is a stub, used for indexing
    end
    # rat.abs        ->  rational
    # 
    # Returns the absolute value of +rat+.
    # 
    #    (1/2r).abs    #=> (1/2)
    #    (-1/2r).abs   #=> (1/2)
    # 
    # Rational#magnitude is an alias for Rational#abs.
    def abs()
        #This is a stub, used for indexing
    end
    # rat.magnitude  ->  rational
    # 
    # Returns the absolute value of +rat+.
    # 
    #    (1/2r).abs    #=> (1/2)
    #    (-1/2r).abs   #=> (1/2)
    # 
    # Rational#magnitude is an alias for Rational#abs.
    def magnitude()
        #This is a stub, used for indexing
    end
    # rat.floor([ndigits])  ->  integer or rational
    # 
    # Returns the largest number less than or equal to +rat+ with
    # a precision of +ndigits+ decimal digits (default: 0).
    # 
    # When the precision is negative, the returned value is an integer
    # with at least <code>ndigits.abs</code> trailing zeros.
    # 
    # Returns a rational when +ndigits+ is positive,
    # otherwise returns an integer.
    # 
    #    Rational(3).floor      #=> 3
    #    Rational(2, 3).floor   #=> 0
    #    Rational(-3, 2).floor  #=> -2
    # 
    #      #    decimal      -  1  2  3 . 4  5  6
    #      #                   ^  ^  ^  ^   ^  ^
    #      #   precision      -3 -2 -1  0  +1 +2
    # 
    #    Rational('-123.456').floor(+1).to_f  #=> -123.5
    #    Rational('-123.456').floor(-1)       #=> -130
    def floor(*ndigits)
        #This is a stub, used for indexing
    end
    # rat.ceil([ndigits])  ->  integer or rational
    # 
    # Returns the smallest number greater than or equal to +rat+ with
    # a precision of +ndigits+ decimal digits (default: 0).
    # 
    # When the precision is negative, the returned value is an integer
    # with at least <code>ndigits.abs</code> trailing zeros.
    # 
    # Returns a rational when +ndigits+ is positive,
    # otherwise returns an integer.
    # 
    #    Rational(3).ceil      #=> 3
    #    Rational(2, 3).ceil   #=> 1
    #    Rational(-3, 2).ceil  #=> -1
    # 
    #      #    decimal      -  1  2  3 . 4  5  6
    #      #                   ^  ^  ^  ^   ^  ^
    #      #   precision      -3 -2 -1  0  +1 +2
    # 
    #    Rational('-123.456').ceil(+1).to_f  #=> -123.4
    #    Rational('-123.456').ceil(-1)       #=> -120
    def ceil(*ndigits)
        #This is a stub, used for indexing
    end
    # rat.truncate([ndigits])  ->  integer or rational
    # 
    # Returns +rat+ truncated (toward zero) to
    # a precision of +ndigits+ decimal digits (default: 0).
    # 
    # When the precision is negative, the returned value is an integer
    # with at least <code>ndigits.abs</code> trailing zeros.
    # 
    # Returns a rational when +ndigits+ is positive,
    # otherwise returns an integer.
    # 
    #    Rational(3).truncate      #=> 3
    #    Rational(2, 3).truncate   #=> 0
    #    Rational(-3, 2).truncate  #=> -1
    # 
    #      #    decimal      -  1  2  3 . 4  5  6
    #      #                   ^  ^  ^  ^   ^  ^
    #      #   precision      -3 -2 -1  0  +1 +2
    # 
    #    Rational('-123.456').truncate(+1).to_f  #=> -123.4
    #    Rational('-123.456').truncate(-1)       #=> -120
    def truncate(*ndigits)
        #This is a stub, used for indexing
    end
    # rat.round([ndigits] [, half: mode])  ->  integer or rational
    # 
    # Returns +rat+ rounded to the nearest value with
    # a precision of +ndigits+ decimal digits (default: 0).
    # 
    # When the precision is negative, the returned value is an integer
    # with at least <code>ndigits.abs</code> trailing zeros.
    # 
    # Returns a rational when +ndigits+ is positive,
    # otherwise returns an integer.
    # 
    #    Rational(3).round      #=> 3
    #    Rational(2, 3).round   #=> 1
    #    Rational(-3, 2).round  #=> -2
    # 
    #      #    decimal      -  1  2  3 . 4  5  6
    #      #                   ^  ^  ^  ^   ^  ^
    #      #   precision      -3 -2 -1  0  +1 +2
    # 
    #    Rational('-123.456').round(+1).to_f  #=> -123.5
    #    Rational('-123.456').round(-1)       #=> -120
    # 
    # The optional +half+ keyword argument is available
    # similar to Float#round.
    # 
    #    Rational(25, 100).round(1, half: :up)    #=> (3/10)
    #    Rational(25, 100).round(1, half: :down)  #=> (1/5)
    #    Rational(25, 100).round(1, half: :even)  #=> (1/5)
    #    Rational(35, 100).round(1, half: :up)    #=> (2/5)
    #    Rational(35, 100).round(1, half: :down)  #=> (3/10)
    #    Rational(35, 100).round(1, half: :even)  #=> (2/5)
    #    Rational(-25, 100).round(1, half: :up)   #=> (-3/10)
    #    Rational(-25, 100).round(1, half: :down) #=> (-1/5)
    #    Rational(-25, 100).round(1, half: :even) #=> (-1/5)
    def round(*smth) #parameteres couldn't be extracted
        #This is a stub, used for indexing
    end
    # rat.to_i  ->  integer
    # 
    # Returns the truncated value as an integer.
    # 
    # Equivalent to Rational#truncate.
    # 
    #    Rational(2, 3).to_i    #=> 0
    #    Rational(3).to_i       #=> 3
    #    Rational(300.6).to_i   #=> 300
    #    Rational(98, 71).to_i  #=> 1
    #    Rational(-31, 2).to_i  #=> -15
    def to_i()
        #This is a stub, used for indexing
    end
    # rat.to_f  ->  float
    # 
    # Returns the value as a Float.
    # 
    #    Rational(2).to_f      #=> 2.0
    #    Rational(9, 4).to_f   #=> 2.25
    #    Rational(-3, 4).to_f  #=> -0.75
    #    Rational(20, 3).to_f  #=> 6.666666666666667
    def to_f()
        #This is a stub, used for indexing
    end
    # rat.to_r  ->  self
    # 
    # Returns self.
    # 
    #    Rational(2).to_r      #=> (2/1)
    #    Rational(-8, 6).to_r  #=> (-4/3)
    def to_r()
        #This is a stub, used for indexing
    end
    # rat.rationalize       ->  self
    # rat.rationalize(eps)  ->  rational
    # 
    # Returns a simpler approximation of the value if the optional
    # argument +eps+ is given (rat-|eps| <= result <= rat+|eps|),
    # self otherwise.
    # 
    #    r = Rational(5033165, 16777216)
    #    r.rationalize                    #=> (5033165/16777216)
    #    r.rationalize(Rational('0.01'))  #=> (3/10)
    #    r.rationalize(Rational('0.1'))   #=> (1/3)
    def rationalize(*several_variants)
        #This is a stub, used for indexing
    end
    # rat.to_s  ->  string
    # 
    # Returns the value as a string.
    # 
    #    Rational(2).to_s      #=> "2/1"
    #    Rational(-8, 6).to_s  #=> "-4/3"
    #    Rational('1/2').to_s  #=> "1/2"
    def to_s()
        #This is a stub, used for indexing
    end
    # rat.inspect  ->  string
    # 
    # Returns the value as a string for inspection.
    # 
    #    Rational(2).inspect      #=> "(2/1)"
    #    Rational(-8, 6).inspect  #=> "(-4/3)"
    #    Rational('1/2').inspect  #=> "(1/2)"
    def inspect()
        #This is a stub, used for indexing
    end
    class compatible
    end
end
