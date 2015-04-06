# Logical::Transaction
# Each represents a row on a table: containing a Date, Bank, Balance, Amount, Summary, source(Recurrence/Transaction)
# Allow the table to just be a plug and play of Transactions
module Logical
  class Payment
    attr_accessor :amount, :date, :source, :summary

    def initialize(date, bank, balance, amount, summary, src)
      @amount = amount
      @source = src
      @date = date
      @balance = balance
      @summary = summary
      @bank = bank
    end

    def link_to_destroy
      "_form_#{@source.class.to_s.downcase}_cancel"
    end

    def link_to_primary
      "_form_#{@source.class.to_s.downcase}"
    end

    def paid?
      @source.is_a? Transaction
    end

    def expense?
      @amount < 0
    end

    def label
      @label unless @label.nil?
      if @source.is_a? Transaction
        @label = @source.summary
      elsif @source.is_a? Bill
        @label = @source.summary #"#{@source.summary} - #{@source.account.name}"
      else
        @label = "Unknown"
      end
    end

  end
end
