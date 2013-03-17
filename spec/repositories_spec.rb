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

    context "listing repositories" do

      it "lists your repositories" do
        request = stub_get("https://defunkt:il0veruby@api.github.com/user/repos").
          to_return(json_response("repositories.json"))

        Octonaut.run %w(-u defunkt -p il0veruby repos)
        expect(request).to have_been_made

        expect($stdout.string).to eq(fixture('repositories.ls').read)
      end

    end

  end

end
