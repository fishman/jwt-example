require 'jwt'

class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, Rails.application.secrets.jwt_secret)
  end

  def self.decode(token)
    return HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.jwt_secret)[0])
  rescue
    nil
  end
end
