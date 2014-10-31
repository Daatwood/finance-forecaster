class Recurrence < ActiveRecord::Base
  belongs_to :bill

  validates_presence_of :frequency

  # Recurrence are due dates for bills. They allow themselves to represent a single date or multiple dates by repeating
  # Eg. First bill is always higher. Add exception to the first due date of recurrence then add a one-time recurrence with adjusted amount.
end
