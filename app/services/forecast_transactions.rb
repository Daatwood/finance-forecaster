=begin

Forecast Transactions

Transverse all user's recurrences and create a transaction hash for each 
occurance until end_date is reached for that recurrence. Will not include 
transactions that the same parent bill and share a matching exclusion date. Once
list of transaction hashes is gather, its sorted by date and user's current
balance is ran through each transaction saving the resulting balance in the
transaction hash.

=end
class ForecastTransactions
  include Service

  def initialize(user, end_date = Date.current + 3.month, limit=365)
    @user = user
    @until = end_date.to_date
    @limit = limit
  end

  def call
    forecast = {}
    @user.recurrences.find_each do |re|
      @tdate = re.active_at.to_date
      begin
        # Do not add if parent has a exlusion for the date
        if valid_date?(re.bill_id, @tdate)
          forecast[@tdate.to_s] ||= []
          forecast[@tdate.to_s] << build_transaction(re)
        end
        # Recurrence stop here if frequency is 'once'
        break if re.once?
        # Recurrence stops once it exceeded the expiration date
        break if (!re.expires_at.nil? && @tdate > re.expires_at.to_date)
        # Move date to next due date
        @tdate += re.frequency_time
      end while (@tdate < @until)
    end
    simulate_balance(forecast)
  end

  #private

  def build_transaction(recurrence)
    { 
      summary: summary_and_blackouts[recurrence.bill_id][:summary],
      note: recurrence.note,
      amount: recurrence.amount,
      recurrence_id: recurrence.id,
      bill_id: recurrence.bill_id
    }
  end

  def valid_date?(bill_id, date)
    bill = summary_and_blackouts[bill_id]
    return true if bill.nil?
    !bill[:blackouts].include?(date.to_s)
  end

  def summary_and_blackouts
    @summary_and_blackouts ||= @user.bills.includes(:exclusions)
      .pluck('exclusions.date', 'bills.id', 'bills.summary')
      .each_with_object({}) do |(date,bill_id, summary),hsh| 
        hsh[bill_id] ||= {}
        hsh[bill_id][:blackouts] ||= []
        hsh[bill_id][:blackouts] << date.to_date.to_s unless date.nil?
        hsh[bill_id][:summary] ||= summary
      end
  end

  # Sort the forecast and step through each transaction, saving every step
  def simulate_balance(forecast)
    balance = @user.bank.balance
    forecast.sort.map do |date, transactions|
      transactions = transactions.each do |transaction| 
        transaction[:balance] = balance += transaction[:amount]
      end
      { date => transactions }
    end
  end

end
