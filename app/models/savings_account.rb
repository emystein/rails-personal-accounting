class SavingsAccount < ApplicationRecord
  belongs_to :user
  has_many :money_transactions
end
