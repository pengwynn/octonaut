ENV['OCTONAUT_ENV']          = 'TEST'
ENV['OCTONAUT_PLUGINS_PATH'] = 'tmp/fakehome/plugins'

require 'octonaut'
require 'rspec/mocks'
require 'webmock/rspec'
require 'vcr'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order = 'random'

  config.before :each do
    Octokit.reset!
    @old_stderr = $stderr
    $stderr = StringIO.new
    @old_stdout = $stdout
    $stdout = StringIO.new
    @old_stdin = $stdin
    $stdin = StringIO.new
    FileUtils.rm_f File.expand_path(Octonaut.config_path)
  end

  config.after :each do
    Octokit.reset!
    $stderr = @old_stderr
    $stdout = @old_stdout
    $stdin  = @old_stdin
    FileUtils.rm_f File.expand_path(Octonaut.config_path)
  end
end

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.filter_sensitive_data("<<ACCESS_TOKEN>>") do
      ENV['OCTONAUT_TEST_TOKEN']
  end
  c.default_cassette_options = {
    :serialize_with             => :json,
    # TODO: Track down UTF-8 issue and remove
    :preserve_exact_body_bytes  => true,
    :decode_compressed_response => true,
    :record                     => ENV['TRAVIS'] ? :none : :once
  }
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end

def login
  ENV['OCTONAUT_TEST_LOGIN'] || 'api-padawan'
end

def token
  ENV['OCTONAUT_TEST_TOKEN']
end

def run_with_token(args = [])
  args.unshift '-u', login, '-p', token
  Octonaut.run args
end

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

def github_url(url)
  if url =~ /^http/
    url
  else
    "https://#{login}:#{token}@api.github.com#{url}"
  end
end

RSpec::Matchers.define :be_a_listing do |expected|
  match do |actual|
    actual.split("\n").length > 0
  end
  failure_message_for_should do |actual|
    "expected that #{actual} would be a listing"
  end
end

module MatchersHelpers
  def data_table(output)
    lines = actual.split("\n")
    data = lines.map {|l| l.gsub(/^\s{2,}/, '') }.
      map {|l| l.split(" ")}
    table = {}
    data.each {|k,v| table[k] = v}

    table
  end

  def is_table?(output)
    data_table(output).values.size > 1
  end
end

RSpec::Matchers.define :be_a_table do |expected|
  include MatchersHelpers
  match do |actual|
    is_table?(actual)
  end
  failure_message_for_should do |actual|
    "expected that \n#{actual} would be a data table"
  end
end
