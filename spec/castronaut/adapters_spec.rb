require File.expand_path( '../../spec_helper', __FILE__ )

describe Castronaut::Adapters do
  
  describe "selected adapter" do
    
    it "delegates to the default of RestfulAuthentication" do
      Castronaut::Adapters.selected_adapter.should == Castronaut::Adapters::RestfulAuthentication::Adapter
    end
    
  end

end
