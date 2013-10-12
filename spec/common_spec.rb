require 'spec_helper'

describe "browse", :vcr do
  it "opens a URL for a user" do
    Launchy.should_receive(:open).
      with("https://github.com/mojombo")
    run_with_token %w(browse mojombo)
  end

  it "opens a URL for a repository" do
    Launchy.should_receive(:open).
      with("https://github.com/octokit/octokit.rb")
    run_with_token %w(browse octokit/octokit.rb)
  end
end
