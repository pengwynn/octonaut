module Octonaut

  desc "List issues"
  arg_name "repository", :optional
  command :issues do |c|
    c.desc "assigned, created, mentioned, subscribed, all"
    c.default_value "all"
    c.flag :filter
    c.desc "open, closed"
    c.default_value "open"
    c.flag :state
    c.desc "created, updated, comments"
    c.default_value "created"
    c.flag :sort
    c.desc "asc, desc"
    c.default_value "desc"
    c.flag :direction
    c.desc "label"
    c.flag :labels
    c.desc "YYYY-MM-DDTHH:MM:SSZ"
    c.flag :since
    c.desc "organization"
    c.flag [:organization]
    c.action do |global,options,args|
      repo = args.shift

      ensure_authenticated("Authentication or repository required") if repo.nil?

      opts = supplied_flags(options)

      org = opts.delete('organization')
      case org
      when 'none'
        ls_issues @client.user_issues(opts), options
      when String
        ls_issues @client.org_issues(org, opts), options
      else
        ls_issues @client.list_issues(repo, opts), options
      end
    end
  end

  desc "View an issue"
  command :issue do |cmd|
    cmd.desc "Show issue"
    cmd.arg_name "repository issue-number"
    cmd.action do |global,options,args|
      repo = args.shift
      raise ArgumentError.new "repository required" if repo.nil?
      number = args.shift
      raise ArgumentError.new "issue number required" if number.nil?

      print_issue_detail @client.issue(repo, number)
    end
  end

  desc "Update an issue"
  arg_name "repository issue-number"
  command ["issue-update"] do |edit|
    edit.desc "Issue title"
    edit.flag :title
    edit.desc "Issue body"
    edit.flag :body
    edit.desc "GitHub username to assign"
    edit.flag :assignee
    edit.desc "open or closed"
    edit.flag :state, :must_match => /open|closed/
    edit.desc "Milestone number"
    edit.flag :milestone
    edit.desc "Issue labels"
    edit.flag :labels, :type => Array
    edit.action do |global,options,args|
      repo = args.shift
      raise ArgumentError.new "repository required" if repo.nil?
      number = args.shift
      raise ArgumentError.new "issue number required" if number.nil?

      opts = supplied_flags

      @client.update_issue repo, number, opts
    end
  end

  desc "Create an issue"
  arg_name "repository"
  command "issue-create" do |ci|
    ci.desc "Issue title"
    ci.flag :title
    ci.desc "Issue body"
    ci.flag :body
    ci.desc "GitHub username to assign"
    ci.flag :assignee
    ci.desc "open or closed"
    ci.flag :state, :must_match => /open|closed/
    ci.desc "Milestone number"
    ci.flag :milestone
    ci.desc "Issue labels"
    ci.flag :labels, :type => Array
    ci.action do |global,options,args|
      repo = args.shift
      raise ArgumentError.new "repository required" if repo.nil?

      opts = supplied_flags(options)
      title = opts.delete('title')
      raise ArgumentError.new "issue title required" if title.nil?
      body = opts.delete('body')
      raise ArgumentError.new "issue body required" if body.nil?

      issue = @client.create_issue repo, title, body, opts

      puts "Created #{repo} #{issue.number}"
    end
  end
end
