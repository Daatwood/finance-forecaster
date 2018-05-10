module BillsHelper

  def bill_color(bill)
    return bill.color unless bill.nil?
    return "#000000"
  end

end
