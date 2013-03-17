module Octonaut

  desc "Display details for a repository"
  arg_name 'name'
  command [:repo, :repository] do |c|
    c.action do |global,options,args|
      name = args.shift

      print_repo_table @client.repo(name)
    end
  end

  desc "Display details for a repository"
  arg_name 'login', :optional
  command [:repos, :repositories] do |c|
    c.desc "Filter repos by type: all, owner, member, public, private"
    c.flag :type

    c.desc "Sort repos by: created, updated, pushed, full_name"
    c.flag :sort

    c.desc "Sort direction: asc or desc"
    c.flag :direction

    c.action do |global,options,args|
      login = args.shift
      opts = options.select {|k,v| !v.nil? }

      ls_repos @client.repositories(login, opts)
    end
  end
end
