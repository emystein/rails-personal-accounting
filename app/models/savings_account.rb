class SavingsAccount < ApplicationRecord
  belongs_to :user
  has_many :money_transactions

  def balance
    money_transactions.sum(&:amount)
  end

  def credit(amount)
    raise RuntimeError unless amount.to_i.positive?

    money_transactions.new(amount: amount)

    save
  end

  def debit(amount)
    raise RuntimeError unless amount.to_i.positive?

    money_transactions.new(amount: -amount.to_i)

    save
  end

  def exchange(source_currency, amount_in_source_currency, to_target_exchange_rate)
    source_account = user.savings_accounts.find { |a| a.currency == source_currency }
    source_account.debit(amount_in_source_currency)
    credit(amount_in_source_currency.to_f * to_target_exchange_rate.to_f)
  end
end
