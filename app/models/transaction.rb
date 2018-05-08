class Transaction < ActiveRecord::Base
  default_scope {order('date DESC')}
  belongs_to :bank

  validates_presence_of :date
  validates_presence_of :amount
  validates_presence_of :summary

  after_create :update_bank

  def update_bank
    bank.balance += amount
  end

  def debit?
    amount < 0
  end

  def credit?
    amount > 0
  end

end
