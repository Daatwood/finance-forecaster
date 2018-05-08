# Interacts directly with bank
class Bill < ActiveRecord::Base
  belongs_to :bank
  has_many :recurrences
  has_many :exclusions

  validates_presence_of :summary

  accepts_nested_attributes_for :recurrences, :exclusions

  def invalid_date?(date)
    invalid = exclusions.map(&:date).include? date
    invalid = transactions.map(&:date).include? date unless invalid
    invalid
  end

  def expense?
    bill_type == "DEBIT"
  end

  def income?
    bill_type == "CREDIT"
  end

end
