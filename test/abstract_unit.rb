ORIG_ARGV = ARGV.dup

begin
  old, $VERBOSE = $VERBOSE, nil
  #require File.expand_path('../../../load_paths', __FILE__)
ensure
  $VERBOSE = old
end

require 'active_support/core_ext/kernel/reporting'
require 'active_support/core_ext/string/encoding'

silence_warnings do
  Encoding.default_internal = "UTF-8" if "ruby".encoding_aware?
  Encoding.default_internal = "UTF-8" if "ruby".encoding_aware?
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

Thread.abort_on_exception = true

# Show backtraces for deprecated behavior for quicker cleanup.
ActiveSupport::Deprecation.debug = true
