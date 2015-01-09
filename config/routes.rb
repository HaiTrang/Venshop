Rails.application.routes.draw do
   
  
  root 'categories#show'
  resources :products
  resources :users
  resources :orderdetails
  resources :orders
  get 'sessions/new'
  get 'productdetail'    => 'products#product_detail'
  post 'productdetail'    => 'products#go_cart'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'
  get  'login'  => 'sessions#new'
  post 'login'  => 'sessions#create'
  post 'signup' => 'users#create'
  post 'deleteallcart' => 'orderdetails#delete_all_cart'
  get 'my_products'  => 'products#my_products'
  
  delete 'logout'  => 'sessions#destroy'
  get 'carts/new'  
  get 'products'   => 'products#index'
  get 'search'     => 'products#search' 

end
