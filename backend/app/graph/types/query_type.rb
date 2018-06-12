QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this schema. See available queries."

  field :greeting, GreetingType do
    description 'fetch a Greeting'
    resolve ->(object, args, ctx){
      token = ""
      if ctx[:request].headers["Authorization"].present?
        pattern = /^Bearer /
        header  = ctx[:request].headers['Authorization']
        token = header.gsub(pattern, '') if header && header.match(pattern)
      end
      Greeting.fetch(token)
    }
  end

  field :currentUser, UserType do
    description 'fetch the current user.'
    resolve ->(object, args, ctx){
      ctx[:current_user]
    }
  end
end
