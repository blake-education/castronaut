module Castronaut

  class AuthenticationResult
    
    attr_reader :username, :error_message, :extra_attributes
        
    def initialize(username, error_or_extra_attributes=nil)
      @username = username
      @error_message    = error_or_extra_attributes if error_or_extra_attributes.is_a? String
      @extra_attributes = error_or_extra_attributes if error_or_extra_attributes.is_a? Hash

      Castronaut.logger.info("#{self.class} - #{@error_message} for #{@username}") if @error_message && @username
    end
    
    def valid?
      error_message.nil?
    end
    
    def invalid?
      !valid?
    end
    
  end

end

