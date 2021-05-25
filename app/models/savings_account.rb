class SavingsAccount < ApplicationRecord
  belongs_to :user
  has_many :money_transactions

  def balance
    money_transactions.sum(&:amount)
  end

  def credit(amount)
    self.money_transactions.new(direction: 'deposit', amount: amount)
    self.save
  end

  def debit(amount)
    self.money_transactions.new(direction: 'withdrawal', amount: - amount.to_i)
    self.save
  end
end
