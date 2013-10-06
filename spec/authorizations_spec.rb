require 'spec_helper'

describe "octonaut" do
  context "tokens" do
    xit "lists tokens" do
      request = stub_get("https://defunkt:il0veruby@api.github.com/authorizations").
        to_return(json_response("tokens.json"))

      Octonaut.run %w(-u defunkt -p il0veruby tokens)
      expect($stdout.string).to eq(fixture('tokens.ls').read)
    end
  end

  context "scopes", :vcr do
    it "displays scopes for a token" do
      Octonaut.run %W(scopes #{token})
      expect($stdout.string).to include("repo, user")
    end
  end
end
