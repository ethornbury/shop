Rails.application.routes.draw do
  devise_for :users
  get 'cart/index'

  resources :items
  #get 'welcome/home'
  root to:  'welcome#home'

  get '/help'  => 'welcome#help'
  get '/about' => 'welcome#about'
  #get 'welcome/about'
  get '/contact' => 'welcome#contact'
  #get 'welcome/contact'
  
  get '/login' => 'user#login'
  get '/logout' => 'user#logout'

  get '/cart', to: 'cart#index'
  get '/cart/:id', to: 'cart#add'
  get '/cart/remove/:id', to: 'cart#remove'
  get '/clearcart', to: 'cart#clearCart'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
