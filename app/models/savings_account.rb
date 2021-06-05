require 'money'

class SavingsAccount < ApplicationRecord
  belongs_to :user
  has_many :money_transactions

  def balance
    Money.new(money_transactions.sum(&:amount), currency)
  end

  def credit(money)
    check_transaction_allows(money)

    add_money_transaction(money)
  end

  def debit(money)
    check_transaction_allows(money)

    raise RuntimeError unless money <= balance

    add_money_transaction(-money)
  end

  private

  def check_transaction_allows(money)
    raise RuntimeError unless money.currency == currency && money.positive?
  end

  def add_money_transaction(money)
    money_transactions.new(amount: money.cents)

    save
  end
end
