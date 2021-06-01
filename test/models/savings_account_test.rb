require 'test_helper'

class SavingsAccountTest < ActiveSupport::TestCase
  test 'initial balance should be 0' do
    account = SavingsAccount.new

    assert account.balance.zero?
  end

  test 'credit 10 should increase balance by 10' do
    account = SavingsAccount.new
    account.credit(10)

    assert account.balance == 10
  end

  test 'credit negative amount should throw an error' do
    account = SavingsAccount.new

    assert_raises RuntimeError do
      account.credit(-10)
    end
  end

  test 'debit 10 should decrease balance by 10' do
    account = SavingsAccount.new
    account.debit(10)

    assert account.balance == -10
  end

  test 'credit 10 debit 10 should set balance to 0' do
    account = SavingsAccount.new
    account.credit(10)
    account.debit(10)

    assert account.balance.zero?
  end

  test 'debit negative amount should throw an error' do
    account = SavingsAccount.new

    assert_raises RuntimeError do
      account.debit(-10)
    end
  end

  test 'buy currency' do
    usd_account = savings_accounts(:user1_usd_account)
    usd_account.credit(100)

    ars_account = savings_accounts(:user1_ars_account)
    ars_account.exchange('USD', 100, 100)

    assert_equal 10_000, ars_account.balance
    assert_equal 0, usd_account.balance
  end
end
