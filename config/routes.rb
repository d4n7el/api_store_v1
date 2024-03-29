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
    resources :categories, only: [:edit, :update, :index, :create, :destroy] do
      resources :products, only: [:edit, :update, :index, :create, :destroy]
    end
  end

  namespace :owner do
    resources :stores, only: [:edit, :update, :index]
    resources :categories, only: [:edit, :update, :index, :create, :destroy] do
      resources :products, only: [:edit, :update, :index, :create, :destroy]
    end
  end

  resource :users, only: [ :update, :edit]

end
