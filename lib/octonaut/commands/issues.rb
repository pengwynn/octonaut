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
        opts = Octonaut.supplied_flags(options)
        printer = Octonaut::Printers::Issues.new
        org = opts.delete(:organization)
        case org
        when 'none'
          printer.ls @client.user_issues(opts), options
        when String
          printer.ls @client.org_issues(org, opts), options
        else
          printer.ls @client.list_issues(repo, opts), options
        end
      end
    end
  end
end
