# frozen_string_literal: true

class TieBillsToBanks < ActiveRecord::Migration
  def self.up
    add_column :bills, :bank_id, :integer
  end

  def self.down
    remove_column :bills, :bank_id
  end
end
