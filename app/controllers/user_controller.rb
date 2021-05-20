class UserController < ApplicationController
  before_action :authenticate_user!

  def show
    @savings_accounts = current_user.savings_accounts
  end

  def new_savings_account

  end

  def create_savings_account
    current_user.savings_accounts.create(currency: params[:currency])

    redirect_to user_url
  end
end
