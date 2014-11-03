class PaymentsToTransactions < ActiveRecord::Migration
  def self.up
      rename_table :payments, :transactions
      add_column :transactions, :summary, :string
      remove_column :transactions, :bill_id
    end

   def self.down
      remove_column :transactions, :summary
      add_column :transactions, :bill_id, :integer
      rename_table :transactions, :payments
   end
end
