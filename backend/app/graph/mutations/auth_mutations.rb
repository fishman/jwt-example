module AuthMutations
  SignIn = GraphQL::Relay::Mutation.define do
    name "signIn"
    description "SignIn"

    input_field :email, types.String
    input_field :password, types.String

    # return_field :user, UserType
    return_field :token, types.String
    return_field :messages, types[FieldErrorType]

    resolve ->(obj, inputs, ctx) {
      user = User.find_for_database_authentication(email: inputs[:email])
      if user.present? && user.valid_password?(inputs[:password])
        user.update_tracked_fields(ctx[:request])
        {
          token: JsonWebToken.encode({user_id: user.id, name: user.name}),
          # user: user
        }
      else
        FieldError.error("Invalid email or password")
      end
    }
  end

  RevokeToken = GraphQL::Relay::Mutation.define do
    name "revokeToken"
    description "revoke token"
    return_field :messages, types[FieldErrorType]

    resolve(Auth.protect ->(obj, inputs, ctx) {
      ctx[:current_user].update(access_token: nil)
      {}
    })
  end
end
