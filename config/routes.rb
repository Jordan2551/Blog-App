Rails.application.routes.draw do
  resources :comments
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "articles#index"
  get "articles/list", 'articles#list'
  
  resources :articles do
  end
 
end
