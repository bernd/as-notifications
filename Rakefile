require 'rake/testtask'
require 'rubygems/package_task'
require 'bundler/setup'

task :default => :test
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.warning = true
  t.verbose = true
end

def gemspec
  Gem::Specification.load('as-notifications.gemspec')
end

Gem::PackageTask.new(gemspec) do |p|
  p.need_zip = false
  p.need_tar = false
end

task :gem => :gemspec

desc %{Validate the gemspec file.}
task :gemspec do
  gemspec.validate
end

desc %{Release the gem to RubyGems.org}
task :release => :gem do
  system "gem push pkg/#{gemspec.name}-#{gemspec.version}.gem"
end

desc %{Sync ActiveSupport::Notifications files and apply changes}
task :sync do
  require 'fileutils'
  require 'tempfile'

  active_support = ENV.fetch('AS_DIR')

  def inplace_edit(path)
    f = File.open(path, 'r')
    s = f.read
    yield(s)
    f.reopen(path, 'w').write(s)
    f.close
  end

  %w(
    lib/active_support/notifications.rb
    lib/active_support/notifications/fanout.rb
    lib/active_support/notifications/instrumenter.rb
    lib/active_support/per_thread_registry.rb
    test/empty_bool.rb
    test/abstract_unit.rb
    test/notifications_test.rb
    test/notifications/evented_notification_test.rb
    test/notifications/instrumenter_test.rb
  ).each do |file|
    local_file = file.gsub('active_support', 'as')
    path = File.join(active_support, file)
    local = File.join(File.expand_path('..', __FILE__), local_file)

    FileUtils.mkdir_p(File.dirname(local))
    FileUtils.cp(path, local)

    inplace_edit(local) do |s|
      s.gsub!('ActiveSupport::Notifications', 'AS::Notifications')
      s.gsub!('ActiveSupport::PerThreadRegistry', 'AS::PerThreadRegistry')
      s.gsub!(%(require 'active_support/notifications), %(require 'as/notifications))
      s.gsub!(%(require 'active_support/per_thread_registry), %(require 'as/per_thread_registry))
      s.gsub!('module ActiveSupport', 'module AS')
      s.gsub!(%(require 'abstract_unit'), %(require 'abstract_unit'\nrequire 'as/notifications'))
      s.gsub!(
        %(require File.expand_path('../../../load_paths', __FILE__)),
        %(#require File.expand_path('../../../load_paths', __FILE__))
      )
      s.gsub!(%(  module PerThreadRegistry), <<-__GSUB)
  module PerThreadRegistry
    if RUBY_VERSION < '1.9'
      require 'as/backports/define_singleton_method'
      require 'as/backports/public_send'
    end
      __GSUB
      s.gsub!(%(assert_predicate notifier.finishes, :empty?), <<-__GSUB)
# Changed from assert_predicate to assert_equal for 1.8 compat.
        assert_equal true, notifier.finishes.empty?
      __GSUB
      s.gsub!(%(assert_predicate notifier.starts, :empty?), <<-__GSUB)
# Changed from assert_predicate to assert_equal for 1.8 compat.
        assert_equal true, notifier.starts.empty?
      __GSUB
      s.gsub!(
        %(Encoding.default_internal = "UTF-8"),
        %(Encoding.default_internal = "UTF-8" if "ruby".encoding_aware?)
      )
      s.gsub!(
        %(Encoding.default_external = "UTF-8"),
        %(Encoding.default_internal = "UTF-8" if "ruby".encoding_aware?)
      )
      s.gsub!(%(require 'active_support/testing/autorun'), <<-__GSUB)
# Ruby 1.8 compat
begin
  require 'active_support/testing/autorun'
rescue LoadError
  require 'test/unit'
end
      __GSUB
    end
  end

  tmpfile = Tempfile.new('as_notifications_45448a5_revert')

  Dir.chdir(active_support) do
    tmpfile.write %x(git diff 45448a5..45448a5^ lib/active_support/notifications/fanout.rb)
    tmpfile.close
  end

  inplace_edit(tmpfile.path) do |s|
    s.gsub!('lib/active_support', 'lib/as')
  end

  puts %x(patch -p1 < #{tmpfile.path})
  FileUtils.rm(Dir['./**/*.orig'])
  tmpfile.unlink
end
