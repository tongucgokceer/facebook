Rails.application.routes.draw do
  devise_for :users, controllers: {
    :sessions => "users/sessions",
    :registrations => "users/registrations",
    omniauth_callbacks: 'users/omniauth_callbacks' }

    devise_scope :user do
      delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroyy_user_session
    end


  
  resources :users, only: [:index, :show] do
    get 'friends' => :show, to: 'users#friends'
  end

  resource :profile, only: [:new, :create, :edit, :update, :show]

  resources :invitations
  resources :posts
  resources :comments

  resources :likes

  

  root to: 'users#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end