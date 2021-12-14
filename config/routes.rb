Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope '/auth' do
    post '/signin', to: 'user_token#create'
    post '/signup', to: 'users#create'
  end

  namespace :admin do
    resources :users, only: [:index, :destroy, :update, :edit]
    resources :stores, only: [:create, :index, :edit, :update, :destroy]
  end

  #resources :categories

  namespace :owner do
    resources :stores, only: [:edit, :update, :index]
  end

  resource :users, only: [ :update, :edit]

end
