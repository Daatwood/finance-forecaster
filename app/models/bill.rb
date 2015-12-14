# Interacts directly with bank
class Bill < ActiveRecord::Base
  belongs_to :account
  belongs_to :bank
  has_many :recurrences
  has_many :exclusions

  validates_presence_of :summary
  validates_presence_of :amount

  # Creates logical payments(an in-memory model) that is used for forecasting.
  # These logical payments can be marked 'paid' which creates payment.
  # Payments are exceptions to the recurrence rule

  # Bills are templates that hold data for recurrences of themselves.
  # Recurrences define the actual dates and repeating and even a variable amount

  # Recurrences cannot happen more than once a day for a single bill
  # Exclusions are kept at bill level to prevent any recurrences from happening
  def create_logical_payments(end_date=Time.now.to_date + 6.months)
    # Loop each recurrence
    logical_payments = []
    recurrences.each do |recur|
      logical_payments += recur.create_logical_payments(end_date).delete_if{|pay| invalid_date?(pay.date) }
    end
    #transactions.each do |payment|
    #  logical_payments << Logical::Payment.new(self,payment.amount,payment.date, true) unless payment.date.nil?
    #end
    logical_payments.uniq.sort! { |a,b| a.date <=> b.date }
  end

  def invalid_date?(date)
    invalid = exclusions.map(&:date).include? date
    invalid = transactions.map(&:date).include? date unless invalid
    invalid
  end

  def transactions
    bank.transactions.where(bill_id: self.id)
  end

  def expense?
    bill_type == "DEBIT"
  end

  def income?
    bill_type == "CREDIT"
  end

  def account_name
    account.name
  end

end
