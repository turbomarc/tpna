Tpna::Application.routes.draw do
  
  #match '/members', to: 'members#index'

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  
  resources :members do
    collection { post :import }
  end
  
end