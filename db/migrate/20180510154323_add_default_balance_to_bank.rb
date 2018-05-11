class AddDefaultBalanceToBank < ActiveRecord::Migration
  def up
    change_column :banks, :balance, :integer, default: 0
  end

  def down
    change_column :banks, :balance, :integer, default: nil
  end

end
