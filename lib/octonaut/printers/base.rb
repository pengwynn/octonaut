module Octonaut
  module Printers
    class Base

      def table(resource)
        data = resource.to_hash
        width = data.keys.map(&:length).max
        data.each { | key, value | puts table_row(key, value, width) }
      end

      def csv(array, options = {})
        unless array.first.respond_to?(:to_hash)
          raise ArgumentError.new("array of hashes required") 
        end

        fields  = FIELDS if defined?(FIELDS)
        fields  ||= fields_from_hash(array.first)
        headers = fields.values
        keys    = fields.keys

        puts headers.to_csv

        array.each do |item|
          data = []
          keys.each {|key| data << item[key] }
          puts data.to_csv
        end
      end

      def ls(array, options = {})
        unless array.first.respond_to?(:to_hash)
          raise ArgumentError.new("array of hashes required") 
        end

        field = defined?(LS_FIELD) ? LS_FIELD : array.first.keys.first
        puts array.map {|item| item[field] }.join("\n")
      end

      private

      def table_row(header, data, header_width)
        "#{header.to_s.upcase.rjust(header_width)} #{data}"
      end

      def fields_from_hash(hash)
        hash.keys.each_with_object({}) {|key, obj| obj[key] = key.to_s.upcase }
      end

    end
  end
end
