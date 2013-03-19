module Octonaut

  desc "(Create and) store an API token using username and password"
  command :authorize do |c|
    c.action do |global,options,args|
      username = ask("GitHub username:      ")
      password = ask("Enter your password:  ") { |q| q.echo = false }

      client = Octokit::Client.new :login => username, :password => password
      authorization = client.create_authorization :scopes => []

      if File.readable?(Octonaut.config_path)
        config = YAML::load_file(Octonaut.config_path)
        File.open(Octonaut.config_path, 'w') do |out|
          %w(t token oauth_token).each do |key|
            config.delete(key)
            config.delete(key.to_sym)
          end
          config[:t] = authorization.token
          YAML.dump(config, out)
        end
      else
        Octonaut.run ["-t", authorization.token, "initconfig"]
      end
    end
  end

end
