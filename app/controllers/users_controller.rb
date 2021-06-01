class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @savings_accounts = current_user.savings_accounts
  end

  def create_savings_account
    current_user.savings_accounts.create(currency: params[:currency])

    redirect_to user_url
  end

  def exchange_currency
    source_currency = params[:source_currency]
    target_currency = params[:destination_currency]
    exchange_rate_to_destination = params[:exchange_rate_to_destination]

    current_user.exchange_currency(source_currency,
                                   params[:amount_in_source_currency],
                                   target_currency,
                                   ExchangeRate.new(source_currency, target_currency, exchange_rate_to_destination))
    redirect_to :profile
  end
end
