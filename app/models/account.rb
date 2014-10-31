class Account < ActiveRecord::Base
  belongs_to :user
  has_many :bills

  validates_presence_of :name
end
