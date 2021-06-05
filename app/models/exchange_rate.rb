ExchangeRate = Struct.new(:source_currency, :target_currency, :rate) do
  def convert(amount)
    Money.new(amount.cents * rate.to_f, target_currency)
  end
end
