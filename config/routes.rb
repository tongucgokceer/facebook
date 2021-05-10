Rails.application.routes.draw do
  devise_for :users, controllers: {
    :sessions => "users/sessions",
    :registrations => "users/registrations" }
  resources :users, only: [:index, :show]

  resource :profile, only: [:new, :create, :edit, :update, :show]

  root to: 'users#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
