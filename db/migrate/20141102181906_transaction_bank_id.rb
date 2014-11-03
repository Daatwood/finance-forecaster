class TransactionBankId < ActiveRecord::Migration
  def self.up
      add_column :transactions, :bank_id, :integer
    end

   def self.down
      remove_column :transactions, :bank_id
   end
end
