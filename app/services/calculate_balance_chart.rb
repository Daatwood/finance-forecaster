class CalculateBalanceChart
  include Service

  def initialize(forecast)
    @forecast = forecast
  end

  def call
    @forecast.reduce({}, :merge).each_with_object([]) do |(date,transactions),arr|
      arr << [date, transactions.last[:balance]]
    end
  end
end
