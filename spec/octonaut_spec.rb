require 'spec_helper'

describe Octonaut do

  before :each do
    @old_stderr = $stderr
    $stderr = StringIO.new
    @old_stdout = $stdout
    $stdout = StringIO.new

    FileUtils.rm_f File.expand_path(Octonaut.config_path)
  end

  after :each do
    $stderr = @old_stderr
    $stdout = @old_stdout

    FileUtils.rm_f File.expand_path(Octonaut.config_path)
  end

  context "with config files" do
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

    context "when authorizing" do

      it "can store a token for later" do
        request = stub_post("https://defunkt:il0veruby@api.github.com/authorizations").
          with(:body => {"scopes" => []}).
          to_return(json_response("token.json"))

        HighLine.any_instance.should_receive(:ask).
          with("GitHub username:      ").
          and_return("defunkt")
        HighLine.any_instance.should_receive(:ask).
          with("Enter your password:  ").
          and_return("il0veruby")

        Octonaut.run %w(authorize)

        expect(request).to have_been_made
        info = YAML::load_file(Octonaut.config_path)
        expect(info['t']).to eq "e46e749d1c727ff18b7fa403e924e58407fd9ac7"
      end

      it "doesn't step on an existing config file" do
        Octonaut.run %w(-u defunkt initconfig --force)
        info = YAML::load_file(Octonaut.config_path)
        expect(info['u']).to eq "defunkt"
        expect(info['t']).to be_nil

        request = stub_post("https://defunkt:il0veruby@api.github.com/authorizations").
          with(:body => {"scopes" => []}).
          to_return(json_response("token.json"))

        HighLine.any_instance.should_receive(:ask).
          with("GitHub username:      ").
          and_return("defunkt")
        HighLine.any_instance.should_receive(:ask).
          with("Enter your password:  ").
          and_return("il0veruby")

        Octonaut.run %w(authorize)

        expect(request).to have_been_made
        info = YAML::load_file(Octonaut.config_path)
        expect(info[:t]).to eq "e46e749d1c727ff18b7fa403e924e58407fd9ac7"
        expect(info['u']).to eq "defunkt"
      end

    end

  end

end

