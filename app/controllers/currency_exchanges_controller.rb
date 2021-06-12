class CurrencyExchangesController < ApplicationController
  before_action :authenticate_user!

  def new
    @currencies = current_user.account_currencies
    @currency_to_sell = params[:currency_to_sell]
    @first_currency_to_buy = @currencies.find { |c| c != @currency_to_sell }
  end

  def create
    current_user.exchange_currency(money_to_sell,
                                   params[:currency_to_buy],
                                   params[:exchange_rate])
    redirect_to :profile
  end

  def money_to_sell
    Money.from_amount(params[:amount_to_sell].to_d, params[:currency_to_sell])
  end
end
