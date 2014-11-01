class WelcomeController < ApplicationController

  def index
    @bills = current_user.bills
    @logicals = []
    @bills.each do |bill|
      @logicals += bill.create_logical_payments
    end
    @logicals.sort! { |a,b| a.date <=> b.date }
  end
end
