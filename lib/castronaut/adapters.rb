module Castronaut

  module Adapters

    @@registered_adapters = {}
    
    def self.register(name, klass)
      @@registered_adapters[name.to_s] = klass
    end
    
    def self.[](name)
      @@registered_adapters[name.to_s]
    end

    def self.selected_adapter
      self[Castronaut.config.cas_adapter['adapter']]
    end
  end

end

Dir[ File.expand_path( '../adapters/**/*.rb', __FILE__ ) ].each{|f| require f}

Castronaut::Adapters.register("development", Castronaut::Adapters::Development::Adapter)
Castronaut::Adapters.register("ldap", Castronaut::Adapters::Ldap::Adapter)
Castronaut::Adapters.register("database", Castronaut::Adapters::RestfulAuthentication::Adapter)
