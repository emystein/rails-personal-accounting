ExchangeRate = Struct.new(:source_currency, :target_currency, :rate) do
  def convert(amount)
    Money.from_amount(amount.amount * rate.to_d, target_currency)
  end
end
