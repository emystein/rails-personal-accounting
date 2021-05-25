class SavingsAccount < ApplicationRecord
  belongs_to :user
  has_many :money_transactions

  def balance
    money_transactions.sum(&:amount)
  end

  def credit(amount)
    money_transactions.new(amount: amount)
    save
  end

  def debit(amount)
    money_transactions.new(amount: - amount.to_i)
    save
  end
end
