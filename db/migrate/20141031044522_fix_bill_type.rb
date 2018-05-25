# frozen_string_literal: true

class FixBillType < ActiveRecord::Migration
  def self.up
    rename_column :bills, :type, :bill_type
  end

  def self.down; end
end
