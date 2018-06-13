#!/usr/bin/env bundle exec ruby

require 'sinatra'
require "sinatra/json"
require 'json'
require 'jwt'
require 'active_support/hash_with_indifferent_access'

SHARED_KEY = "9cdd3c973b10b17f106d029e54ce1250f2a0062eccd7cf439ab2733c987dc2b5956898933962c6a71d5e9eabf2e9242225d817e5d0c16a36d529c03d502e2b64"

def jwt_decode(token)
  return HashWithIndifferentAccess.new(JWT.decode(token, SHARED_KEY)[0])
end

get '/greetings' do
  authorization_header = request.env['HTTP_AUTHORIZATION']
  auth_token = nil
  if authorization_header
    pattern = /^Bearer /i
    token = authorization_header.gsub(pattern, '') if authorization_header && authorization_header.match(pattern)

    begin
      auth_token = jwt_decode(token)
    rescue JWT::VerificationError, JWT::DecodeError, NoMethodError
      return json greetings: { message: "auth token is invalid"}
    end

  end
  json greetings: { message: "Hello #{auth_token['name']}" }
end
