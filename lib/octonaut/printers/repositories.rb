module Octonaut
  module Printers
    class Repositories < Base

      def field_map
        {
          "id"             => "ID",
          "name"           => "NAME",
          "full_name"      => "FULL NAME",
          "description"    => "DESCRIPTION",
          "default_branch" => "DEFAULT BRANCH",
          "homepage"       => "HOMEPAGE",
          "language"       => "PRIMARY LANGUAGE",
          "open_issues"    => "OPEN ISSUES",
          "fork"           => "FORK",
          "forks_count"    => "FORKS",
          "watchers"       => "STARS",
          "private"        => "PRIVATE",
          "has_downloads"  => "DOWNLOADS ENABLED",
          "has_issues"     => "ISSUES ENABLED",
          "has_wiki"       => "WIKI ENABLED",
          "created_at"     => "CREATED",
          "pushed_at"      => "LAST PUSH",
          "updated_at"     => "UPDATED"
        }
      end

      def ls_field; :full_name end

    end
  end
end
