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
    usd_account.credit(100)

    ars_account = @user.account_for_currency('ARS')

    post '/exchange_currencies', params: {
      source_currency: 'USD',
      source_amount: 100,
      destination_currency: 'ARS',
      exchange_rate: 100
    }

    assert_equal 10_000, ars_account.balance
    assert_equal 0, usd_account.balance
  end
end
