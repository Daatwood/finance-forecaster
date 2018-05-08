# Recurrence are due dates for bills. They allow themselves to represent a single date or multiple dates by repeating
# Eg. First bill is always higher. Add exception to the first due date of recurrence then add a one-time recurrence with adjusted amount.
class Recurrence < ActiveRecord::Base
  belongs_to :bill

  validates_presence_of :frequency, :bill, :active_at, :amount, :interval

  def next_date
    active_at.to_date + advance_frequency
  end

  def forever?
    expires_at.blank? || active_at.to_date == expires_at.to_date
  end

  def basic_frequency
    case frequency
    when "DAILY"
      return (1).day
    when "WEEKLY"
      return (7).days
    when "MONTHLY"
      return (1).month
    when "YEARLY"
      return (1).year
    else
      return 0
    end
  end

  def advance_frequency
    case frequency
    when "DAILY"
      return (1 * interval).day
    when "WEEKLY"
      return (7 * interval).days
    when "MONTHLY"
      return (1 * interval).month
    when "YEARLY"
      return (1 * interval).year
    else
      return 0
    end
  end

end
