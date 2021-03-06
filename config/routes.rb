require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do

  devise_for :users

  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?

  post '/graphql', to: 'graphql#execute'

  root 'website#home'
  get '/app', to: 'webapp#init'

  # Admin
  authenticate :user, ->(u) { u.admin? } do
    namespace :admin do
      mount Sidekiq::Web => '/sidekiq'

      resources :users
      resources :blocks
      resources :languages
      resources :sentences
      resources :lessons
      resources :translations

      root to: 'users#index'
    end
  end

  get '/health', to: proc { [200, {}, ['healthy']] }
end
