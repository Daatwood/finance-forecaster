class CalculateDashboardData
  include Service

  def initialize(banks, timespan = 6)
    @banks = banks
    @timespan = timespan
  end

  def call
    results = {}
    @banks.each do |bank|
      results[bank.name] = {}
      logicals = []
      bank.bills.each do |bill|
        logicals += CalculateLogicalPayments.call(bank, Time.now.to_date + @timespan.months)
      end
      results[bank.name]["dates"] = group_by_date(logicals)
      results[bank.name]["alerts"] = setup_balance(bank.balance, results[bank.name]["dates"])
    end
    results
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
