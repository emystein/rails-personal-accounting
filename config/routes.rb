Rails.application.routes.draw do
  devise_for :users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :money_transactions, except: %i[edit update destroy]

  resources :savings_accounts do
    member do
      get :new_deposit, :new_withdrawal
      post :deposit, :withdraw
    end
  end

  get '/user' => 'users#show'
  get '/user/new_savings_account' => 'users#new_savings_account'
  post '/user/create_savings_account' => 'users#create_savings_account'

  root :to => "users#show"
end
