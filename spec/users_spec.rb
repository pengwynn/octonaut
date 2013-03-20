require 'spec_helper'

describe Octonaut do

  context "users" do

    it "looks up users by login" do
      request = stub_get('/users/defunkt').
        to_return(json_response("user.json"))

      Octonaut.run %w(whois defunkt)

      expect(request).to have_been_made
      expect($stdout.string).to include("Chris Wanstrath")
    end

    it "gracefully handles bogus users" do
      request = stub_get('/users/defunktzzz').
        to_return(:status => 404)

      Octonaut.run %w(whois defunktzzz)

      expect(request).to have_been_made
      expect($stdout.string).to include("User or organization defunktzzz not found")
    end

  end

  context "listing followers" do

    it "should list followers for the current user" do
      request = stub_get("https://defunkt:il0veruby@api.github.com/users/defunkt/followers").
        to_return(json_response("users.json"))

      Octonaut.run %w(-l defunkt -p il0veruby followers)
      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('users.ls').read)
    end

    it "should list followers for a user" do
      request = stub_get("https://api.github.com/users/pengwynn/followers").
        to_return(json_response("users.json"))

      Octonaut.run %w(followers pengwynn)
      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('users.ls').read)
    end

  end

  context "listing following" do

    it "should list who the current users follows" do
      request = stub_get("https://defunkt:il0veruby@api.github.com/users/defunkt/following").
        to_return(json_response("users.json"))

      Octonaut.run %w(-l defunkt -p il0veruby following)
      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('users.ls').read)
    end

    it "should list followers for a user" do
      request = stub_get("https://api.github.com/users/pengwynn/following").
        to_return(json_response("users.json"))

      Octonaut.run %w(following pengwynn)
      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('users.ls').read)
    end

  end

  context "checking if a user follows another" do
    it "should check if the current user follows a user" do
      request = stub_get("https://defunkt:il0veruby@api.github.com/user/following/pengwynn").
        to_return(:status => 204)

      Octonaut.run %w(-l defunkt -p il0veruby follows pengwynn)
      expect(request).to have_been_made
      expect($stdout.string).to eq("Yes, defunkt follows pengwynn.\n")
    end
  end

  context "following users" do

    it "should follow users" do

      request = stub_put("https://defunkt:il0veruby@api.github.com/user/following/mojombo").
        to_return(:status => 204)

      request_two = stub_put("https://defunkt:il0veruby@api.github.com/user/following/joeyw").
        to_return(:status => 204)

      request_three = stub_put("https://defunkt:il0veruby@api.github.com/user/following/linus").
        to_return(:status => 204)

      Octonaut.run %w(-l defunkt -p il0veruby follow mojombo joeyw linus)
      expect(request).to have_been_made
      expect(request_two).to have_been_made
      expect(request_three).to have_been_made
      expect($stdout.string).to eq("Followed mojombo.\nFollowed joeyw.\nFollowed linus.\n")

    end

    it "should unfollow users" do

      request = stub_delete("https://defunkt:il0veruby@api.github.com/user/following/mojombo").
        to_return(:status => 204)

      request_two = stub_delete("https://defunkt:il0veruby@api.github.com/user/following/joeyw").
        to_return(:status => 204)

      request_three = stub_delete("https://defunkt:il0veruby@api.github.com/user/following/linus").
        to_return(:status => 204)

      Octonaut.run %w(-l defunkt -p il0veruby unfollow mojombo joeyw linus)
      expect(request).to have_been_made
      expect(request_two).to have_been_made
      expect(request_three).to have_been_made
      expect($stdout.string).to eq("Unfollowed mojombo.\nUnfollowed joeyw.\nUnfollowed linus.\n")

    end

  end
end

