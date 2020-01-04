# This is an autogenerated function, ported from the original legacy version.
# It /should work/ as is, but will not have all the benefits of the modern
# function API. You should see the function docs to learn how to add function
# signatures for type safety and to document this function using puppet-strings.
#
# https://puppet.com/docs/puppet/latest/custom_functions_ruby.html
#
# ---- original file header ----
require 'digest/md5'

# ---- original file header ----
#
# @summary
#       Safely escapes a string using $$ using a random tag which should be consistent
#
#
Puppet::Functions.create_function(:'postgresql_escape') do
  # @param args
  #   The original array of arguments. Port this to individually managed params
  #   to get the full benefit of the modern function API.
  #
  # @return [Data type]
  #   Describe what the function returns here
  #
  dispatch :default_impl do
    # Call the method named 'default_impl' when this is matched
    # Port this to match individual params for better type safety
    repeated_param 'Any', :args
  end


  def default_impl(*args)
    

    raise(Puppet::ParseError, "postgresql_escape(): Wrong number of arguments " +
      "given (#{args.size} for 1)") if args.size != 1

    password = args[0]

    if password !~ /\$\$/ 
      retval = "$$#{password}$$"
    else
      escape = Digest::MD5.hexdigest(password)[0..5].gsub(/\d/,'')
      until password !~ /#{escape}/
        escape = Digest::MD5.hexdigest(escape)[0..5].gsub(/\d/,'')
      end
      retval = "$#{escape}$#{password}$#{escape}$"
    end
    retval 
  
  end
end
