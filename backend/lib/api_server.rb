#!/usr/bin/env bundle exec ruby

require 'sinatra'
require "sinatra/json"
require 'json'

get '/greetings' do
  json greetings: { message: 'whatever' }
end
