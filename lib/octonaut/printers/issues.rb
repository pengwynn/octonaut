module Octonaut
  module Printers
    class Issues < Base

      def field_map
        {
          "id"         => "ID",
          "title"      => "TITLE",
          "body"       => "BODY",
          "created_at" => "CREATED"
        }
      end

      def ls(issues, options = {})
        issues.each {|i| puts issue_row(i) }
      end

      private

      def issue_row(issue, options = {})
        "#{issue.number}\t#{issue.title}"
      end
    end
  end
end
