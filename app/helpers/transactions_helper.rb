module TransactionsHelper

  def default_summary(bill)
    bill.nil? ? "" : bill.summary
  end
end
