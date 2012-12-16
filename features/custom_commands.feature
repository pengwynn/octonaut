Feature: Custom commands
  In order to do special CLI tasks
  As an O user
  I want to specify custom O commands

  Scenario: App just runs
    When I get help for "o"
    Then the exit status should be 0

  Scenario: List custom commands
    Given I have a custom command in "~/custom.rb"
    """
    desc "Run something custom"
    command :custom do |c|
      c.action do |global,options,args|
        puts 'custom'
      end
    end
    """
    When I get help for "o"
    Then the output should contain "custom"
    And the output should contain "Run something custom"
