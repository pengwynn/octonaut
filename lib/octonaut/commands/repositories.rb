module Octonaut

  command [:repo, :repository] do |c|
    c.default_command :show

    c.command :show do |show|
      show.action do |global,options,args|
        puts "#{show.name} #{args.first}"
      end
    end

    c.command :browse do |browse|
      browse.action do |global,options,args|
        puts "#{browse.name} #{args.first}"
      end
    end

  end
end
