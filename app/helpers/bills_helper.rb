module BillsHelper

  def accounts_bip_collection(accounts)
    accounts.inject({}){|hsh,acc| hsh[acc.id] = acc.name; hsh}
  end

  def account_color(bill)
    return bill.account.color unless bill.account.nil?
    return "#000000"
  end

  def bill_color(bill)
    return bill.color unless bill.nil?
    return "#000000"
  end

  def bank_color(bill)
    return bill.bank.color unless bill.bank.nil?
    return "#000000"
  end

end
