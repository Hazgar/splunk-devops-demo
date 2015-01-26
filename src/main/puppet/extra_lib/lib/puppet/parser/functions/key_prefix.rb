module Puppet::Parser::Functions
  newfunction(:key_prefix, :type => :rvalue, :doc => <<-'ENDHEREDOC') do |args|
    Add a prefix to each key of an array

    For example:

        $hash = {'one' => 1, 'two', => 2}
        $prefixed_keys = key_prefix($hash, 'test_')
        # The resulting hash is equivalent to:
        # {'test_one' => 1, 'test_two' => 2}


    ENDHEREDOC

    unless args.length == 2
      raise Puppet::ParseError, ("key_prefix(): wrong number of arguments (#{args.length}; must be 2)")
    end
    unless args[0].is_a?(Hash)
      raise Puppet::ParseError, "key_prefix(): expects the first argument to be a hash, got #{args[0].inspect} which is of type #{args[0].class}"
    end

    Hash[args[0].map{|k,v| [args[1] + k,v]}]
  end
end
