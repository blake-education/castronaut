require File.expand_path( '../../../../spec_helper', __FILE__ )

describe Castronaut::Adapters::Ldap::Adapter do

  describe "authenticate" do
    
    it "calls authenticate on the nested User model" do
      Castronaut::Adapters::Ldap::User.should_receive(:authenticate).with('username', 'password')
      Castronaut::Adapters::Ldap::Adapter.authenticate('username', 'password')
    end
    
  end

end
