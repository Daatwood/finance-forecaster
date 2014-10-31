# Interacts directly with bank
class Bill < ActiveRecord::Base
  belongs_to :account
  belongs_to :bank
  has_many :recurrences
  has_many :payments

  validates_presence_of :summary
  validates_presence_of :amount

  # Creates logical payments(an in-memory model) that is used for forecasting.
  # These logical payments can be marked 'paid' which creates payment.
  # Payments are exceptions to the recurrence rule

  # Bills are templates that hold data for recurrences of themselves.
  # Recurrences define the actual dates and repeating and even a variable amount
end
