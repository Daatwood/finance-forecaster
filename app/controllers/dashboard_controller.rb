class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @bills = current_user.bills
    @banks = current_user.banks
    @exclusion = Exclusion.new
    @transactions = current_user.transactions
    @transaction = current_user.transactions.new

    # @transactions.each do |transaction|
    #   @logicals << Logical::Payment.new(transaction,transaction.amount,transaction.date)
    # end
    #@balance = 0
    #@banks.all.map{|x| @balance += x.balance}
    #

    @results = {}
    @banks.each do |bank|
      @results[bank.name] = {}
      logicals = []
      bank.bills.each do |bill|
        logicals += bill.create_logical_payments
      end
      logicals.sort! { |a,b| a.date <=> b.date }
      @results[bank.name]["dates"] = group_by_date(logicals)
      @results[bank.name]["alerts"] = setup_balance(bank.balance, @results[bank.name]["dates"])

    end

    # Generate Chart Data
    @balances = {}
    @labels = @results[@banks.first.name]['dates'].keys
    @banks.each do |bank|
      @balances[bank.name] = []
      @results[bank.name]["dates"].each_value{|v| @balances[bank.name] << v[:balance]}
    end

    # Group Payments by date.
    #group_by_date
    # Set summary, change and balance
    #setup_balance
    p @balances.inspect
  end

  private

  def group_by_date(logicals)
    dates = {}
    logicals.each do |payment|
      date = payment.date.strftime("%F")
      if dates[date].nil?
        dates[date] = {}
      end
      if dates[date][:payments].nil?
        dates[date][:payments] = []
      end
      dates[date][:payments] << payment
    end
    return dates
  end

  def setup_balance(balance, dates)
    alerts = {}
    dates.each do |date, row|
      row[:summary] = row[:payments].map{|p| p.label}.join(", ")
      row[:change] = row[:payments].inject(0){|cng, pay| cng + pay.amount}
      row[:balance] = balance += row[:change]
      #@balances << row[:balance]
      if balance < 0
        row[:alert] = 'danger'
        alerts[date] = {alert: 'Account below Zero', balance: balance}
      elsif balance < 350
        row[:alert] = 'warning'
        alerts[date] = {alert: 'Account below Warning', balance: balance}
      end
    end
    return alerts
  end

end
