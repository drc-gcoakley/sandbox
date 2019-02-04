=begin
 This is a machine generated stub using stdlib-doc for <b>class KeyError</b>
 Sources used:  Ruby 2.5.0-preview1
 Created by IntelliJ Ruby Stubs Generator.
=end

# Raised when the specified key is not found. It is a subclass of
# IndexError.
# 
#    h = {"foo" => :bar}
#    h.fetch("foo") #=> :bar
#    h.fetch("baz") #=> KeyError: key not found: "baz"
class KeyError < IndexError
    def receiver()
        #This is a stub, used for indexing
    end
    def key()
        #This is a stub, used for indexing
    end
end
