require 'test_helper'
require 'money'

class SavingsAccountTest < ActiveSupport::TestCase
  test 'initial balance should be 0' do
    account = SavingsAccount.new(currency: 'ARS')

    assert account.balance.zero?
  end

  test 'credit 10 should increase balance by 10' do
    account = SavingsAccount.new(currency: 'ARS')
    account.credit(Money.new(10, 'ARS'))

    assert account.balance == Money.new(10, 'ARS')
  end

  test 'credit negative amount should throw an error' do
    account = SavingsAccount.new(currency: 'ARS')

    assert_raises RuntimeError do
      account.credit(Money.new(-10, 'ARS'))
    end
  end

  test 'credit 20 debit 15 should set balance to 5' do
    account = SavingsAccount.new(currency: 'ARS')
    account.credit(Money.new(20, 'ARS'))
    account.debit(Money.new(15, 'ARS'))

    assert account.balance == Money.new(5, 'ARS')
  end

  test 'debit negative amount should throw an error' do
    account = SavingsAccount.new(currency: 'ARS')

    assert_raises RuntimeError do
      account.debit(Money.new(-10, 'ARS'))
    end
  end

  test 'debit below balance should throw an error' do
    account = SavingsAccount.new(currency: 'ARS')

    assert_raises RuntimeError do
      account.debit(Money.new(10, 'ARS'))
    end
  end
end
