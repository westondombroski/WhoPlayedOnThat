Rails.application.routes.draw do
  get 'musicians/show'

  root 'welcome#index'

  get '/login', :to => 'sessions#new', :as => :login
  get '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'

  get 'tracks/index'
  get '/tracks/:id', :to => 'tracks#show'


end
