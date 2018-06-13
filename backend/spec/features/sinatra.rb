require 'api_server'
require 'rack/test'

describe 'Sinatra App' do
  include Rack::Test::Methods

  def app
    SinatraApp.new
  end

  it "returns json" do 
    get '/greetings'
  end

end

