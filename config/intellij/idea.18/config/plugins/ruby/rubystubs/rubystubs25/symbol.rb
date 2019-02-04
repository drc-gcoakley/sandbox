=begin
 This is a machine generated stub using stdlib-doc for <b>class Symbol</b>
 Sources used:  Ruby 2.5.0-preview1
 Created by IntelliJ Ruby Stubs Generator.
=end

# <code>Symbol</code> objects represent names and some strings
# inside the Ruby
# interpreter. They are generated using the <code>:name</code> and
# <code>:"string"</code> literals
# syntax, and by the various <code>to_sym</code> methods. The same
# <code>Symbol</code> object will be created for a given name or string
# for the duration of a program's execution, regardless of the context
# or meaning of that name. Thus if <code>Fred</code> is a constant in
# one context, a method in another, and a class in a third, the
# <code>Symbol</code> <code>:Fred</code> will be the same object in
# all three contexts.
# 
#    module One
#      class Fred
#      end
#      $f1 = :Fred
#    end
#    module Two
#      Fred = 1
#      $f2 = :Fred
#    end
#    def Fred()
#    end
#    $f3 = :Fred
#    $f1.object_id   #=> 2514190
#    $f2.object_id   #=> 2514190
#    $f3.object_id   #=> 2514190
class Symbol
    include Comparable
    # Symbol.all_symbols    => array
    # 
    # Returns an array of all the symbols currently in Ruby's symbol
    # table.
    # 
    #    Symbol.all_symbols.size    #=> 903
    #    Symbol.all_symbols[1,20]   #=> [:floor, :ARGV, :Binding, :symlink,
    #                                    :chown, :EOFError, :$;, :String,
    #                                    :LOCK_SH, :"setuid?", :$<,
    #                                    :default_proc, :compact, :extend,
    #                                    :Tms, :getwd, :$=, :ThreadGroup,
    #                                    :wait2, :$>]
    def self.all_symbols()
        #This is a stub, used for indexing
    end
    # sym == obj   -> true or false
    # 
    # Equality---If <i>sym</i> and <i>obj</i> are exactly the same
    # symbol, returns <code>true</code>.
    def == obj
        #This is a stub, used for indexing
    end
    # sym == obj   -> true or false
    # 
    # Equality---If <i>sym</i> and <i>obj</i> are exactly the same
    # symbol, returns <code>true</code>.
    def ===(p1)
        #This is a stub, used for indexing
    end
    # sym.inspect    -> string
    # 
    # Returns the representation of <i>sym</i> as a symbol literal.
    # 
    #    :fred.inspect   #=> ":fred"
    def inspect()
        #This is a stub, used for indexing
    end
    # sym.to_s      -> string
    # 
    # Returns the name or string corresponding to <i>sym</i>.
    # 
    #    :fred.id2name   #=> "fred"
    #    :ginger.to_s    #=> "ginger"
    def to_s()
        #This is a stub, used for indexing
    end
    # sym.id2name   -> string
    # 
    # Returns the name or string corresponding to <i>sym</i>.
    # 
    #    :fred.id2name   #=> "fred"
    #    :ginger.to_s    #=> "ginger"
    def id2name()
        #This is a stub, used for indexing
    end
    # sym.intern   -> sym
    # 
    # In general, <code>to_sym</code> returns the <code>Symbol</code> corresponding
    # to an object. As <i>sym</i> is already a symbol, <code>self</code> is returned
    # in this case.
    def intern()
        #This is a stub, used for indexing
    end
    # sym.to_sym   -> sym
    # 
    # In general, <code>to_sym</code> returns the <code>Symbol</code> corresponding
    # to an object. As <i>sym</i> is already a symbol, <code>self</code> is returned
    # in this case.
    def to_sym()
        #This is a stub, used for indexing
    end
    # sym.to_proc
    # 
    # Returns a _Proc_ object which respond to the given method by _sym_.
    # 
    #   (1..3).collect(&:to_s)  #=> ["1", "2", "3"]
    def to_proc()
        #This is a stub, used for indexing
    end
    # sym.succ
    # 
    # Same as <code>sym.to_s.succ.intern</code>.
    def succ()
        #This is a stub, used for indexing
    end
    # sym.succ
    # 
    # Same as <code>sym.to_s.succ.intern</code>.
    def next()
        #This is a stub, used for indexing
    end
    # symbol <=> other_symbol       -> -1, 0, +1, or nil
    # 
    # Compares +symbol+ with +other_symbol+ after calling #to_s on each of the
    # symbols. Returns -1, 0, +1, or +nil+ depending on whether +symbol+ is
    # less than, equal to, or greater than +other_symbol+.
    # 
    # +nil+ is returned if the two values are incomparable.
    # 
    # See String#<=> for more information.
    def <=> other_symbol
        #This is a stub, used for indexing
    end
    # sym.casecmp(other_symbol)   -> -1, 0, +1, or nil
    # 
    # Case-insensitive version of <code>Symbol#<=></code>.
    # Currently, case-insensitivity only works on characters A-Z/a-z,
    # not all of Unicode. This is different from Symbol#casecmp?.
    # 
    #   :aBcDeF.casecmp(:abcde)     #=> 1
    #   :aBcDeF.casecmp(:abcdef)    #=> 0
    #   :aBcDeF.casecmp(:abcdefg)   #=> -1
    #   :abcdef.casecmp(:ABCDEF)    #=> 0
    # 
    # +nil+ is returned if the two symbols have incompatible encodings,
    # or if +other_symbol+ is not a symbol.
    # 
    #   :foo.casecmp(2)   #=> nil
    #   "\u{e4 f6 fc}".encode("ISO-8859-1").to_sym.casecmp(:"\u{c4 d6 dc}")   #=> nil
    def casecmp(other_symbol)
        #This is a stub, used for indexing
    end
    # sym.casecmp?(other_symbol)   -> true, false, or nil
    # 
    # Returns +true+ if +sym+ and +other_symbol+ are equal after
    # Unicode case folding, +false+ if they are not equal.
    # 
    #   :aBcDeF.casecmp?(:abcde)     #=> false
    #   :aBcDeF.casecmp?(:abcdef)    #=> true
    #   :aBcDeF.casecmp?(:abcdefg)   #=> false
    #   :abcdef.casecmp?(:ABCDEF)    #=> true
    #   :"\u{e4 f6 fc}".casecmp?(:"\u{c4 d6 dc}")   #=> true
    # 
    # +nil+ is returned if the two symbols have incompatible encodings,
    # or if +other_symbol+ is not a symbol.
    # 
    #   :foo.casecmp?(2)   #=> nil
    #   "\u{e4 f6 fc}".encode("ISO-8859-1").to_sym.casecmp?(:"\u{c4 d6 dc}")   #=> nil
    def casecmp?(other_symbol)
        #This is a stub, used for indexing
    end
    # sym =~ obj   -> integer or nil
    # 
    # Returns <code>sym.to_s =~ obj</code>.
    def =~ obj
        #This is a stub, used for indexing
    end
    # sym[idx]      -> char
    # sym[b, n]     -> string
    # 
    # Returns <code>sym.to_s[]</code>.
    def [](*several_variants)
        #This is a stub, used for indexing
    end
    # sym.slice(idx)      -> char
    # sym.slice(b, n)     -> string
    # 
    # Returns <code>sym.to_s[]</code>.
    def slice(*several_variants)
        #This is a stub, used for indexing
    end
    # sym.length   -> integer
    # 
    # Same as <code>sym.to_s.length</code>.
    def length()
        #This is a stub, used for indexing
    end
    # sym.size     -> integer
    # 
    # Same as <code>sym.to_s.length</code>.
    def size()
        #This is a stub, used for indexing
    end
    # sym.empty?   -> true or false
    # 
    # Returns whether _sym_ is :"" or not.
    def empty?()
        #This is a stub, used for indexing
    end
    # sym.match(pattern)        -> matchdata or nil
    # sym.match(pattern, pos)   -> matchdata or nil
    # 
    # Returns <code>sym.to_s.match</code>.
    def match(*several_variants)
        #This is a stub, used for indexing
    end
    # sym.match?(pattern)        -> true or false
    # sym.match?(pattern, pos)   -> true or false
    # 
    # Returns <code>sym.to_s.match?</code>.
    def match?(*several_variants)
        #This is a stub, used for indexing
    end
    # sym.upcase              -> symbol
    # sym.upcase([options])   -> symbol
    # 
    # Same as <code>sym.to_s.upcase.intern</code>.
    def upcase(*several_variants)
        #This is a stub, used for indexing
    end
    # sym.downcase              -> symbol
    # sym.downcase([options])   -> symbol
    # 
    # Same as <code>sym.to_s.downcase.intern</code>.
    def downcase(*several_variants)
        #This is a stub, used for indexing
    end
    # sym.capitalize              -> symbol
    # sym.capitalize([options])   -> symbol
    # 
    # Same as <code>sym.to_s.capitalize.intern</code>.
    def capitalize(*several_variants)
        #This is a stub, used for indexing
    end
    # sym.swapcase              -> symbol
    # sym.swapcase([options])   -> symbol
    # 
    # Same as <code>sym.to_s.swapcase.intern</code>.
    def swapcase(*several_variants)
        #This is a stub, used for indexing
    end
    # sym.encoding   -> encoding
    # 
    # Returns the Encoding object that represents the encoding of _sym_.
    def encoding()
        #This is a stub, used for indexing
    end
end
