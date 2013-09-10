require 'spec_helper'

describe "octonaut" do

  context "repository" do

    it "displays repository information" do
      request = stub_get('/repos/defunkt/dotjs').
        to_return(json_response("repository.json"))

      Octonaut.run %w(repo defunkt/dotjs)

      expect(request).to have_been_made
      expect($stdout.string).to include("1336779")
      expect($stdout.string).to include("dotjs")

    end

  end

  context "languages" do

    it "displays languages for a repository" do
      request = stub_get('/repos/pengwynn/dotfiles/languages').
        to_return(json_response("languages.json"))

      Octonaut.run %w(languages pengwynn/dotfiles)
      expect(request).to have_been_made
      expect($stdout.string).to eq(fixture('languages.table').read)
    end

  end



  context "repositories" do

    it "lists your repositories" do
      request = stub_get("https://defunkt:il0veruby@api.github.com/user/repos").
        to_return(json_response("repositories.json"))

      Octonaut.run %w(-u defunkt -p il0veruby repos)
      expect(request).to have_been_made

      expect($stdout.string).to eq(fixture('repositories.ls').read)
    end

  end

  context "collaborators" do 

    it "lists collaborators for a repository" do 
      request = stub_get('/repos/pengwynn/dotfiles/collaborators').
        to_return(json_response("collaborators.json"))

      Octonaut.run %w(collaborators pengwynn/dotfiles)
      expect($stdout.string).to eq(fixture('collaborators.ls').read)

    end
  end
end
