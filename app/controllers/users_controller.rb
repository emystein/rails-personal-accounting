class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @savings_accounts = current_user.savings_accounts
    @currencies = current_user.currencies
  end

  def create_savings_account
    current_user.savings_accounts.create(currency: params[:currency])

    redirect_to :profile
  end
end
