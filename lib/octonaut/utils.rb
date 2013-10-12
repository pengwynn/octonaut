module Octonaut
  module Utils

    REPO_ISSUE_REGEX = /^(?<repo>.*)#(?<number>\d+)$/

    def supplied_flags(options = {})
      options.dup.select {|k, v| k.is_a?(Symbol) }
    end

  end
end
