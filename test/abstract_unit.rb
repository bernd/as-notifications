ORIG_ARGV = ARGV.dup

begin
  old, $VERBOSE = $VERBOSE, nil
  #require File.expand_path('../../../load_paths', __FILE__)
ensure
  $VERBOSE = old
end

require 'active_support/core_ext/kernel/reporting'
require 'active_support/core_ext/string/encoding'

# Ruby 1.8 compat
if "ruby".encoding_aware?
  silence_warnings do
    Encoding.default_internal = "UTF-8"
    Encoding.default_external = "UTF-8"
  end
end

# Ruby 1.8 compat
begin
  require 'active_support/testing/autorun'
rescue LoadError
  require 'test/unit'
end
require 'empty_bool'

ENV['NO_RELOAD'] = '1'
require 'active_support'

# Show backtraces for deprecated behavior for quicker cleanup.
ActiveSupport::Deprecation.debug = true
