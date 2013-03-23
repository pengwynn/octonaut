require 'spec_helper'

describe "octonaut" do

  context "readme" do

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

  end

  context "contents" do

    it "gets contents of a file" do
      request = stub_get("/repos/pengwynn/octonaut/contents/README.md").
        to_return(:headers => {"Content-Type" => "application/vnd.github.raw; charset=utf-8"},
                  :body => fixture("readme.src"))

      Octonaut.run %w(contents pengwynn/octonaut README.md)

      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('readme.src').read)
    end

    it "gets an archive link" do
      url = "https://nodeload.github.com/pengwynn/octonaut/legacy.zip/master"
      Octokit::Client.any_instance.should_receive(:archive_link).
        with("pengwynn/octonaut", :format => "zipball", :ref => "master").
        and_return(url)

      Octonaut.run %w(archive-link -f zip pengwynn/octonaut)
      expect($stdout.string).to eq(url)

    end

  end

end
