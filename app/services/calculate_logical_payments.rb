# Creates logical payments(an in-memory model) that is used for forecasting.
# These logical payments can be marked 'paid' which creates payment.
# Payments are exceptions to the recurrence rule

# Bills are templates that hold data for recurrences of themselves.
# Recurrences define the actual dates and repeating and even a variable amount

# Recurrences cannot happen more than once a day for a single bill
# Exclusions are kept at bill level to prevent any recurrences from happening
class CalculateLogicalPayments
  include Service

  def initialize(bank, end_date=Time.now.to_date + 6.months)
    @bank = bank
    @end_date = end_date
  end

  def call
    logical_payments = []

    bills = @bank.bills
    bills.each do |bill|
      recurrences = bill.recurrences
      recurrences.each do |recurrence|
        current_increment = recurrence.interval
        current_date = recurrence.active_at.to_date
        until current_date > @end_date do
          if current_increment % recurrence.interval == 0
            amt = recurrence.bill.expense? ? -recurrence.amount : recurrence.amount
            logical_payments << Logical::Payment.new(current_date,@bank,@bank.balance,amt,recurrence.note,recurrence)
            #puts "Creating LP: #{current_date}"
          end
          advancement = recurrence.basic_frequency
          if advancement == 0
            next
            #return logical_payments
          end
          current_date += advancement
          current_increment += 1
          unless recurrence.forever?
            next if current_date > recurrence.expires_at.to_date
            # return logical_payments
          end
        end
        puts "Deleted: #{logical_payments.delete_if{|pay| bill.invalid_date?(pay.date) }.count}"
        logical_payments = logical_payments.delete_if{|pay| bill.invalid_date?(pay.date) }
        logical_payments.uniq!
      end # bill.recurrences.each do |recurrence|
      logical_payments.uniq!
    end # @bank.bills.each do |bill|
    logical_payments.uniq.sort { |a,b| a.date <=> b.date }
  end

end
