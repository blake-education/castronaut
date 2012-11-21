# Copyright 2008-2009 Relevance Inc.
# All rights reserved

# This file may be distributed under an MIT style license.
# See MIT-LICENSE for details.

require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'
require 'simplecov'
require "fileutils"

desc "Run all examples with Rcov"
RSpec::Core::RakeTask.new('specs_with_rcov') do |t|
  ENV["test"] = "true"
  t.pattern = 'spec/**/*.rb'
  t.rcov = true
  t.rcov_opts = ['--text-report', '--exclude', "~/.gem,spec,Library,lib/castronaut/db,#{ENV['GEM_HOME']}", '--sort', 'coverage']
end

desc "Run all examples"
RSpec::Core::RakeTask.new('spec') do |t|
  ENV["test"] = "true"
  t.pattern = 'spec/**/*.rb'
  t.rcov = false
  t.rspec_opts = ['-cfn']
end

namespace :ssl do

  desc "Generate a test SSL certificate for development"
  task :generate do
    FileUtils.mkdir_p('ssl') unless File.exist?('ssl')

    if %x{which openssl}.strip.size == 0
      puts "Unable to locate openssl, please make sure you have it installed and in your path."
    else
      system("openssl req -x509 -nodes -days 365 -subj '/C=US/ST=NC/L=CH/CN=localhost' -newkey rsa:1024 -keyout ssl/devcert.pem -out ssl/devcert.pem")
    end
  end

end

task :default => [:spec]
