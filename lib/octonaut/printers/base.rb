module Octonaut
  module Printers
    class Base

      def table(resource)
        data = resource.to_hash
        unless field_map.empty?
          data = data.select do |key, value|
            field_map.keys.include?(key.to_s)
          end
        end
        width = data.keys.map(&:length).max
        data.each { | key, value | puts table_row(key, value, width) }
      end

      def print(array, options = {})
        options[:csv] ? csv(array) : ls(array)
      end

      def csv(array, options = {})
        unless array.first.respond_to?(:to_hash)
          raise ArgumentError.new("array of hashes required")
        end

        fields  = field_map.empty? ?
                  fields_from_hash(array.first) :
                  field_map
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
        data = array.map(&:to_hash)

        field = ls_field || data.first.keys.first
        puts data.map {|item| item[field] }.join("\n")
      end

      def field_map; {} end

      def ls_field; end

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
