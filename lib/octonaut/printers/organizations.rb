module Octonaut
  module Printers
    class Organizations < Users

      FIELDS = {
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
