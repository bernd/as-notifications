Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'as-notifications'
  s.version     = '1.0.2'
  s.summary     = 'Provides an instrumentation API for Ruby'
  s.description = 'Provides an instrumentation API for Ruby. It has been extracted from rails activesupport.'

  s.license = 'MIT'

  s.author   = 'Bernd Ahlers'
  s.email    = 'bernd@tuneafish.de'
  s.homepage = 'https://github.com/bernd/as-notifications'

  s.files        = Dir['MIT-LICENSE', 'README.md', 'lib/**/*']
  s.require_path = 'lib'

  s.rdoc_options.concat ['--encoding', 'UTF-8']

  s.add_runtime_dependency 'mutex_m'
end
