module Octonaut

  desc "View README for repository"
  arg_name "repo"
  command :readme do |c|
    c.desc "Output format"
    c.flag [:f, :format]
    c.desc "Ref (branch name or commit SHA)"
    c.flag [:ref]
    c.action do |global,options,args|

      repo = args.shift
      raise ArgumentError.new "Repository required" if repo.nil?

      format = options[:f] || "raw"

      opts = {}
      opts[:ref] = options[:ref] if options[:ref]
      opts[:accept] = "application/vnd.github.#{format}"

      puts @client.readme repo, opts
    end

  end

end
