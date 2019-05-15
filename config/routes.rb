Rails.application.routes.draw do
  devise_for :users, controllers:{registrations: 'registrations'}
    root to: "articles#index"
    
    resources :articles
    resources :restaurants do
      resources :reviews, except: [:show, :index]
    end
#    resources :favourites, only: [:show, :create, :destroy]
    resources :friendships, only: [:show, :index, :create, :destroy]
    
end
