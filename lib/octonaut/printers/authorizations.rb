module Octonaut
  module Printers
    module Authorizations

      def ls_authorizations(authorizations, options = {})
        authorizations.each {|a| puts "#{a.token}   #{a.scopes.join(',')}   #{a.app.name}" }
      end
      alias_method :ls_tokens, :ls_authorizations
    end
  end
end
