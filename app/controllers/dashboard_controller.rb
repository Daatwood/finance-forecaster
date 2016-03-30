class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @bills = current_user.bills
    @banks = current_user.banks
    @exclusion = Exclusion.new
    @transactions = current_user.transactions
    @transaction = current_user.transactions.new
    @timespan = params[:timespan].to_i if params[:timespan]
    @timespan ||= 6
    @end_date = Time.now.to_date + @timespan.months
    @results = CalculateDashboardData.call(@banks, @timespan)
    # @results = {}
    # @banks.each do |bank|
    #   @results[bank.name] = {}
    #   logicals = []
    #   bank.bills.each do |bill|
    #     logicals += CalculateLogicalPayments.call(@end_date)
    #   end
    #   @results[bank.name]["dates"] = group_by_date(logicals)
    #   @results[bank.name]["alerts"] = setup_balance(bank.balance, @results[bank.name]["dates"])
    # end
    # Generate Chart Data
    @labels = @results[@banks.first.name]['dates'].keys
    @balances = CalculateBalanceChart.call(@banks, @results)
    # @balances = {}
    # @banks.each do |bank|
    #   @balances[bank.name] = []
    #   @results[bank.name]["dates"].each_value{|v| @balances[bank.name] << v[:balance]}
    # end
  end

  # private
  #
  # def group_by_date(logicals)
  #   dates = {}
  #   logicals.each do |payment|
  #     date = payment.date.strftime("%F")
  #     if dates[date].nil?
  #       dates[date] = {}
  #     end
  #     if dates[date][:payments].nil?
  #       dates[date][:payments] = []
  #     end
  #     dates[date][:payments] << payment
  #   end
  #   return dates
  # end
  #
  # def setup_balance(balance, dates)
  #   alerts = {}
  #   dates.each do |date, row|
  #     row[:summary] = row[:payments].map{|p| p.label}.join(", ")
  #     row[:change] = row[:payments].inject(0){|cng, pay| cng + pay.amount}
  #     row[:balance] = balance += row[:change]
  #     #@balances << row[:balance]
  #     if balance < 0
  #       row[:alert] = 'danger'
  #       alerts[date] = {alert: 'Account below Zero', balance: balance}
  #     elsif balance < 350
  #       row[:alert] = 'warning'
  #       alerts[date] = {alert: 'Account below Warning', balance: balance}
  #     end
  #   end
  #   return alerts
  # end

end
