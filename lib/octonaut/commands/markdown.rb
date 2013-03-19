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

      opts = options.select { |k,v| !v.nil? }
      response = @client.markdown args.shift, opts

      puts response
    end
  end
end
