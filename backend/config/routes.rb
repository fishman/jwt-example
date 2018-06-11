Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/graphql", to: "graphql#create"
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  # get '*all', to: 'application#index'
end
