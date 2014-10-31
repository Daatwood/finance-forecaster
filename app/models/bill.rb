class Bill < ActiveRecord::Base
  belongs_to :account
  has_many :recurrences
  has_many :payments

  validates_presence_of :summary
  validates_presence_of :amount
end
