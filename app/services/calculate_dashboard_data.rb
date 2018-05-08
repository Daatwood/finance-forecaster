class CalculateDashboardData
  include Service

  def initialize(bank, timespan = 1.month)
    @bank = bank
    @timespan = timespan
  end

  def call
    results = {}
    logicals = []
    @bank.bills.each do |bill|
      logicals += CalculateLogicalPayments.call(@bank, Time.now.to_date + @timespan)
    end
    results["dates"] = group_by_date(logicals)
    results["alerts"] = setup_balance(@bank.balance, results["dates"])
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
