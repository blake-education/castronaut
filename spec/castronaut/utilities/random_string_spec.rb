require File.expand_path( '../../../spec_helper', __FILE__ )

describe Castronaut::Utilities::RandomString do

  it "generates random string with a given length using ISAAC" do
    isaac = stub(:rand => "123")
    ::Crypt::ISAAC.should_receive(:new).and_return(isaac)

    isaac.should_receive(:rand).with(4_294_619_050).exactly(8).times.and_return("123")

    Castronaut::Utilities::RandomString.generate
  end

end
