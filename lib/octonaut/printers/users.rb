module Octonaut
  module Printers
    class Users < Base

      USER_FIELDS = {
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

      LS_FIELD = :login
    end
  end
end
