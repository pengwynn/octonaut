require 'octonaut/printers/users'

module Octonaut
  module Printer
    include Octonaut::Printers::Users

    def print_table(data)
      data.each { | key, value | puts "#{key.rjust(data.keys.map(&:length).max)} #{value}" }
    end

  end
end
