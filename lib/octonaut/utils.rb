module Octonaut
  module Utils

    REPO_ISSUE_REGEX = /^(?<repo>.*)#(?<number>\d+)$/

    def flags_as_symbols(options = {})
      options.dup.select {|k, v| k.is_a?(Symbol) }
    end


    def fetch_options(options, *keys)
      flags_as_symbols(options).select do |key, value|
        keys.include?(key)
      end
    end
  end
end
