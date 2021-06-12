require 'test_helper'
require 'money'

class UserTest < ActiveSupport::TestCase
  test 'exchange currency' do
    user = users(:one)

    usd_account = user.account_for_currency('USD')
    usd_account.credit(Money.new(100, 'USD'))

    ars_account = user.account_for_currency('ARS')

    user.exchange_currency(Money.us_dollar(100), 'ARS', 100)

    assert_equal Money.new(10_000, 'ARS'), ars_account.balance
    assert usd_account.balance.zero?
  end

  test 'reject exchange same currency' do
    user = users(:one)

    assert_raises RuntimeError do
      user.exchange_currency(Money.us_dollar(100), 'USD', 1)
    end
  end
end
