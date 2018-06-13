Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/graphql", to: "graphql#create"
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  scope '/api' do
    # Version 1 of API
    scope module: :v1, constraints: ApiConstraint.new(version: 1) do
      scope '/v1' do
        # mount_devise_token_auth_for 'User', at: 'auth'
        resources :greetings, only: [:index]
      end
    end

  # get '*all', to: 'application#index'
end
