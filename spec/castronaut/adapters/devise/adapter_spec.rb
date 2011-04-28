require File.expand_path( '../../../../spec_helper', __FILE__ )

describe Castronaut::Adapters::Devise::Adapter do

  describe "authenticate" do

    it "calls authenticate on the nested User model" do
      Castronaut::Adapters::Devise::User.should_receive(:authenticate).with('username', 'password')
      Castronaut::Adapters::Devise::Adapter.authenticate('username', 'password')
    end

  end

end
