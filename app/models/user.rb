class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :savings_accounts

  after_create :create_default_accounts

  def exchange_currency(money, to_currency, exchange_rate)
    from_currency = money.currency

    Money.add_rate(from_currency, to_currency, exchange_rate)

    from_account = account_in(from_currency)
    to_account = account_in(to_currency)

    from_account.exchange_money(money, to_account)
  end

  def account_in(currency)
    savings_accounts.find { |a| a.currency == currency }
  end

  def currencies
    savings_accounts.map(&:currency)
  end

  private

  def create_default_accounts
    Bank.default_currencies.map { |c| savings_accounts.create(currency: c) }
  end
end
