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

  def exchange_money(money, to_account)
    raise RuntimeError unless to_account.currency != currency

    debit(money)

    to_account.credit_exchange(money)
  end

  def credit_exchange(money)
    credit(money.exchange_to(currency))
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
