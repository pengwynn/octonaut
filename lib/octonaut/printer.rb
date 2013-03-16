module Octonaut
  module Printer

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

    def print_user(user)
      data = {}
      USER_FIELDS.each do |field, heading|
        data[heading] = user[field]
      end

      print_table(data)
    end

    def list_users(users, options)
      if options[:csv]
        puts USER_FIELDS.values.to_csv
      else
        puts users.map(&:login) * "\n"
      end
    end

    def print_table(data)
      data.each { | key, value | puts "#{key.rjust(data.keys.map(&:length).max)} #{value}" }
    end


  end
end
