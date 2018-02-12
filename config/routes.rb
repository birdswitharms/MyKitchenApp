Rails.application.routes.draw do
  root 'recipes#index'

  get 'food/index'

  get 'recipe/:id' => 'recipe#show'

  resources :recipes do
    resources :ingredients, only: [:new, :create]
  end

  resources :kitchen

  resources :sessions, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create]

  get 'food' => 'food#index'

end
