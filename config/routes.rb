Rails.application.routes.draw do
  resources :shots
  resources :users
  resources :links
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "shots#new"

  get '/auth/:provider/callback', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

end
