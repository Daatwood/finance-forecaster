=begin

Forecast Transactions

Gather all recurrences and create Forecast::Transaction
Keeping in mind of exception dates
Cycle through transactions and keeping a running balance

Returns an array of Forecast::Transaction 

Whe

=end
class ForecastTransactions
  include Service

  def initialize(user, end_date = Date.current + 3.month, limit=2000)
    @user = user
    @until = end_date.to_date
    @limit = limit
  end

  def call
    forecast = []
    @user.recurrences.find_each do |re|
      blackouts = re.bill.exclusions.pluck(:date).map(&:to_date)
      @date = re.active_at.to_date
      begin 
        forecast << {@date.to_s =>  forecast(re) } if !(blackouts.include? @date)
        timechange = re.advance_frequency
        break if timechange == 0
        break if !re.forever? && @date > re.expires_at.to_date
        @date += timechange
        break if forecast.count > @limit
      end while (@date < @until)
    end
    forecast.sort { |a,b| a.keys.first <=> b.keys.first }
    balance = @user.bank.balance
    forecast.map do |f|
      f.each_pair do |k,v|
        balance += v[:amount]
        v[:balance] = balance 
      end
    end
  end

  private

  def forecast(recurrence)
    { 
      summary: recurrence.bill.summary,
      note: recurrence.note,
      amount: recurrence.amount * (recurrence.bill.expense? ? -1 : 1),
      recurrence_id: recurrence.id,
      bill_id: recurrence.bill_id
    }
  end

end