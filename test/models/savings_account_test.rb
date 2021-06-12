require 'test_helper'
require 'money'

class SavingsAccountTest < ActiveSupport::TestCase
  setup do
    @ars_account = SavingsAccount.new(currency: 'ARS')
    @usd_account = SavingsAccount.new(currency: 'USD')
    @dollars_10 = Money.from_amount(10, 'USD')
  end

  test 'initial balance should be 0' do
    assert @ars_account.balance.zero?
  end

  test 'credit 10 should increase balance by 10' do
    @ars_account.credit(Money.from_amount(10, 'ARS'))

    assert @ars_account.balance == Money.from_amount(10, 'ARS')
  end

  test 'credit negative amount should throw an error' do
    assert_raises RuntimeError do
      @ars_account.credit(Money.from_amount(-10, 'ARS'))
    end
  end

  test 'credit 20 debit 15 should set balance to 5' do
    @ars_account.credit(Money.from_amount(20, 'ARS'))
    @ars_account.debit(Money.from_amount(15, 'ARS'))

    assert @ars_account.balance == Money.from_amount(5, 'ARS')
  end

  test 'debit negative amount should throw an error' do
    assert_raises RuntimeError do
      @ars_account.debit(Money.from_amount(-10, 'ARS'))
    end
  end

  test 'debit below balance should throw an error' do
    assert_raises RuntimeError do
      @ars_account.debit(Money.from_amount(10, 'ARS'))
    end
  end

  test 'reject credit different currency' do
    assert_raises RuntimeError do
      @ars_account.credit(Money.from_amount(10, 'USD'))
    end
  end

  test 'reject debit different currency' do
    @ars_account.credit(Money.from_amount(20, 'ARS'))

    assert_raises RuntimeError do
      @ars_account.debit(Money.from_amount(10, 'USD'))
    end
  end

  test 'sell 10 USD to ARS account' do
    @usd_account.credit(@dollars_10)

    Money.add_rate('USD', 'ARS', 100)

    @usd_account.sell_money_to_account(@dollars_10, @ars_account)

    assert @usd_account.balance == Money.from_amount(0, 'USD')
    assert @ars_account.balance == Money.from_amount(1000, 'ARS')
  end

  test 'reject sell money with different currency than source account' do
    @usd_account.credit(@dollars_10)

    ars_10 = Money.from_amount(10, 'ARS')

    assert_raises RuntimeError do
      @usd_account.sell_money_to_account(ars_10, @ars_account)
    end
  end
end
