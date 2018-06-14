require 'api_server'
require 'rack/test'

describe 'Sinatra App' do
  include Rack::Test::Methods

  def app
    ApiServer.new
  end

  it "returns not authorized" do
    get '/greetings'

    expect(last_response.body).to include("invalid")
    expect(last_response.status).to eq(401)
  end

  it "returns greeting" do
    token = JWT.encode({user_id: 10, name: "john"}, 
                       ENV["AUTH_SECRET"], "HS256")
    header "Authorization", "Bearer #{token}"

    get '/greetings'

    expect(last_response.body).to include("john")
  end

end
