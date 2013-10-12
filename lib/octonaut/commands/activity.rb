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
        login = target || (@client.user_authenticated? ? @client.login : nil)
      end

      if repo
        # TODO: Fix this upstream to take a single arg
        result  = @client.starred?(user, repo) ? "" : "not "
        puts "#{login} has #{result}starred #{user}/#{repo}"
      elsif login.nil?
        puts "Please authenticate or provide a GitHub login"
      else
        opts = Octonaut.supplied_flags(options)
        printer = Octonaut::Printers::Repositories.new
        printer.ls @client.starred(login, opts)
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

      printer = Octonaut::Printers::Users.new
      printer.ls @client.stargazers(repo)
    end
  end

  desc "Subscribe to a repository"
  arg_name "repository"
  command :subscribe do |c|
    c.desc "Ignore notifications"
    c.switch [:i, :ignored]
    c.action do |global,options,args|
      repo = args.shift
      raise ArgumentError.new "Repository required" if repo.nil?

      opts = Octonaut.supplied_flags(options).select {|k, v| k == 'ignored'}
      if @client.update_subscription(repo, opts)
        message = "Subscribed to #{repo}"
        message << " and ignored" if opts['ignored']
        puts message
      else
        puts "Could not subscribe to #{repo}"
      end
    end
  end

  desc "Unsubscribe to a repository"
  arg_name "repository"
  command :unsubscribe do |c|
    c.action do |global,options,args|
      repo = args.shift
      raise ArgumentError.new "Repository required" if repo.nil?

      if @client.delete_subscription(repo)
        puts "Unsubscribed to #{repo}"
      else
        puts "Could not unsubscribe to #{repo}"
      end
    end
  end

  desc "List subscribers for a repository"
  arg_name "repository"
  command :subscribers do |c|
    c.action do |global,options,args|
      repo = args.shift
      raise ArgumentError.new "Repository required" if repo.nil?

      printer = Octonaut::Printers::Users.new
      printer.ls @client.subscribers(repo)
    end
  end

  desc "List user repository subscriptions"
  arg_name "user", :optional
  command :subscriptions do |c|
    c.action do |global,options,args|
      user = args.shift || @client.login
      raise ArgumentError.new "User or authentication required" if user.nil?
      printer = Octonaut::Printers::Repositories.new
      printer.ls @client.subscriptions(user)
    end
  end

end
