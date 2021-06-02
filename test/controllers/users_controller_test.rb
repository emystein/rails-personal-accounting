require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)

    sign_in @user

    MoneyTransaction.delete_all
  end

  test 'exchange currency' do
    usd_account = @user.account_for_currency('USD')
    usd_account.credit(100)

    ars_account = @user.account_for_currency('ARS')

    post '/user/exchange_currency', params: {
      source_currency: 'USD',
      source_amount: 100,
      destination_currency: 'ARS',
      exchange_rate: 100
    }

    assert_equal 10_000, ars_account.balance
    assert_equal 0, usd_account.balance
  end
end
