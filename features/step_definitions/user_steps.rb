Given /^a user "(.*?)"$/ do |username|
  Octokit.should_receive(:user).
    with(username).
    and_return(json_fixture("#{username}.json"))
end
