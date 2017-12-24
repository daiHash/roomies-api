Rails.application.routes.draw do
  namespace :v1 do
    post '/register', to: 'users#register'
    post '/login', to: 'users#login'
    get '/test', to: 'users#test'
  end
end
