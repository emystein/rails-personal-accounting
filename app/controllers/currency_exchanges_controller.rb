class CurrencyExchangesController < ApplicationController
  before_action :authenticate_user!

  def new
    @currencies = current_user.account_currencies
    @currency_to_sell = params[:currency_to_sell]
    @first_currency_to_buy = @currencies.find { |c| c != @currency_to_sell }
  end

  def create
    currency_to_sell = params[:currency_to_sell]
    currency_to_buy = params[:currency_to_buy]

    current_user.exchange_currency(Money.from_amount(params[:amount_to_sell].to_d, currency_to_sell),
                                   currency_to_buy,
                                   ExchangeRate.new(currency_to_sell, currency_to_buy, params[:exchange_rate]))
    redirect_to :profile
  end
end
