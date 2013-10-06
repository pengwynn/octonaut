require 'spec_helper'

describe "octonaut", :vcr do
  context "repository" do
    it "displays repository information" do
      Octonaut.run %w(repo defunkt/dotjs)
      output = $stdout.string
      expect(output).to include("1336779")
      expect(output).to include("dotjs")
    end
  end

  context "languages" do
    it "displays languages for a repository" do
      Octonaut.run %w(languages pengwynn/dotfiles)
      output = $stdout.string
      expect(output).to be_a_table # TODO: assert headers
    end
  end

  context "repositories" do
    it "lists your repositories" do
      run_with_token %w(repos)
      output = $stdout.string
      expect(output).to be_a_listing
      expect(output).to include('api-padawan/test-create')
    end
  end

  context "collaborators" do 
    it "lists collaborators for a repository" do 
      Octonaut.run %w(collaborators pengwynn/dotfiles)
      output = $stdout.string
      expect(output).to be_a_listing
      expect(output).to include('pengwynn')
    end
  end
end
