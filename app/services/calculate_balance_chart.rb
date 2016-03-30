class CalculateBalanceChart
  include Service

  def initialize(banks, dashboard_data)
    @banks = banks
    @dashboard_data = dashboard_data
  end

  def call
    balances = {}
    @banks.each do |bank|
      balances[bank.name] = []
      @dashboard_data[bank.name]["dates"].each_value{|v| balances[bank.name] << v[:balance]}
    end
    balances
  end
end
