MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :signIn, field: AuthMutations::SignIn.field
  field :revokeToken, field: AuthMutations::RevokeToken.field

  field :signUp, field: UserMutations::SignUp.field
  field :updateUser, field: UserMutations::Update.field
  field :changePassword, field: UserMutations::ChangePassword.field
  field :cancelAccount, field: UserMutations::CancelAccount.field
end
