require 'money'

class SavingsAccount < ApplicationRecord
  belongs_to :user
  has_many :money_transactions

  def balance
    Money.new(money_transactions.sum(&:amount), currency)
  end

  def credit(amount)
    amount = Money.new(amount, currency) unless amount.is_a?(Money)

    raise RuntimeError unless amount.positive?

    money_transactions.new(amount: amount.cents)

    save
  end

  def debit(amount)
    amount = Money.new(amount, currency) unless amount.is_a?(Money)

    raise RuntimeError unless amount.positive? && amount <= balance

    money_transactions.new(amount: -amount.cents)

    save
  end
end
