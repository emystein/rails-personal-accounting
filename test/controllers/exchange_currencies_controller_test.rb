require 'test_helper'

class ExchangeCurrenciesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)

    sign_in @user

    MoneyTransaction.delete_all
  end

  test 'exchange currencies' do
    usd_account = @user.account_for_currency('USD')
    usd_account.credit(Money.from_amount(100, 'USD'))

    ars_account = @user.account_for_currency('ARS')

    post '/exchange_currencies', params: {
      currency_to_sell: 'USD',
      amount_to_sell: 100,
      currency_to_buy: 'ARS',
      exchange_rate: 100
    }

    assert_equal Money.from_amount(10_000, 'ARS'), ars_account.balance
    assert_equal Money.from_amount(0, 'USD'), usd_account.balance
  end
end
