class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @bills = current_user.bills
    @transaction = current_user.bank.transactions.new

    @forecast = ForecastTransactions.call(current_user)

    @chart_data = CalculateBalanceChart.call(@forecast)




    #@bills = current_user.bills
    #@transaction = current_user.bank.transaction.new
    

    # @bills = current_user.bills
    # @bill = current_user.bank.bills.new
    # @bank = current_user.bank
    # @transaction = current_user.bank.transactions.new
    # @timespan = params[:timespan].to_i.months if params[:timespan]
    # @timespan ||= 1.months
    # @end_date = Time.now.to_date + @timespan.months
    # # Generate Chart Data
    # unless @bills.blank? && 0==0
    #   @results = CalculateDashboardData.call(@bank, @timespan)
    #   @labels = @results['dates'].keys
    #   @chart_labels = (@labels.collect!{|x| x[5..9]}).to_s.gsub('"',"'")
    #   @balances = CalculateBalanceChart.call(@bank, @results)
    #   @chart_data = @balances.to_json
    #   @chart_color = "#0b8b6f" # TODO quick fix
    # end
  end
end
