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

  desc "Get repository contents"
  arg_name "repo"
  arg_name "path"
  command :contents do |c|
    c.desc "Output format"
    c.flag [:f, :format]
    c.desc "Ref (branch name or commit SHA)"
    c.flag [:ref]
    c.action do |global,options,args|

      repo = args.shift
      raise ArgumentError.new "Repository required" if repo.nil?

      format = options[:f] || "raw"

      opts = {}
      opts[:ref]    = options[:ref] if options[:ref]
      opts[:path]   = args.shift
      opts[:accept] = "application/vnd.github.#{format}"

      puts @client.contents repo, opts
    end
  end

  desc "Get repository tarball or zipball archive URL"
  arg_name "repo"
  command :archive_link do |c|
    c.desc "Archive format"
    c.default_value "tar"
    c.flag [:f, :format]
    c.desc "Ref (branch name or commit SHA)"
    c.default_value "master"
    c.flag [:ref]
    c.action do |global,options,args|

      repo = args.shift
      raise ArgumentError.new "Repository required" if repo.nil?

      opts = {}
      opts[:format] = "#{options[:format]}ball"
      opts[:ref]    = options[:ref]
      print @client.archive_link repo, opts
    end
  end
end
