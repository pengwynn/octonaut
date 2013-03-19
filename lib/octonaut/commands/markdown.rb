require 'json'

module Octonaut

  desc "Convert markdown to HTML"
  arg_name 'string'
  command [:markdown, :md] do |c|
    MODE_OPTS = %w(gfm markdown)
    c.desc "Render markdown in plain 'markdown' or 'gfm'"
    c.default_value 'gfm'
    c.flag [:m, :mode]

    c.desc "The repository context for 'gfm' mode"
    c.flag [:c, :context]

    c.action do |global,options,args|
      raise ArgumentError.new "Valid mode options are #{MODE_OPTS.join(', ')}" unless MODE_OPTS.include? options[:mode]

      src  = args.shift
      src  = $stdin.gets if src.nil?
      opts = {}
      if mode = options.fetch(:mode, nil)
        opts[:mode] = mode
      end
      if context = options.fetch(:context, nil)
        opts[:context] = context
      end
      response = @client.markdown src, opts

      puts response
    end
  end
end
