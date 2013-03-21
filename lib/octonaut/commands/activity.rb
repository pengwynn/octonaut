module Octonaut


  desc "List or check starred repositories for a user"
  arg_name 'login or repository', :optional
  command :starred do |c|

    c.desc "Sort repos by: created, updated"
    c.flag :sort

    c.desc "Sort direction: asc or desc"
    c.flag :direction

    c.action do |global,options,args|
      target = args.shift
      if target && target[/\//]
        user, repo = target.split("/")
        login = @client.login
      else
        login = target || @client.login
      end

      if repo
        # TODO: Fix this upstream to take a single arg
        result  = @client.starred?(user, repo) ? "" : "not "
        puts "#{login} has #{result}starred #{user}/#{repo}"
      elsif login.nil?
        puts "Please authenticate or provide a GitHub login"
      else
        opts = Octonaut.supplied_flags(options)
        ls_repos @client.starred(login, opts)
      end
    end

  end

  desc "Star a repository"
  arg_name 'repository'
  command :star do |c|
    c.action do |global,options,args|
      repo = args.shift
      raise ArgumentError.new "Repository required" if repo.nil?

      puts "Starred #{repo}" if @client.star(repo)
    end
  end

  desc "Unstar a repository"
  arg_name 'repository'
  command :unstar do |c|
    c.action do |global,options,args|
      repo = args.shift
      raise ArgumentError.new "Repository required" if repo.nil?

      puts "Unstarred #{repo}" if @client.unstar(repo)
    end
  end

  desc "List stargazers"
  arg_name 'repository'
  command :stargazers do |c|
    c.action do |global,options,args|
      repo = args.shift
      raise ArgumentError.new "Repository required" if repo.nil?

      ls_users @client.stargazers(repo)
    end
  end
end
