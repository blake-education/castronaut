require File.dirname(__FILE__) + "/../spec_helper"

describe Castronaut::AuthenticationResult do

  it "exposes the given username at :username" do
    Castronaut::AuthenticationResult.new("billy").username.should == "billy"
  end

  it "exposes the given message at :error_message" do
    Castronaut::AuthenticationResult.new(anything, "my error").error_message.should == "my error"
  end

  it "exposes the given extra attributes at :extra_attributes" do
    Castronaut::AuthenticationResult.new(anything, {:hello => "world!"}).extra_attributes[:hello].should == "world!"
  end

  it "is valid if there is no error message" do
    Castronaut::AuthenticationResult.new(anything, nil).should be_valid
  end

  it "is invalid if there is an error message" do
    Castronaut::AuthenticationResult.new(anything, "bad").should be_invalid
  end

  it "is valid if extra attributes are given" do
    Castronaut::AuthenticationResult.new(anything, {:foo => "bar"}).should be_valid
  end

end
