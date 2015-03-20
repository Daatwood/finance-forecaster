# Holds an amount of money and is interacted with by bills, adding and subtractig from balance.
class Bank < ActiveRecord::Base
  belongs_to :user
  has_many :transactions
  has_many :bills

  validates_presence_of :name

  def balance
    @balance ||= transactions.inject(0){|bal, transaction| bal + transaction.amount}
  end

  # def get_balance
  #   if @total_balance.nil?
  #     @total_balance = balance
  #     transactions.order(:date).map{|trans| @total_balance += trans.amount}
  #   end
  #   @total_balance
  # end
end
