# Recurrence are due dates for bills. They allow themselves to represent a single date or multiple dates by repeating
# Eg. First bill is always higher. Add exception to the first due date of recurrence then add a one-time recurrence with adjusted amount.
class Recurrence < ActiveRecord::Base
  FREQUENCIES = %w(Once Daily Weekly Monthly Yearly)

  default_scope {order('active_at ASC')}

  belongs_to :bill

  validates_presence_of :frequency, :active_at, :amount, :interval

  validates :frequency, inclusion: { in: Recurrence::FREQUENCIES,
    message: "%{value} is not a valid frequency." }

  before_validation do 
    frequency = frequency.capitalize if frequency
  end

  def next_date
    active_at.to_date + advance_frequency
  end

  def forever?
    expires_at.blank?
  end

  def advance_frequency(adv=interval)
    case frequency.upcase
    when "DAILY"
      return (1 * adv).day
    when "WEEKLY"
      return (7 * adv).days
    when "MONTHLY"
      return (1 * adv).month
    when "YEARLY"
      return (1 * adv).year
    else
      return 0
    end
  end

end
