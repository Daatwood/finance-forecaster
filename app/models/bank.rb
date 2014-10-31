# Holds an amount of money and is interacted with by bills, adding and subtractig from balance.
class Bank < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :balance
end
