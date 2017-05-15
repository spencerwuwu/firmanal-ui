Rails.application.routes.draw do
  # Upload routes
  get 'targets/index'
  get 'targets/new'
  get 'targets/create'
  get 'targets/show'
  get 'targets/destroy'
  resources :targets, only: [:index, :new, :create, :show, :destroy]

  get 'targets/source_code/:id', to: "targets#source_code"
  get 'targets/angr/:id', to: "targets#angr"
  get 'targets/afl/:id', to: "targets#afl"
  get 'targets/network_fuzz/:id', to: "targets#network_fuzz"
  get 'targets/metasploits/:id', to: "targets#metasploits"

  get "/", to: "targets#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
