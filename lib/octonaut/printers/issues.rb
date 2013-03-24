module Octonaut
  module Printers
    module Issues

      ISSUE_FIELDS = {
        "id"         => "ID",
        "title"      => "TITLE",
        "body"       => "BODY",
        "created_at" => "CREATED"
      }

      def print_issue_table(issue, options = {})
        data = {}
        ISSUE_FIELDS.each do |field, heading|
          data[heading] = issue[field]
        end

        print_table(data)
      end

      def print_issues(issues, options = {})
        options[:csv] ? print_csv_issues(issues) : ls_issues(issues)
      end

      def print_csv_issues(issues, options = {})
        options[:fields] = ISSUE_FIELDS
        print_csv issues, options
      end

      def ls_issues(issues, options = {})
        issues.each {|i| puts issue_row(i) }
      end

      def issue_row(issue, options = {})
        "#{issue.number}\t#{issue.title}"
      end
    end
  end
end
