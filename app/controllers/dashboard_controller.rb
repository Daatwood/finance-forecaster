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

    # Group Payments by date.
    group_by_date
    # Set summary, change and balance
    setup_balance

  end

  private

  def group_by_date
    @dates = {}
    @logicals.each do |payment|
      date = payment.date.strftime("%F")
      if @dates[date].nil?
        @dates[date] = {}
      end
      if @dates[date][:payments].nil?
        @dates[date][:payments] = []
      end
      @dates[date][:payments] << payment
    end
  end

  def setup_balance
    balance = @balance
    @dates.each_value do |row|
      row[:summary] = row[:payments].map{|p| p.label}.join(", ")
      row[:change] = row[:payments].inject(0){|cng, pay| cng + pay.amount}
      row[:balance] = balance += row[:change]
    end
  end

end
