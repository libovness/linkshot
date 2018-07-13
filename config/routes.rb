Rails.application.routes.draw do
  resources :shots
  resources :users
  resources :links
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/auth/:provider/callback', to: 'sessions#create'
  
end
