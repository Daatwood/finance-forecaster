class WelcomeController < ApplicationController

  def index
    @bills = current_user.bills
    @logicals = []
    @bills.each do |bill|
      @logicals += bill.create_logical_payments
    end
    @balance = 0
    Bank.all.map{|x| @balance += x.balance}
    @logicals.sort! { |a,b| a.date <=> b.date }
  end
end
