class RecurrenceStaticPrice < ActiveRecord::Migration
  def self.up
    add_column :recurrences, :static_amount, :boolean
  end

  def self.down
    remove_column :recurrences, :static_amount
  end
end
