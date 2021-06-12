require 'test_helper'
require 'money'

class SavingsAccountTest < ActiveSupport::TestCase
  setup do
    @ars_account = SavingsAccount.new(currency: 'ARS')
    @usd_account = SavingsAccount.new(currency: 'USD')

    @ars5 = Money.from_amount(5, 'ARS')
    @ars10 = Money.from_amount(10, 'ARS')
    @dollars10 = Money.from_amount(10, 'USD')
  end

  test 'initial balance should be 0' do
    assert @ars_account.balance.zero?
  end

  test 'credit 10 should increase balance by 10' do
    @ars_account.credit(@ars10)

    assert @ars_account.balance == @ars10
  end

  test 'credit negative amount should throw an error' do
    assert_raises RuntimeError do
      @ars_account.credit(Money.from_amount(-10, 'ARS'))
    end
  end

  test 'credit 10 debit 5 should set balance to 5' do
    @ars_account.credit(@ars10)
    @ars_account.debit(@ars5)

    assert @ars_account.balance == @ars5
  end

  test 'debit negative amount should throw an error' do
    assert_raises RuntimeError do
      @ars_account.debit(Money.from_amount(-10, 'ARS'))
    end
  end

  test 'debit below balance should throw an error' do
    assert_raises RuntimeError do
      @ars_account.debit(@ars10)
    end
  end

  test 'reject credit different currency' do
    assert_raises RuntimeError do
      @ars_account.credit(@dollars10)
    end
  end

  test 'reject debit different currency' do
    @ars_account.credit(@ars10)

    assert_raises RuntimeError do
      @ars_account.debit(@dollars10)
    end
  end

  test 'sell 10 USD to ARS account' do
    @usd_account.credit(@dollars10)

    Money.add_rate('USD', 'ARS', 100)

    @usd_account.sell_money_to_account(@dollars10, @ars_account)

    assert @usd_account.balance.zero?
    assert @ars_account.balance.amount == 1000
  end

  test 'reject sell money with different currency than source account' do
    @usd_account.credit(@dollars10)

    assert_raises RuntimeError do
      @usd_account.sell_money_to_account(@ars10, @ars_account)
    end
  end
end
