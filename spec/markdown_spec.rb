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

  end
end
