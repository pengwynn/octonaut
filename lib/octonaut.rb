require 'csv'
require 'gli'
require 'launchy'
require 'octokit'
require 'octonaut/printer'
require 'octonaut/helpers'
require 'octonaut/version'

module Octonaut
  extend GLI::App
  extend Octonaut::Printer
  extend Octonaut::Helpers

  program_desc 'Octokit-powered CLI for GitHub'
  commands_from 'octonaut/commands'
  commands_from File.join(ENV['HOME'], '.octonaut', 'plugins')


  desc 'Use .netrc file for authentication'
  default_value false
  switch [:n, :netrc]

  desc 'GitHub login'
  flag [:u, :login]
  desc 'GitHub password'
  flag [:p, :password], :mask => true
  desc 'GitHub API token'
  flag [:t, :oauth_token, :token], :mask => true
  desc 'Automatically fetch all pages of paginated results'
  default_value true
  switch [:a, :auto_traversal]


  pre do |global,command,options,args|
    # Pre logic here
    # Return true to proceed; false to abourt and not call the
    # chosen command
    # Use skips_pre before a command to skip this block
    # on that command only

    @client = client(global, options)
    true
  end

  post do |global,command,options,args|
    # Post logic here
    # Use skips_post before a command to skip this
    # block on that command only
  end

  on_error do |exception|
    case exception
    when Octokit::Unauthorized
      puts "Authentication required. Please check your login, password, or token."
    else
      # Need to handle other return codes within the calling method
      true
    end
  end

  def self.client(global, options)
    opts = global.merge(options).
      select {|k, v| Octokit::Configuration::VALID_OPTIONS_KEYS.include?(k) }
    Octokit::Client.new(opts)
  end

end
