require 'csv'
require 'gli'
require 'highline/import'
require 'launchy'
require 'octokit'
require 'octonaut/printer'
require 'octonaut/helpers'
require 'octonaut/utils'
require 'octonaut/version'

module Octonaut
  extend GLI::App
  extend Octonaut::Printer
  extend Octonaut::Helpers
  extend Octonaut::Utils

  def self.config_path
    path = if ENV['OCTONAUT_ENV'] == 'TEST'
      'tmp/fakehome'
    else
      ENV['HOME']
    end

    File.expand_path(File.join(path, '.octonaut'))
  end

  program_desc 'Octokit-powered CLI for GitHub'
  commands_from 'octonaut/commands'
  if plugins_path = ENV['OCTONAUT_PLUGINS_PATH']
    commands_from File.expand_path(plugins_path)
  end

  config_file Octonaut.config_path

  desc 'Use .netrc file for authentication'
  default_value false
  switch [:n, :netrc]

  desc '.netrc file for authentication'
  flag "netrc-file"

  desc 'GitHub login'
  flag [:u, :login]
  desc 'GitHub password'
  flag [:p, :password], :mask => true
  desc 'GitHub API token'
  flag [:t, :oauth_token, :token], :mask => true
  desc 'Automatically fetch all pages of paginated results'
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
    opts = global
    netrc_path = global.delete("netrc-file")
    opts[:netrc] = netrc_path if netrc_path
    # drop OAuth token if basic auth is present
    if (opts['login'] && opts['password']) || opts[:netrc]
      %w(t token oauth_token).each do |k|
        opts.delete(k)
        opts.delete(k.to_sym)
      end
    end
    opts.merge!(options).
      select {|k, v| Octokit::Configuration::VALID_OPTIONS_KEYS.include?(k) }
    Octokit::Client.new(opts)
  end


end
