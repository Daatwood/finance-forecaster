class Exclusion < ActiveRecord::Base
  belongs_to :bill

  validates_presence_of :bill

  default_scope {order('date ASC')}

end
