require 'spec_helper'

describe Octonaut do

  before :each do
    @old_stderr = $stderr
    $stderr = StringIO.new
    @old_stdout = $stdout
    $stdout = StringIO.new
  end

  after :each do
    $stderr = @old_stderr
    $stdout = @old_stdout
  end

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
      expect($stdout.string).to include("User defunktzzz not found")
    end

  end

  context "listing followers" do

    it "should list followers for the current user" do
      request = stub_get("https://defunkt:il0veruby@api.github.com/user/followers").
        to_return(json_response("users.json"))

      Octonaut.run %w(-l=defunkt -u=il0veruby followers)
      expect(request).to have_been_made
      expect($stdout.string).to eq <<-EOS
anyer
birgita
Sakirk
shilezi
zhuyinan
Sup3rgnu
tokuda109
robot9
bcachet
turboho
luoyangylh
rmmillar86
yekowele
ksauzz
tsnow
ziyasal
jessebikman
svallory
srned
rafaelsachetto
cslew
igoogle1990
johnnywell
yoshi10321
matthewmspencer
showaid
eranb
mzararagoza
douglascamata
jnewland
      EOS
    end

  end
end

