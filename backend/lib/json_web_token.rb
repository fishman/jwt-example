require 'jwt'

class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, "9cdd3c973b10b17f106d029e54ce1250f2a0062eccd7cf439ab2733c987dc2b5956898933962c6a71d5e9eabf2e9242225d817e5d0c16a36d529c03d502e2b64")
  end

  def self.decode(token)
    return HashWithIndifferentAccess.new(JWT.decode(token, "9cdd3c973b10b17f106d029e54ce1250f2a0062eccd7cf439ab2733c987dc2b5956898933962c6a71d5e9eabf2e9242225d817e5d0c16a36d529c03d502e2b64")[0])
  rescue
    nil
  end
end
