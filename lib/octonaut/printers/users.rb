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

      def list_users(users, options = {})
        options[:csv] ? csv_users(users) : ls_users(users)
      end

      def csv_users(users, options = {})
        puts USER_FIELDS.values.to_csv
      end

      def ls_users(users, options = {})
        users.each {|u| puts u.login }
      end
    end
  end
end
