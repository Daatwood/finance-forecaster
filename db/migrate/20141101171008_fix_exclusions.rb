class FixExclusions < ActiveRecord::Migration
  def self.up
    add_column :exclusions, :bill_id, :integer
  end

  def self.down
    remove_column :exclusions, :bill_id
  end
end
