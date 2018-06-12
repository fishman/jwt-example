class ApplicationController < ActionController::API
  include Authenticatable
  before_action :authenticate
  attr_reader :current_user
end
