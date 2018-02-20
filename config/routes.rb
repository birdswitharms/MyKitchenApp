Rails.application.routes.draw do
  root 'recipes#index'

  get 'food/index'

  get 'recipe/:id' => 'recipe#show'
  post 'recipes/new' => 'recipes#create'

  resources :recipes do
    resources :ingredients, only: [:new, :create]
  end

  resources :sessions, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create]
  get 'users/kitchen' => 'users#kitchen'

  get 'food' => 'food#index'

end
