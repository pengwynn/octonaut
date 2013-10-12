module Octonaut
  module Printers
    class Organizations < Users

      def field_map
        {
          "id"         => "ID",
          "created_at" => "JOINED",
          "login"      => "LOGIN",
          "name"       => "NAME",
          "location"   => "LOCATION",
          "blog"       => "URL"
        }
      end
    end
  end
end
