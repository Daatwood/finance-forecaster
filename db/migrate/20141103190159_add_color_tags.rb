class AddColorTags < ActiveRecord::Migration
  def self.up
    add_column :bills, :color, :string
    add_column :accounts, :color, :string
    add_column :banks, :color, :string
  end

  def self.down
    remove_column :bills, :color
    remove_column :accounts, :color
    remove_column :banks, :color
  end
end
