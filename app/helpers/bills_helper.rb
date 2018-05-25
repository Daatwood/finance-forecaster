# frozen_string_literal: true

module BillsHelper
  def bill_color(bill)
    return bill.color unless bill.nil?
    '#000000'
  end
end
