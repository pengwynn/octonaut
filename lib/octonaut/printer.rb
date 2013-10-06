require 'octonaut/printers/authorizations'
require 'octonaut/printers/organizations'
require 'octonaut/printers/users'
require 'octonaut/printers/repositories'
require 'octonaut/printers/collaborators'

module Octonaut
  module Printer
    include Octonaut::Printers::Authorizations
    include Octonaut::Printers::Repositories
    include Octonaut::Printers::Users
    include Octonaut::Printers::Collaborators

    def print_table(resource)
      data = resource.to_hash
      data.each { | key, value | puts "#{key.to_s.rjust(data.keys.map{|key| key.to_s.length}.max)} #{value}" }
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
