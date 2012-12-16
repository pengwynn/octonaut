# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','o','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'o'
  s.version = O::VERSION
  s.author = 'Your Name Here'
  s.email = 'your@email.address.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
# Add your other files here if you make them
  s.files = %w(
bin/o
lib/o/version.rb
lib/o.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','o.rdoc']
  s.rdoc_options << '--title' << 'o' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'o'
  s.add_dependency('octokit', '~> 1.17.0')
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_development_dependency('guard-cucumber')
  s.add_development_dependency('rb-fsevent', '~> 0.9.1')
  s.add_runtime_dependency('gli','2.5.2')
end
