require 'json_web_token'
require 'grpc'
require 'greeter_services_pb'

class Greeting
  extend ERB::Util

  attr_reader :message

  def initialize(message)
    @message = message
  end

  def self.fetch(token)
    metadata = {authorization: token}
    stub = Greeter::Greeter::Stub.new('localhost:50051', :this_channel_is_insecure)
    message = stub.say_hello(Greeter::HelloRequest.new(), metadata: metadata).message


    self.new(h(message))
  rescue GRPC::NotFound, GRPC::Unauthenticated
    self.new("Bad auth token")
  rescue GRPC::Unavailable
    self.new("Greeter service down")
  end
end
