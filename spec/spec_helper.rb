ENV['OCTONAUT_ENV']          = 'TEST'
ENV['OCTONAUT_PLUGINS_PATH'] = 'tmp/fakehome/plugins'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order = 'random'

  config.before :each do
    @old_stderr = $stderr
    $stderr = StringIO.new
    @old_stdout = $stdout
    $stdout = StringIO.new
    @old_stdin = $stdin
    $stdin = StringIO.new
    FileUtils.rm_f File.expand_path(Octonaut.config_path)
  end

  config.after :each do
    $stderr = @old_stderr
    $stdout = @old_stdout
    $stdin  = @old_stdin
    FileUtils.rm_f File.expand_path(Octonaut.config_path)
  end
end

require 'octonaut'
require 'rspec/mocks'
require 'webmock/rspec'

def a_delete(url)
  a_request(:delete, github_url(url))
end

def a_get(url)
  a_request(:get, github_url(url))
end

def a_patch(url)
  a_request(:patch, github_url(url))
end

def a_post(url)
  a_request(:post, github_url(url))
end

def a_put(url)
  a_request(:put, github_url(url))
end

def stub_delete(url)
  stub_request(:delete, github_url(url))
end

def stub_get(url)
  stub_request(:get, github_url(url))
end

def stub_head(url)
  stub_request(:head, github_url(url))
end

def stub_patch(url)
  stub_request(:patch, github_url(url))
end

def stub_post(url)
  stub_request(:post, github_url(url))
end

def stub_put(url)
  stub_request(:put, github_url(url))
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def json_response(file, headers = {})
  {
    :body => fixture(file),
    :headers => {
      :content_type => 'application/json; charset=utf-8'
    }.merge(headers)
  }
end

def github_url(url)
  if url =~ /^http/
    url
  else
    "https://api.github.com#{url}"
  end
end
