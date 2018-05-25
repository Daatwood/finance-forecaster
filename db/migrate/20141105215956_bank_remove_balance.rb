# frozen_string_literal: true

class BankRemoveBalance < ActiveRecord::Migration
  def self.up
    remove_column :banks, :balance
  end

  def self.down
    add_column :banks, :balance, :integer
  end
end
