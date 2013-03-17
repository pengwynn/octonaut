module Octonaut
  module Printers
    module Repositories

      REPOSITORY_FIELDS = {
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

      def print_repo_table(repo, options = {})
        data = {}
        REPOSITORY_FIELDS.each do |field, heading|
          data[heading] = repo[field]
        end

        print_table(data)
      end

      def print_repos(repos, options = {})
        options[:csv] ? print_csv_repos(repos) : ls_repos(repos)
      end

      def print_csv_repos(repos, options = {})
        options[:fields] = REPOSITORY_FIELDS
        print_csv repos, options
      end

      def ls_repos(repos, options = {})
        repos.each {|r| puts r.name }
      end
    end
  end
end
