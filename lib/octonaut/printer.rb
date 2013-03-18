require 'octonaut/printers/organizations'
require 'octonaut/printers/users'
require 'octonaut/printers/repositories'

module Octonaut
  module Printer
    include Octonaut::Printers::Users
    include Octonaut::Printers::Repositories

    def print_table(data)
      data.each { | key, value | puts "#{key.rjust(data.keys.map(&:length).max)} #{value}" }
    end

    def print_csv(array, options = {})
      raise ArgumentError.new("array of hashes required") unless array.first.kind_of?(Hash)
      fields  = options[:fields]
      headers = fields.values
      keys    = fields.keys

      puts headers.to_csv

      array.each do |item|
        data = []
        keys.each {|key| data << item[key] }
        puts item.inspect
        puts data
      end
    end

  end
end
