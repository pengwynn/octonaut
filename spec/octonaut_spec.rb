require 'spec_helper'

describe "octonaut" do
  it "finds plugins" do
    Octonaut.run %w(foo)

    expect($stdout.string).to include("bar")
  end

  xit "knows about .netrc info" do
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
    request = stub_get("https://api.github.com/user").
      with(:headers => { "Authorization" => "token 1234567890123456789012345678901234567890" }).
      to_return(json_response("user.json"))
    Octonaut.run %w(--access_token=1234567890123456789012345678901234567890 me)
    expect(request).to have_been_made
  end


  it "can store a token for later" do
    now = Time.now
    Time.stub(:now).and_return(now)

    request = stub_post("https://defunkt:il0veruby@api.github.com/authorizations").
      with(:body => {"scopes" => [], "note" => "Octonaut #{now}"}.to_json).
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

  it "correctly handles a 2FA response" do
    now = Time.now
    Time.stub(:now).and_return(now)

    request = stub_post("https://defunkt:il0veruby@api.github.com/authorizations").
      with(:body => {"scopes" => [], "note" => "Octonaut #{now}"}.to_json).
      to_return(:status => 401, :headers => {"X-GitHub-OTP" => "required; sms"})

    request = stub_post("https://defunkt:il0veruby@api.github.com/authorizations").
      with(:body => {"scopes" => [], "note" => "Octonaut #{now}"}.to_json,
        :headers => {"X-GitHub-OTP" => "123456"}).
      to_return(json_response("token.json"))

    HighLine.any_instance.should_receive(:ask).
      with("GitHub username:      ").
      and_return("defunkt")
    HighLine.any_instance.should_receive(:ask).
      with("Enter your password:  ").
      and_return("il0veruby")
    HighLine.any_instance.should_receive(:ask).
      with("Enter your 2FA token: ").
      and_return("123456")

    Octonaut.run %w(authorize)

    expect(request).to have_been_made
    info = YAML::load_file(Octonaut.config_path)
    expect(info['t']).to eq "e46e749d1c727ff18b7fa403e924e58407fd9ac7"
  end

  it "doesn't step on an existing config file" do
    now = Time.now
    Time.stub(:now).and_return(now)

    Octonaut.run %w(-u defunkt initconfig --force)
    info = YAML::load_file(Octonaut.config_path)
    expect(info['u']).to eq "defunkt"
    expect(info['t']).to be_nil

    request = stub_post("https://defunkt:il0veruby@api.github.com/authorizations").
      with(:body => {"scopes" => [], "note" => "Octonaut #{now}"}.to_json).
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

  context "initconfig" do
    it "can init a config file" do
      Octonaut.run %w(-t 123456 initconfig)
      info = YAML::load_file(Octonaut.config_path)
      expect(info['t']).to eq "123456"
    end
  end
end

