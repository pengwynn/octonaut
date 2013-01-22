module Octonaut
  command :me do |c|
    c.action do |global,options,args|
      data = @client.user

      data.each { | key, value | puts "#{key.rjust(data.keys.map(&:length).max)} #{value}" }
    end
  end

  command [:user, :whois] do |c|
    c.action do |global,options,args|
      data = Octokit.user args.first

      data.each { | key, value | puts "#{key.rjust(data.keys.map(&:length).max)} #{value}" }
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
