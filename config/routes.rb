Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope '/auth' do
    post '/signin', to: 'user_token#create'
    post '/signup', to: 'users#create'
   end

   resources :users, only: [:index, :update, :destroy, :edit]

end
