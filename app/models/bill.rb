# Interacts directly with bank
class Bill < ActiveRecord::Base
  belongs_to :account
  belongs_to :bank
  has_many :recurrences
  has_many :exclusions
  has_many :payments

  validates_presence_of :summary
  validates_presence_of :amount

  # Creates logical payments(an in-memory model) that is used for forecasting.
  # These logical payments can be marked 'paid' which creates payment.
  # Payments are exceptions to the recurrence rule

  # Bills are templates that hold data for recurrences of themselves.
  # Recurrences define the actual dates and repeating and even a variable amount

  # Recurrences cannot happen more than once a day for a single bill
  # Exclusions are kept at bill level to prevent any recurrences from happening
  def create_logical_payments
    # Loop each recurrence
    logical_payments = []
    recurrences.each do |recur|
      logical_payments += recur.create_logical_payments.delete_if{|pay| valid_date?(pay.date) }
    end
    logical_payments.uniq.sort! { |a,b| a.date <=> b.date }
  end

  def valid_date?(date)
    exclusions.map(&:date).include? date
  end

end
