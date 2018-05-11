# Logical::Transaction
# Each represents a row on a table: containing a Date, Bank, Balance, Amount, Summary, source(Recurrence/Transaction)
# Allow the table to just be a plug and play of Transactions
module Logical
  class Payment
    attr_accessor :amount, :date, :recurrence, :summary

    def initialize(date, bank, balance, amount, summary, recurrence)
      @amount = amount
      @recurrence = recurrence
      @date = date
      @balance = balance
      @summary = summary
      @bank = bank
    end

    def bill
      @recurrence.bill
    end

    def link_to_destroy
      "_form_#{bill.class.to_s.downcase}_cancel"
    end

    def link_to_primary
      "_form_#{bill.class.to_s.downcase}"
    end

    def paid?
      bill.is_a? Transaction
    end

    def expense?
      @amount < 0
    end

    def label
      @label unless @label.nil?
      @label = bill.summary
    end

  end
end
