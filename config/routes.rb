Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :money_transactions
  resources :savings_accounts
  devise_for :users

  get '/user' => 'user#show'
  get '/user/new-savings-account' => 'user#new_savings_account'
  post '/user/create-savings-account' => 'user#create_savings_account'

  root :to => "user#show"
end
