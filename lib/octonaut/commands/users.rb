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

  desc "View who a user is following"
  arg_name 'login', :optional
  command :following do |c|
    c.action do |global,options,args|
      login = args.shift || @client.login
      print_users @client.following(login), options
    end
  end

  desc "Check to see if a user follows another"
  arg_name 'target'
  command :follows do |c|
    c.action do |global,options,args|
      target = args.shift
      message = if @client.follows?(target)
        "Yes, #{@client.login} follows #{target}."
      else
        "No, #{@client.login} does not follow #{target}."
      end

      puts message
    end
  end

  desc "Follow a user"
  arg_name 'target', :multiple
  command :follow do |c|
    c.action do |global,options,args|
      targets = args
      targets.each {|t| follow_user(t) }
    end
  end

  desc "Unfollow a user"
  arg_name 'target', :multiple
  command :unfollow do |c|
    c.action do |global,options,args|
      targets = args
      targets.each {|t| unfollow_user(t) }
    end
  end

  def self.follow_user(target)
    puts "Followed #{target}." if @client.follow(target)
  end

  def self.unfollow_user(target)
    puts "Unfollowed #{target}." if @client.unfollow(target)
  end

end
