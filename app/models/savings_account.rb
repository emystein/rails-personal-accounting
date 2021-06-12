require 'money'

class SavingsAccount < ApplicationRecord
  belongs_to :user
  has_many :money_transactions

  def balance
    Money.from_amount(money_transactions.sum(&:amount), currency)
  end

  def credit(money)
    check_transaction_allows(money)

    add_transaction(money)
  end

  def debit(money)
    check_transaction_allows(money)

    raise RuntimeError unless money <= balance

    add_transaction(-money)
  end

  def sell_money_to_account(money_to_sell, destination_account)
    raise RuntimeError unless destination_account.currency != currency

    debit(money_to_sell)

    destination_account.credit_exchange(money_to_sell)
  end

  def credit_exchange(money_to_sell)
    credit(money_to_sell.exchange_to(currency))
  end

  private

  def check_transaction_allows(money)
    raise RuntimeError unless money.currency == currency && money.positive?
  end

  def add_transaction(money)
    money_transactions.new(amount: money.amount)

    save
  end
end
