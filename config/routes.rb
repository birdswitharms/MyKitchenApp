Rails.application.routes.draw do
  root 'recipes#index'

  get 'food/index'

  get 'recipe/:id' => 'recipe#show'
  post 'recipes/new' => 'recipes#create'

  post 'recipe/:id/savedfoods' => 'recipes#add_shoppinglist', as: 'saved_foods'
  post 'users/shoppinglist' => 'users#remove_shoppinglist', as: 'removed_foods'
  post 'recipe/:id/savedsomefoods' => 'recipes#addsome_shoppinglist', as: 'saved_some_foods'

  get 'recipes/search' => 'recipes#search'
  post 'recipes/search' => 'recipes#searchaction'

  resources :recipes do
    resources :ingredients, only: [:new, :create]
  end

  resources :sessions, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create]
  get 'users/kitchen' => 'users#kitchen'
  get 'users/pantry' => 'users#pantry'
  get 'users/shoppinglist' => 'users#shoppinglist'
  patch 'users/kitchen' => 'users#update'

  get 'food' => 'food#index'

  post 'recipe/:id/favorite' => 'recipes#favorite', as: 'favorite_recipe'
  post 'recipe/:id/review' => 'recipes#review', as: 'review_recipe'
  get 'user/favorites' => 'users#favorites', as: 'user_favorites'
end
