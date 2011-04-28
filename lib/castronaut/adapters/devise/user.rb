require "digest/sha1"
require File.expand_path( '../../restful_authentication/user', __FILE__ )

module Castronaut
  module Adapters
    module Devise

      class User < Castronaut::Adapters::RestfulAuthentication::User

        def crypted_password
          encrypted_password
        end

        def salt
          password_salt
        end

      end

    end # Devise
  end # Adapters
end # Castronaut
