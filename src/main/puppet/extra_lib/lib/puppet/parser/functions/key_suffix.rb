module Puppet::Parser::Functions
  newfunction(:key_suffix, :type => :rvalue, :doc => <<-'ENDHEREDOC') do |args|
    Add a suffix to each key of an array

    For example:

        $hash = {'one' => 1, 'two', => 2}
        $suffixed_keys = key_suffix($hash, '_test')
        # The resulting hash is equivalent to:
        # {'one_test' => 1, 'two_test' => 2}


    ENDHEREDOC

    unless args.length == 2
      raise Puppet::ParseError, ("key_suffix(): wrong number of arguments (#{args.length}; must be 2)")
    end
    unless args[0].is_a?(Hash)
      raise Puppet::ParseError, "key_suffix(): expects the first argument to be a hash, got #{args[0].inspect} which is of type #{args[0].class}"
    end

    Hash[args[0].map{|k,v| [k + args[1],v]}]
  end
end
