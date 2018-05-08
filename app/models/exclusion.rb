class Exclusion < ActiveRecord::Base
  belongs_to :bill

  validates_presence_of :bill

end
