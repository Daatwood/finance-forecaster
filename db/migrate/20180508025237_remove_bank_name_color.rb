class RemoveBankNameColor < ActiveRecord::Migration
  def change
    remove_column :banks, :name
    remove_column :banks, :color
  end
end
