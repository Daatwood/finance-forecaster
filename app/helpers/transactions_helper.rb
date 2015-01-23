module TransactionsHelper

  def default_summary(bill)
    (bill.nil? ? "" : "#{bill.summary} (#{bill.account.name})")
  end

  def default_amount(bill)
    (bill.nil? ? 0 : (bill.income? ? bill.amount : -bill.amount))
  end
end
