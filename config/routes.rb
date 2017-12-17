Rails.application.routes.draw do
  namespace :v1 do
    post 'auth/register', to: 'users#register'
  end  
end
