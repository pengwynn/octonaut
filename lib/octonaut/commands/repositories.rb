module Octonaut

  desc "Display details for a repository"
  arg_name :name
  command [:repo, :repository] do |c|
    c.action do |global,options,args|
      name = args.shift

      print_repo_table @client.repo(name)
    end
  end
end
