require 'test_helper'
require 'money'

class UserTest < ActiveSupport::TestCase
  test 'exchange currency' do
    user = users(:one)

    usd_account = user.account_for_currency('USD')
    usd_account.credit(100)

    ars_account = user.account_for_currency('ARS')

    user.exchange_currency(Money.us_dollar(100), 'ARS', ExchangeRate.new('USD', 'ARS', 100))

    assert_equal 10_000, ars_account.balance
    assert_equal 0, usd_account.balance
  end

  test 'reject exchange same currency' do
    user = users(:one)

    assert_raises RuntimeError do
      user.exchange_currency(Money.us_dollar(100), 'USD', ExchangeRate.new('USD', 'USD', 1))
    end
  end
end
