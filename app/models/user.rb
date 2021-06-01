class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :savings_accounts

  def exchange_currency(source_currency, source_amount, target_currency, exchange_ratio)
    account_for_currency(source_currency).debit(source_amount)

    account_for_currency(target_currency).credit(exchange_ratio.convert(source_amount))
  end

  def account_for_currency(currency)
    savings_accounts.find { |a| a.currency == currency }
  end
end
