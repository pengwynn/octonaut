module Octonaut
  module Printers
    class Authorizations < Base

      def ls(authorizations, options = {})
        authorizations.each {|a| puts "#{a.token}   #{a.scopes.join(',')}   #{a.app.name}" }
      end
    end
  end
end
