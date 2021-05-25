class SavingsAccount < ApplicationRecord
  belongs_to :user
  has_many :money_transactions

  def balance
    money_transactions.filter{ |t| t.direction == 'deposit' }.sum(&:amount) -
      money_transactions.filter{ |t| t.direction == 'withdrawal' }.sum(&:amount)
  end
end
