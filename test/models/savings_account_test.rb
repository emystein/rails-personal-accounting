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

  test 'credit 20 debit 15 should set balance to 5' do
    account = SavingsAccount.new
    account.credit(20)
    account.debit(15)

    assert account.balance == 5
  end

  test 'debit negative amount should throw an error' do
    account = SavingsAccount.new

    assert_raises RuntimeError do
      account.debit(-10)
    end
  end

  test 'debit below balance should throw an error' do
    account = SavingsAccount.new

    assert_raises RuntimeError do
      account.debit(10)
    end
  end
end
