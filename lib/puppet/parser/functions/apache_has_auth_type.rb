module Puppet::Parser::Functions

  newfunction(:apache_has_auth_type, :type => :rvalue, :doc => <<-'ENDHEREDOC') do |args|
    Given an array of hashes, which has a key 'auth' whose value is a
    hash, compare the value of the key 'type' in the latter hash to the
   given value.

    ENDHEREDOC

    unless args.length == 2
      raise Puppet::ParseError, ("apache_has_auth_type(): wrong number of arguments (#{args.length}; must be 2)")
    end

    unless args[0].is_a?(Array)
      raise Puppet::ParseError, "apache_has_auth_type(): expects the first argument to be a array, got #{args[0].inspect} which is of type #{args[0].class}"
    end

    found = false
    args[0].each do |entry|
      unless entry.is_a?(Hash)
        raise Puppet::ParseError, "apache_has_auth_type(): expects the first argument to be a array of hashes, array member #{entry.inspect} is of type #{entry.class}"
      end
      if entry.has_key?('auth')
        subentry = entry['auth']
        unless subentry.is_a?(Hash)
          raise Puppet::ParseError, "apache_has_auth_type(): expects the values of 'auth' keys to be hashes, got value #{subentry.inspect} which is of type #{subentry.class}"
        end
        if subentry.has_key?('type')
          if subentry['type'] == args[1]
            found = true
            break
          end
        end
      end
    end
    return found
  end

end
