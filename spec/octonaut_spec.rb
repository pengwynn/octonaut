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
    before do
      FileUtils.rm_f Dir.glob(File.join(ENV['HOME'], '.octonaut'))
    end

    after do
      FileUtils.rm_f Dir.glob(File.join(ENV['HOME'], '.octonaut'))
    end

    it "works" do
      expect(true).to be_true
    end
  end

  context "when authenticating" do

    before do
      FileUtils.cp File.join('spec', 'fixtures', '.netrc'), File.join(ENV['HOME'])
    end

    it "knows about .netrc info" do
      stub_get("https://defunkt:il0veruby@api.github.com/user").
        to_return(json_response("user.json"))
      Octonaut.run %w(-n me)
      expect(a_get("https://defunkt:il0veruby@api.github.com/user")).to have_been_made
    end

  end

end

