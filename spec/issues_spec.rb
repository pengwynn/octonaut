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

    it "displays a single issue for a repository" do
      request = stub_get("/repos/pengwynn/octonaut/issues/1").
        to_return(json_response("issue.json"))

      Octonaut.run %w(issue pengwynn/octonaut 1)
      expect(request).to have_been_made
      expect(terminal_output).to eq(fixture('issue.detail').read)
    end

    it "updates an issue" do
      pending("Waiting on patch from Octokit")
      request = stub_patch("/repos/pengwynn/octonaut/issues/1").
        with(:body => {:title => "Can haz better executable name"}).
        to_return(json_response("issue.json"))

      Octonaut.run %w(issue --title 'Can haz better executable name' pengwynn/octonaut 1)
      expect(request).to have_been_made
      expect(terminal_output).to eq("Issue updated")
    end

  end

  context "issue-create" do

    it "creates an issue" do
      request = stub_post("/repos/pengwynn/octonaut/issues").
        with(:body => {:title => "Better executable name", :body => 'foobar baz'}).
        to_return(json_response("issue.json"))

      Octonaut.run [
        "issue-create",
        "--title",
        "Better executable name",
        "--body",
        "foobar baz",
        "pengwynn/octonaut"
      ]
      expect(request).to have_been_made
      expect(terminal_output).to eq("Created pengwynn/octonaut 1\n")
    end

  end

end
