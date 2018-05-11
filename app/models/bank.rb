# Holds an amount of money and is interacted with by bills, adding and subtractig from balance.
class Bank < ActiveRecord::Base
  belongs_to :user, inverse_of: :bank
  has_many :transactions, dependent: :destroy
  has_many :bills, dependent: :destroy
  has_many :recurrences, through: :bills
  has_many :exclusions, through: :bills
end
