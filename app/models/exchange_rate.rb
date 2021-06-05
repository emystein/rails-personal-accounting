ExchangeRate = Struct.new(:source_currency, :target_currency, :rate) do
  def convert(amount)
    amount.cents * rate.to_f
  end
end
