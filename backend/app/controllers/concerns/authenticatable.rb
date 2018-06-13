# coding: utf-8
module Authenticatable
  require 'json_web_token'
  def authenticate
    if request.headers["Authorization"].present?
      pattern = /^Bearer /
      header  = request.headers['Authorization']
      token = header.gsub(pattern, '') if header && header.match(pattern)

      if token.present?
        auth_token = JsonWebToken.decode(token)
        @current_user = User.find(auth_token[:user_id])

        if @current_user.nil?
          render json: FieldError.error("Auth token is invalid")
        end
      end
    end
  rescue JWT::VerificationError, JWT::DecodeError
    render json: FieldError.error("Auth token is invalid")
  end

  def current_user
    @current_user
  end
end
