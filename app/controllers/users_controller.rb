class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @savings_accounts = current_user.savings_accounts
  end

  def create_savings_account
    current_user.savings_accounts.create(currency: params[:currency])

    redirect_to :profile
  end

  def new_exchange_currency

  end

  def create_exchange_currency
    source_currency = params[:source_currency]
    target_currency = params[:destination_currency]

    current_user.exchange_currency(source_currency,
                                   params[:source_amount],
                                   target_currency,
                                   ExchangeRate.new(source_currency, target_currency, params[:exchange_rate]))
    redirect_to :profile
  end
end
