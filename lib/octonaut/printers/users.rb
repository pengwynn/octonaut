module Octonaut
  module Printers
    class Users < Base

      def field_map
        {
          "id"         => "ID",
          "login"      => "LOGIN",
          "name"       => "NAME",
          "company"    => "COMPANY",
          "location"   => "LOCATION",
          "followers"  => "FOLLOWERS",
          "following"  => "FOLLOWING",
          "hireable"   => "HIREABLE",
          "blog"       => "URL",
          "created_at" => "JOINED"
        }
      end

      def ls_field; :login end
    end
  end
end
