module Logical
  class Payment
    attr_accessor :amount, :date, :bill

    def initialize(bill, amount, date)
      @amount = amount
      @bill = bill
      @date = date
    end

  end
end