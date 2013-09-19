require 'spec_helper'

describe "octonaut" do
  context "markdown", :vcr do

    it "renders gfm markdown" do
      Octonaut.run ['markdown', 'pengwynn/octonaut#1']
      expect($stdout.string).to include("https://github.com/pengwynn/octonaut/issues/1")
    end

    it "renders plain markdown", :vcr do
      Octonaut.run ['markdown', '# Test #', '-m', 'markdown']
      expect($stdout.string).to include("Test</h1>")
    end

    it "takes input from STDIN" do
      $stdin.should_receive(:gets).and_return("*foo*")
      Octonaut.run ['markdown']
      expect($stdout.string).to include("<em>foo</em>")
    end

  end
end
