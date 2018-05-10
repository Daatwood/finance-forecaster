# Interacts directly with bank
class Bill < ActiveRecord::Base
  KINDS = %w(INCOME EXPENSE)

  belongs_to :bank

  has_many :recurrences, dependent: :destroy
  has_many :exclusions, dependent: :destroy

  accepts_nested_attributes_for :recurrences

  before_validation do
    self.bill_type = bill_type.upcase 
  end

  validates_presence_of :summary
  validates :bill_type, inclusion: { in: Bill::KINDS, 
    message: '%{value} is not a valid bill type.' }

  def invalid_date?(date)
    @blackouts ||= exclusions.pluck(:date).map(&:to_date)
    @blackouts.include? date
  end

  def next_due
    recurrences.first unless recurrences.blank?
  end

  def expense?
    bill_type == "EXPENSE"
  end

  def income?
    bill_type == "INCOME"
  end

  def forecast 

  end

end
