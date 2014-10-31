class FixRecurrenceBillId < ActiveRecord::Migration
  def self.up
    add_column :recurrences, :bill_id, :integer
  end

  def self.down
    remove_column :recurrences, :bill_id
  end
end
