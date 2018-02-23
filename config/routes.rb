Rails.application.routes.draw do
  root 'recipes#index'

  get 'food' => 'food#index'

  resources :recipes do
    resources :ingredients, only: [:new, :create]
  end

  get 'recipes/search' => 'recipes#search'
  get 'recipe/:id' => 'recipe#show'
  post 'recipes/new' => 'recipes#create'
  post 'recipe/:id/savedfoods' => 'recipes#add_shoppinglist', as: 'saved_foods'
  post 'recipe/:id/savedsomefoods' => 'recipes#addsome_shoppinglist', as: 'saved_some_foods'
  post 'recipe/:id/maderecipe' => 'recipes#user_made', as: 'made_recipe'
  post 'recipes/search' => 'recipes#searchaction'
  post 'recipe/:id/favorite' => 'recipes#favorite', as: 'favorite_recipe'
  post 'recipe/:id/review' => 'recipes#review', as: 'review_recipe'

  resources :users, only: [:new, :create]
  get 'users/kitchen' => 'users#kitchen'
  get 'user/:id' => 'users#show', as: 'user_profile'
  get 'users/pantry' => 'users#pantry'
  get 'users/shoppinglist' => 'users#shoppinglist'
  get 'user/favorites' => 'users#favorites', as: 'user_favorites'
  get 'user/appliances' => 'users#appliances', as: 'user_appliances'
  patch 'user/appliances' => 'users#update_appliances'
  patch 'users/kitchen' => 'users#update', as: 'update_pantry'
  post 'users/shoppinglist' => 'users#remove_shoppinglist', as: 'removed_foods'

  resources :sessions, only: [:new, :create, :destroy]





end
