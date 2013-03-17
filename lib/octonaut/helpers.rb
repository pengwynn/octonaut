module Octonaut
  module Helpers

    def open(resource, relation = 'self')
      link_field = case relation
                   when 'self'
                     'url'
                   when /_url$/
                     relation
                   else
                     "#{relation}_url"
                   end

      url = resource.send(link_field.to_sym)

      Launchy.open url
    end

  end
end
