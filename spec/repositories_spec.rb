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

  context "repositories" do

    it "displays repository information" do
      request = stub_get('/repos/defunkt/dotjs').
        to_return(json_response("repository.json"))

      Octonaut.run %w(repo defunkt/dotjs)

      expect(request).to have_been_made
      expect($stdout.string).to include("1336779")
      expect($stdout.string).to include("dotjs")

    end

  end

end
