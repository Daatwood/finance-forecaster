class Recurrence < ActiveRecord::Base
  belongs_to :bill

  validates_presence_of :frequency
end
