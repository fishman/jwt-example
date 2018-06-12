GreetingType = GraphQL::ObjectType.define do
  name "Greeting"
  description "An greeting, returns a user greeting"

  field :message, types.String, "The greeting message"
end
