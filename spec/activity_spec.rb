require 'spec_helper'

describe Octonaut do

  context "stars" do

    it "requires a username to list stars" do
      request = stub_get("https://api.github.com/users/pengwynn/starred").
        to_return(json_response("starred.json"))

      Octonaut.run %w(starred)
      expect(request).to have_not_been_made

      expect($stdout.string).to eq("Please authenticate or provide a GitHub login\n")
    end


    it "lists your starred repositories" do
      request = stub_get("https://defunkt:il0veruby@api.github.com/users/defunkt/starred").
        to_return(json_response("starred.json"))


      Octonaut.run %w(-u defunkt -p il0veruby starred)
      expect(request).to have_been_made

      expect($stdout.string).to eq(fixture('starred.ls').read)
    end

    it "lists stars for a user" do
      request = stub_get("https://api.github.com/users/pengwynn/starred").
        to_return(json_response("starred.json"))


      Octonaut.run %w(starred pengwynn)
      expect(request).to have_been_made

      expect($stdout.string).to eq(fixture('starred.ls').read)
    end

    it "stars a repository" do
      request = stub_put("https://defunkt:il0veruby@api.github.com/user/starred/defunkt/dotjs").
        to_return(:status => 204)

      Octonaut.run %w(-u defunkt -p il0veruby star defunkt/dotjs)
      expect(request).to have_been_made

      expect($stdout.string).to eq("Starred defunkt/dotjs\n")
    end

    it "unstars a repository" do
      request = stub_delete("https://defunkt:il0veruby@api.github.com/user/starred/defunkt/dotjs").
        to_return(:status => 204)

      Octonaut.run %w(-u defunkt -p il0veruby unstar defunkt/dotjs)
      expect(request).to have_been_made

      expect($stdout.string).to eq("Unstarred defunkt/dotjs\n")
    end

    it "checks if you've starred a repository" do
      request = stub_get("https://defunkt:il0veruby@api.github.com/user/starred/defunkt/dotjs").
        to_return(:status => 204)

      Octonaut.run %w(-u defunkt -p il0veruby starred defunkt/dotjs)
      expect(request).to have_been_made

      expect($stdout.string).to eq("defunkt has starred defunkt/dotjs\n")
    end

    it "indicates a user has not starred a repo" do
      request = stub_get("https://defunkt:il0veruby@api.github.com/user/starred/defunkt/dotjs").
        to_return(:status => 404)

      Octonaut.run %w(-u defunkt -p il0veruby starred defunkt/dotjs)
      expect(request).to have_been_made

      expect($stdout.string).to eq("defunkt has not starred defunkt/dotjs\n")
    end

    it "lists stargazers for a repository" do
      request = stub_get("/repos/defunkt/dotjs/stargazers").
        to_return(json_response("users.json"))

      Octonaut.run %w(stargazers defunkt/dotjs)

      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('users.ls').read)
    end

  end

  context "subscriptions" do

    it "subscribes to a repository" do
      request = stub_put("https://defunkt:il0veruby@api.github.com/repos/defunkt/dotjs/subscription").
        to_return(:status => 204)

      Octonaut.run %w(-u defunkt -p il0veruby subscribe defunkt/dotjs)
      expect(request).to have_been_made
      expect($stdout.string).to eq("Subscribed to defunkt/dotjs\n")
    end

    it "marks a subscription as ignored" do
      request = stub_put("https://defunkt:il0veruby@api.github.com/repos/defunkt/dotjs/subscription").
        with(:body => {:ignored => true}).
        to_return(:status => 204)

      Octonaut.run %w(-u defunkt -p il0veruby subscribe -i defunkt/dotjs)
      expect(request).to have_been_made
      expect($stdout.string).to eq("Subscribed to defunkt/dotjs and ignored\n")
    end

    it "unsubscribes to a repository" do
      request = stub_delete("https://defunkt:il0veruby@api.github.com/repos/defunkt/dotjs/subscription").
        to_return(:status => 204)

      Octonaut.run %w(-u defunkt -p il0veruby unsubscribe defunkt/dotjs)
      expect(request).to have_been_made
      expect($stdout.string).to eq("Unsubscribed to defunkt/dotjs\n")
    end

    it "lists subscribers for a repository" do
      request = stub_get("https://api.github.com/repos/defunkt/dotjs/subscribers").
        to_return(json_response("subscribers.json"))

      Octonaut.run %w(subscribers defunkt/dotjs)
      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('subscribers.ls').read)
    end

    it "lists subscribed repositories" do
      request = stub_get("https://defunkt:il0veruby@api.github.com/users/defunkt/subscriptions").
        to_return(json_response("repositories.json"))

      Octonaut.run %w(-u defunkt -p il0veruby subscriptions)
      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('repositories.ls').read)
    end

  end

end
