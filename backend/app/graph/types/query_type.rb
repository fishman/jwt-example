QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this schema. See available queries."

  # field :greeting, GreetingType do
  #   description 'fetch a Greeting'
  #   resolve ->(object, args, ctx){
  #     Greeting.fetch()
  #   }
  # end

  field :currentUser, UserType do
    description 'fetch the current user.'
    resolve ->(object, args, ctx){
      ctx[:current_user]
    }
  end
end
