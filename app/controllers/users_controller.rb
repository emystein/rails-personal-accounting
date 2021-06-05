class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @savings_accounts = current_user.savings_accounts
    @currencies = current_user.account_currencies
  end

  def new_operation_on_account
    currency = params[:operate_with][:currency]
    account = current_user.account_for_currency(currency)

    case params[:transaction]
    when 'deposit'
      redirect_to new_deposit_savings_account_url(account)
    when 'withdrawal'
      redirect_to new_withdrawal_savings_account_url(account)
    when 'currency_sale'
      redirect_to new_exchange_currency_url(currency: currency)
    end
  end

  def create_savings_account
    current_user.savings_accounts.create(currency: params[:currency])

    redirect_to :profile
  end
end
