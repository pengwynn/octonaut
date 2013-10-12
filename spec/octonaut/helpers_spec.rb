require 'spec_helper'

describe '.open_relation' do
  before do
    stub_get("https://api.github.com/users/defunkt").
      to_return(json_response("user.json"))
    @user = Octokit.user 'defunkt'
  end

  it 'grabs a relation off a resource' do
    Launchy.should_receive(:open).
      with("http://api.github.dev/users/defunkt")
    Octonaut.open_relation(@user, 'self')
  end

  it 'defaults to the :html relation' do
    Launchy.should_receive(:open).
      with("http://github.dev/defunkt")

    Octonaut.open_relation(@user)
  end
end
