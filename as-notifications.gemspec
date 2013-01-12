Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'as-notifications'
  s.version     = '0.1.0' # Will track ActiveSupport versions once 4.0 is releasesd.
  s.summary     = 'Provides an instrumentation API for Ruby'
  s.description = 'Provides an instrumentation API for Ruby. It has been extracted from rails activesupport.'

#  s.required_ruby_version = '>= 1.9.3'

  s.license = 'MIT'

  s.author   = 'Bernd Ahlers'
  s.email    = 'bernd@tuneafish.de'
  s.homepage = 'https://github.com/bernd/as-notifications'

  s.files        = Dir['MIT-LICENSE', 'README.rdoc', 'lib/**/*']
  s.require_path = 'lib'

  s.rdoc_options.concat ['--encoding',  'UTF-8']
end
