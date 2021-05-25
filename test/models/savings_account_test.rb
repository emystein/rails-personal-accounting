require 'test_helper'

class SavingsAccountTest < ActiveSupport::TestCase
  test 'initial balance should be 0' do
    account = SavingsAccount.new

    assert account.balance == 0
  end

  test 'credit 10 should increase balance by 10' do
    account = SavingsAccount.new
    account.credit(10)

    assert account.balance == 10
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

    assert account.balance == 0
  end
end
