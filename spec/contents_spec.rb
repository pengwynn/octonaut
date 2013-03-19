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

    it "renders a README on a ref" do
      Octokit::Client.any_instance.should_receive(:readme).
        with("pengwynn/octonaut", :ref => "some-branch", :accept => "application/vnd.github.html")

      Octonaut.run %w(readme -f html --ref some-branch pengwynn/octonaut)
    end

    xit "renders a directory tree of repository contents" do
      # need more smarts in Octokit for this
    end

    it "gets contents of a file" do
      request = stub_get("/repos/pengwynn/octonaut/contents/README.md").
        to_return(:headers => {"Content-Type" => "application/vnd.github.raw; charset=utf-8"},
                  :body => fixture("readme.src"))

      Octonaut.run %w(contents pengwynn/octonaut README.md)

      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('readme.src').read)
    end

    xit "gets an archive link" do

    end

  end

end
