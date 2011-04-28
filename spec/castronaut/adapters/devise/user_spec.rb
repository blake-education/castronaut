require File.expand_path( '../../../../spec_helper', __FILE__ )

describe Castronaut::Adapters::Devise::User do

  subject { Castronaut::Adapters::Devise::User }

  it { should respond_to(:authenticate) }
  its(:ancestors) { should include(Castronaut::Adapters::Devise::User) }

  describe "crypted_password" do

    subject { Castronaut::Adapters::Devise::User.new }
    before { subject.stub!(:encrypted_password) { 'passwd' } }
    its(:crypted_password) { should == 'passwd' }

  end

  describe "salt" do

    subject { Castronaut::Adapters::Devise::User.new }
    before { subject.stub!(:password_salt) { 'pepper' } }
    its(:salt) { should == 'pepper' }

  end

end
