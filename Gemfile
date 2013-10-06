source 'https://rubygems.org'

gem 'jruby-openssl', :platforms => :jruby
gem 'rake', '~> 10.0.3'

group :development do
  gem 'guard-rspec'
  gem 'rb-fsevent', '~> 0.9.3'
end

group :test do
  gem 'coveralls', :require => false
  gem 'json', '~> 1.7', :platforms => [:ruby_18, :jruby]
  gem 'rspec', '~> 2.13.0'
  gem 'simplecov', :require => false
  gem 'test-queue', '~> 0.1.3'
  gem 'vcr', '~> 2.5.0'
  gem 'webmock', '1.11.0'
end

gemspec
