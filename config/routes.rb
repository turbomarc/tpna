Tpna::Application.routes.draw do

  root :to => "home#index"
  devise_for :users
  resources :users

  resources :members do
    collection { post :import }
  end

end
