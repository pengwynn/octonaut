require 'spec_helper'

describe Octonaut do

  context "contents" do

    it "displays the src for a README" do
      request = stub_get("/repos/pengwynn/octonaut/readme").
        to_return(:headers => {"Content-Type" => "application/vnd.github.raw; charset=utf-8"},
                  :body => fixture("readme.src"))

      Octonaut.run %w(readme pengwynn/octonaut)

      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('readme.src').read)
    end

    it "displays a rendered README in HTML" do
      request = stub_get("/repos/pengwynn/octonaut/readme").
        to_return(:headers => {"Content-Type" => "application/vnd.github.html; charset=utf-8"},
                  :body => fixture("readme.html"))

      Octonaut.run %w(readme -f html pengwynn/octonaut)

      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('readme.html').read)
    end

    xit "renders a directory tree of repository contents" do

    end

    xit "gets text content of a file" do

    end

    xit "gets a binary file" do

    end

    xit "gets an archive link" do

    end

  end

end
