Rails.application.routes.draw do
  resources :comments
  
  #USERS ROUTES
  resources :users, except: :new
  get 'signup', to: 'users#new'
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "articles#index"
  get "articles/list", 'articles#list'
  post 'users', to: 'users#create'
  
  resources :articles do
  end
 
end
