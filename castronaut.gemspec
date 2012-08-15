Gem::Specification.new do |s|

  s.name = 'castronaut'
  s.version = '0.7.5'

  s.required_rubygems_version = Gem::Requirement.new('>= 1.4') if s.respond_to? :required_rubygems_version=
  s.authors = ['Relevance, Inc.', 'Nat Budin', 'Damien Le Berrigaud']
  s.date = '2011-02-16'
  s.default_executable = 'castronaut'
  s.description = 'Castronaut CAS server'
  s.executables = ['castronaut']

  s.files = %w(MIT-LICENSE Rakefile README.textile castronaut.rb bin/castronaut)
  s.files << Dir['lib/**/*', 'app/**/*', 'config/**/*']

  s.homepage = 'http://github.com/nbudin/castronaut'
  s.require_paths = ["lib"]
  s.rubygems_version = '1.5.0'
  s.summary = 'Castronaut CAS server'
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'sinatra', '~> 1.0'
  s.add_dependency 'json', '~> 1.6.0'
  s.add_dependency 'activesupport', '>= 2.0'
  s.add_dependency 'activerecord', '>= 2.0'
  s.add_dependency 'crypt-isaac', '~> 0.9'
  s.add_dependency 'builder', '>= 2.0.0'

  # TODO these should be optional
  # according to the chosen adapter
  s.add_dependency 'sqlite3', '~> 1.3.1'
  s.add_dependency 'ruby-net-ldap'
  s.add_dependency 'mysql2'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '>= 2.2.1'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'racksh'
  s.add_development_dependency 'test-unit', '1.2.3'
  s.add_development_dependency 'simplecov'

end
