Rails.application.routes.draw do
  namespace :v1 do
    post '/register', to: 'users#register'
    post '/login', to: 'users#login'
    get '/user/:id', to: 'users#show'

    post '/profiles', to: 'profiles#create'
    get '/profiles', to: 'profiles#index'
    get '/profiles/:id', to: 'profiles#show'
    put '/profiles/:id', to: 'profiles#update'
  end
end
