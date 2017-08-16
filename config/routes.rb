Rails.application.routes.draw do
  resources :comments
  
  #USERS ROUTES
  resources :users, except: :new
  get 'signup', to: 'users#new'

  #SESSIONS ROUTES
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'articles#index'
  get 'articles/list', to: 'articles#list'
  post 'users', to: 'users#create'
  
  resources :articles
 
end
