module Octonaut
  desc "View your profile"
  command :me do |c|
    c.action do |global,options,args|
      user = @client.user

      print_user user
    end
  end

  desc "View profile for a user"
  command [:user, :whois] do |c|
    c.action do |global,options,args|
      user = Octokit.user args.first

      print_user user
    end
  end

  command :search do |c|
    c.action do |global,options,args|
      puts global.merge(options).inspect
    end
  end

  command :followers do |c|

  end


  command :following do |c|

  end

  command :follows? do |c|

  end

  command :follow do |c|

  end

  command :unfollow do |c|

  end

end
