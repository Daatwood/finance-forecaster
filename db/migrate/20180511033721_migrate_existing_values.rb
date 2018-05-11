class MigrateExistingValues < ActiveRecord::Migration
  def change
    # Ensure all banks have starting value of zero
    Bank.where(balance: nil).update_all(balance: 0)

    # change of bill_type for better clarification
    Bill.where(bill_type: "DEBIT").update_all(bill_type: 'expense')
    Bill.where(bill_type: "CREDIT").update_all(bill_type: 'income')

    # Decouple recurrence amount's sign from bill
    Recurrence.joins(:bill).where("bills.bill_type = 'expense' AND amount > 0").find_each do |re|
      re.update(amount: re.amount * -1)
    end
    Recurrence.find_each do |re|
      re.update(frequency: re.frequency.downcase)
    end
  end
end
