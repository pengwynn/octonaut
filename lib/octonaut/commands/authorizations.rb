module Octonaut

  desc "Create and store an API token using username and password"
  command :authorize do |c|
    c.action do |global,options,args|
      username = ask("GitHub username:      ")
      password = ask("Enter your password:  ") { |q| q.echo = false }
      headers = {}
      hostname = Socket.gethostname

      client = Octokit::Client.new :login => username, :password => password
      begin
        authorization = client.create_authorization :scopes => [],
          :note => "Octonaut #{hostname} #{Time.now}", :headers => headers
      rescue Octokit::OneTimePasswordRequired
        one_time_password = ask("Enter your 2FA token: ")
        headers.merge!("X-GitHub-OTP" => one_time_password)
        retry
      end

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

  desc "Manage tokens"
  command [:tokens, :authorizations] do |c|
    c.default_command :ls

    c.desc "List GitHub API tokens"
    c.command [:ls, :list] do |ls|
      ls.action do |global,options,args|
        raise ArgumentError.new "Basic Authentication required" unless @client.user_authenticated?

        ls_tokens @client.authorizations
      end
    end

  end

  desc "List scopes for a token"
  arg_name "token"
  command :scopes do |c|
    c.action do |global,options,args|
      token = args.shift

      raise ArgumentError.new "Token required" unless token

      puts (Octokit.scopes(token).join(', '))
    end
  end
end
