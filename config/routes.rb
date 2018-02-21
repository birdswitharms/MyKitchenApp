Rails.application.routes.draw do
  root 'recipes#index'

  get 'food/index'

  get 'recipe/:id' => 'recipe#show'
  post 'recipes/new' => 'recipes#create'

  get 'recipes/search' => 'recipes#search'
  post 'recipes/search' => 'recipes#searchaction'

  resources :recipes do
    resources :ingredients, only: [:new, :create]
  end

  resources :sessions, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create]
  get 'users/kitchen' => 'users#kitchen'
  get 'users/pantry' => 'users#pantry'
  patch 'users/kitchen' => 'users#update'

  get 'food' => 'food#index'

  post 'recipe/:id/favorite' => 'recipes#favorite', as: 'favorite_recipe'

end
