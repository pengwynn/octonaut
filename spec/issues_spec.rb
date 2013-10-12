require 'spec_helper'

describe "octonaut", :vcr do
  context "issues" do
    it "lists issues visible to the current user" do
      run_with_token %w(issues)
      output = $stdout.string
      expect(output).to be_a_listing
      assert_requested :get,
        github_url('/issues?filter=all&state=open')
    end

    it "filters issues" do
      run_with_token %w(issues --filter assigned --state closed)
      output = $stdout.string
      expect(output).to be_a_listing
      assert_requested :get,
        github_url('/issues?filter=assigned&state=closed')
    end

    it "lists issues visible to the current user, excluding organizations owned repositories" do
      run_with_token %w(issues --org none)
      output = $stdout.string
      expect(output).to be_a_listing
      assert_requested :get,
        github_url('/user/issues?filter=all&state=open')
    end

    it "lists issues visible to the current user across respositories for a given organization" do
      run_with_token %w(issues --org api-playground)
      output = $stdout.string
      expect(output).to be_a_listing
      assert_requested :get,
        github_url('/orgs/api-playground/issues?filter=all&state=open')
    end

    it "lists issues for a respository" do
      run_with_token %w(issues octokit/octokit.rb)
      output = $stdout.string
      expect(output).to be_a_listing
      assert_requested :get,
        github_url('/repos/octokit/octokit.rb/issues?filter=all&state=open')
    end

    describe "show", :vcr do
      it "displays a single issue for a repository" do
        run_with_token %w(issues show octokit/octokit.rb#1)
        output = $stdout.string
        expect(output).to be_a_table
        assert_requested :get,
          github_url('/repos/octokit/octokit.rb/issues/1')
      end
    end

    describe "create" do
      it "creates an issue"
    end

    describe "update" do
      it "updates an issue"
    end
  end
end
