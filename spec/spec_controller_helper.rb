require File.expand_path( '../spec_helper', __FILE__ )

require 'sinatra'
require 'test/unit'
require 'rack/test'

require File.expand_path( '../../lib/castronaut/application', __FILE__ )

Castronaut::Application.set(
  :environment => :test,
  :run => false,
  :raise_errors => true,
  :logging => false
)

include Rack::Test::Methods

def app
  Castronaut::Application.new
end
