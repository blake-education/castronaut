require 'active_support'
require 'active_record'

module Castronaut

  def self.load_file( *path )
    load file_path( path )
  end

  def self.require_file( *path )
    require file_path( path )
  end

  def self.file_path( *path )
    File.expand_path File.join( '../..', path ), __FILE__
  end

  def self.config
    @cas_config
  end

  def self.config=(config)
    @cas_config = config
  end

  def self.logger
    @cas_config.logger
  end

  %w(
    configuration
    support/sample
    utilities/random_string
    models/consumeable
    models/dispenser
    models/login_ticket
    models/service_ticket
    models/proxy_ticket
    models/ticket_granting_ticket
    models/proxy_granting_ticket
    models
    authentication_result
    ticket_result
    presenters/base
    presenters/validate
    presenters/login
    presenters/logout
    presenters/process_login
    presenters/service_validate
    presenters/proxy_validate
    adapters
  ).each do |file|

    require_file 'lib', 'castronaut', file

  end

end
