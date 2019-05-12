Rails.application.routes.draw do
  devise_for :users, controllers:{registrations: 'registrations'}
    root to: "articles#index"
    
    resources :articles
    resources :restaurants do
      resources :reviews, except: [:show, :index]
    end
    
    
end
