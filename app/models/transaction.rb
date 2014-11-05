class Transaction < ActiveRecord::Base
  belongs_to :bank

  validates_presence_of :date
  validates_presence_of :amount
  validates_presence_of :summary

  def bill_summary
    return "" if bill_id.blank?

    bill = Bill.find(bill_id)
    return bill.summary unless bill.nil?
    "Unknown"
  end
end
