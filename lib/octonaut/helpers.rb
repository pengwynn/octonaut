module Octonaut
  module Helpers

    def open_relation(resource, relation = 'html')
      url = resource.rels[relation.to_sym].href
      open url
    end

    def open(url)
      Launchy.open url
    end
  end
end
