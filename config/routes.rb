Tpna::Application.routes.draw do

  root :to => "home#index"
  devise_for :users
  resources :users



  resources :members do
    collection do 
      post :import
      get :export
    end
  end

end
