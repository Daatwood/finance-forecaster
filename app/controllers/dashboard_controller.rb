class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @bills = current_user.bills
    @banks = current_user.banks
    @transactions = current_user.transactions
    @logicals = []
    @bills.each do |bill|
      @logicals += bill.create_logical_payments
    end
    # @transactions.each do |transaction|
    #   @logicals << Logical::Payment.new(transaction,transaction.amount,transaction.date)
    # end
    @balance = 0
    @banks.all.map{|x| @balance += x.get_balance}
    @logicals.sort! { |a,b| a.date <=> b.date }
  end
end