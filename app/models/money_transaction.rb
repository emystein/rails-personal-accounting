class MoneyTransaction < ApplicationRecord
  belongs_to :savings_account

  scope :order_desc, -> { order('created_at DESC') }
end
