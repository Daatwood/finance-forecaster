class DeleteBillsAccountId < ActiveRecord::Migration
  def change
    remove_column :bills, :account_id
  end
end
