Rails.application.routes.draw do
  root to: 'users#show'

  devise_for :users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get '/user' => 'users#show', as: :profile
  get '/user/new_savings_account' => 'users#new_savings_account'
  post '/user/create_savings_account' => 'users#create_savings_account'

  resources :savings_accounts do
    member do
      get :new_deposit, :new_withdrawal
      post :deposit, :withdraw
    end
  end

  resources :money_transactions, except: %i[edit update destroy]

  resources :exchange_currencies
end
