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

  end
end
