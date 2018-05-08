class CalculateBalanceChart
  include Service

  def initialize(bank, dashboard_data)
    @bank = bank
    @dashboard_data = dashboard_data
  end

  def call
    balances = []
    @dashboard_data["dates"].each_value{|v| balances << v[:balance]}
    balances
  end
end
