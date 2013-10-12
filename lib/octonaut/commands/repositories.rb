module Octonaut

  desc "Display details for a repository"
  arg_name 'name'
  command [:repo, :repository] do |c|
    c.action do |global,options,args|
      name = args.shift

      printer = Octonaut::Printers::Repositories.new
      printer.table @client.repo(name)
    end
  end

  desc "List repositories for a user or organization"
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

      printer = Octonaut::Printers::Repositories.new
      printer.ls @client.repositories(login, opts)
    end
  end

  desc "Display languages for a repo"
  arg_name "owner/repo"
  command [:langs, :languages] do |c|
    c.action do |global,options,args|
      name = args.shift

      printer = Octonaut::Printers::Base.new
      printer.table @client.languages(name)
    end
  end

  desc "Display collaborators for a repo"
  arg_name "owner/repo"
  command [:collabs, :collaborators] do |c|
    c.action do |globa, options, args|
      name = args.shift

      printer = Octonaut::Printers::Collaborators.new
      printer.print @client.collaborators(name)
    end
  end

end
