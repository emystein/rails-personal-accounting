class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :savings_accounts

  def exchange_currency(source_amount, target_currency, exchange_ratio)
    raise RuntimeError unless target_currency != source_amount.currency

    account_for_currency(source_amount.currency)
      .debit(source_amount.cents)

    account_for_currency(target_currency)
      .credit(exchange_ratio.convert(source_amount))
  end

  def account_for_currency(currency)
    savings_accounts.find { |a| a.currency == currency }
  end

  def account_currencies
    savings_accounts.map(&:currency)
  end
end
