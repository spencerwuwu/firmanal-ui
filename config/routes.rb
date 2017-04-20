Rails.application.routes.draw do
  # Upload routes
  get 'targets/index'
  get 'targets/new'
  get 'targets/create'
  get 'targets/destroy'
  resources :targets, only: [:index, :new, :create, :destroy]

  get "/", to: "targets#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
