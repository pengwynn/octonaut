require 'spec_helper'

describe "octonaut", :vcr do
  context "readme" do
    it "displays the src for a README" do
      Octonaut.run %w(readme pengwynn/octonaut)
      output = $stdout.string
      expect(output).to include('### Example usage')
    end

    it "displays a rendered README in HTML" do
      Octonaut.run %w(readme -f html pengwynn/octonaut)
      output = $stdout.string
      expect(output).to include('<p>Octonaut is inspired by')
    end

    it "renders a README on a ref" do
      Octonaut.run %w(readme -f html --ref master pengwynn/octonaut)
      output = $stdout.string
      expect(output).to include('<p>Octonaut is inspired by')
    end
  end

  context "contents", :vcr do
    it "gets contents of a file" do
      Octonaut.run %w(contents pengwynn/octonaut README.md)
      output = $stdout.string
      expect(output).to include('### Example usage')
    end

    it "gets an archive link" do
      url = "https://codeload.github.com/pengwynn/octonaut/legacy.zip/master"
      Octonaut.run %w(archive-link -f zip pengwynn/octonaut)
      expect($stdout.string).to eq(url)
    end
  end
end
