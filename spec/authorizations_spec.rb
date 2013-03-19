require 'spec_helper'

describe Octonaut do

  context "authorizations" do

    it "lists tokens" do
      request = stub_get("https://defunkt:il0veruby@api.github.com/authorizations").
        to_return(json_response("tokens.json"))

      Octonaut.run %w(-u defunkt -p il0veruby tokens)

      expect($stdout.string).to eq(fixture('tokens.ls').read)
    end

    it "displays scopes for a token" do

      request = stub_get("https://@api.github.com/user").
        with(:headers => {"Authorization" => "token e46e749d1c727ff18b7fa403e924e58407fd9ac7"}).
        to_return(json_response("user.json", {"X-OAuth-Scopes" => "repo, user"}))

      Octonaut.run %w(scopes e46e749d1c727ff18b7fa403e924e58407fd9ac7 )

      expect($stdout.string).to include("repo, user")

    end

    xit "creates a token" do
      request = stub_post("https://defunkt:il0veruby@api.github.com/authorizations").
        with(:body => {"scopes" => ["repo", "user"]}).
        to_return(json_response("token.json"))


      Octonaut.run %w(-u defunkt -p il0veruby tokens create -s repo user)
      expect($stdout.string).to include("e46e749d1c727ff18b7fa403e924e58407fd9ac7")
    end

    xit "updates a token" do

    end

    xit "deletes a token" do

    end
  end

end
