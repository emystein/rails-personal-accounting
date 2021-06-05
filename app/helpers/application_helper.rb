module ApplicationHelper
  def usd
    Money::Currency.new('USD')
  end

  def ars
    Money::Currency.new('ARS')
  end
end
