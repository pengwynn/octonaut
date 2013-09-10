module Octonaut
  module Printers
    module Collaborators

      def print_collabs(collaborators, options = {})
        ls_collabs(collaborators)
      end

      def ls_collabs(collaborators, options = {})
        collaborators.each { |c| puts c.login }
      end

    end
  end
end
