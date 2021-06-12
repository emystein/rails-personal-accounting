class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_default_accounts

  has_many :savings_accounts

  def exchange_currency(amount_to_sell, currency_to_buy, exchange_rate)
    Money.add_rate(amount_to_sell.currency, currency_to_buy, exchange_rate)

    account_for_currency(amount_to_sell.currency)
      .sell_money_to_account(amount_to_sell, account_for_currency(currency_to_buy))
  end

  def account_for_currency(currency)
    savings_accounts.find { |a| a.currency == currency }
  end

  def account_currencies
    savings_accounts.map(&:currency)
  end

  def create_default_accounts
    Bank.default_currencies.map { |c| savings_accounts.create(currency: c) }
  end
end
