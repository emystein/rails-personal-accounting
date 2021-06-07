class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @savings_accounts = current_user.savings_accounts
    @currencies = current_user.account_currencies
    @operations = {
      new_deposit: 'Deposit',
      new_withdrawal: 'Withdraw',
      new_currency_sale: 'Sell'
    }
  end

  def new_operation_on_account
    currency = params[:operate_with][:currency]
    account = current_user.account_for_currency(currency)
    redirect_to "/savings_accounts/#{account.id}/#{params[:operation]}"
  end

  def create_savings_account
    current_user.savings_accounts.create(currency: params[:currency])

    redirect_to :profile
  end
end
