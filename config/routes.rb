Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :money_transactions
  resources :savings_accounts
  devise_for :users

  get '/user' => 'user#show'
  get '/user/new-savings-account' => 'user#new_savings_account'
  post '/user/create-savings-account' => 'user#create_savings_account'

  get '/savings-accounts/:id/new_deposit' => 'savings_accounts#new_deposit', as: :new_deposit
  post '/savings-accounts/:id/deposit' => 'savings_accounts#deposit', as: :deposit

  get '/savings-accounts/:id/new_withdrawal' => 'savings_accounts#new_withdrawal', as: :new_withdrawal
  post '/savings-accounts/:id/withdraw' => 'savings_accounts#withdraw', as: :withdraw

  root :to => "user#show"
end
