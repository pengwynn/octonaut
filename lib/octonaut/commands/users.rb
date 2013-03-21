module Octonaut
  desc "View your profile"
  command :me do |c|
    c.action do |global,options,args|
      user = @client.user
      print_user_table user
    end
  end

  desc 'Manage users'
  command [:user, :whois] do |c|
    c.default_command :show
    c.desc "View a user profile"
    c.arg_name 'login'
    c.command :show do |show|
      show.action do |global,options,args|
        login = args.shift
        begin
          user = @client.user login
          case user['type']
          when 'Organization'
            print_org_table user
          else
            print_user_table user
          end
        rescue Octokit::NotFound
          puts "User or organization #{login} not found"
        end
      end
    end

    c.desc "Update a user profile"
    c.command :update do |update|

      update.arg_name "Name", :optional
      update.flag :name
      update.arg_name "Email", :optional
      update.flag :email
      update.arg_name "Blog", :optional
      update.flag :blog
      update.arg_name "Company", :optional
      update.flag :company
      update.arg_name "Location", :optional
      update.flag :location
      update.arg_name "Hireable", :optional
      update.switch :hireable
      update.action do |global,options,args|
        opts = Octonaut.supplied_flags(options)
        if @client.update_user(opts)
          puts "User profile updated"
        end
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
