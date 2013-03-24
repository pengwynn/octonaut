require 'spec_helper'

describe "octonaut" do

  context "issues" do

    it "lists issues visible to the current user" do
      request = stub_get("https://defunkt:il0veruby@api.github.com/issues").
        to_return(json_response("issues.json"))

      Octonaut.run %w(-l defunkt -p il0veruby issues)
      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('issues.ls').read)
    end

    it "filters issues" do
      request = stub_get("https://defunkt:il0veruby@api.github.com/issues?filter=assigned&state=closed").
        to_return(json_response("issues.json"))

      Octonaut.run %w(-l defunkt -p il0veruby issues --filter assigned --state closed)
      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('issues.ls').read)
    end

    it "lists issues visible to the current user, excluding organizations owned repositories" do
      request = stub_get("https://defunkt:il0veruby@api.github.com/user/issues").
        to_return(json_response("issues.json"))

      Octonaut.run %w(-l defunkt -p il0veruby issues --org none)
      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('issues.ls').read)
    end

    it "lists issues visible to the current user across respositories for a given organization" do
      request = stub_get("https://defunkt:il0veruby@api.github.com/orgs/octokit/issues").
        to_return(json_response("issues.json"))

      Octonaut.run %w(-l defunkt -p il0veruby issues --org octokit)
      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('issues.ls').read)
    end

    it "lists issues for a respository" do
      request = stub_get("/repos/pengwynn/octokit/issues").
        to_return(json_response("issues.json"))

      Octonaut.run %w(issues pengwynn/octokit)
      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('issues.ls').read)
    end

  end

  context "issue" do

    xit "displays a single issue for a repository" do

    end

    xit "displays an issue in different output formats" do

    end

    xit "updates an issue" do

    end

    xit "creates an issue" do

    end

  end

end
