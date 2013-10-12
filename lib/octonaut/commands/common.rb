module Octonaut
  desc 'Browse resource on github.com'
  arg_name 'name'
  command :browse do |c|
    c.action do |global,options,args|
      name = args.shift
      raise ArgumentError.new("Name required") if name.nil?

      owner, repo = name.split("/")
      if repo.nil?
        item = @client.user owner
      else
        item = @client.repo(name)
      end

      Octonaut.open_relation item
    end
  end
end
