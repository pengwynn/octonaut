# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','octonaut','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'octonaut'
  s.version = Octonaut::VERSION
  s.author = ['Wynn Netherland', 'Larry Marburger']
  s.email = 'wynn.netherland@gmail.com'
  s.homepage = 'http://github.com/pengwynn'
  s.licenses = ['MIT']
  s.platform = Gem::Platform::RUBY
  s.summary = 'CLI for GitHub'
  s.files = `git ls-files`.split('\n')
  s.files = %w(README.md LICENSE.md Rakefile octonaut.gemspec)
  s.files += Dir.glob("lib/**/*.rb")
  s.files += Dir.glob("bin/**/*")
  s.files += Dir.glob("spec/**/*")
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'octonaut'
  s.add_dependency('gli','~> 2.5.5')
  s.add_dependency('octokit', '~> 1.22.0')
  s.add_dependency('launchy', '~> 2.2.0')
  s.add_dependency('highline', '~> 1.6.15')
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('guard-cucumber')
  s.add_development_dependency('rb-fsevent', '~> 0.9.1')
  s.add_development_dependency('rspec', '~> 2.12.0')
  s.add_development_dependency('rspec-mocks', '~> 2.12.0')
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'webmock'
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
end
