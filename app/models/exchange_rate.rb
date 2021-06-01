ExchangeRate = Struct.new(:source_currency, :target_currency, :rate) do
  def convert(amount)
    amount.to_f * rate.to_f
  end
end
