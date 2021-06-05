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
    usd_account.credit(Money.new(100, 'USD'))

    ars_account = @user.account_for_currency('ARS')

    post '/exchange_currencies', params: {
      source_currency: 'USD',
      source_amount: 100,
      destination_currency: 'ARS',
      exchange_rate: 100
    }

    assert_equal Money.new(10_000, 'ARS'), ars_account.balance
    assert_equal Money.new(0, 'USD'), usd_account.balance
  end
end
