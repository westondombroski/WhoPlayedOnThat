Rails.application.routes.draw do

  root 'welcome#index'

  get '/login', :to => 'sessions#new', :as => :login
  get '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'
  get '/signout' => 'sessions#destroy', :as => :signout

  get '/tracks', :to => 'tracks#index', :as => :tracks
  get '/track/:id', :to => 'tracks#show', :as => :track_show

  get '/musicians/:id', :to => 'musicians#show', :as => :musician
  post 'musicians', :to => 'musicians#create', :as =>:playlist_create

end
