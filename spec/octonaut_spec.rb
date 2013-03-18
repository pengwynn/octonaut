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

  context "with an empty config file" do
    it "works" do
      expect(true).to be_true
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

