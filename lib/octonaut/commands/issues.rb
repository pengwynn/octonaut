module Octonaut
  desc "Manage issues"
  command :issues do |c|
    c.default_command :ls

    c.desc "List issues"
    c.command [:ls, :list] do |list|
      list.arg_name "assigned, created, mentioned, subscribed, all"
      list.default_value "all"
      list.flag :filter
      list.arg_name "open, closed"
      list.default_value "open"
      list.flag :state
      list.arg_name "organization"
      list.flag [:organization]
      list.arg_name "repository", :optional
      list.action do |global,options,args|
        repo = args.shift
        ensure_authenticated("Authentication or repository required") if repo.nil?
        opts = Octonaut.flags_as_symbols(options)
        printer = Octonaut::Printers::Issues.new
        org = opts.delete(:organization)
        case org
        when 'none'
          printer.ls @client.user_issues(opts), opts
        when String
          printer.ls @client.org_issues(org, opts), opts
        else
          printer.ls @client.list_issues(repo, opts), opts
        end
      end
    end

    c.desc "Show issue"
    c.command [:show] do |show|
      show.arg_name ":owner/:repo#number"
      show.action do |global,options,args|
        info = Octonaut::Utils::REPO_ISSUE_REGEX.match(args.shift)
        opts = Octonaut.flags_as_symbols(options)

        printer = Octonaut::Printers::Issues.new
        printer.table \
          @client.issue(info[:repo], info[:number])
      end
    end
  end
end
