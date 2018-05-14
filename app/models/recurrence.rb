class Recurrence < ActiveRecord::Base
  FREQUENCIES = { 
    'once' => 0, 
    'daily' => 1.day, 
    'weekly' => 7.days, 
    'monthly' => 1.month, 
    'yearly' => 1.year
  }

  FREQUENCY_KINDS = Recurrence::FREQUENCIES.keys

  default_scope {order('active_at ASC')}

  belongs_to :bill

  before_validation :normalize_frequency
  before_create :adjust_amount

  validates_presence_of :frequency, :active_at, :interval

  validates :frequency, inclusion: { 
    in: Recurrence::FREQUENCY_KINDS, 
    message: "%{value} must be one of the following: 
      #{Recurrence::FREQUENCY_KINDS.join(', ')}"
  }

  # Defines: once? daily? weekly? monthly? yearly?
  FREQUENCY_KINDS.each do |freq|
    define_method("#{freq}?") do 
      freq == self.frequency
    end
  end

  def next_date
    active_at.to_date + frequency_time unless once?
  end
  
  def forever?
    expires_at.blank?
  end

  def frequency_time
    (Recurrence::FREQUENCIES[self.frequency].seconds * self.interval / 1.day).days
  end

  private

  def normalize_frequency
    self.frequency = frequency.downcase.strip if frequency
  end

  def adjust_amount
    self.amount = amount * -1 if bill.expense? && amount > 0
  end

end
