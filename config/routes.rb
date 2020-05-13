Rails.application.routes.draw do
  #get 'sessions/new'
  #get 'users/new'

  # Setup routes for login and signup
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"

  # Displays user information page and recipes by that user.
  get '/users/:username', to: 'users#show', as: 'show_user'

  # Displays search page.
  get '/search', to: 'recipes#search_recipes', as: 'search_recipes'

  # map '/' to be a redirect to '/recipes'
  root :to => redirect('/recipes')

  resources :users
  resources :sessions
  resources :recipes
end
