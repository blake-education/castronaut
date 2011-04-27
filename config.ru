require 'rubygems'
require 'bundler/setup'

require File.expand_path( File.join File.dirname(__FILE__), 'lib/castronaut' )
require File.expand_path( File.join File.dirname(__FILE__), 'lib/castronaut/application' )

run Castronaut::Application
