class RecurrencePower < ActiveRecord::Migration
  def self.up
    add_column :recurrences, :active_at, :datetime
    add_column :recurrences, :amount, :integer, default: 0
    remove_column :bills, :active_at
    remove_column :bills, :expires_at
  end

  def self.down
    remove_column :recurrences, :active_at
    remove_column :recurrences, :amount
    add_column :bills, :active_at, :datetime
    add_column :bills, :expires_at, :datetime
  end
end
