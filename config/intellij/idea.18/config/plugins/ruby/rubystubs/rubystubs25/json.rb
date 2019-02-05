=begin
 This is a machine generated stub using stdlib-doc for <b>module JSON</b>
 Sources used:  Ruby 2.5.0-preview1
 Created by IntelliJ Ruby Stubs Generator.
=end

module JSON
    module Ext
        # This is the JSON generator implemented as a C extension. It can be
        # configured to be used by setting
        # 
        #  JSON.generator = JSON::Ext::Generator
        # 
        # with the method generator= in JSON.
        module Generator
            module GeneratorMethods
                module Array
                    # to_json(state = nil)
                    # 
                    # Returns a JSON string containing a JSON array, that is generated from
                    # this Array instance.
                    # _state_ is a JSON::State object, that can also be used to configure the
                    # produced JSON string output further.
                    def to_json(state = nil)
                        #This is a stub, used for indexing
                    end
                end
                module Bignum
                    # to_json(*)
                    # 
                    # Returns a JSON string representation for this Integer number.
                    def to_json(*)
                        #This is a stub, used for indexing
                    end
                end
                module FalseClass
                    # to_json(*)
                    # 
                    # Returns a JSON string for false: 'false'.
                    def to_json(*)
                        #This is a stub, used for indexing
                    end
                end
                module Fixnum
                    # to_json(*)
                    # 
                    # Returns a JSON string representation for this Integer number.
                    def to_json(*)
                        #This is a stub, used for indexing
                    end
                end
                module Float
                    # to_json(*)
                    # 
                    # Returns a JSON string representation for this Float number.
                    def to_json(*)
                        #This is a stub, used for indexing
                    end
                end
                module Hash
                    # to_json(state = nil)
                    # 
                    # Returns a JSON string containing a JSON object, that is generated from
                    # this Hash instance.
                    # _state_ is a JSON::State object, that can also be used to configure the
                    # produced JSON string output further.
                    def to_json(state = nil)
                        #This is a stub, used for indexing
                    end
                end
                module Integer
                    # to_json(*)
                    # 
                    # Returns a JSON string representation for this Integer number.
                    def to_json(*)
                        #This is a stub, used for indexing
                    end
                end
                module NilClass
                    # to_json(*)
                    # 
                    # Returns a JSON string for nil: 'null'.
                    def to_json(*)
                        #This is a stub, used for indexing
                    end
                end
                module Object
                    # to_json(*)
                    # 
                    # Converts this object to a string (calling #to_s), converts
                    # it to a JSON string, and returns the result. This is a fallback, if no
                    # special method #to_json was defined for some object.
                    def to_json(*)
                        #This is a stub, used for indexing
                    end
                end
                module String
                    # String.included(modul)
                    # 
                    # Extends _modul_ with the String::Extend module.
                    def self.included(modul)
                        #This is a stub, used for indexing
                    end
                    # to_json(*)
                    # 
                    # This string should be encoded with UTF-8 A call to this method
                    # returns a JSON string encoded with UTF16 big endian characters as
                    # \u????.
                    def to_json(*)
                        #This is a stub, used for indexing
                    end
                    # to_json_raw(*args)
                    # 
                    # This method creates a JSON text from the result of a call to
                    # to_json_raw_object of this String.
                    def to_json_raw(*args)
                        #This is a stub, used for indexing
                    end
                    # to_json_raw_object()
                    # 
                    # This method creates a raw object hash, that can be nested into
                    # other data structures and will be generated as a raw string. This
                    # method should be used, if you want to convert raw strings to JSON
                    # instead of UTF-8 strings, e. g. binary data.
                    def to_json_raw_object()
                        #This is a stub, used for indexing
                    end
                    module Extend
                        # json_create(o)
                        # 
                        # Raw Strings are JSON Objects (the raw bytes are stored in an array for the
                        # key "raw"). The Ruby String can be created by this module method.
                        def json_create(o)
                            #This is a stub, used for indexing
                        end
                    end
                end
                module TrueClass
                    # to_json(*)
                    # 
                    # Returns a JSON string for true: 'true'.
                    def to_json(*)
                        #This is a stub, used for indexing
                    end
                end
            end
            class State
                # from_state(opts)
                # 
                # Creates a State object from _opts_, which ought to be Hash to create a
                # new State instance configured by _opts_, something else to create an
                # unconfigured instance. If _opts_ is a State object, it is just returned.
                def self.from_state(opts)
                    #This is a stub, used for indexing
                end
                # new(opts = {})
                # 
                # Instantiates a new State object, configured by _opts_.
                # 
                # _opts_ can have the following keys:
                # 
                # * *indent*: a string used to indent levels (default: ''),
                # * *space*: a string that is put after, a : or , delimiter (default: ''),
                # * *space_before*: a string that is put before a : pair delimiter (default: ''),
                # * *object_nl*: a string that is put at the end of a JSON object (default: ''),
                # * *array_nl*: a string that is put at the end of a JSON array (default: ''),
                # * *allow_nan*: true if NaN, Infinity, and -Infinity should be
                #   generated, otherwise an exception is thrown, if these values are
                #   encountered. This options defaults to false.
                # * *buffer_initial_length*: sets the initial length of the generator's
                #   internal buffer.
                def self.new(opts = {})
                    #This is a stub, used for indexing
                end
                # initialize_copy(orig)
                # 
                # Initializes this object from orig if it can be duplicated/cloned and returns
                # it.
                def initialize_copy(orig)
                    #This is a stub, used for indexing
                end
                # indent()
                # 
                # Returns the string that is used to indent levels in the JSON text.
                def indent()
                    #This is a stub, used for indexing
                end
                # indent=(indent)
                # 
                # Sets the string that is used to indent levels in the JSON text.
                def indent=(indent)
                    #This is a stub, used for indexing
                end
                # space()
                # 
                # Returns the string that is used to insert a space between the tokens in a JSON
                # string.
                def space()
                    #This is a stub, used for indexing
                end
                # space=(space)
                # 
                # Sets _space_ to the string that is used to insert a space between the tokens in a JSON
                # string.
                def space=(space)
                    #This is a stub, used for indexing
                end
                # space_before()
                # 
                # Returns the string that is used to insert a space before the ':' in JSON objects.
                def space_before()
                    #This is a stub, used for indexing
                end
                # space_before=(space_before)
                # 
                # Sets the string that is used to insert a space before the ':' in JSON objects.
                def space_before=(space_before)
                    #This is a stub, used for indexing
                end
                # object_nl()
                # 
                # This string is put at the end of a line that holds a JSON object (or
                # Hash).
                def object_nl()
                    #This is a stub, used for indexing
                end
                # object_nl=(object_nl)
                # 
                # This string is put at the end of a line that holds a JSON object (or
                # Hash).
                def object_nl=(object_nl)
                    #This is a stub, used for indexing
                end
                # array_nl()
                # 
                # This string is put at the end of a line that holds a JSON array.
                def array_nl()
                    #This is a stub, used for indexing
                end
                # array_nl=(array_nl)
                # 
                # This string is put at the end of a line that holds a JSON array.
                def array_nl=(array_nl)
                    #This is a stub, used for indexing
                end
                # max_nesting
                # 
                # This integer returns the maximum level of data structure nesting in
                # the generated JSON, max_nesting = 0 if no maximum is checked.
                def max_nesting()
                    #This is a stub, used for indexing
                end
                # max_nesting=(depth)
                # 
                # This sets the maximum level of data structure nesting in the generated JSON
                # to the integer depth, max_nesting = 0 if no maximum should be checked.
                def max_nesting=(depth)
                    #This is a stub, used for indexing
                end
                # check_circular?
                # 
                # Returns true, if circular data structures should be checked,
                # otherwise returns false.
                def check_circular?()
                    #This is a stub, used for indexing
                end
                # allow_nan?
                # 
                # Returns true, if NaN, Infinity, and -Infinity should be generated, otherwise
                # returns false.
                def allow_nan?()
                    #This is a stub, used for indexing
                end
                # ascii_only?
                # 
                # Returns true, if NaN, Infinity, and -Infinity should be generated, otherwise
                # returns false.
                def ascii_only?()
                    #This is a stub, used for indexing
                end
                # depth
                # 
                # This integer returns the current depth of data structure nesting.
                def depth()
                    #This is a stub, used for indexing
                end
                # depth=(depth)
                # 
                # This sets the maximum level of data structure nesting in the generated JSON
                # to the integer depth, max_nesting = 0 if no maximum should be checked.
                def depth=(depth)
                    #This is a stub, used for indexing
                end
                # buffer_initial_length
                # 
                # This integer returns the current initial length of the buffer.
                def buffer_initial_length()
                    #This is a stub, used for indexing
                end
                # buffer_initial_length=(length)
                # 
                # This sets the initial length of the buffer to +length+, if +length+ > 0,
                # otherwise its value isn't changed.
                def buffer_initial_length=(length)
                    #This is a stub, used for indexing
                end
                # configure(opts)
                # 
                # Configure this State instance with the Hash _opts_, and return
                # itself.
                def configure(opts)
                    #This is a stub, used for indexing
                end
                alias merge configure
                # to_h
                # 
                # Returns the configuration instance variables as a hash, that can be
                # passed to the configure method.
                def to_h()
                    #This is a stub, used for indexing
                end
                alias to_hash to_h
                # [](name)
                # 
                # Returns the value returned by method +name+.
                def [](p1)
                    #This is a stub, used for indexing
                end
                # []=(name, value)
                # 
                # Sets the attribute name to value.
                def []=(p1, p2)
                    #This is a stub, used for indexing
                end
                # generate(obj)
                # 
                # Generates a valid JSON document from object +obj+ and returns the
                # result. If no valid JSON document can be created this method raises a
                # GeneratorError exception.
                def generate(obj)
                    #This is a stub, used for indexing
                end
                def merge(p1)
                    #This is a stub, used for indexing
                end
                def to_hash()
                    #This is a stub, used for indexing
                end
            end
        end
        # This is the JSON parser implemented as a C extension. It can be configured
        # to be used by setting
        # 
        #  JSON.parser = JSON::Ext::Parser
        # 
        # with the method parser= in JSON.
        class Parser
            # new(source, opts => {})
            # 
            # Creates a new JSON::Ext::Parser instance for the string _source_.
            # 
            # Creates a new JSON::Ext::Parser instance for the string _source_.
            # 
            # It will be configured by the _opts_ hash. _opts_ can have the following
            # keys:
            # 
            # _opts_ can have the following keys:
            # * *max_nesting*: The maximum depth of nesting allowed in the parsed data
            #   structures. Disable depth checking with :max_nesting => false|nil|0, it
            #   defaults to 100.
            # * *allow_nan*: If set to true, allow NaN, Infinity and -Infinity in
            #   defiance of RFC 4627 to be parsed by the Parser. This option defaults to
            #   false.
            # * *symbolize_names*: If set to true, returns symbols for the names
            #   (keys) in a JSON object. Otherwise strings are returned, which is
            #   also the default. It's not possible to use this option in
            #   conjunction with the *create_additions* option.
            # * *create_additions*: If set to false, the Parser doesn't create
            #   additions even if a matching class and create_id was found. This option
            #   defaults to false.
            # * *object_class*: Defaults to Hash
            # * *array_class*: Defaults to Array
            def self.new(p1, p2 = {})
                #This is a stub, used for indexing
            end
            # parse()
            # 
            #  Parses the current JSON text _source_ and returns the complete data
            #  structure as a result.
            def parse()
                #This is a stub, used for indexing
            end
            # source()
            # 
            # Returns a copy of the current _source_ string, that was used to construct
            # this Parser.
            def source()
                #This is a stub, used for indexing
            end
        end
    end
end
