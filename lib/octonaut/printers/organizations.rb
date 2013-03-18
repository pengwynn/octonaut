module Octonaut
  module Printers
    module Organizations

      ORG_FIELDS = {
        "id"         => "ID",
        "created_at" => "JOINED",
        "login"      => "LOGIN",
        "name"       => "NAME",
        "location"   => "LOCATION",
        "blog"       => "URL"
      }

      def print_org_table(org, options = {})
        data = {}
        ORG_FIELDS.each do |field, heading|
          data[heading] = org[field]
        end

        print_table(data)
      end

      def print_orgs(orgs, options = {})
        options[:csv] ? print_csv_orgs(orgs) : ls_orgs(orgs)
      end

      def print_csv_orgs(orgs, options = {})
        options[:fields] = ORG_FIELDS
        print_csv orgs, options
      end

      def ls_orgs(orgs, options = {})
        orgs.each {|o| puts o.login }
      end
    end
  end
end
