require 'spec_helper'

describe Octonaut do

  context "stars" do

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

    it "requires a username to list stars" do
      request = stub_get("https://api.github.com/users/pengwynn/starred").
        to_return(json_response("starred.json"))

        Octonaut.run %w(starred)
        expect(request).to have_not_been_made

        expect($stdout.string).to eq("Please authenticate or provide a GitHub login\n")
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

    xit "subscribes to a repository" do

    end

    xit "unsubscribes to a repository" do

    end

    xit "lists subscriptions for a repository" do

    end

  end

end
