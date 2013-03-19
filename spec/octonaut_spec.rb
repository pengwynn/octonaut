require 'spec_helper'

describe Octonaut do

  before :each do
    @old_stderr = $stderr
    $stderr = StringIO.new
    @old_stdout = $stdout
    $stdout = StringIO.new
  end

  after :each do
    $stderr = @old_stderr
    $stdout = @old_stdout
  end

  context "with config files" do
    before do
      FileUtils.rm_f File.expand_path(Octonaut.config_path)
    end

    after do
      FileUtils.rm_f File.expand_path(Octonaut.config_path)
    end

    it "can init a config file" do
      Octonaut.run %w(-t 123456 initconfig)
      info = YAML::load_file(Octonaut.config_path)
      expect(info['t']).to eq "123456"
    end
  end

  context "plugins" do
    it "finds plugins" do
      Octonaut.run %w(foo)

      expect($stdout.string).to include("bar")
    end
  end

  context "when authenticating" do

    it "knows about .netrc info" do
      request = stub_get("https://defunkt:il0veruby@api.github.com/user").
        to_return(json_response("user.json"))
      Octonaut.run %w(--netrc-file tmp/fakehome/.netrc me)
      expect(request).to have_been_made
    end

    it "uses basic auth" do
      request = stub_get("https://pengwynn:m3tal@api.github.com/user").
        to_return(json_response("user.json"))
      Octonaut.run %w(--login=pengwynn --password=m3tal me)
      expect(request).to have_been_made
    end

    it "can use an OAuth token" do
      request = stub_get("https://pengwynn:m3tal@api.github.com/user").
        to_return(json_response("user.json"))
      Octonaut.run %w(--login=pengwynn --password=m3tal me)
      expect(request).to have_been_made
    end

    it "can use an OAuth token" do
      request = stub_get("https://api.github.com/user").
        with(:headers => { "Authorization" => "token 1234567890123456789012345678901234567890" }).
        to_return(json_response("user.json"))
      Octonaut.run %w(--oauth_token=1234567890123456789012345678901234567890 me)
      expect(request).to have_been_made
    end

  end

end

