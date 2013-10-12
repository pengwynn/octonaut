require 'spec_helper'

describe "octonaut", :vcr do
  context "whois" do
    it "looks up users by login" do
      run_with_token %w(whois defunkt)
      output = $stdout.string
      expect(output).to be_a_table
      expect(output).to include("Chris Wanstrath")
    end
    it "gracefully handles bogus users" do
      request = stub_get('/users/defunktzzz').
        to_return(:status => 404)
      run_with_token %w(whois defunktzzz)
      expect(request).to have_been_made
      expect($stdout.string).to include("User or organization defunktzzz not found")
    end
  end

  context "user" do
    it "it updates a user profile" do
      run_with_token %w(user update --email wynn.netherland+api-padawan@gmail.com)
      output = $stdout.string
      expect(output).to include("User profile updated")
    end
  end

  context "followers" do
    it "lists followers for the current user" do
      run_with_token %w(followers)
      output = $stdout.string
      expect(output).to be_a_listing
      expect(output).to include('dennisreimann')
    end

    it "lists followers for a user" do
      run_with_token %w(followers pengwynn)
      output = $stdout.string
      expect(output).to be_a_listing
      expect(output).to include('defunkt')
    end
  end

  context "following" do
    it "lists who the current users follows" do
      run_with_token %w(following)
      output = $stdout.string
      expect(output).to be_a_listing
      expect(output).to include('pengwynn')
    end

    it "lists users a user follows" do
      run_with_token %w(following pengwynn)
      output = $stdout.string
      expect(output).to be_a_listing
      expect(output).to include('mojombo')
    end
  end

  context "follows" do
    it "checks if the current user follows a user" do
      run_with_token %w(follows pengwynn)
      expect($stdout.string).to eq("Yes, api-padawan follows pengwynn.\n")
    end
  end

  context "follow" do
    it "follows users" do
      run_with_token %w(follow mojombo fakeatmos linus)
      expect($stdout.string).to eq("Followed mojombo.\nFollowed fakeatmos.\nFollowed linus.\n")
    end
  end

  context "unfollow" do
    it "unfollows users" do
      run_with_token %w(unfollow mojombo joeyw linus)
      expect($stdout.string).to eq("Unfollowed mojombo.\nUnfollowed joeyw.\nUnfollowed linus.\n")
    end
  end
end

