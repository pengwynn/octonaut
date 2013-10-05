require 'spec_helper'

describe "octonaut", :vcr do
  context "starred" do
    it "requires a username to list stars" do
      Octonaut.run %w(starred)
      expect($stdout.string).to eq("Please authenticate or provide a GitHub login\n")
    end

    it "lists your starred repositories" do
      run_with_token %w(starred)
      output = $stdout.string
      expect(output).to be_a_listing
      expect(output).to include("octokit/octokit.rb")
    end

    it "lists stars for a user" do
      Octonaut.run %w(starred pengwynn)
      output = $stdout.string
      expect(output).to be_a_listing
      expect(output).to include("sigmavirus24/betamax")
    end

    it "checks if you've starred a repository" do
      run_with_token %w(starred defunkt/dotjs)
      expect($stdout.string).to eq("api-padawan has starred defunkt/dotjs\n")
    end

    it "indicates a user has not starred a repo" do
      run_with_token %w(starred rails/rails)
      expect($stdout.string).to eq("api-padawan has not starred rails/rails\n")
    end
  end

  context "star" do
    it "stars a repository" do
      run_with_token %w(star defunkt/dotjs)
      expect($stdout.string).to eq("Starred defunkt/dotjs\n")
    end
  end

  context "unstar" do
    it "unstars a repository" do
      run_with_token %w(unstar defunkt/dotjs)
      expect($stdout.string).to eq("Unstarred defunkt/dotjs\n")
    end
  end

  context "stargazers" do
    it "lists stargazers for a repository" do
      Octonaut.run %w(stargazers defunkt/dotjs)
      output = $stdout.string
      expect(output).to be_a_listing
      expect(output).to include('defunkt')
    end
  end

  context "subscribe" do
    it "subscribes to a repository" do
      run_with_token %w(subscribe defunkt/dotjs)
      expect($stdout.string).to eq("Subscribed to defunkt/dotjs\n")
    end

    it "marks a subscription as ignored" do
      run_with_token %w(subscribe -i defunkt/dotjs)
      expect($stdout.string).to eq("Subscribed to defunkt/dotjs and ignored\n")
    end
  end

  context "unsubscribe" do
    it "unsubscribes to a repository" do
      run_with_token %w(unsubscribe defunkt/dotjs)
      expect($stdout.string).to eq("Unsubscribed to defunkt/dotjs\n")
    end
  end

  context "subscribers" do
    it "lists subscribers for a repository" do
      Octonaut.run %w(subscribers defunkt/dotjs)
      output = $stdout.string
      expect(output).to be_a_listing
      expect(output).to include('defunkt')
    end
  end

  context "subscriptions" do
    it "lists subscribed repositories" do
      run_with_token %w(subscriptions)
      output = $stdout.string
      expect(output).to be_a_listing
      expect(output).to include('pengwynn/api-sandbox')
    end
  end
end
