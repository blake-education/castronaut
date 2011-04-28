require File.expand_path( '../../../../spec_helper', __FILE__ )

describe Castronaut::Adapters::RestfulAuthentication::Adapter do

  describe "authenticate" do

    it "calls authenticate on the nested User model" do
      Castronaut::Adapters::RestfulAuthentication::User.should_receive(:authenticate).with('username', 'password')
      Castronaut::Adapters::RestfulAuthentication::Adapter.authenticate('username', 'password')
    end

  end

end
