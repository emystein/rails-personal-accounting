class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @savings_accounts = current_user.savings_accounts
    @currencies = current_user.account_currencies
    @operations = {
      deposit: 'Deposit',
      withdrawal: 'Withdraw',
      currency_sale: 'Sell'
    }
  end

  def new_operation_on_account
    currency = params[:operate_with][:currency]
    account = current_user.account_for_currency(currency)

    case params[:operation]
    when 'deposit'
      redirect_to new_deposit_savings_account_url(account)
    when 'withdrawal'
      redirect_to new_withdrawal_savings_account_url(account)
    when 'currency_sale'
      redirect_to new_currency_exchange_url(currency_to_sell: currency)
    end
  end

  def create_savings_account
    current_user.savings_accounts.create(currency: params[:currency])

    redirect_to :profile
  end
end
