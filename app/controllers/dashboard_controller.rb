class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @bills = current_user.bills
    @transaction = current_user.bank.transactions.new

    @forecast = ForecastTransactions.call(current_user)

    @chart_data = CalculateBalanceChart.call(@forecast)
  end
end
