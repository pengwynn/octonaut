module Octonaut
  module Printers
    module Users

      USER_FIELDS = {
        "id"         => "ID",
        "created_at" => "JOINED",
        "login"      => "LOGIN",
        "name"       => "NAME",
        "company"    => "COMPANY",
        "location"   => "LOCATION",
        "followers"  => "FOLLOWERS",
        "following"  => "FOLLOWING",
        "hireable"   => "HIREABLE",
        "blog"       => "URL"
      }

      def print_user_table(user, options = {})
        data = {}
        USER_FIELDS.each do |field, heading|
          data[heading] = user[field]
        end

        print_table(data)
      end

      def print_users(users, options = {})
        options[:csv] ? print_csv_users(users) : ls_users(users)
      end

      def print_csv_users(users, options = {})
        options[:fields] = USER_FIELDS
        print_csv users, options
      end

      def ls_users(users, options = {})
        users.each {|u| puts u.login }
      end
    end
  end
end
