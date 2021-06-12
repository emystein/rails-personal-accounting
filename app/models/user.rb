class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_default_accounts

  has_many :savings_accounts

  def exchange_currency(source_amount, destination_currency, exchange_rate)
    Money.add_rate(source_amount.currency, destination_currency, exchange_rate)

    destination_account = account_for_currency(destination_currency)

    account_for_currency(source_amount.currency).sell_money_to_account(source_amount, destination_account)
  end

  def account_for_currency(currency)
    savings_accounts.find { |a| a.currency == currency }
  end

  def account_currencies
    savings_accounts.map(&:currency)
  end

  def create_default_accounts
    savings_accounts.create(currency: 'ARS')
    savings_accounts.create(currency: 'USD')
  end
end
