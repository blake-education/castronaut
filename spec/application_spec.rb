require File.expand_path( '../spec_controller_helper', __FILE__ )

describe 'Castronaut Application Controller' do

  subject { last_response }
  let(:params) { { :env => {'REMOTE_ADDR' => '10.0.0.1'} } }
  let(:json_response) { ActiveSupport::JSON.decode(last_response.body) }

  describe "GET /" do

    before do
      get '/'
    end

    it { should be_redirection }

  end

  describe "GET /login" do

    before do
      jan_1st_2008 = Time.parse("01/01/2008 00:00:00")
      jan_1st_2003 = Time.parse("01/01/2003 00:00:00")
      Time.stub!(:now).and_return(jan_1st_2008)

      get '/login', params
    end

    it { should be_ok }

    it "sets html content-type" do
      last_response.headers['Content-Type'] == 'text/html'
    end

    it "sets the Pragma header to 'no-cache'" do
      last_response.headers['Pragma'].should == 'no-cache'
    end

    it "sets the Cache-Control header to 'no-store'" do
      last_response.headers['Cache-Control'].should == 'no-store'
    end

    it "sets the Expires header to '5 years ago in rfc2822 format'" do
      last_response.headers['Expires'].should include("Wed, 01 Jan 2003 00:00:00")
    end

  end

  describe "GET /login.json" do

    before do
      get '/login.json', params
    end

    it { should be_ok }

    it "sets json content-type" do
      last_response.headers['Content-Type'].should include 'application/json'
    end

    it "should have messages as an array" do
      json_response['messages'].should == []
    end

  end

  describe "POST /login" do

    before do
      post '/login', params
    end

    it { should be_ok }

    it "sets html content-type" do
      last_response.headers['Content-Type'] == 'text/html'
    end

  end

  describe "POST /login.json" do

    before do
      post '/login.json', params
    end

    it { should be_ok }

    it "sets json content-type" do
      last_response.headers['Content-Type'].should include 'application/json'
    end

  end

  describe "GET /logout" do

    before do
      get '/logout', params
    end

    it { should be_ok }

    it "sets html content-type" do
      last_response.headers['Content-Type'] == 'text/html'
    end

  end

  describe "GET /logout.json" do

    before do
      get '/logout.json', params
    end

    it { should be_ok }

    it "sets json content-type" do
      last_response.headers['Content-Type'] == 'application/json'
    end

    it "should have messages as an array" do
      json_response['messages'].should == ["You have successfully logged out."]
    end

  end

  describe "GET /serviceValidate" do

    before do
      get '/serviceValidate', params
    end

    it { should be_ok }

    it "sets xml content-type" do
      last_response.headers['Content-Type'] == 'application/xml'
    end

  end

  describe "GET /serviceValidate.json" do

    before do
      get '/serviceValidate.json', params
    end

    it { should be_ok }

    it "sets json content-type" do
      last_response.headers['Content-Type'] == 'application/json'
    end

  end

  describe "GET /proxyValidate" do

    before do
      get '/proxyValidate', params
    end

    it { should be_ok }

    it "sets xml content-type" do
      last_response.headers['Content-Type'] == 'application/xml'
    end

  end

  describe "GET /proxyValidate.json" do

    before do
      get '/proxyValidate.json', params
    end

    it { should be_ok }

    it "sets json content-type" do
      last_response.headers['Content-Type'] == 'application/json'
    end

  end

  describe 'path prefix' do

    before do
      Castronaut.config.stub!(:prefix) { 'foo' }
      Castronaut.load_file 'lib/castronaut/application.rb'
    end

    it "should set a prefix on routes" do
      Castronaut::Application.routes['GET'].last[0].to_s.should include('^\/foo\/')
      Castronaut::Application.routes['POST'].last[0].to_s.should include('^\/foo\/')
    end

  end

end
