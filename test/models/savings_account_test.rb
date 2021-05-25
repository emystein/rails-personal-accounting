require 'test_helper'

class SavingsAccountTest < ActiveSupport::TestCase
  test 'initial balance should be 0' do
    account = SavingsAccount.new

    assert account.balance == 0
  end

  test 'deposit 10 should increase balance by 10' do
    account = SavingsAccount.new
    account.money_transactions.new(direction: 'deposit', amount: 10)
    account.save

    assert account.balance == 10
  end

  test 'withdraw 10 should decrease balance by 10' do
    account = SavingsAccount.new
    account.money_transactions.new(direction: 'deposit', amount: 10)
    account.money_transactions.new(direction: 'withdrawal', amount: 10)
    account.save

    assert account.balance == 0
  end
end
