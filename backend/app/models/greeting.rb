require 'json_web_token'
require 'grpc'
require 'greeter_services_pb'
require 'faraday'
require 'faraday_middleware'

class Greeting
  extend ERB::Util

  attr_reader :message

  def initialize(message)
    @message = message
  end

  def self.fetch(token)
    metadata = {authorization: token}
    stub = Greeter::Greeter::Stub.new(Rails.configuration.grpc_server, :this_channel_is_insecure)
    message = stub.say_hello(Greeter::HelloRequest.new(), metadata: metadata).message


    self.new(h(message))
  rescue GRPC::NotFound, GRPC::Unauthenticated
    self.new("Bad auth token")
  rescue GRPC::Unavailable
    self.new("Greeter service down")
  end

  def fetch_http(token)
    conn = Faraday.new(:url => "http://#{Rails.configuration.grpc_server}") do |faraday|
      faraday.request  :url_encoded
      faraday.request :json
      faraday.response :json, :content_type => /\bjson$/
      faraday.headers["Authorization"] = "bearer #{token}"
      faraday.adapter Faraday.default_adapter
    end

    self.new(h(conn.get('/greetings').body["greetings"]["message"]))
  rescue Faraday::ConnectionFailed
    self.new("Greeter service down")
  end
end
