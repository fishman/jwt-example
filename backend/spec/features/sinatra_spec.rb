require 'api_server'
require 'rack/test'

describe 'Sinatra App' do
  include Rack::Test::Methods

  def app
    ApiServer.new
  end

  it "returns json" do
    get '/greetings'

    expect(last_response.body).to include("invalid")
    expect(last_response.status).to eq(401)
  end

end
