# Holds an amount of money and is interacted with by bills, adding and subtractig from balance.
class Bank < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  validates_presence_of :name
  validates_presence_of :balance

  def get_balance
    if @total_balance.nil?
      @total_balance = balance
      transactions.order(:date).map{|trans| @total_balance += trans.amount}
    end
    @total_balance
  end
end
