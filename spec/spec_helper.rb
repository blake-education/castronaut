require 'rubygems'
require 'bundler/setup'
require 'ruby-debug'

require File.join(File.dirname(__FILE__), '..', 'lib', 'castronaut')
require File.join(File.dirname(__FILE__), 'spec_rails_mocks')

Castronaut.config = Castronaut::Configuration.load(File.join File.dirname(__FILE__), '..', 'config', 'castronaut.example.yml')

class CreateUsers < ActiveRecord::Migration
  Castronaut::Adapters::RestfulAuthentication::User.connection.create_table "users", :force => true do |t|
    t.string   :login,                    :limit => 40
    t.string   :name,                     :limit => 100, :default => '', :null => true
    t.string   :email,                    :limit => 100
    t.string   :crypted_password,         :limit => 40
    t.string   :salt,                     :limit => 40
    t.datetime :created_at
    t.datetime :updated_at
    t.string   :remember_token,           :limit => 40
    t.datetime :remember_token_expires_at
    t.string   :first_name, :last_name
  end
  Castronaut::Adapters::RestfulAuthentication::User.connection.add_index :users, :login, :unique => true
end

class CreateUsers < ActiveRecord::Migration
  Castronaut::Adapters::Development::User.connection.create_table "users", :force => true do |t|
    t.string :login,    :limit => 40
    t.string :name,     :limit => 100, :default => '', :null => true
    t.string :password
  end
  Castronaut::Adapters::Development::User.connection.add_index :users, :login, :unique => true
end

RSpec.configure do |config|
  config.include RSpec::Rails::Mocks
end
