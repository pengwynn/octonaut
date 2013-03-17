module Octonaut
  desc "View your profile"
  command :me do |c|
    c.action do |global,options,args|
      user = @client.user
      print_user_table user
    end
  end

  desc "View profile for a user"
  arg_name 'login'
  command [:user, :whois] do |c|
    c.action do |global,options,args|
      login = args.shift
      begin
        user = @client.user login
        print_user_table user
      rescue Octokit::NotFound
        puts "User #{login} not found"
      end
    end
  end

  desc "View followers for a user"
  arg_name 'login', :optional
  command :followers do |c|
    c.action do |global,options,args|
      login = args.shift || @client.login
      print_users @client.followers(login), options
    end
  end

  command :following do |c|

  end

  command :follows do |c|

  end

  command :follow do |c|

  end

  command :unfollow do |c|

  end

end
