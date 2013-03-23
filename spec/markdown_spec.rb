require 'spec_helper'

describe "octonaut" do

  context "markdown" do

    it "renders gfm markdown" do
      request = stub_post('/markdown').
        to_return(:body => fixture('gfm.html'))

      Octonaut.run ['markdown', '# Test #']
      expect(request).to have_been_made
    end

    it "renders plain markdown" do
      request = stub_post('/markdown').
        to_return(:body => fixture('markdown.html').read)

      Octonaut.run ['markdown', '# Test #', '-m', 'markdown']
      expect(request).to have_been_made
    end

    it "takes input from STDIN" do

      $stdin.should_receive(:gets).and_return("*foo*")
      Octokit::Client.any_instance.
        should_receive(:markdown).
        with("*foo*", {:mode => "gfm"})

      Octonaut.run ['markdown']

    end

  end
end
