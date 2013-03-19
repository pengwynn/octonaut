module Octonaut

  desc "View README for repository"
  arg_name "repo"
  command :readme do |c|
    c.desc "Output format"
    c.flag [:f, :format]
    c.action do |global,options,args|

      repo = args.shift
      raise ArgumentError.new "Repository required" if repo.nil?

      format = options[:f] || "raw"

      opts = {}
      opts[:accept] = "application/vnd.github.#{format}"

      puts @client.readme repo, opts
    end

  end

end
