Rails.application.routes.draw do
  devise_for :users
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?

  post '/graphql', to: 'graphql#execute'

  root 'website#home'
  get '/app', to: 'webapp#init'
end
