module Octonaut
  module Printer

    USER_FIELDS = %w(id login name company location followers hireable)

    def print_user(user)
      data = {}
      USER_FIELDS.each {|f| data[f] = user[f] }

      print_table(data)
    end

    def print_table(data)
      data.each { | key, value | puts "#{key.rjust(data.keys.map(&:length).max)} #{value}" }
    end

  end
end
