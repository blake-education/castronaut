require 'sinatra'
require 'castronaut'

module Castronaut

  Castronaut.config ||= Castronaut::Configuration.load

  class Application < Sinatra::Base

    configure do

      root     = File.expand_path( '../../app', __FILE__ )
      app_file = "#{root}/controllers/application.rb"
      views    = "#{root}/views"
      pub_dir  = "#{root}/public"

      Castronaut.logger.debug "Sinatra Config - setting root path to #{root}"
      Castronaut.logger.debug "Sinatra Config - setting views path to #{views}"
      Castronaut.logger.debug "Sinatra Config - setting public path to #{pub_dir}"

      set :environment,  Castronaut.config.environment.to_sym
      set :run,          true
      set :raise_errors, true
      set :logging,      true
      set :port,         Castronaut.config.respond_to?(:server_port) ? Castronaut.config.server_port : Sinatra::Application.default_options[:port]

      set :root,         root
      set :app_file,     app_file
      set :views,        views
      set :public,       pub_dir
      set :logging,      true
      set :raise_errors, true
      set :run,          false
      set :env,          ENV['RACK_ENV'] || 'production'

    end

  private

    class << self
      def prefix
        if Castronaut.config.respond_to?(:prefix)
          return "#{Castronaut.config.prefix}/"
        end

        ''
      end

      def path_regex path
        /^\/#{prefix}#{path}(\.json)?$/
      end
    end

  public

    get '/' do
      redirect '/login'
    end

    get(path_regex 'login') do |extension|
      no_cache
      present! Presenters::Login, view_format(extension)
    end

    post(path_regex 'login') do |extension|
      present! Presenters::ProcessLogin, view_format(extension)
    end

    get(path_regex 'logout') do |extension|
      present! Presenters::Logout, view_format(extension)
    end

    get(path_regex 'serviceValidate') do |extension|
      present! Presenters::ServiceValidate, view_format(extension, :xml)
    end

    get(path_regex 'proxyValidate') do |extension|
      present! Presenters::ProxyValidate, view_format(extension, :xml)
    end

    def view_format(extension, default = :html)
      extension && extension.delete('.').to_sym || default
    end

  private

    def no_cache
      response.headers.merge!(
        'Pragma' => 'no-cache',
        'Cache-Control' => 'no-store',
        'Expires' => (Time.now - 5.years).rfc2822
      )
    end

    def present!(klass, format = :html)
      @presenter = klass.new(self, format)
      @presenter.represent!
      @presenter.your_mission.call
    end

  end # class

end # module
