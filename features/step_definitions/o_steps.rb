When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end


Given /^I have a custom command in "(.*?)"$/ do |cmd_file, cmd_text|
  File.open(File.expand_path(cmd_file), 'w') { |f| f << cmd_text }
end
