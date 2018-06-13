require 'jwt'

class JsonWebToken
  def self.encode(payload)
    payload[:exp] = (Rails.configuration.jwt_duration).seconds.from_now.to_i
    JWT.encode(payload, Rails.application.secrets.jwt_secret)
  end

  def self.decode(token)
    return HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.jwt_secret)[0])
  rescue
    nil
  end
end
